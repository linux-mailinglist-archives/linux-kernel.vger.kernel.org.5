Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF379FB48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjINFsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjINFsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:48:43 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB5DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:48:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so8471391fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670517; x=1695275317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFMKkaMhSsUcFI5NdgHlEe2QFDzkmY/+DSyUfESyT8M=;
        b=ZRU9Ozvp6oAzLTu2qUfaYUwU3c74VGf4WCDM3M3RKVuXV8qG1hSWDcvjVHRLVfGLFb
         zDCQ5TIMWn8v7Yygsubyp3uMD1h10WbGYAA/cAZ6LjH9RPVJKJABisfOzIpmH+pqsUuP
         J1p6Nvg9hQ31dDn8Eb2ch6zCeHVNBIqcc1dlprN+W5uGFnqZlamyERZDjFIIIHYjYxXV
         mdkiAz0BzXeEUorWrHnV/UWgBk5tN3yAIACU1228pbAt4iI4b0ArdybCDAGKHT/OVBgj
         t5Tn/e6iyrNcrZMxcflttizpvIZGv/aNeAgR5DJlCtGA8Qs7DWi2glwtrdth8pdeU7Va
         nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670517; x=1695275317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFMKkaMhSsUcFI5NdgHlEe2QFDzkmY/+DSyUfESyT8M=;
        b=FGs1p+G6Ymr4nw7fVkPjl7riQS+56oXIOlROnC/iTLz84o9gw5P/7BJ+Ql3pTq/qlU
         0KCTflxAEJI+iwAOIMflND0I5Wjay+e9X48G5Tbob43Bg3E4sEpA7GPMHN2thVXg7C76
         bCBlv6gG+vbbc7LJaqL7osoY1h+ni74FL7EOtY/m9EwQk6kfX+r86/lLIVhZOJao9lqT
         7aqeR5e9VedWF9/0R+LRxe945FH/QWsxWIJKtLTEmZK5YquctRVv4eRW9NkftTZTezWb
         xZTIywPPIgEF37pMgQR9R1i1RmsbQx4QVT/uIgIdrkfeEywZuvo1bgj7F8us6LREmUeh
         VZWQ==
X-Gm-Message-State: AOJu0YzXTb9qqblJm4Rs0ifI/voihAcdqfaim0UEIrCL2nnvkxaEISJT
        sO+joz36n+L+nK73t+1S/mwzhA==
X-Google-Smtp-Source: AGHT+IHqvVR9sUD8cthK3BCLbP7cGXgI4MR5vPevghYKfDeQw08fPiB0b1KIyAU6X4cKd9gENw+iQw==
X-Received: by 2002:a2e:3603:0:b0:2bd:a85:899e with SMTP id d3-20020a2e3603000000b002bd0a85899emr3952768lja.3.1694670517278;
        Wed, 13 Sep 2023 22:48:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906248700b00988c0c175c6sm473098ejb.189.2023.09.13.22.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:48:36 -0700 (PDT)
Message-ID: <bc122417-6d59-4c1d-3f73-c20711f9a32f@linaro.org>
Date:   Thu, 14 Sep 2023 07:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/5] arm64: dts: imx93: update gpio node
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230914-vf610-gpio-v1-5-3ed418182a6a@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 04:21, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc, i.MX93 GPIO supports two interrupts, and not
> compatible with i.MX7ULP. So update the node
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 6f85a05ee7e1..011c34a57c53 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -825,11 +825,12 @@ usdhc3: mmc@428b0000 {
>  		};
>  
>  		gpio2: gpio@43810080 {
> -			compatible = "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> +			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";

As your driver change points, it is breaking users, so no :(

Best regards,
Krzysztof

