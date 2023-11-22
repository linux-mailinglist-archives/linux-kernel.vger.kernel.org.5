Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9F7F4BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjKVP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjKVP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:58:27 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C5101;
        Wed, 22 Nov 2023 07:58:21 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC3D540E0257;
        Wed, 22 Nov 2023 15:58:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8NJPuA-vM66A; Wed, 22 Nov 2023 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700668697; bh=lkQQu+7yzLoFCKM//WjE/StEqjZ0XkwKCxRlE1ZiQU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjHY00CJcTYH1bI1V0jspnlHcxeLBH1k0C1j6H0gpjoQLgpoYMA8B1VZKPudbgiGS
         CvYn13YTTlfAqpzkxXs/mjNWSqRh79QctnkkgenIkZ2hm96RdwVZKxAQYrChTQJs/n
         dVEs9Mmk43IaUBVlxp5yLk3g1btd/NEXsiiTEVA9Q7DgXjSbO2BeKUuPV3hNch1UNr
         w+ZVZIH2it8cse4pwkD63DQr9OeoSqSiVB7dhR9jTinM1inaWVKwiEqMtW3y7tPTnR
         kDxl2TysFGSZSTvtfL7Ve2BBjrfoY4gGfIYeTALP/3M2VqXyw+zyeUTBQr+avPphGG
         zxrmNbhDUHomCOulNP35d6c9CQXfHShfDmPqQaF8OJ68zAU2vnLv+gq6R5Ed8cCC81
         3G2uk89qePCTKAa1TlaE7VwPnXnjdo2HHnuKq/my+bfMrGr0ouxX2xLeP4VXzWv238
         qOv0CQRjPEXmxDTR2hGdIzvGeY9ZVAlswMb4fpNmAschTiAlEeZSccCaRUf6L0tn3m
         PRwJBL3PD+/XvsYZcGv7itdgEIiXL+WCBU4DwYnwS9nkCGJy+Q85NgfYd23gIoxAhh
         xleOlqL2uYPX349KSEHsbJ/ShltHQ4hL/Iecee7SciQqsxKurC6yuKDIXvWVLP6rGN
         arjX/3ZcALQgWbehIS0s33KA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C359440E024E;
        Wed, 22 Nov 2023 15:58:06 +0000 (UTC)
Date:   Wed, 22 Nov 2023 16:57:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Message-ID: <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure,

lemme do that.

Hi Linus,

we have a disagreement on what is a userspace regression and what is
not.

The whole thread starts here:

https://lore.kernel.org/r/c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info

and I'm leaving Thorsten's arguments fully quoted below for more
context.

Basically, dracut has been grepping the kernel's .config to figure out
whether to add microcode blobs to the intird or not.

Now, we changed a CONFIG and it broke. Again. It wasn't the first time.

It went and fixed it this way:

https://github.com/dracutdevs/dracut/commit/6c80408c8644a0add1907b0593eb83f90d6247b1

which will break next time we change stuff.

IMO, yes, we should not break userspace but dracut is special. And it
parses willy nilly kernel internals which are not ABI to begin with.

Looking at that dracut function check_kernel_config(), it does:

    # no kernel config file, so return true
    [[ $_config_file ]] || return 0

if it can't find a kernel .config at the two places it looks for which
is just silly: if it can't find a .config just return true and include
those microcode blobs. Might as well hide the config as a fix. :-)

What it should do, is parse the .notes section of vmlinux for which
I have a proper fix:

https://lore.kernel.org/r/20231122132419.GBZV4BA399sG2JRFAJ@fat_crate.local

So IMNSVHO, CONFIG symbols are not an ABI. 

If there's some other userspace tool which goes and greps the kernel
sources and looks for a particular function or symbol which is not even
exported, does that mean that we won't be able to change that function
name or symbol anymore just because some random tool touches it.

Yes, I know, we should not break userspace but there has to be some
sensible limit somewhere as to what constitutes a userspace breakage.

In the end of the day, that's your call.

If we consider this a userspace breakage, I would add back those
CONFIG_MICROCODE_INTEL and CONFIG_MICROCODE_AMD Kconfig symbols and
everytime I add a new CONFIG symbol, I should probably write a big fat
note above it that userspace should not rely on it existing forever...

Thx.

On Wed, Nov 22, 2023 at 04:34:03PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Preface: considered CCing Linus here, as it's quite possible that I'm
> wrong, as every situation is somewhat different. If anybody disagrees
> with what I bring up below to hopefully clarify things thus please do me
> a favor an CC Linus so he can clarify things.
> 
> Ohh, and sorry for being a PITA. I hate that, but when it comes to
> regressions disagreements often happen, as all those discussions linked
> at the end of https://docs.kernel.org/process/handling-regressions.html
> illustrate.
> 
> On 22.11.23 12:58, Borislav Petkov wrote:
> > On Wed, Nov 22, 2023 at 10:15:42AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> [1] unless you fiddle with things obviously internal; not sure if this
> >> case would qualify for him, but somehow I doubt it -- but I might be
> >> wrong there.
> > 
> > Well, think about it - by that logic, if CONFIG_* items are an ABI, we
> > will never ever be able to change any of them. [...]
> 
> Can't follow your logic (or the one from Lukas in the other reply), as
> what's an ABI (or an API) is afaik not the important factor when it
> comes to the "no regressions" rule: you can change things (including
> ABIs or APIs) all you want, as long as nothing breaks. To quote Linus from
> https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/
> 
> ```
> The rules about regressions have never been about any kind of
> documented behavior, or where the code lives.
> 
> The rules about regressions are always about "breaks user workflow".
> 
> The other side of the coin is that people who talk about "API
> stability" are entirely wrong. API's don't matter either. You can make
> any changes to an API you like - as long as nobody notices.
> 
> Again, the regression rule is not about documentation, not about
> API's, and not about the phase of the moon.
> 
> It's entirely about "we caused problems for user space that used to work".
> ```
> 
> >> BTW: I see that this could help preventing problems like the current one
> >> to happen in the far future. But how would that help the current
> >> situation (e.g. users that have an old dracut and updated the kernel
> >> without updating dracut)?
> > Update dracut too?
> 
> To quote Linus again, this time from
> https://lore.kernel.org/lkml/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/
> 
> ```
> People should basically always feel like they can update their kernel
> and simply not have to worry about it.
> 
> I refuse to introduce "you can only update the kernel if you also
> update that other program" kind of limitations. If the kernel used to
> work for you, the rule is that it continues to work for you.
> 
> There have been exceptions, but they are few and far between,
> [...]
> But if something actually breaks, then the change must get fixed or
> reverted. And it gets fixed in the *kernel*. Not by saying "well, fix
> your user space then".
> ```
> 
> Are those quotes fitting to the situation at hand? Not totally sure.
> Initramfs generators might be special and we have done exceptions for
> them in the past if no other solution could be found to prevent a
> regression[1]. We'd need Linus to clarify.
> 
> Ciao, Thorsten
> 
> [1] maybe it's a naive idea, but can't we just avoid the problem at hand
> by adding CONFIG_MICROCODE_AMD and CONFIG_MICROCODE_INTEL back as a
> hidden config stub and remove those in ~3 years? Yeah, ugly, but we have
> done things way more ugly than that to prevent regressions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
