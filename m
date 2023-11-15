Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A07EC84F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKOQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:20:02 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17ACC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:19:59 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so11066761fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700065197; x=1700669997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icFERsbKRy7KfOqu0tTtbnE8bN6Q90hl/QIfyS74idg=;
        b=QmWb2h693nxK9kNemXp1n67tsqcifoZNbYkEgbGGc3Zw/CQchcwDj5npLnzlGJBmqY
         J7Ka6tWKEExoSxSNZEXsA3+OiN5i8P5/mk995xZLtZDG0fPvOfhIqoopma345ehMlxZG
         sApULPfNprkzeYx4jG8383XHNtvNefC8igWU81m2twbJC0N1EquVQjZqAkHgil9npB8a
         9IMQxymignKe+1TUgZIwpMs4iFqBlV02id79uh91qsdKZ/EBkfFh9kW522ZZYNmohD37
         Cdsn2M1ZqvUqyr0w5nsuLjqwK/8xCdWKBdazEWgbuOoJW6++pxmq9A1Tjm55MVnOHALX
         4shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065197; x=1700669997;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icFERsbKRy7KfOqu0tTtbnE8bN6Q90hl/QIfyS74idg=;
        b=bL0hsVpl98aR33fryCDpvNWDGdVPolwi0QNcav2M+8S7M3D+W3E1yLRqv/VAZpBbai
         8vuDoFoa94EEbbOwCGjMoye+7+UrJ3VJwoh8i2p8R8+uJyADBqams689QrHyH/1iQxJy
         pldJSPyaOBOzeoD33eqAMmTXnLf0PTko/W3Qu/BVcJrGZy5aZIES8PiOtz7mYT4r9JyD
         znK+NvIJUGRHQbrN/Kid2jxAHqeK8rk4LIcnN7uuddBWd33AT37OIyU77S3sFG+er2ug
         rbjjYL7E2vnQbnct3FrlAhDKLfl1mWke/Md6T8IIXECSNVEBZolN+DFMccRCFYJy4M7D
         +pAw==
X-Gm-Message-State: AOJu0Yz1Euhu58gQSn3ekPrhldtXSOzwJ/2uNG/zkbqny749k5Dfm2rt
        0CIsSQ8jhbp/nYfBakKuhqp63qQDSNGdq03KOgARlg==
X-Google-Smtp-Source: AGHT+IES8N0nnyIJL4H2hctBPCl60o8JV4reP/XkECqkfH7STBbygsVf2WKbM5aI8v1zxUkoSTMF2Q==
X-Received: by 2002:a2e:9ec9:0:b0:2c6:ec37:fb5 with SMTP id h9-20020a2e9ec9000000b002c6ec370fb5mr2117421ljk.10.1700065197245;
        Wed, 15 Nov 2023 08:19:57 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651c0a0800b002bce77e4ddfsm1699622ljq.97.2023.11.15.08.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:19:56 -0800 (PST)
Message-ID: <9dec865b-36ed-4686-9d25-1e11e3fc25a8@linaro.org>
Date:   Wed, 15 Nov 2023 17:19:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: correct LED panic
 indicator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/23 10:56, Krzysztof Kozlowski wrote:
> There is no "panic-indicator" default trigger but a property with that
> name:
> 
>    sdm845-db845c.dtb: leds: led-0: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
> 
> Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
