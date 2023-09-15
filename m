Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74787A1C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjIOKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIOKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDF1A8;
        Fri, 15 Sep 2023 03:37:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3aa139a0ab2so1141679b6e.2;
        Fri, 15 Sep 2023 03:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694774263; x=1695379063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aTl45Atg916IrcMSDlQ6uhC5r2cQw4zOo7x5EWFn8I=;
        b=JcNqJVxmmjpcbC5YIdDm/SvP8RkvSSC4RNgZw/adAYE4SdEvv/l18fkywUG8ev5WaK
         DNWFhmlqFWINGt0eRHNLsKCUfH9wRvh+RqWPLKaU+py1pPQWxTnUXkYQjs8VWs9RLVAr
         H/Hxjdusj7GPSBQRbc4Yhdd3dRueXwXdceC8uZYC7xuXalCjxtGaVbcJDKHUMLPNpFGL
         vknevNN7E8pTbPZ7fqfcXGL6bjoHa9NBnVW2JUpAtjWecljATm7t0cUBxGDP8lI2Tf9G
         KWvBG79EUOkErIBBw9qn6kFRLa+G5trZ0B+KvlDumpyIQ1hY9imr14I7/71wiBneneJ0
         p1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774263; x=1695379063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aTl45Atg916IrcMSDlQ6uhC5r2cQw4zOo7x5EWFn8I=;
        b=qcGXhKanBapSgJfX80wk0e1KLYyszA2GL0Tg9My2Gzc/I/2CSH2iZ4U1/Jsu0FcTJH
         jtni/Jj79cCFPGZA2b4akDiErkH3a8ZiBNiIdJ44F/qAfxbbFYuXmEKwIyicyWikjkd+
         BYqUhr82xadATs9gsHx0B7lpEwMxiXA4oG+3YNXEDgmSeT73UwTSoIRWxU0/ttWUNJG3
         lsLpk2enC2f6rMHeBtZGX5KOJ77S0B0+fPcRoePmOMx6Gbq4rmA23+A/+xfn7HytI0Np
         cwRIs37PqIw9YwG2tcFG/lWorD2pwFIA1k1qcTYCuz78bcOhx3SHd+4Z0qUpkY3Boicp
         wlOA==
X-Gm-Message-State: AOJu0YyOrW4wHlpBt5PLUiWNH3KDk4KlmTx+K8vjntDkhLE5EEPAPINZ
        9OkJadt9/6pCgyYeuxjdvCrEJsBcxcGbGg==
X-Google-Smtp-Source: AGHT+IHfDkAF5lFxzwCsuzooqcT5wVc2Lv0iPF2B9l36BbfPHfEJb18Xe/wuI3oIXfupOT/8Z4mfvg==
X-Received: by 2002:a54:470a:0:b0:3a8:84a9:242c with SMTP id k10-20020a54470a000000b003a884a9242cmr1119739oik.42.1694774263440;
        Fri, 15 Sep 2023 03:37:43 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id i123-20020a636d81000000b0056c2f1a2f6bsm2520465pgc.41.2023.09.15.03.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:37:43 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date:   Fri, 15 Sep 2023 18:37:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: nomadik - add MODULE_DESCRIPTION
Message-ID: <ZQQz98TbipuBaiQo@gondor.apana.org.au>
References: <20230824195658.1582059-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824195658.1582059-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:56:58PM +0200, Martin Kaiser wrote:
> Add a MODULE_DESCRIPTION to fix the W=1 warning
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/char/hw_random/nomadik-rng.o
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/nomadik-rng.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
