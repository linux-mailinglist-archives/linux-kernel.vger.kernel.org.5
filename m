Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB67E9264
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjKLT5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKLT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:57:14 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A01BFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:57:11 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39D1E40E0176;
        Sun, 12 Nov 2023 19:57:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 70Q4wPQm9flK; Sun, 12 Nov 2023 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699819027; bh=Zh/duGgCc9tYaG3OAsOZn20tSJHKu3D5P/EZhGTwDGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feyQDiZZhq8t1Qx3pSPTnAUefcYzyvLRtwunY+AqBtndhg1IC+RNn/2yhtAo3Rn/F
         rqDdhmzEmlrHnPvotBsl3crXbvgtjp50svdBieiG5nrOklUlqPLIC6PtsN3bViFq02
         hX0hEVpJfqyZcbZHehaIWyk0UG9goU/wfIxFr9gLL0Q7zjYRPQjSAZ0BF05rBsxg/7
         7pzThio3LhgIUW8Mx14kHL5FfbMT0aW/mFevckM6fvM5B73dADMt32DoHLKfYJPFGn
         XrLzWVRq0ggPjDhQFyeexnjmdbfP2kQhh926FQBibuHV1ZynLb8NzdZUoqt2QHH4Db
         5v7n8CSVhr8Wbu3/fCvQs3q6idxlNJUdIK47HmGKm1vjx+9bwY2ZNL5bG5uM+XgbX2
         OJFM0y52/ZZzmxG66zUygVcyYa2EbJTrXxJdAaXlBhzKkTf2xLUqZHWBCq29PEcvsb
         6KmCcJ2rTSfK1TGGCu/VGKZt4+1cW7m+l7SlhEKRmmXWf91swRI763AFPqNY3Msskx
         YB740f/9UMRYuYW740KOJVa1u2ly03J+TZjQgtU+sYCswk+V/1Rz7tsXGIYsU19VW0
         5kw0SkJzdOsIVEEmxqhIyaXHWOboz07xAGaUt15poOh2rSDcbLiUFOmuojGKlnLn3+
         HqdL838BGkcOIKb8NhvO+sWo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD3A340E0032;
        Sun, 12 Nov 2023 19:57:03 +0000 (UTC)
Date:   Sun, 12 Nov 2023 20:56:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/microcode for 6.7
Message-ID: <20231112195657.GCZVEuCVfBYuDVoLHG@fat_crate.local>
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
 <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
 <20231111223549.GBZVABxWKgkuGNhEqe@fat_crate.local>
 <20231112122309.GAZVDDrYRiH4RuVbRV@fat_crate.local>
 <CAHk-=wi_ko54kPH3Jc_eEXHrxjJOQ_TDkeo1cjU1pdeC+kzATg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_ko54kPH3Jc_eEXHrxjJOQ_TDkeo1cjU1pdeC+kzATg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 11:41:53AM -0800, Linus Torvalds wrote:
> I can verify that this makes my boot logs look sane again.

Cool.

> I'm not applying this directly, and will let you do the final version
> in the tip tree (split into two?), but thought I'd at least ack that
> it works for me.

Thanks!

So I was looking at the Intel side earlier and it doesn't dump the
revision it had *before* the early loading. And people have asked for
that functionality - to be able to dump the revision which got
overwritten.

So I'll try to pull up that code and use for both drivers, test on all
machines and send out a proper set.

And yap, you'll get that eventually through tip, in time for 6.7.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
