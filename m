Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5317A1C66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjIOKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F98EA1;
        Fri, 15 Sep 2023 03:37:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so17752565ad.1;
        Fri, 15 Sep 2023 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774252; x=1695379052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYaRwmAQ1s3MYUiuLQYxUzG6o/LB4qv4cOCg1g/HVsg=;
        b=jO4h6z8YJPO6zL6RHXDmTE56i0vokyURqeMauBCgC1PWbNOWr4Ati72LaT6gjmiOIw
         aawNlZ7fos2LrrPFn7ZXfFlXanKrwnopALAmfZB25y2t8LPF/NfCNO9WMulZ7y1VdcF+
         y7D/noE/062nVgt90ajTK8cj45wRiIqoOsn+h+RDfaJU4PuZsK7btYGsa+gnm6qrw60s
         9HDvsLdFp2jaP50jRGLEKDsycrUI9wyMoZH41latrxaonIRfle2qpDxj5f4435f7xs3w
         +CUeDetH5WdxY60kY+Mll8XJAJiwl+kp1dKmv2wlJ+UmbsOCjRw7c8GpDOGb2DUOV1f7
         n9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774252; x=1695379052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYaRwmAQ1s3MYUiuLQYxUzG6o/LB4qv4cOCg1g/HVsg=;
        b=p+mM0sEXNfYb0bbpxiaVpR6tKOCeaEHOjrOPr/rg5S2gqWc74V3Em6ADp3T+B2YnE0
         l03v7hb5fh3VNJV9tJ/i2KVP3vtZLTswMJuOB8Q7xL181xstOcFTZHLfGUVT9s4ug+Wk
         MLv1qrnJmLaE+V5ND50m1ILUT1qDMvJVIXgndoVDPeCbO4TFHSomoMmkvGva2+ekhPjD
         XeDTdjj4T0KLIYX52pJUspEeGhW7jynwxXENz5rVhSIxlb2Vw1QbNXcHTU+AM4tr74tL
         3/nzdrXUAZmR2/gWGeBhN1ZY1Wg/Pj9liURY0XfsB+dy8A+X25D7R/ISbOkdJk2X6cDS
         0gJg==
X-Gm-Message-State: AOJu0YyZI8b71TESyr9aG4g9JW1Q+frFnjCF/TEyyuyrRmH7bKDaN+2v
        cvdOy1M/K5BYu+EJ75DgIfs=
X-Google-Smtp-Source: AGHT+IHEdd9tXYlZx7iAaWCUy3Zd3XnfkheVE9Ouv9Jazd+2BxOo7CqsEUkhSnnEGWEUwXgvzw+7NA==
X-Received: by 2002:a17:902:e552:b0:1c3:3682:f83f with SMTP id n18-20020a170902e55200b001c33682f83fmr1503331plf.30.1694774252370;
        Fri, 15 Sep 2023 03:37:32 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id z14-20020a170902d54e00b001bd28b9c3ddsm3164643plf.299.2023.09.15.03.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:37:32 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:37:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3]  hwrng: ks-sa - simple cleanups
Message-ID: <ZQQz64WxYDeirM7X@gondor.apana.org.au>
References: <20230824194037.1575276-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824194037.1575276-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:40:34PM +0200, Martin Kaiser wrote:
> Some simple cleanups of the ks-sa-rng driver. Compile-tested only.
> 
> Martin Kaiser (3):
>   hwrng: ks-sa - access private data via struct hwrng
>   hwrng: ks-sa - remove dev from struct ks_sa_rng
>   hwrng: ks-sa - use dev_err_probe
> 
>  drivers/char/hw_random/ks-sa-rng.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> -- 
> 2.39.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
