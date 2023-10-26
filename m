Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBABA7D7D65
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJZHJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJZHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:09:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663151BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:09:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40839807e82so2830315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698304157; x=1698908957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BILS8KUyc8CYNIz97erkh2z34zcJnlmkNV4IJqyOsA=;
        b=A6xW9jrQSRg/bQaPX/UJYYZOWoz7c0wepilnjO0d6Yg10wGBxEcTsvs6ivyEDLPqgx
         q6uiQPR93VKmPatWdhY0/3Z+7Gfo9CQrdJ3BPbqo9TXz6iqn3zW6rv9nf4f3dctnZA/Y
         2NNjOZSlqLPFpdB5toZF3UVU+LBMdf197yVBfYRmRdCf0fzWNSWWOEyyAjpQ9jQ3heVV
         9js/QsRT9ZrK2e606l5lBul1w4kWpyxUL40a0TtssLVs7Eock4rn8GWYRYBv9MoYVOUc
         V75ntG2fxCefmnlZYfCV9+rvXVJCj47364IROzcaG73+Mw6Z5Gx4maJR98bw7dXLRCUv
         mUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304157; x=1698908957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BILS8KUyc8CYNIz97erkh2z34zcJnlmkNV4IJqyOsA=;
        b=IQZe6g+pjgAJgRZr9fEb4qM71cpTRic7c4ALG1cUilgPlscfQ0guvbc3ZNo/VR3zpz
         EGt2pOiAnHeAFpy58vE3KzBENcNQBPsVtOJuVJVvoY4QG8v6BbJ089PWBRyh8jXi2ClG
         0gabbjTLZF28RF689WABiA3sQi7XSTkOlICT4MPySXv1sU1GDrRRF2+OLTvo9sA4myil
         seq9czMs3X3T8T3JVK6q0aKiCwe0azA94aEO9AYTAhDQwv9frinuSJ6Tgv/6fZBawJ8/
         rw1jCJe2qH3ZixkM/JsGgETTIZ6Cz2hRSkvBoCTTiZQTpftXuoqPAeSq7sf4WzXS7Cm5
         LTPQ==
X-Gm-Message-State: AOJu0YycCm5RxFXqqd3oaj3b07Y1PIvGZbWsYFwYnBhBv3bJQYU5PfuR
        OErfQxy0ph4JKmfz0zb0qEdrzWDZdPuEaw6n+yw=
X-Google-Smtp-Source: AGHT+IF7MbGTwUiJqzSxkrn8fd143j0rcKtNnGGuZdmy8GATP+kEKFS5l//fd1cA96eKTnbS85SP2w==
X-Received: by 2002:a05:600c:3b03:b0:3fe:d67d:5040 with SMTP id m3-20020a05600c3b0300b003fed67d5040mr1980143wms.5.1698304156614;
        Thu, 26 Oct 2023 00:09:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c428300b0040596352951sm1698897wmc.5.2023.10.26.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:09:16 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:09:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] staging: rtl8192e: Convert array rx_idx[] to
 variable rx_idx
Message-ID: <008844f2-4cc6-46ee-be7c-50446ef11290@kadam.mountain>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
 <f9e3ee95cdc2de810687a9c71f1a9f8d8fdbeac1.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e3ee95cdc2de810687a9c71f1a9f8d8fdbeac1.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:44:24AM +0200, Philipp Hortmann wrote:
> @@ -1614,7 +1610,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
>  		skb = new_skb;
>  		skb->dev = dev;
>  
> -		priv->rx_buf[priv->rx_idx[rx_queue_idx]] =
> +		priv->rx_buf[priv->rx_idx] =
>  								 skb;

I really like how you split these patches up.  Like there was a bunch
of different ways to do that and you chose one which made it so easy to
review.  You made the right choice to avoid touching unrelated white
space issues.

But could you send a follow on patch to move this lonely skb back with
his friends?

regards,
dan carpenter

