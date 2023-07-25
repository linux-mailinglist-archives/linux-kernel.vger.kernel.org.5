Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26530760D74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGYIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjGYIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:44:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023A1737
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:43:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9928abc11deso885892166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690274620; x=1690879420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/5MYpwZX8YZh9CvTUBEr8SBBjxZ6y5PFcRX0cN4LMc=;
        b=ussonJWJijQ/eUOgdbLQpv5TrOMwVDVKoBE3LhZg+ad+GsoxPLSCtSSA0+FdaFZ7zC
         qUAJRKL5ld8lH93vByTaDRQed8X7786ErNFFtc3mKzlR8MjOs1KCeNsPh+iZ7wy51P4q
         llW6exbHmlX4XVQpe9cn98do8DGTUzThVqz/TJu+c5233aMI/fKaE723eVefzCIbCsV8
         qe4IWAM1z1NfWQkns3W6YuKsqSHNy7HtLRKAGhgo7jpRbSybxGXYvvCfflLCeSPXZ3nc
         crl3FIMPDjx9dAIcjk1NLwScNYY0/KkFtCX+P5rHrZ5rbEOVFqCEAEIEln8jqDDotUuX
         ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274620; x=1690879420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/5MYpwZX8YZh9CvTUBEr8SBBjxZ6y5PFcRX0cN4LMc=;
        b=Zl2/REQW1HmtewXyUh/qURzEYc9D6KqJjb/97qF01L05DOEFFUvtgJfEoLqBKt0m8v
         tuf1jQgrbvs3irzm0u4tUGBfhM/8imsucK79p4rblcPc7ZlRNBy5AXFdv7y3+DRDI1qx
         8TatP6APsyA7sxNhPG1+7nqhQTAQNAWZzu5HKTFMl7RUkgkEB3Rhiem0OKpGVATYavkY
         xw1X72QyfUVrx6uHDZBCMKhIZfs3usvJ69To5hWY5ZNdsun/NXB6e57bB3GHRxY8lbHi
         IaLy0cqeYNU9O226nwm/wTyWn2Of74s4bYYwKvrlHbMDdqnIGA2soRgnLjUVGKIcCibo
         MXmg==
X-Gm-Message-State: ABy/qLYHSTbvw1ed5Jebz9CvWCLMNWMSDd8UcUbVTimFWB5EkmT0RcJw
        8splbVISLNYApsoKXdfF+i9QmA==
X-Google-Smtp-Source: APBJJlEvNfHXCLxKORlgA/+xQIubNxQmZKL3JCOvlOF+ydKTlRXi9gv/lk1Je7+Acf6P1eOxI053Kw==
X-Received: by 2002:a17:907:b13:b0:991:b292:695 with SMTP id h19-20020a1709070b1300b00991b2920695mr12701403ejl.55.1690274620500;
        Tue, 25 Jul 2023 01:43:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709062b0f00b0098ce63e36e9sm7954479ejg.16.2023.07.25.01.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:43:40 -0700 (PDT)
Message-ID: <06136510-0b24-17ab-728b-79a952194a0e@linaro.org>
Date:   Tue, 25 Jul 2023 10:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] arm64: defconfig: enable driver for bluetooth nxp uart
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Garry <john.garry@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Will Deacon <will@kernel.org>
References: <20230725083700.14881-1-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725083700.14881-1-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 10:37, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable driver for Bluetooth NXP UART applicable amongst others for NXP
> 88W8997 and IW416 as found on multiple Toradex SoMs.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

This should go via IMX/NXP SoC tree, so I think you miss here to CC Shawn.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

