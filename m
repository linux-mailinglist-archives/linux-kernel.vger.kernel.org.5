Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579C7FC510
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbjK1UNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1UNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:13:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA783;
        Tue, 28 Nov 2023 12:13:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so7855017a12.2;
        Tue, 28 Nov 2023 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701202419; x=1701807219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR68o+FcLbsjMSQ16SqXF4RBidgTdDJ0WL15TOT2Y7Y=;
        b=Z8p0bJ7lTmmlvBMHjinpc44Wq7L/itkwxLgNrpiruEVpUmF2oRlhtmVQsCkkRbMcCx
         Jhso6dL8Ce1WOivBMq9X42sa5VDiNaMzVrgG00tSUlgsuaJ5N3sQ/NNbueRat0qyqnIF
         7NkM1opaCXOMKoyYpukTwz4GfI4RYMT8jf05MqOPeJLmMyflTK84MLPSg2jLFJeDR1Hp
         g0WoGSsLgmAAhCFJMIWe5UBiyo2CWAnFhCN62cZdjvjdbqQsQgBz9VVjDXqiE0P45tpj
         CcWJPX+Agf8YH8XxU7lFyuqZye7WdLydm/MHQrwF+qFLsM+2OZx00GHtMProGZ8+b6gL
         su6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701202419; x=1701807219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wR68o+FcLbsjMSQ16SqXF4RBidgTdDJ0WL15TOT2Y7Y=;
        b=d+yHp08o1egA4qrtfzmbosFXf+v0Oh4N0LmrXPLTDbsBjUguSLgMJNhz6b3onpdZRH
         Ng2OYK5pNigMvCCtK4xUMih2D/X4sS3Jw/AZ70uTJRZtSq0SeFFVMcQHygYcKc3y3Xmg
         /qeiNzcNfm42/UulFFAme0vj9+l/WRtgYEbK3uLMWpyc02h3WkJF+6yTfo5jc/642e1r
         r20uuuStwKXzvjFV1fzGLfNVtwMC6OnuhtVGpDv0RPCAu8/r5+gdBpvsRUFKNBCdiJ/R
         eWmdyPaX4ZS1/H8zWu36fZvnxVRo87ZHYosTi0dGEs/BjzDlNcpzALxRROOlRRtxGX3u
         hN8Q==
X-Gm-Message-State: AOJu0YywQ6dB0sWLWlAe/Edqxp1t07EXXT/GIsHao+OvNT8zm6fQkGuO
        LdDSklmgPV9YPLpz70uqz+0L/Wkz+Uc=
X-Google-Smtp-Source: AGHT+IEXtv/0vHkXr7m5Lwaz+QkYqvcyBt48sGWnYQAibbW7HfxmLOVzZwvVsnHhRapAQHTxJ9vXTw==
X-Received: by 2002:a17:907:3a93:b0:9fe:ac0e:9c01 with SMTP id fh19-20020a1709073a9300b009feac0e9c01mr10432027ejc.62.1701202419430;
        Tue, 28 Nov 2023 12:13:39 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906009a00b009b9aa8fffdasm7071508ejc.131.2023.11.28.12.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 12:13:38 -0800 (PST)
Message-ID: <944b641e-9351-40d1-89cb-82b448802aa1@gmail.com>
Date:   Tue, 28 Nov 2023 21:13:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/surface: aggregator: fix recv_buf() return
 value
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20231128194935.11350-1-francesco@dolcini.it>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231128194935.11350-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 20:49, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes
> consumed, therefore an int in between 0 and count.
> 
> Do not return negative number in case of issue, when
> ssam_controller_receive_buf() returns ESHUTDOWN just returns 0, e.g. no
> bytes consumed, this keep the exact same behavior as it was before.
> 
> This fixes a potential WARN in serdev-ttyport.c:ttyport_receive_buf().
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks! Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/aggregator/core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
> index 1a6373dea109..6152be38398c 100644
> --- a/drivers/platform/surface/aggregator/core.c
> +++ b/drivers/platform/surface/aggregator/core.c
> @@ -231,9 +231,12 @@ static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
>   			    size_t n)
>   {
>   	struct ssam_controller *ctrl;
> +	int ret;
>   
>   	ctrl = serdev_device_get_drvdata(dev);
> -	return ssam_controller_receive_buf(ctrl, buf, n);
> +	ret = ssam_controller_receive_buf(ctrl, buf, n);
> +
> +	return ret < 0 ? 0 : ret;
>   }
>   
>   static void ssam_write_wakeup(struct serdev_device *dev)
