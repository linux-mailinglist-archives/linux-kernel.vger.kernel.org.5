Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30479078C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347885AbjIBLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIBLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:10:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD73E5B;
        Sat,  2 Sep 2023 04:10:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so47245681fa.3;
        Sat, 02 Sep 2023 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693653035; x=1694257835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sCWoWPe6h8Qmaq6PAfz3dXsnt+0ElN/TsBNKOj8iL1I=;
        b=rDUrCWwtoEKkI6uMphA7bZtCx0ChO9rIqIDtcaMjHLhlYybsBP1qJ/6yPRI5pqHVOT
         rrDiwCUQ1lekFd30nbYCjJnU0IqrJd56YkMjM/FbHSlKPG5vuvzIuXWKEi6fNFOuZpch
         DefsK5T450is/YsJCPiwfRXKz+4Z2Gl94wZhSw3EqlTen074iDM4ukZ/2aCecrM2gVsy
         RtYvhJiuMIjN76POTunQTyOXLBv3YFg1+HVa4Ug1ynFIa0h7vmqKxWUovc7HAgpyeZHs
         +g6wIoh5HsuIVaCQscYZ99iX4VJ5ZZqfdBCnAqMFoywLR6CS+hTrldMzhef4vtD69/gz
         p2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693653035; x=1694257835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCWoWPe6h8Qmaq6PAfz3dXsnt+0ElN/TsBNKOj8iL1I=;
        b=D5oJoNHlZAt8cl42vHu8S+/mVs5BPyN/MjeAslKhcG7JArP6tR0955zJ9X7zvrq/+V
         1VJ6aC6PdvhY/c+CcS3Y3k7BpUq48Mr7pMynLS1Loz3Fo+ihYerUwr3TjiCr6hpMjhVj
         giJhMdLT2bQAFAMbaBd0hJPFQ/LsloNGN/vxqukrPTLXoqsIrIGSnNjqXUUMdVNrrHz6
         FlmYLz2gYMRrLqLumMiz85cQtR4vkKvWuPi5XFn0hjoK6uU/7LeJP/p3GK755Zkp1sPr
         LDv9r2E09G60HWUSUvFynocClEe/NDgYbrlG9vii0wCAxnmP5v0q9YE+93TqToTVZvNY
         an4w==
X-Gm-Message-State: AOJu0Yy69njzpn1dnS+7sA6ZxFYWT5FYSgnB1wOtqOpp6jBb47MtfhLI
        d/AnIIHj6DPL53zHApremBwNpE956+G4EX0yeSbi8+mq97k=
X-Google-Smtp-Source: AGHT+IG/VqY3vkLqgYJkFoWyA3BAQzDL3TGfy+OM6GskqKn3cNhSQnpX1YM1Nnj35Q12kl0+w6BraWus5k49mAtQrh4=
X-Received: by 2002:a05:6512:742:b0:500:7f51:d129 with SMTP id
 c2-20020a056512074200b005007f51d129mr2639186lfs.34.1693653035278; Sat, 02 Sep
 2023 04:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZPDgdGBbxrTl+m2s@debian> <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 2 Sep 2023 12:09:59 +0100
Message-ID: <CADVatmMF1QS235CD4KbDPy_w9hAi0rN1EJqAXtJok2Xg0iE-UA@mail.gmail.com>
Subject: Re: mainline build failure due to 501126083855 ("fbdev/g364fb: Use
 fbdev I/O helpers")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 20:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 31 Aug 2023 at 11:48, Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> > The latest mainline kernel branch fails to build mips jazz_defconfig with
> > the error:
> >
> > drivers/video/fbdev/g364fb.c:115:9: error: 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean 'FB_DEFAULT_IOMEM_OPS'?
> >   115 |         FB_DEFAULT_IOMEM_HELPERS,
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> >       |         FB_DEFAULT_IOMEM_OPS
> >
> >
> > git bisect pointed to 501126083855 ("fbdev/g364fb: Use fbdev I/O helpers").
> >
> > Reverting the commit has fixed the build failure.
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> Would you mind testing the exact thing that the compiler suggested?
>
> So instead of the revert, just replace FB_DEFAULT_IOMEM_HELPERS with
> FB_DEFAULT_IOMEM_OPS.
>
> I think it's just a typo / confusion with the config variable (which
> is called FB_IOMEM_HELPERS).

Yeah, you were right.
Patch sent - https://lore.kernel.org/lkml/20230902095102.5908-1-sudip.mukherjee@codethink.co.uk/


-- 
Regards
Sudip
