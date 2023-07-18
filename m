Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A175840A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGRSBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjGRSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:01:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1251A19BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:01:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991fe70f21bso804144966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689703297; x=1692295297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkVGM62mLoDf1421cn8cwTEotQIx3Vb8NTgK8HMMhLs=;
        b=zChok7gLqa3CeX8YEWNGoSPxHG7oVyaI4+5EvYswkjR8IqeKcdDVxDaeSFeDUxvPbe
         bzhLSaNLT4Keg26LYPhrh0NXkFCzQ79n4Rno3rIBtz+XJj2ROIPIc84IgaWhUbnaTOo/
         yRlRL6+X9fG6D1WAWsv6xLsdHAtvQ5esp4a2NECiLsXySWQSjp1LJiCOp3QdoRrg1med
         ElwcBadNtrVzGLlxpXSMW7yFnqw85uISx8daZ30f210Zte0h35C3oc+0zqvvTriJ2+rJ
         REIqn2gbNR4NaGyCE1HgpDJXWkS0FRIOFLWqK9RXB1KfZRlv5bSrqLqg9vhOAmdQ58Zh
         JGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703297; x=1692295297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkVGM62mLoDf1421cn8cwTEotQIx3Vb8NTgK8HMMhLs=;
        b=Ir0yEYWuviT8KHkezcSmbu9UtT7l8KFKA9iPo948tEnEtSuEaasm0ADisoRLmBepj3
         jnJbFenSGqdhnQhBXPAoiFrO6EYA+ANEkoOE2PQaFT1sLxgeMiOwYxbNdwTncNmpmyfm
         oDxBeMYrARd3Cs0jMrf8wXtjbzXDbuf7CaNOT5bWdIRKUvDTO9Ij6b1km56qIfi4ecS3
         Q0DUl8ReqvwVbDBa/nsxN3117zGb645Bct6AhT6Mb0kPeHXK6zm3YuLlcrOqC03m7RYc
         AUg+Vw8txGu0173p/vTPaaX9AUwGBqkCJAj2M43NYwMxXxkYBpNb4C/m+VLOzIP1oLBU
         JB/w==
X-Gm-Message-State: ABy/qLaMFBNrEv6+iPSWde2DffSM0t9x0AL37UbQHHUmOje3rzdf5leH
        eCxfbMXzW18lKptSmHbqw00EYQ==
X-Google-Smtp-Source: APBJJlFhWjdgZ1ezpyp222J0MdGWAGjVP8OoiENBNp0TYKiVYjOrc3M21q/BeICF5P2a9vwFoqzFgw==
X-Received: by 2002:a17:906:53c7:b0:988:9ec1:a8c5 with SMTP id p7-20020a17090653c700b009889ec1a8c5mr340449ejo.55.1689703297677;
        Tue, 18 Jul 2023 11:01:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b0098e0a937a6asm1299075ejb.69.2023.07.18.11.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 11:01:37 -0700 (PDT)
Message-ID: <a12286d2-f929-ed6d-c0f2-4dad5ce6b388@linaro.org>
Date:   Tue, 18 Jul 2023 20:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
 <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
 <4c932cbf-19db-2c88-2558-aa42c5338598@linaro.org>
 <ab0fb666-e370-cb07-367b-f3b88e18fba9@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ab0fb666-e370-cb07-367b-f3b88e18fba9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 16:30, Michal Simek wrote:
>>>
>>> Please correct me if I am wrong. Description about ID should be removed from
>>> commit message because it is not necessary. And
>>> include/dt-bindings/reset/xlnx-versal-net-resets.h
>>> should be added when we merge also DT for versal-net SOC.
>>
>> No, the binding header is needed only if driver is using it. Adding DTS
>> will not change that - still no kernel driver users. No benefits of such
>> binding. If there are no users and no benefits - don't make it a binding.
> 
> But header in board folder should be fine like these.
> arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
> arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
> arch/arm64/boot/dts/mediatek/mt8167-pinfunc.h
> arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
> arch/arm64/boot/dts/exynos/exynos-pinctrl.h
> arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
> arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
> arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
> arch/arm64/boot/dts/freescale/imx93-pinfunc.h
> arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
> arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> arch/arm64/boot/dts/tesla/fsd-pinctrl.h

Yes. If you want to store some constants (register values, firmware
magic numbers) and use in DTS, this is the way to go. Most (or all) of
examples above are for register values.

Best regards,
Krzysztof

