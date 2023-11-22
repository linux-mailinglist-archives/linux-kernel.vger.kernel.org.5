Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4C7F51E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjKVUwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:51:59 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723FC1BD;
        Wed, 22 Nov 2023 12:51:54 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6ED6A40E014B;
        Wed, 22 Nov 2023 20:51:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d81rvFVnWo-F; Wed, 22 Nov 2023 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700686310; bh=SG2A28lgttWuxdRCaoYK+1fwtUHLkqRaLnYpgZm8oSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDX3kg53+AEnunCD2CIsZTtUqi/Z1Z5bcAydl7DKCaSrc91hghxKBA5lj/OVlipWW
         xmx60EVAaC1kmqiKs5jhwo3ZeL42u6LaU3DQtNE/fFMIdYlE5H7GHF2ySa5Rb2DrLg
         hFNlb5ov1lm9oBTwLHWZKpBBRFkvtfeAZZ8WbfVmUPMOKJcIStEUTEb6JAK3eQzliR
         WU3cGxi1vM+vmngdWjRJR3NjM6eNLkytHphkbNNsLxKWDi2yNT2+eYPXNZxPPUaa4u
         iV+2gl7P8sIQXP9SE0REA6ZO7OPONniU5Sght53fk3z5tyUi5Zf5dnb6MhuxIlHd/x
         HWz67kUCYUFPFzuhq+DGdjjURl33E31JhQYkBzYpcFXM7b4LyqWfMVBd4iLRAU7ULg
         AJlJH9d0zxj8g6OxKqkUvVgMGJJQ0Es1h4k1PZ7hRkKzuKz+PEObEVE+CJ0sm8Zn8h
         +g/az0DkJl6VqzHrTXIqxrPA8a/h2NjgiFknGoWKc230x1fra7ON4u3extGGJXwJxB
         cVdaHSxlj2Z9UiUCt8MJ+G2nokp1ztFFCVxMucMY0FCWj57a0vrJM62QeSz6JBf1MP
         vBwCsfBIHu8RCwAJw8lrecUM3WfTcitUXRpZAZM+U0FaaHpALRG1Eo5q/NtUl/2a6C
         IGMumPJ6YlJ+YLV2YtjK4LfQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7687840E0259;
        Wed, 22 Nov 2023 20:51:40 +0000 (UTC)
Date:   Wed, 22 Nov 2023 21:51:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Message-ID: <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
 <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:35:54PM -0800, Linus Torvalds wrote:
> IOW, the whole "users are the only thing that matters" pretty much
> means that it's a non-issue. Things continued to work, to the point
> that I'm actually surprised anybody even noticed.

Right, the patch which did the changes is in 6.6:

e6bcfdd75d53 ("x86/microcode: Hide the config knob")

I'm still waiting for the other shoe to drop when 6.6 gets used more but
we'll see...

> That said, I don't think some ELF note is the fix either. I think we
> might as well leave it at CONFIG_MICROCODE. Maybe add a note in the
> kernel Kconfig that this thing matters for dracut.
> 
> Dracut also checks for CONFIG_ACPI_INITRD_TABLE_OVERRIDE. It's a
> similar "normal users don't care".

Ok.

My only worry here is that we're making a precedent and basically saying
that it is ok for tools to grep .config to figure out what is supported
by the kernel. And then other tools might follow.

I have no clue how many tools are actually interested in stuff enabled
in the kernel .config though. If only dracut then sure, don't care, but
what if it starts proliferating...

I'm just talking with my devil's advocate hat on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
