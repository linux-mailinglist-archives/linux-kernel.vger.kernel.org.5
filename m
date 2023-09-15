Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0186D7A1C76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjIOKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjIOKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:38:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B3193;
        Fri, 15 Sep 2023 03:38:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso15491545ad.1;
        Fri, 15 Sep 2023 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774311; x=1695379111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btOVjqJn1faldyc3uKYJ7Px+XL49l1yXtToXF/dnaow=;
        b=PcEpNJgaqzlED8jSa30gCABmc4DxDmEX6KlEnFqaYspgF5OIz6o0XopTRS5MHj3bLD
         FjhH6g6rgB8shC50Xle4g6e71/KqnCSL9axF9/sZuixq19Ux+bVSLcztuEmYUp41+EkN
         R5v3dKGSwAF7Naw4Xb+7yspMvMJ5cH7e9DlG8gGqa8vZI8NCmm+RMKHiggCJT1twMgt5
         09OcgMxyfaZBk5c8xBd3CQRtGL5lDdDlj8/BjsJHZ5i40UYfMVqmZSgPAfIkVOBjcHzw
         //sFdM9ADJjPYVBLUWw+oxhJ8Dok7QCUghh962EuBvf6jZ9sHLOaJuI7UEuetQLW8juo
         bt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774311; x=1695379111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btOVjqJn1faldyc3uKYJ7Px+XL49l1yXtToXF/dnaow=;
        b=Iw4CCFOxwTaIgZ4IZd/+ZTLAjNiPVzhy+S+BJH50tFiRmv25rq9LZK2H0IAshJ7GCr
         4b+wtTdjwedJH3EZLYuxtEbh6qd3Esd/kFFz3xZE656V9xYFF49zF7mdC4N0w3xcyUBc
         g8oCjFWXtmMVZpvaPv66jtoAy7QjAUvxNAJxsublPagUUkxIgZ7d8JwhBC8ggVXQ/7lZ
         DF1X3wfUBTPqu9LJedku9+CmgxLSFDIJ0npeVJ6OzpJWp3gEafpLV0/S2ZZLo7YGmh/W
         p3X/IQtchXnqeuwzsipg3BIaCk94CUpTf1Pm64bPDceJdp9fqZF9TNyU+IaIo+2/goVI
         o7VA==
X-Gm-Message-State: AOJu0Yx7fRrlpM1WWs4Yu7d1IP+fGyGwBpJr92+t8okJDx9GAouJ5AVX
        kcTx6nSMSPHiUHpyunhS2Eo=
X-Google-Smtp-Source: AGHT+IGqVTZl1XH3056cSeAtqEr/auv5I/4WWT8JxaRUD8Ou4Zok/Y4astWWohu7GD00lpjl7G2pIA==
X-Received: by 2002:a17:903:41cc:b0:1bb:dc48:644a with SMTP id u12-20020a17090341cc00b001bbdc48644amr1338876ple.49.1694774310627;
        Fri, 15 Sep 2023 03:38:30 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b05e96d859sm3157517ple.135.2023.09.15.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:38:30 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:38:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        olivia@selenic.com, alex@shruggie.ro
Subject: Re: [PATCH] char: hw_random: xiphera-trng: removed unnneded
 platform_set_drvdata()
Message-ID: <ZQQ0JlHIYnA2RiRT@gondor.apana.org.au>
References: <20230828102943.21097-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828102943.21097-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 01:29:43PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/xiphera-trng.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
