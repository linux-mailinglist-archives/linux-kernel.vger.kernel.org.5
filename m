Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E907F7393
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbjKXMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKXMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:15:15 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EED41;
        Fri, 24 Nov 2023 04:15:21 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2BDC340E0258;
        Fri, 24 Nov 2023 12:15:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oeRxXeCdZJaq; Fri, 24 Nov 2023 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700828117; bh=143OkiA/6ugtGo+t9Jv92D/VYmZJw5vW1hFX+labQD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpobDvAZuPT7RAui0BS6WKvdYl5RmaqPg0F9WqUC8QtlyPHiNXvgreLA+I84h8xWP
         YmjpB0biW3zilNJHokQ5WxORil6RaBAW+IjRoUHvtKrSM8shl2WVyV9PM8FJCD1NvI
         dh+7mk8PAOe8sIVi0rqxFDKBbZx93MBsy4wUv+xQHaXAkRLGwMhG1crmEwojPms/DH
         J45RVCHIxKng/kJRLkaLwIFGfEsdkSlbYti/SzVQIhzXECQ/s7Z6hfQK85bBwL+5Ti
         q2XPvNdNdiKgrKM792wOI0r/n/BD6EfMYeJSTR24UZAVWPpYAgAG+TeUxtDkknCqML
         173/o/WO9IOlQjSF8unkfIEqGNFrGu/fdNB5e0n5GEslIuX3PuCc77vKTQL2wLvO3z
         faj1kXiRgcALXk2rPWOicNr8H48ozvo8wBFR2dZfXzGQTjWniHkHzPqm++ORnlxy3i
         2+0TAguxz9kUjFcHKBzlwaf/41PbfbouJdQTgRJLuryEKKCwmIio+OP6EEWYdIVeMZ
         nhCNQcRb9kNMf5skoZyx28QkIzeBGGubfNEE2vgbJNWT2OHDAB20zS+rYVwJozLDKp
         6VMR1XlTqZ8vu8Iw8jxzfc1B9C1eQ4JE01MCgFkyBpl429DP+KoUj+XVGnMtIw3O1G
         Z8vhDYL4jleA60mn7wTqh7/Y=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01F4740E0195;
        Fri, 24 Nov 2023 12:15:05 +0000 (UTC)
Date:   Fri, 24 Nov 2023 13:15:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Antonio Feijoo <antonio.feijoo@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Message-ID: <20231124121500.GAZWCTxML94BSYaQf3@fat_crate.local>
References: <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
 <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
 <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
 <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
 <20231123112013.GAZV81bezsrS6sdJQR@fat_crate.local>
 <66f077cf-ff85-44dc-a76a-05d8995ea261@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66f077cf-ff85-44dc-a76a-05d8995ea261@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:49:27AM +0100, Antonio Feijoo wrote:
> As Linus said, the `check_kernel_config` stuff was implemented in 2014 and this
> is not the only kernel config option that it's being checked by dracut
> (CONFIG_ACPI_TABLE_UPGRADE, CONFIG_ACPI_INITRD_TABLE_OVERRIDE, CONFIG_RD_ZSTD),
> although I agree that it's fragile if something changes. But adding in CC the
> initramfs list (like you did), would be enough to prepare a simple fix in time.

Right, how about we give you a more reliable way to check functionality
built into the kernel instead of grepping the .config file?

Like the ELF note thing, for example:

https://lore.kernel.org/r/20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local

The current thing is not ABI and will break everytime we change
something and even if you fix it on time, older dracuts will still be
broken.

> The only problem I see in your patch is that we should also remove the
> `--early-microcode` option, and dracut will fail if someone pass an option
> available since 2013 (5f2c30d9bcd614d546d5c55c6897e33f88b9ab90) that would not
> be recognized now (and by failing, I mean it will not build an initramfs if an
> unrecognized option is passed).

Ah ok, --early-microcode becomes a no-op with my change. Sure.

> Please, submit it to https://github.com/dracutdevs/dracut, so more people can
> see it and discuss it. Thank you.

I presume I should read this first:

https://github.com/dracutdevs/dracut/blob/master/docs/HACKING.md

and send a github pull request?

Anything else I need to pay attention to when sending dracut patches?

Or is there also an old school mailing list where I can send the patch
to?

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
