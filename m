Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39C275100F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGLRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjGLRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:53:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B0619BA;
        Wed, 12 Jul 2023 10:53:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3143b88faebso8180500f8f.3;
        Wed, 12 Jul 2023 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689184416; x=1691776416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy7TMx25OOcOwHTgIEstLTCYZ1iR7it/Mc/2+XGG40M=;
        b=h8D94D46435ovzfgyMBFeIF3u81woZEWgoieagwrfcbFRdfbma8LFIBRR6dM8BvxWJ
         aDgVnEnLH2bGvcs9qX2k+KcTSHDzY4dmtLcG02EMR9FiRuH9AyIFBWay2B9UDvYR04kS
         jRSvY9tcrG8tITd1qQxJyJI2cw0kCv932MRzt35JGrc0febcO1FybDXeTKLIHUs3xTz6
         QT14y26cZjHAbbBcQTN3v47dfMIMczWMMlVy2fGb53sZehQ3cMnU8WjPDLs/9SAfdxiD
         hujh2Drbl5nuAti2rOBdk2E1dzdU6PZ9a7E20Iet08WGeMShend1n58Yh6b3gMrwzpQV
         mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184416; x=1691776416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy7TMx25OOcOwHTgIEstLTCYZ1iR7it/Mc/2+XGG40M=;
        b=CcCbJq1hgZim3cVxrmz3C070qaCMZChyL03S/zHp+vLr/jNpkCd/L+rRqARZCrsrDn
         UXP/3+RCXVQ/2euhnAT1ScjcpVDbZzNtfh94y3iZXotx/D1VnVPFXBjtONsg4AbRDqJt
         Eex3zxYel6qf41gpWXXf+6ZHhCtZhui6vL8n/1XX+CEtiJu+wK9UgSEEWw+4i/xJoToc
         HPnuyJ5lpkZ1GaNg1pfLxjtlm2bgSmzeTMtCcKu9jNUeYSlFRb4V7d6VqZ8aX+Dhzzw1
         ax3xoE2XY/YwY9lLcuaaSiQUr94GiTTRiDd2m8YbZn6jos4pnmGR1p1e0x6CyH3k9sTk
         SLTg==
X-Gm-Message-State: ABy/qLYaeq822f5EGTP2Sp6CfR1Rq77XTHxsXg1P+DbnpcAh+OXNofqR
        UD2dbcCxqc8mt3h0/y10igg=
X-Google-Smtp-Source: APBJJlGe4Oadz97d6MAqk6U26mnQpsHKnU2Pf6ColWhf9rdTpZ7fTGemU/U0qaeoXEhSrRE8pqouPQ==
X-Received: by 2002:adf:e501:0:b0:314:2732:e81e with SMTP id j1-20020adfe501000000b003142732e81emr18810569wrm.8.1689184416024;
        Wed, 12 Jul 2023 10:53:36 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d6506000000b003143b14848dsm5656142wru.102.2023.07.12.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:53:35 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] pinctrl: sunxi: Add some defensiveness for regulators array
Date:   Wed, 12 Jul 2023 19:53:34 +0200
Message-ID: <2688812.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230712-pinctrl-sunxi-boudns-v1-1-85f37de79b9f@kernel.org>
References: <20230712-pinctrl-sunxi-boudns-v1-1-85f37de79b9f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 12. julij 2023 ob 19:19:59 CEST je Mark Brown napisal(a):
> The sunxi pinctrl has a fixed size array it uses to store regulators used
> in the driver. There is currently nothing that ensures that the number of
> elements in the array is large enough to map the regulators defined by the
> individual SoCs. While this is currently the case having an explicit check
> in there will make life easier for anyone debugging memory issues that
> manifest in the driver so let's add one.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index 1dc1882cbdd7..1d1cd3d6d379
> 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -848,6 +848,9 @@ static int sunxi_pmx_request(struct pinctrl_dev
> *pctldev, unsigned offset) char supply[16];
>  	int ret;
> 
> +	if (WARN_ON_ONCE(bank_offset >= ARRAY_SIZE(pctl->regulators)))
> +		return -EINVAL;
> +
>  	if (reg) {
>  		refcount_inc(&s_reg->refcount);
>  		return 0;
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230711-pinctrl-sunxi-boudns-95bf5da3d075
> 
> Best regards,




