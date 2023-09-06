Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039879377F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjIFIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjIFIw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:52:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365BE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:52:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so2788473f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693990373; x=1694595173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfJ6EiGtQip0OGudrI4BPeU8/IOFG65Mt4ZCTg7kHPM=;
        b=OMEn+srEz/mfdc9x42fsIENrvoTlN4z01/CbrbE5YS7UhwOWafieUi8Fr5iLJY4SYg
         4C6dIPXompw7FGSeunaqfLz2Xo+AKX489PGg6yUzqdRZB7tESpCOkyrOlm17hBSWtj+V
         zMN2PBT6JxyX/NQIttdJwlMnp6dvpY+uAZFEAD9GyVGP3/3poV0RtumY+IoxMxCVlYMZ
         OMWW3xLiBj2oZV/mSRqkkwM+0gayqdRTprAb5EtRRFtlNBxXz5xDFTAm2z0jV3plWG6m
         N1PNnCOpCWJT+th4aynSGBqcg9gjfzXLmQ7sY67u3iwJuiv7xXUd23wqRrBggDXWeZii
         0d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693990373; x=1694595173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfJ6EiGtQip0OGudrI4BPeU8/IOFG65Mt4ZCTg7kHPM=;
        b=LR5mJKIjgN625nGoAGsw6l0pRz0sw1p+Y9j7o2S3X+n6MnT+nt9A5a6IjK6Medbkwm
         HkORDpY6vdLvTIxlasrPb4yP0t8iPUcrI4mqGpPzci45vpfJbLtsJyNnlUodllNfayEl
         BN7nyULNHZFaTTgLh1TRro/XcC1b03jWfsW1ZOPV2UX32wF+r3Dvfs9njmiiz5zx4DfI
         nz2PYGGuH3TVge0gVNFak710W6Vn5rgnCidJTOfUhxKAs00/JfpCg1CDp2pVM/CMwfDc
         tSjMRlYRk4jvJAMNwTAdKx4p1TMqJWdsATbsiysWdxXN7Z3C6g5yM0Kx59cCDNrV5cjk
         Mxnw==
X-Gm-Message-State: AOJu0YyUBkUCFsFh7R35VY2g+hWicReZiCG+UatCQsIqPvS7VZT5A/5l
        yReMTRTThJ0vzddl+X6fd18mPA==
X-Google-Smtp-Source: AGHT+IH9dK1R9hCLbXHFqEQjm71wqlFg//hfLFlBI0i2Te1UllPFWp2LBixdSShTbZzRa/EQOXWoPw==
X-Received: by 2002:adf:f24a:0:b0:315:8f4f:81b8 with SMTP id b10-20020adff24a000000b003158f4f81b8mr1786330wrp.50.1693990372951;
        Wed, 06 Sep 2023 01:52:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v2-20020adff682000000b0031c5dda3aedsm19831973wrp.95.2023.09.06.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 01:52:52 -0700 (PDT)
Date:   Wed, 6 Sep 2023 11:52:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vme_user: Fix block comments where '*' on
 each line should be aligned
Message-ID: <775380d1-add8-4f1e-a9df-85b8ec0b9043@kadam.mountain>
References: <20230905194632.19174-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905194632.19174-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:46:32PM +0200, Jonathan Bergh wrote:
> Fixed checkpatch warnings where lines with '*' in block comments should
> be aligned and were not as well as incorrect tab spacings at the start of
> comment lines.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
>  1 file changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
> index dbdf5dabaf90..9748b7897527 100644
> --- a/drivers/staging/vme_user/vme_tsi148.h
> +++ b/drivers/staging/vme_user/vme_tsi148.h
> @@ -251,28 +251,28 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
>   */
>  #define TSI148_LCSR_VMEFL	0x250
>  
> -	/*
> -	 * VME exception.
> -	 * offset  260
> +/*
> + * VME exception.
> + * offset  260

Your patch doesn't introduce this but it should be hex 0x260 instead of
decimal 260.  Same for all the other comments.

>   */
>  #define TSI148_LCSR_VEAU	0x260
>  #define TSI148_LCSR_VEAL	0x264
>  #define TSI148_LCSR_VEAT	0x268

regards,
dan carpenter
