Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860D7A1C64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjIOKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjIOKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257ACDD;
        Fri, 15 Sep 2023 03:37:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-69002ef0104so1626288b3a.1;
        Fri, 15 Sep 2023 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774242; x=1695379042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phxDcl2cePpng3hZcoSl3/Urge1v5nDXVIV2EedNyt8=;
        b=IM2ODcbHk9e/7MC9cqeqssLDQ+OjcYO+0NfxuqT9d6W9NbhueWSI/6rnWzp5KWm333
         8Wmqz2zpw0L62P8WKdhsKOp+v7B16kGUDkxONMwFVJ/gByImUz7yOjX0XWHFTKlq3pi4
         1V1GMpGK2uKDFuhsyK80af4R2nSo8gOttYeITSBz0tjqwvlLP+0eZfxKgTpGNIsSMm1h
         wT8k/smvdjVcxKNY70KnYXncAKWEnaNg0nVU/qEXXgfGRDzQOgTzBe5/Y9muKYQ59woA
         w/gSTlyR8xwxOXljxXXh7b5B2RW+Q8XlLqmfkW9/ksMsDlEgW48VpFuQPrsuSSzMG469
         h1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774242; x=1695379042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phxDcl2cePpng3hZcoSl3/Urge1v5nDXVIV2EedNyt8=;
        b=HeRTSp5g02r6P6BbFd4+2MMJuHAOCbrsMBspYamjfeCfVPXPw8XWQxhyN85SQJtyK5
         ONjbWXq/nmdP/qWqFb/nFg+C0u/kY8wG4m0OWaxMmwUpmBWuJdzraU2hPpqd8uyBisLY
         GCUkN1egHtzFH3s58btaahtGe7+5iuuUzXvFt7gOS3oCUD92x9jPSf2pWw4xFvN/3OTh
         H3lZGaMO6xsgpN5AWS8zYK7wWSTytWrSJqOKjyrr5lSro3EeeOo7v3JZZx2tJL/wGuQ6
         QVdzMPvhyUpO+hZiCvrsZl1ubOtZvaLhLzhrWy4MgjMxTGdIhNon1oj8tKamoHD52lwd
         SM1w==
X-Gm-Message-State: AOJu0YzrvRXsJZOvD16ZrCokWb79i0L49IQqk1n+pkHw1Upg/Z64d6fS
        eZly9jmxYHR2AsjS9csV/I8=
X-Google-Smtp-Source: AGHT+IHa0aA6BIMxwvmQgFz+Tfi4Cq8fvLjfQGmUolZXWmsr7ZwZPhOgXA4TgTozW1H7LuXlxJxuHg==
X-Received: by 2002:a05:6a20:244e:b0:14d:e075:fc5d with SMTP id t14-20020a056a20244e00b0014de075fc5dmr1444888pzc.40.1694774242269;
        Fri, 15 Sep 2023 03:37:22 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a588200b0026f4bb8b2casm4590581pji.6.2023.09.15.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:37:21 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:37:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        alex@shruggie.ro, olivia@selenic.com
Subject: Re: [PATCH] char: hw_random: hisi-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <ZQQz4eDvCjVCePY/@gondor.apana.org.au>
References: <20230823112139.4012-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823112139.4012-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:21:39PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/hisi-rng.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
