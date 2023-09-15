Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73D7A1C99
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjIOKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjIOKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:44:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F71AB;
        Fri, 15 Sep 2023 03:43:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69002ef0104so1630512b3a.1;
        Fri, 15 Sep 2023 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774638; x=1695379438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqP1psGcZRdVmUUjw/rzqv6oDKC5zTrt48sqFT23qfI=;
        b=FKeXWFVLR9byiKTQy/cQ/uT8mca9CeFgwj7tL3pyiRqras7yF5c8oEoobg5GAvIT6E
         z1JSAGBEi2QSLM1xcoRvZO7tbBaZ/EP2+VT/+yP64mrW+7trOB3axUCLBuM5iboxFCms
         tv9/LIUYJO3hb+jz6hg6iRKupk2jZg3PySLO8rhqsY/jMCCgtMWW/1//zTc66KPv8ImG
         ZwFSRZUkvDlQdcIlu2jxW0TRC/sU+9C8nLkrh6Ki9KMGeLSahttdgbGN4W3c6pe/4+Tl
         ZvYSzQ0+tFcx97mjNaOpbcJPZ/q4+gvp7mT9s9fScmTRekqEBFXyd7KOMwCZkULgb+Pv
         5Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774638; x=1695379438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqP1psGcZRdVmUUjw/rzqv6oDKC5zTrt48sqFT23qfI=;
        b=bGFaPbP/y/Sa2GIUSbRtXS7zzB3Jc/1ngo8kbPgBNUJbLMLbZuqDGplDjxbb5h19Z2
         2eToYFrPtsguj5ZhWSt6Tlop4qnk7fgHftAlwTQfXsZNkaJGwFDqVmjDMYQckvZkk0FJ
         aisuV6uCIVkZ0Ix524GmSP4zsRgfghHeCCMn9+MknpZxFETmU/HYw/VsDgy/deswYBzr
         BaBg7nJ86xhu6gdJixClMqPHvwDZGTSnF9P9pVhgREBXywnYXfY2y0uOtmqgEiFa5kWD
         fvp7Qp+WJ94TRpFVs3UlP8mOip4N0MkXi0psAhkGiNgRflDD12qkmoqwgou1EzJapL0O
         RYgA==
X-Gm-Message-State: AOJu0Yz0nK+mDrp893g0aJ4PaeZI0C+z0ancuFD4yKjIcoEJAzANxqGa
        z4fMNSXfm4yYx1EifE7KsFw=
X-Google-Smtp-Source: AGHT+IHOCHNovDJgIlga+tOpezqhjzKI6jH+k8BgVMhIvCp0Q/15ToEK4jPuxCUH0jpQL3zgGu2BNw==
X-Received: by 2002:a05:6a21:66c6:b0:14c:4deb:7120 with SMTP id ze6-20020a056a2166c600b0014c4deb7120mr1169542pzb.62.1694774638216;
        Fri, 15 Sep 2023 03:43:58 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id go20-20020a17090b03d400b002612150d958sm4604923pjb.16.2023.09.15.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:43:57 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:43:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Longfang Liu <liulongfang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
Message-ID: <ZQQ1bR16UR0CTFoX@gondor.apana.org.au>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:17:29PM +0200, Christophe JAILLET wrote:
> This error handling looks really strange.
> Check if the string has been truncated instead.
> 
> Fixes: 02ab994635eb ("crypto: hisilicon - Fixed some tiny bugs of HPRE")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
