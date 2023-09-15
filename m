Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2F7A1C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjIOKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjIOKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:38:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F57CC7;
        Fri, 15 Sep 2023 03:37:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34df2a961a0so6849595ab.2;
        Fri, 15 Sep 2023 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774273; x=1695379073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwd2N0grIdPSYN+tUTD2RB+Rwy9jZb2v050gmLsT66I=;
        b=SFQRYqgcx8lGgp5+OM56Vf7iGXsSJVJEkvu3oHTOOReFXFiunzsYC5XT7CMo02voH9
         7IkRm+n7GbIVw8ur9Qae2wY9kT+nSuEqCkKz/pfSDak6RpFaw1qpj684Py+QEix1En8A
         jdplg98ElguLriz5onc8jWt10RQkBKGAy0MVhGs6bENr2IcjcM1MlZNTaYLjmzfN0/s2
         72LSOjgo6YV6fWUuf7Cs7bG34yOPT8rD+xeZPzUFKkay5z1r6gjpyjyqS4IfQHX/C2Wg
         LXZGIeLHVxhBD3U4LRXZFID4wfAVrFSf3se3y4TAlxBI6+N1cy357+kR7XURoKsGBx+c
         izMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774273; x=1695379073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwd2N0grIdPSYN+tUTD2RB+Rwy9jZb2v050gmLsT66I=;
        b=vgxn7/WBxxEnDst0hyDRHeOXQXITsFGVIxbqpLzl3DQ5ewlvT0vAvQW3pBHcGD3JSZ
         WMJ7vkd9HpxthDQdLoZkvyk7hp6K22sYtD5SvTBH8aiLib/1eOfb99ujnM2pbTuuAtfD
         aonI7fafOckMgbFWtb7w+DB2aACIDB2LGuXqJ8YMVE2o1lnL0KkiYnPx5Wu/4u3JbJH0
         u9wuHrOuHAV7fn4Z9XwZX5HiUbKfj3EY4YYqV5nOMpLJ9tKqKIveOXqPEVKW7GKjzIHi
         mcMd1l1xucuayaVzLoSE055uENXRIrnoyoGdkw7Z7uTszBMz8ItcPR1sx4cfZcckL4sa
         UVlg==
X-Gm-Message-State: AOJu0YydDZWD1ZJpkQoFof8zG2CzTi+6O+8+4RivhzPByNmgDQ4S2ZKc
        jWEnpeOLa77Ot7w+2b0+slQ=
X-Google-Smtp-Source: AGHT+IGWBMxNI+6TgvWa2nBzX4jO0KFiEem1tZH+YPg9BBgMHT6NDi77jNexEiFVJKcT9PV0avh5eQ==
X-Received: by 2002:a05:6e02:1d96:b0:34d:ee65:a8ca with SMTP id h22-20020a056e021d9600b0034dee65a8camr1712828ila.24.1694774272870;
        Fri, 15 Sep 2023 03:37:52 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0068fe9f23bf4sm2715553pfo.103.2023.09.15.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:37:52 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:37:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: st - add MODULE_DESCRIPTION
Message-ID: <ZQQ0APjy52fDgCAK@gondor.apana.org.au>
References: <20230824195740.1582088-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824195740.1582088-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:57:40PM +0200, Martin Kaiser wrote:
> Add a MODULE_DESCRIPTION to fix the W=1 warning
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/char/hw_random/st-rng.o
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/st-rng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
