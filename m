Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A167514F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjGMAGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGMAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:06:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0F1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:06:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55bc29a909dso152875a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206766; x=1691798766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LOQzfArdKyoh0/cJdj+91t3hCKydREUK4x9SKxUeuZA=;
        b=SNTnxxbDDFD/bB0Z9qGp0bKVb+ImfAwTlsGrRcyOhPwg8/0n0VWon9DRFM/Lp5MNG1
         F3zul1Rh2nd1W+o0RJbEeQwr5CffnpUDifpXfwPBqbga3O+wLoTvIWz0o8XwyutHDbRb
         0HySMMeD7Q4B1VmTdZcY77ptaU1bx8xIXPk84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206766; x=1691798766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOQzfArdKyoh0/cJdj+91t3hCKydREUK4x9SKxUeuZA=;
        b=jMto9XCCTXeK3DseaNNUhVJNUwW7egY1FV/2MfVr2eRpHfGfUnD1iJPQ4CmTbUvKj5
         DYDOujUXoI3G1+NAnrOIshx7V5K0TgYAp4D4tZaBVjjs4yONJ3i8dTwcMh8BChbkQN0Z
         ZMDgHRVjzRVtyg4JxfuiT84PHFZdRI2TxJ4TW0xTJDZnOiaMDjutcEH2eQ54QLn8eyNp
         GoaXDuk0iC6qpEB4LSVQZ0sNOa4j3PTQeA+cZHA3biSTePEl1yAMdoIwGb20q8prYVSP
         7YbO9o66FcGsGXGn1twy84OgUCva0zGxe4lETG+yg0o1b6oe/sXH5wPVxUesKsfeHNPN
         E6XA==
X-Gm-Message-State: ABy/qLatu7mUbPDSzwyYsf6MrGwzYJ1in6LmloLYoRLXeUZm8hpRjvYJ
        iEO6fR8o+YENTU9wAleoCTMNOY/XvhSIEC+wcmU=
X-Google-Smtp-Source: APBJJlEAx7/PcFgkkfn3LeyeGuXgkatlwVNtpXdGig3PXV9pbYE3NZ/bS20n35vKtj5Mb+0pGL3Xtw==
X-Received: by 2002:a17:902:e54b:b0:1b9:ebf4:5d2 with SMTP id n11-20020a170902e54b00b001b9ebf405d2mr108770plf.33.1689206765707;
        Wed, 12 Jul 2023 17:06:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bg4-20020a1709028e8400b001b53be3d942sm4509375plb.232.2023.07.12.17.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:06:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:06:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202307121703.D2BE6DFEE@keescook>
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
 <202305231020.37C95FD@keescook>
 <CADmuW3UAHODqC5YAmjK1sOuo3C56noOa6hsHA+2Es2R9MT36_g@mail.gmail.com>
 <AM0PR04MB62891F29BB182FA2B24A37098F30A@AM0PR04MB6289.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB62891F29BB182FA2B24A37098F30A@AM0PR04MB6289.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:46:50PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Azeem Shaikh <azeemshaikh38@gmail.com>
> > Sent: Sunday, July 9, 2023 9:36 PM
> > To: Kees Cook <keescook@chromium.org>
> > Cc: Qiang Zhao <qiang.zhao@nxp.com>; linux-hardening@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Leo Li
> > <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with
> > strscpy
> > 
> > On Tue, May 23, 2023 at 1:20 PM Kees Cook <keescook@chromium.org>
> > wrote:
> > >
> > > On Tue, May 23, 2023 at 02:14:25AM +0000, Azeem Shaikh wrote:
> > > > strlcpy() reads the entire source buffer first.
> > > > This read may exceed the destination size limit.
> > > > This is both inefficient and can lead to linear read overflows if a
> > > > source string is not NUL-terminated [1].
> > > > In an effort to remove strlcpy() completely [2], replace
> > > > strlcpy() here with strscpy().
> > > > No return values were used, so direct replacement is safe.
> > > >
> > > > [1]
> > > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
> > > >
> > w.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fdeprecated.html%23s
> > tr
> > > >
> > lcpy&data=05%7C01%7Cleoyang.li%40nxp.com%7C11f9df1df1b5440e4ec108
> > db8
> > > >
> > 0ee64de%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63824553360
> > 3780
> > > >
> > 889%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > MzIiLCJB
> > > >
> > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=jcTy3IF37wqC1
> > MWsSuF
> > > > %2F51Z1trQEMaow7BHkPSh3hzI%3D&reserved=0
> > > > [2]
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > >
> > thub.com%2FKSPP%2Flinux%2Fissues%2F89&data=05%7C01%7Cleoyang.li%
> > 40nx
> > > >
> > p.com%7C11f9df1df1b5440e4ec108db80ee64de%7C686ea1d3bc2b4c6fa92cd
> > 99c5
> > > >
> > c301635%7C0%7C0%7C638245533603780889%7CUnknown%7CTWFpbGZsb3d
> > 8eyJWIjo
> > > >
> > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> > 00%7
> > > >
> > C%7C%7C&sdata=Blr0W1oYPIw5uDu7HqlEkU7xOuAo4bQNkk%2Bt%2BAuFqc
> > s%3D&res
> > > > erved=0
> > > >
> > > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > 
> > Friendly ping on this.
> 
> Sorry for the late response.  But I found some old discussions with the conclusion to be not converting old users.  Has this been changed later on?
> https://lwn.net/Articles/659214/

The objection was with _mass_ conversions due to the risk of regressions
being introduced in a way that makes it hard to revert/bisect, etc.
We've being long on the road to doing these conversions to eliminate
strlcpy(), which continues to get introduced into the kernel, even
though it is risky.

-- 
Kees Cook
