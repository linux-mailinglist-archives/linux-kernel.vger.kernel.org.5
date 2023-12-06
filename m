Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9C806571
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjLFDJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:09:23 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69DD1AA;
        Tue,  5 Dec 2023 19:09:29 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 60A255C0280;
        Tue,  5 Dec 2023 22:09:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 22:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701832166; x=1701918566; bh=Gx
        di2p1Yk4cVJg6E5kznzYfmmylAHaLEa4Ys452Wccc=; b=i4hdYtqIFUOVf+8n84
        PjgoROde2ekdUMDbZ8s+3AYfuvufs3hppWaaikpS/RnDiGfMI4Q1JLZhBYJ77n4n
        kKAVTy8aI6PAnh7I3HV1d6EYJaDu+a7eKbBcTcvcWUK0PVpTCgcij+NngvPL82q5
        IJzLp9iInZ1JNKxxZrGpe/XntMmmJCW7dN7vesRgk9frbuEXrPE8xZQ71PmVx6EW
        oq9OHjalRzfG6d3+faG3barDAB1xEk9uUfRYYQEtM7SjGDPg1hQd1z8ApuXanPxp
        5A3yuMWb8oMNN0hx+LPehjCw2+LTQF0bRqvgc8VBFVss/62WnxH2g6E3MXADU83u
        4jNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701832166; x=1701918566; bh=Gxdi2p1Yk4cVJ
        g6E5kznzYfmmylAHaLEa4Ys452Wccc=; b=H51r7g3HoBensEOkyoaIOWc0/6sh2
        Ph/AgYEHfJbThnTYjxLiKJ1T6bFuVg55E+bTLPGBrWCHO7K0xRgGv9251tt/a2oc
        EESLCRhy8DxnWiLpM9MqzIAVVnr6s2u8nRh5FdTAsAPv11OSIk0ENFi4Saqac7D/
        Okf76KWsfoyX6ufuaxmYpc2kXGAt1gTLZSUqZsmJsbKKuAJNh7SUG4AIgldiUPh+
        pstlhp4sjZnhT3siM2XeOEBL6qTPWL2Ychae65es0xFnyPNiIumuVM3q2RhSziFV
        y2wuxlI0BmhBbdy9C3AMeCEkviD+BChKGqKQt5l1J9ce0Ioau6GLP5uFg==
X-ME-Sender: <xms:5eVvZSXboh_iSBfMeo3HnMRLISiE0_GslKZNtvsdd0h6px33_3L4DQ>
    <xme:5eVvZemoTC15y0ah3IEduuJrnlogH8RJ4bsXQ9O7b0SXe9TZfwbIV2OrG7ozL2F8k
    d7Ub2Eh2GNmYQ>
X-ME-Received: <xmr:5eVvZWaZkeW9CVA3GoSn8lHxuoOqpkF17EvVxg6lTWhw85pUv494RfUFyeZ-ybFgzwgbc_khoEtsQm7AC_9azNnC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:5eVvZZVgu7Gsqq0Rrt5K9GVB0rwCQm9wLMe0TyI8MYeQdo5pwthWKw>
    <xmx:5eVvZcnBLYE3cgrsFpDaO8IdI6e57Upyx_XuA3nIitzPxtzx-7ZSnQ>
    <xmx:5eVvZee0yJD303i0bHmBmQvCY_rtv-WKZfJXWkV3WT56eMyDn_nY6Q>
    <xmx:5uVvZbddXSQ6aoKfZ1n3r-Su5Yf2DzneImm-ec5nAnLLL-kAWafrpA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 22:09:24 -0500 (EST)
Date:   Wed, 6 Dec 2023 12:09:17 +0900
From:   Greg KH <greg@kroah.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <2023120650-faucet-palpable-f1a3@gregkh>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
 <2023120657-henna-spongy-9ef6@gregkh>
 <20231206005542.GJ1674809@ZenIV>
 <20231206030047.GL1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206030047.GL1674809@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:00:47AM +0000, Al Viro wrote:
> On Wed, Dec 06, 2023 at 12:55:42AM +0000, Al Viro wrote:
> > On Wed, Dec 06, 2023 at 08:46:50AM +0900, Greg KH wrote:
> > > > >
> > > > > But of course, it doesn't always hold true, there are a few minor
> > > > > exceptions, but they are rare.
> > > > 
> > > > $ grep -r \\#include lib | grep asm
> > > > 
> > > > shows quite a few exceptions, and just in lib/.
> > > > 
> > > > For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
> > > > where lib/math/int_log.c should be #include 'ing linux/bug.h rather
> > > > than asm/bug.h?
> > > 
> > > Probably yes, but we don't normally go back and take coding style fixes
> > > for old files like this as it doesn't make much sense to do so.
> > > 
> > > But, if you are cleaning up the headers for large portions with the goal
> > > of faster builds, that's a good reason.
> > 
> > FWIW, the most common (by far - about 13% of such includes, over drivers/, fs/,
> > mm/, net/ and sound/) is asm/unaligned.h.
> 
> Why the hell is unaligned.h in asm/*, anyway?
> 
> We have 3 variants: arc, parisc and generic (== everything else).
> Both arc and parisc instances have an explicit include of
> asm-generic/unaligned.h (i.e. the generic variant).
> 
> On arc there's also misaligned_fixup() extern or stub, with exactly
> one user (in arch/arc/kernel/traps.c).  On parisc there are
> externs for handle_unaligned() and check_unaligned() (3 call sites,
> all in arch/parisc/kernel/traps.c).
> 
> How about we take those into arch/{arc,parisc}/kernel/unaligned.h,
> slap #include "unaligned.h" into their traps.c and unaligned.c
> (callers and definitions resp.) and strip those from asm/unaligned.h?
> At that point we can remove arch/{arc,parisc}/asm/unaligned.h - everything
> will pick include/asm-generic/unaligned.h.
> 
> Then the next cycle we ask Linus to run the following:
> for i in `git grep -l -w asm/unaligned.h`; do
> 	sed -i -e "s/asm\/unaligned.h/linux\/unaligned.h/" $i
> done
> git mv include/asm-generic/unaligned.h include/linux/unaligned.h
> sed -i -e "/unaligned.h/d" include/asm-generic/Kbuild
> right before releasing -rc1 and asm/unaligned.h is gone...

Please do, it's really annoying and would be great to fix up.

thanks,

greg k-h
