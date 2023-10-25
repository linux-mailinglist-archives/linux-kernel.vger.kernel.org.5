Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188D7D6992
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjJYKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJYKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:54:03 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346BC1;
        Wed, 25 Oct 2023 03:53:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE01640E01B1;
        Wed, 25 Oct 2023 10:53:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UxMrYoXksK9l; Wed, 25 Oct 2023 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698231236; bh=E1YroIZPP2LEFjZpjyLid5YBIHN+4MkpG+Icb9Gwcco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZkT0okAuJIU+zBKJLopKGvY2X1aBBPAB1sLylSYQ3tAKbHJAYcxtV0fnEBL6CKpl
         v/f3YzVyhvGWTn67W3slNIKqlsEC/Q0fItCYMcU7DvGA/CLi2lHsfUMDq+XBV5Kn0n
         ptzLlsbt7XqfZNWRrrYcR1DwTeScssl9V8rZMm3gaG9udFBVZhdDBU878Tuq8RjGQc
         TKVVCvy4JKpJskHoTaem2gwyjs4epjqm/3xxPCcIOWIzMMWpflvgGPofbCWSqcDDW8
         5b7bRlRlzwyuRHj2czSyRCnSu4r8iPcMJNMDXtG/lC3cPa2XdtNHUJ48RT8IknR7XO
         F837qfgp4zBJJxFPvuRyIH6HzL+UtMBqGMInUkpIVQA2RR9jMI9KvL5TpCNJCD5mcZ
         bA2KOwN8kCWedYTfeCRqpbnxtvvNdra5tO01ZH7TX0TxJdaWEqI3Nce7yyq5xF0RUj
         0OJPtdxru8htfZy9yQ4mY4WiN+kZYrNqEZnpjiLZqx2BOp+PhXtNjBI2Si1x45HNew
         nO0UI92pD6NEE6arxNto74cghh0j+fDejB1KXsU2yacE4rm67BxwOvFA30ApSt0Bbb
         bYjth3owKglc1TAf4M6OwlNeBpjCjbrob23yosnb9N6vRE7RjmuT+V3Du9FNd/YYRl
         8P2cNJuu+LNXEL83YPKPYEV4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31D5840E014B;
        Wed, 25 Oct 2023 10:53:49 +0000 (UTC)
Date:   Wed, 25 Oct 2023 12:53:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
Message-ID: <20231025105343.GDZTjztyfNVT0ujOsS@fat_crate.local>
References: <20231005173526.42831-1-yazen.ghannam@amd.com>
 <20231005173526.42831-2-yazen.ghannam@amd.com>
 <20231011173528.GUZSbc4Ag03d9Xastz@fat_crate.local>
 <f65db953-ebf6-488b-94ac-2bf65d2a982d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f65db953-ebf6-488b-94ac-2bf65d2a982d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:47:09AM -0400, Yazen Ghannam wrote:
> Of course not! :P
> 
> I do mean "Supported" though. From the top of MAINTAINERS file:
> 
>         S: *Status*, one of the following:
>            Supported:   Someone is actually paid to look after this.

Whatever - I'm not even going to ask why the distinction is being made.
:-\

> 
> >> +#define DF_BROADCAST		0xFF
> >> +
> >> +#define DF_FICAA_INST_EN	BIT(0)
> >> +#define DF_FICAA_REG_NUM	GENMASK(10, 1)
> >> +#define DF_FICAA_FUNC_NUM	GENMASK(13, 11)
> >> +#define DF_FICAA_INST_ID	GENMASK(23, 16)
> >> +
> >> +/* Register field changed in new systems. */
> > 
> > I don't understand that comment.
> 
> I'll make it more explicit.
> 
> The "REG_NUM" field changed. Please note the slightly different
> bitmasks.

Sure, but that belongs in the changelog - not in a static comment. "new
systems" turns into old systems after a couple of years. :)

> Fair. It took some getting used to, but I've come to prefer the bitops.
> I'd like to keep them if you don't mind.

I guess. They haven't pissed me off that much yet and since you're going
to be staring at that thing...

> Is this so it loads independently?

Yes.

> I'm thinking it should only load as a dependency for other modules.

Then you can express that dependency in those other modules' Kconfig
stanzas. No need to check vendor here.

> If it fails to load, wouldn't modules that depend on it fail to load?

So if this fails loading, then you need to return an error from the
loading routine and the other modules should not load.

If the other modules should still load, then you need to make the
translation lib optional and use the module device table thing so that
the translation lib can exist independently.

However, then you need to handle the case where the other module calls
into the translation lib and at exactly the same time, that library
module is removed. There must be a way to prevent this in the module
code, ref counting perhaps, but you'll have to check how exactly.

> Yes. The intention is to allow any code to use this "library" including
> arch code like MCA.

Ah, then it should be in asm/atl.h

> Genoa is a public name for a particular Server model group. And the
> quirk applies to that group. It doesn't apply to other Zen4 systems like
> Client models, etc.

So Zen4 server. Still better to have the generation and hw type than
some italian name which we will forget.

> Sure, but I don't understand.
> 
> Should these be moved to edac.rst? This code isn't part of EDAC.
> 
> Or are you suggesting that this new "library" should have a
> Documentation/ entry?

Documentation/ras/ I guess?

> No, PA 0 is a valid address. The physical memory map (at least on x86)
> starts at 0.
> 
> We can still get hardware errors for address 0 even though it's part of
> a reserved space. These could be found by patrol scrubbers, etc.

Oh fun.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
