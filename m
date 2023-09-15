Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9E7A1CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjIOKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:46:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964F106;
        Fri, 15 Sep 2023 03:46:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c43fe0c0bfso1615775ad.1;
        Fri, 15 Sep 2023 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774796; x=1695379596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSl/jwqe6RV3E0AIS7y6p1IAA1dCImMj5GR2Th+oWW0=;
        b=ak3BdVRpa26zD/0oraNbY05qLIu8OvJr+Pts6hVR7s3Tz4eRDERd2H2LQRA0nMBJKe
         J8jvFs7jfishtD0aGPQq6dKN/G1rzs1JleCc0BcwU82qFwv7nrRhl319tHNZBR1rK/2C
         ByR359MbA74ogLuS7lH3UAMc+1g33gWstoiF8pjZRroxHasEpDAmE0NAkEAI2GZIKksG
         7b8WCCcyp3l+ACjv4KPuM1lVHKgZwFlGfdxFGJHjRSpd1sO/srzITO9/isgzUkg4rJSh
         e9t0o1EWF759Rl4Qf2v/ec+7IXDrB9GZlUFrm4Q3IDvlndw6W/kKyNTYDuVYD7lUSKZd
         eBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774796; x=1695379596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSl/jwqe6RV3E0AIS7y6p1IAA1dCImMj5GR2Th+oWW0=;
        b=OqLtWLoaxgHK7nXXVWaIxky5LFGOE2Xjzk51TO63ypuarslM993gtLtkmcDHtfqggK
         Htn+YlZi2d0IqeB7uPlIiBTKfpzgSPDnLPNzIxEejSQa0AcIz+R8SAjcGEuIfo2Us94z
         2OyaMTLVALUD9Zf0XVNIVq1bavsY0bi5Nfo/Nd0tRQAJWhxtOQ/uBLxuimTEzgOW6lxn
         VSCPCM6I9iZXrhOK5vF+8Nye6xzldZUnlFacOZe/uXFTccqekTSd0loEvG6+U9tyoTpu
         RSPZ0HCV8W+1Oyo4oOAW/RkFN7nDwHt/jUaMfqDhW9GiF2R+P8YOoC+wMBtbsglFw61V
         ju7A==
X-Gm-Message-State: AOJu0Yyj1D3Rz+1PdqQArS9qfcEayKYU8ZnyTigmDk8VAOxiWQNTCQS9
        nKqzLTmXxpla0MSDcKHyvf4=
X-Google-Smtp-Source: AGHT+IEzXBmfXb/LKt9bJszwrWMGs2Jy9iUH3YJ3pOjhoVSFEReOW/GFXDqdF1jBJyVcUSgJGjiHsg==
X-Received: by 2002:a17:902:f814:b0:1c4:3e6a:7ad4 with SMTP id ix20-20020a170902f81400b001c43e6a7ad4mr474188plb.13.1694774795719;
        Fri, 15 Sep 2023 03:46:35 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b001acae9734c0sm3161284pll.266.2023.09.15.03.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:46:35 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:46:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Andres Salomon <dilinger@queued.net>,
        Olivia Mackall <olivia@selenic.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Timur I . Davletshin" <timur.davletshin@gmail.com>,
        Jo-Philipp Wich <jo@mein.io>, linux-geode@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: geode: fix accessing registers
Message-ID: <ZQQ2Cv1uL/YVxNBb@gondor.apana.org.au>
References: <20230910083418.8990-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910083418.8990-1-jonas.gorski@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 10:34:17AM +0200, Jonas Gorski wrote:
> When the membase and pci_dev pointer were moved to a new struct in priv,
> the actual membase users were left untouched, and they started reading
> out arbitrary memory behind the struct instead of registers. This
> unfortunately turned the RNG into a constant number generator, depending
> on the content of what was at that offset.
> 
> To fix this, update geode_rng_data_{read,present}() to also get the
> membase via amd_geode_priv, and properly read from the right addresses
> again.
> 
> Fixes: 9f6ec8dc574e ("hwrng: geode - Fix PCI device refcount leak")
> Reported-by: Timur I. Davletshin <timur.davletshin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217882
> Tested-by: Timur I. Davletshin <timur.davletshin@gmail.com>
> Suggested-by: Jo-Philipp Wich <jo@mein.io>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/char/hw_random/geode-rng.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
