Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8D376653D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjG1HZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbjG1HZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:25:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4D272A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:25:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe05fbe250so3072986e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690529098; x=1691133898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CceitGBktJ5bl2EgyiKuJix09Sqk48kJBWDPrUBjBA=;
        b=ZjLh6glI0DBrWIK8xdiEkIPRsPWu6X/FgZzvSqcn1A9e5fXeUJKT/mt/pbxHGP3Jf3
         /YBA5L2sjF3QY2uhNEaswq4vcYvaokohLR6nh9Zj9E1NxAAtYLtC0aQ+WlSIe0CaK2AD
         mSidRsf2kcPZoxPAcMROKLJTODSnBp5OSrsSZUIu9EONY6+fTOYETLfIHb0eygh4eu+x
         YKCklMiqPmqdm/mKdoSjZ4O0tAcdaw9m2VbH9jSrx/OORMDD+mngg7m7uTgNYIcvzim/
         GEIywiRiP+D1Am0tjSt7yT7wK2PnZgasgs2ZZYoo0XpKE1A8u6z/sUtKsW8xlZAk+t6e
         Lf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529098; x=1691133898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CceitGBktJ5bl2EgyiKuJix09Sqk48kJBWDPrUBjBA=;
        b=iTTWp52woLwGoMaOrEN+qhcC4goFfyg/1vv1UDR2x8YSXkZkWfXLQHucfSW8Rgz1Dx
         2KBGfE0+ePgWkl1VILXtXyNiYO26pf7BtwaENMssQm321dQqN5EfXZ0/NIH3yqLKPj0r
         CFb5RFnou15l4ou7H+teAzLqMMZY/QomAltv0sJwzhxUsZgQqgD2FUibhNNlYz6F1cq2
         plA1UF/M1itVue0h1HzhkJto6NO9nFyDkqpUMv9MoEhO1srxSxW5kfsBwpydCbpQ1o0F
         YEfjSu9rFDW8XR5k8RqhHA0Wki7MjEwNk5FSXbbVhW1GdpX/Km/SRP8HhmEjTefB6ELW
         bTTw==
X-Gm-Message-State: ABy/qLZvV9pRA6pAZHUNwTtv2PY8K+obOdpvUP+1vInqNxybP/siz6R6
        HUbnFbvfTnpfhs5aU4KzSPPPEw==
X-Google-Smtp-Source: APBJJlGdBNk2rNRr5WsXl5NO/tKmrzEZriuWayKLlttvSw0BTfgl1j8i2N4fxBnNU5V5H6Frj9pEXw==
X-Received: by 2002:a19:911a:0:b0:4f8:7124:6803 with SMTP id t26-20020a19911a000000b004f871246803mr973038lfd.35.1690529098498;
        Fri, 28 Jul 2023 00:24:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c514000000b005222dd0b2fbsm1471345edq.92.2023.07.28.00.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:24:58 -0700 (PDT)
Message-ID: <e21be108-28e4-5be7-2dee-73e3668f62ce@linaro.org>
Date:   Fri, 28 Jul 2023 09:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/14] ARM: dts: sti: enable basic display on
 stih418-b2264 board
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727215141.53910-1-avolmat@me.com>
 <20230727215141.53910-15-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727215141.53910-15-avolmat@me.com>
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

On 27/07/2023 23:51, Alain Volmat wrote:
> Enable the compositor, tvout, hdmi and gpu on the B2264 board.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/st/stih418-b2264.dts | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
> index fc32a03073b6..35bf618e0783 100644
> --- a/arch/arm/boot/dts/st/stih418-b2264.dts
> +++ b/arch/arm/boot/dts/st/stih418-b2264.dts
> @@ -96,6 +96,14 @@ st,pins {
>  			};
>  		};
>  
> +		hdmiddc: i2c@9541000 {

You should really override by labels/phandles...


Best regards,
Krzysztof

