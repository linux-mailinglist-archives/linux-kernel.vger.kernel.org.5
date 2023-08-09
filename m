Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD76277642F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHIPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHIPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:40:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AAB2113
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:40:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf3f59905so1007384966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691595631; x=1692200431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yC5xase6smHlx6Uy5irliycOyGMEybwCUwk9LUBQXs=;
        b=t/wqd7+FII8iINHlG1eDUtpIETF3crH/5YRfn29MT/3ap33OUQN2dEGYsBCsN3Z17k
         g9R1pf0KoxuHWQrnAttp6GA6d8mUEaecC+rZN+jAn08N7/+7CIqca2FgQxGI7oB9jdI0
         ju+RHOvg7VRJYBXq9/pGNrw9GtqU7CWGkH1eua8S3E3LVRqBfdb2eos1XCwGUWSyKnAc
         Ux1gFGoS5hOhKKB0CQXtOdKRQcGHlFBLufrhLowjQGYR8UA0wtydQuuOO8HgLRwPAz0d
         NKclJ9eNcgSkgxpVAmhMS3JARTiAq+B677MptiYX1nru4Jbd5V0b/QKBXN1G5aIU/tYV
         nP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691595631; x=1692200431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yC5xase6smHlx6Uy5irliycOyGMEybwCUwk9LUBQXs=;
        b=T4b19v/VbtoRSga1WBoZA970rXlSlyCyWEwpxKER60CubG8WGnP7K3Ad3tDktw/+fJ
         q/1L2vuMC7UzQtfUSOcRaLzAw6azE5NLOHaOklrq6YqKf/gH0EG4IupHuZlc64EWvPih
         n20K0LA4CgHyo/u0/lEYoJtOXhSbPC96b8xJgr9hu2/w5A0h5manVlxc9uBfB3WJZ1b7
         LeZK3nF4OR0wlEeAJa0NWFlR+e/rXrXqnqUmSSktOI+043vl+YLs8OUVDxjsJUQrI8NL
         fzuI7U7VAdXbTeK8zqiqgiPoOri3s23uzGNBCYDfM3HHSWutMhlUwjWsCuO1+iYVG+EC
         a6Eg==
X-Gm-Message-State: AOJu0YyP01o57ML+1cmgudwr3oh8dQCTTaO1sAlRyzjDgrQVhlgrwp0i
        3us49LLONrZj9E7Iu4VkXYL3iA==
X-Google-Smtp-Source: AGHT+IF13UWe1MzHgutPF37GkytYBpFYpWtYYBuaRYhBQgtEtu8j0k3Zh1rX2Rf9+htNW51UD1J/9A==
X-Received: by 2002:a17:907:2bf8:b0:99c:a2ca:4f54 with SMTP id gv56-20020a1709072bf800b0099ca2ca4f54mr2307609ejc.34.1691595631439;
        Wed, 09 Aug 2023 08:40:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id fy2-20020a170906b7c200b00992eabc0ad8sm8074852ejb.42.2023.08.09.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:40:30 -0700 (PDT)
Message-ID: <e42b0248-f7a7-5615-0c8a-8255c8a4548c@linaro.org>
Date:   Wed, 9 Aug 2023 17:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 4/4] arm64: defconfig: Enable qca8k nss clock
 controller
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-5-quic_luoj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230809080047.19877-5-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 10:00, Luo Jie wrote:
> Enable clock controller config for Qualcomm qca8386/qca8084 chip.

Which boards or products in upstream kernel use it? We do not enable
drivers which are not used/needed.

Best regards,
Krzysztof

