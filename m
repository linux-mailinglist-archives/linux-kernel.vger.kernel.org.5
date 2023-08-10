Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF37778F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjHJNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHJNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:00:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A039E5D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:00:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso13598541fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691672456; x=1692277256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqaq2qh+s+LndcnV3vQwifPWzpMoy4YKSrxCHAVgNTM=;
        b=LtJxCDHcud+FCX7JX/xsiIqAayB9O8LCNdsWksT4hTu/LT9PCaaugwwkKxkWTrmG0t
         /EJVnECdK3JIHGkMeywGDr8Z9MnfNAd7Cf6ELzhJzu9QvhzHmj4tC0X5s4CXsALAru0h
         8pObSCG/L9PM4DBlzfbsNLyAW3ENqnGhooqSdfCUfwZoc8LUan0pWi9uppgn2emhA8SJ
         4PWKPQtcomB9avni5FY1iDjADQKi6WpMA7FLrfHHZzRqYsUdfx/1fJP+11cdHrZ/OPag
         q6tzaBYVPSwH9GrPvan0Lf62kpKiL9IS0/dXvn9AKAslVMaT+m3Rgx57yN5zJ87kC0ow
         vwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691672456; x=1692277256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqaq2qh+s+LndcnV3vQwifPWzpMoy4YKSrxCHAVgNTM=;
        b=Y5t7ob3lTZagucX8xiA1uV+nd2hk23ALeBeDpGPARHWTVjdU8/QAdmpOkGMMt6aHeL
         FUCxfKTcPMWdUJSZEtfTw0mXllk0aGYQKwyezAjNdpnPztZSfsXIjFKKav/KAI3cBB4n
         mog43g7QtwBkjVHPMHs6wbL8DeYB48aoaVG7OoFxY5TzyO3MbEb7GLYJO31S1oYL1r7f
         hPE+ktP+5asnWAL//ZAbAlPxSELz98AezfkEQpwR7f68xj7smr23GshwE9XWlzgT1B5S
         FpmeQfTINBuqttGMFYol4oKmsNIiPEAJcnY7LDEc+6V3CJ0PxLGUWQYu3oRknur1MrIB
         tvAA==
X-Gm-Message-State: AOJu0Yyya5mPfvD94T9nF0SGv4sTvJLCIVIpnQwqXy67q8bZnkSmd0a2
        s4dKLVEd0RmJwLvgZo+gtGVIgw==
X-Google-Smtp-Source: AGHT+IHVGeEHAhNupz7Y8GGIUNrg0/gXepcebg5L4eteUR6BJZyZB003DRwhW9l41F/KAzXUKNOosg==
X-Received: by 2002:a2e:9997:0:b0:2b6:e283:32cb with SMTP id w23-20020a2e9997000000b002b6e28332cbmr2003663lji.23.1691672456229;
        Thu, 10 Aug 2023 06:00:56 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e720c000000b002b9fdfdab75sm354562ljc.12.2023.08.10.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:00:55 -0700 (PDT)
Message-ID: <19d47ac3-ca9f-4181-b3ed-e2bba473dda8@linaro.org>
Date:   Thu, 10 Aug 2023 15:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        quic_srichara@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1691660905.git.quic_varada@quicinc.com>
 <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b17b55b2ff2277bb9bfa99acdb2f98ed420dfb6e.1691660905.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 11:56, Varadarajan Narayanan wrote:
> Add the M31 USB2 phy driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
[...]

> + #define FSEL				BIT(4)
> + #define RETENABLEN			BIT(3)
> + #define FREQ_24MHZ			(GENMASK(6, 6) | GENMASK(4, 4))
GENMASK(x, x) is BIT(x)

Konrad
