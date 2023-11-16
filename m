Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2F7EE039
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbjKPL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:57:23 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC49B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:57:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77bac408851so156800085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700135839; x=1700740639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krk4VBYuGi0GRPy3jr9qgf+JsOMGZYRly2u1txqNaOs=;
        b=NzBAC1OXNlUjSNbO+kZVwJXIVxTsaQjBhBadCIP10wQpb15JY6KRRfrqpZ9dFGi+Qj
         RmIKrIYTvl0XycilgJY7u7GKayxbDxuJ3sKGQJj4gClFDOBzhRQMCUQNPFhQFxGEYwCg
         Zluqf7wk7S4Ti9hxSJ/GSLGVX2uSMFkNJrC3ooaU8QdEnO9uic3b4tgshDzPzWnRr+mG
         BYiwPBOdVZXHcH8ntmS/OqlgO8kfrRbkT104M62+mcyOJpyJj/32hGnFC9qrRLL5uvCg
         bMkI93JFLyu3WYLbGFWsklOqJtqQ7Fja2T68bNHEgfL5kDzhdNtNl1ioN+tN3WwKSf5b
         oBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135839; x=1700740639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krk4VBYuGi0GRPy3jr9qgf+JsOMGZYRly2u1txqNaOs=;
        b=BLbwMeQb0+Btrs1m2DdbM2IASkP/t3zxOtUSTWvhe2nNWkuxIatSPSv1oJCXkfyt16
         oqNWakpkoz+y8C1c9W6bL3mcmdBnu3djc+oJHUpt0N8hO0SETLoNfrrSLZCOzgiNhglX
         ntJcc351Q+suaMKUqKPGA2SX9YTOAhUzdQCQCplSFg+0ZZCOL+b+FeRUBenKfCTHGgVn
         ofM4xmSRpkiXfwQL7R7no9Vt+1FmBeOZuxKKTEBZ6g11rW/eHuweQgBKJdprR7eQIF0j
         KpG+sN/CS8Ld0FafRNcsT8x0oddXd7rqCCz+MJKN4iactAHpxB+yAYiohB3lFp01m3ic
         i3xQ==
X-Gm-Message-State: AOJu0YyKhsC3O8Rth1rgaBit5Ia329Bcv7RYHwmOYAcdj2CheI/Y6R2o
        7SgrljghP2pZWxFaXY3dtUoftA==
X-Google-Smtp-Source: AGHT+IFU9LBKvJxlcV3mqN0WuU20u/5D5JH6PPclyR4BBA180Ey+p7XrU5hEyiqU+4an3rs0N3nRaw==
X-Received: by 2002:a05:6214:ca4:b0:66d:5cfe:82a6 with SMTP id s4-20020a0562140ca400b0066d5cfe82a6mr2074829qvs.27.1700135839405;
        Thu, 16 Nov 2023 03:57:19 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4408f000000b00670867d7bdfsm1315936qvp.122.2023.11.16.03.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:57:19 -0800 (PST)
Message-ID: <7786f8e0-2395-4bb6-bc29-071ed637611f@linaro.org>
Date:   Thu, 16 Nov 2023 12:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] net: mdio: ipq4019: increase eth_ldo_rdy for ipq5332
 platform
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr
Cc:     linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-2-quic_luoj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231115032515.4249-2-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 04:25, Luo Jie wrote:
> There are two PCS(UNIPHY) supported in SOC side on ipq5332,
> and three PCS(UNIPHY) supported on ipq9574.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/mdio/mdio-ipq4019.c | 55 +++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index abd8b508ec16..9d444f5f7efb 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -18,28 +18,31 @@
>  #define MDIO_DATA_WRITE_REG			0x48
>  #define MDIO_DATA_READ_REG			0x4c
>  #define MDIO_CMD_REG				0x50
> -#define MDIO_CMD_ACCESS_BUSY		BIT(16)
> -#define MDIO_CMD_ACCESS_START		BIT(8)
> -#define MDIO_CMD_ACCESS_CODE_READ	0
> -#define MDIO_CMD_ACCESS_CODE_WRITE	1
> -#define MDIO_CMD_ACCESS_CODE_C45_ADDR	0
> -#define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
> -#define MDIO_CMD_ACCESS_CODE_C45_READ	2
> +#define MDIO_CMD_ACCESS_BUSY			BIT(16)
> +#define MDIO_CMD_ACCESS_START			BIT(8)
> +#define MDIO_CMD_ACCESS_CODE_READ		0
> +#define MDIO_CMD_ACCESS_CODE_WRITE		1
> +#define MDIO_CMD_ACCESS_CODE_C45_ADDR		0
> +#define MDIO_CMD_ACCESS_CODE_C45_WRITE		1
> +#define MDIO_CMD_ACCESS_CODE_C45_READ		2

Where is anything related to ipq5332 here?


..

>  	bus->name = "ipq4019_mdio";
>  	bus->read = ipq4019_mdio_read_c22;
> @@ -288,6 +296,7 @@ static void ipq4019_mdio_remove(struct platform_device *pdev)
>  static const struct of_device_id ipq4019_mdio_dt_ids[] = {
>  	{ .compatible = "qcom,ipq4019-mdio" },
>  	{ .compatible = "qcom,ipq5018-mdio" },
> +	{ .compatible = "qcom,ipq5332-mdio" },

How user comes before binding?

Best regards,
Krzysztof

