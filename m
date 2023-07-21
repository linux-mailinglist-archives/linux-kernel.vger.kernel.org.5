Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08EC75C0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGUIE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGUIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:04:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0130E8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:04:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fd18b1d924so13281785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689926680; x=1690531480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RkqSVR+7llkTa6YTD6wpemPL/KILFkcOg74xryiQSs=;
        b=yYp/ymTIoCgiOMSqQcTSUbLhKN+3wJRprAt/9Ydam8fY5N4+oa1X8r3ZDnkAde/yvn
         UBblbGOR7tMPoLgSXr7hZOlL5n14nMx/0PGl3nbe8FA1XKRZXsR5ymMbm2FTQ7hobsnZ
         wUWhFOIZLI3+vGDNsNMLKNBRIvN/1KjgiC4vVi0VuM2VV7IrNKMX4Y6MAOPhHKiP7Dhb
         SxtaarmGxvILK7R+Gsj0QbHse9G65cLRH715B3DZ3ZPcayjclT02BjT2Goytot2kgWiw
         vU7HGvR/3Dx+J9QhYZYXCADowI5ZI9NT3hyJ1w0P4PQUjN+pc7UgerTG3lsxv9g3uaB3
         /R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926680; x=1690531480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RkqSVR+7llkTa6YTD6wpemPL/KILFkcOg74xryiQSs=;
        b=ff/Da69fppDx7pxWxSMfh6oM04dU0+2XATyIBgUi3xqS5Yjey8Jfnsu2Czyruc0Mi1
         izwhdPzQtDVvZ9F/eHrTo8kO3wMHX0iATk8+5fpnVcQshY0C1Lrij/Y4VoY4Prf+Yqyn
         nyUPtwOhLLhcavP+h+7/l5IcBGF8tS9paib3OcO4zdZZKWQOJoYPi2WmchWseVV0eMUP
         r3Vp6sLKJgWyXo+wEkqGXuzf0IX3eCBenmSii6+JBoa0UgzzpMP5Kqc4rvlnYiBZKM9h
         kwDVkgxRSMyuglMfvz69VaAmJKU4wMOBMC2ReuJV/CTxBxm4Zq9PhetF8+awEkX7YNVd
         AfoA==
X-Gm-Message-State: ABy/qLaGo6o42UuMGti+S6wqXXXbG4m0GA4Hwf5UuEyWhpZutE28ty5u
        9dgUsf64q7uDs72BRBuo8RVc8w==
X-Google-Smtp-Source: APBJJlHDywLFcftzP3Pndyl8kQpYfNXrg4jp0JQi1bGgj6LuGck4OlNyhvFUKpMKKLUfqem+Mt7dbA==
X-Received: by 2002:a05:600c:2214:b0:3fa:8db4:91ec with SMTP id z20-20020a05600c221400b003fa8db491ecmr757702wml.10.1689926680301;
        Fri, 21 Jul 2023 01:04:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbb06af219sm2823674wmd.32.2023.07.21.01.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:04:39 -0700 (PDT)
Message-ID: <1cb6d3f9-7cab-b304-c3b7-49d6f1cd71ee@linaro.org>
Date:   Fri, 21 Jul 2023 10:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, michal.simek@amd.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230721041119.4058430-1-piyush.mehta@amd.com>
 <20230721041119.4058430-2-piyush.mehta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721041119.4058430-2-piyush.mehta@amd.com>
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

On 21/07/2023 06:11, Piyush Mehta wrote:
> Added dt-binding documentation for Versal NET platforms.
> 
> Versal Net is a new AMD/Xilinx  SoC.
> 
> The SoC and its architecture is based on the Versal ACAP device.
> The Versal Net  device includes more security features in the
> platform management controller (PMC) and increases the number
> of CPUs in the application processing unit (APU) and the
> real-time processing unit (RPU).
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

