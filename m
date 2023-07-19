Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823D758E92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGSHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGSHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:15:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351C1FF5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:15:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98df3dea907so841343766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689750928; x=1692342928;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gggJ+ho+4kj2kjwWGJKnU62Dt5ugjbXcyEz5Qkidj0=;
        b=YebysdanKJANlFyUHs9plVBEgFmwKf11bG4SHPl8XzI9EnEbrXcq/O+QpEcoKq9nKI
         sakHKu75o603EjesPtcgQqaAXGfIj4pQczscyFQyfKNLPrt7WgPMVo8Lw+Z/UTE9jmfR
         16qv8texVJsqyyGm6Ns5nF80FdvjgRrZr3Je69hUDuaGeyIoTL05q2Xh6NOG/SMZfkZw
         uzizrSQCyzvv6Mz44mS/69zNTeXfiMMdU42bcLSvttlOd0zoXppAOuYHeKZK7eI3OD5b
         PNbG8pS79fcWtQFzOGr7qbQ5b5r+4eAbZc/HvWoqwXDmcLNfYX5SiciCrJX4mRQdi3aS
         78SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750928; x=1692342928;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gggJ+ho+4kj2kjwWGJKnU62Dt5ugjbXcyEz5Qkidj0=;
        b=hJZwwoRqPP29H7ewlZsxvfLqao3PDXhnGbw8m7omkAafLjny93k0zOOQQQgkAZm8so
         jwMa7fj2Lc+y+6H3NIrIdJOapKDoe9OPNK1/C7XXQZKlR1FTFMFMgo7XeM1Wr1Uv8wYe
         EU7S6ILfBnjbuGmYJKchZ/60zn5iMncuz5YkXMVG9KEAxXni+vyL/Eg38aB4Cl2rg9W9
         6OrijphM2qm/6ihbSwNq/rba5X56hdic9B6aaPEPR4Yk+8QrNMNCm6pJ6Y7MFi01L6vB
         bNAasav5l6xVna2/if0IizYGE8PW4in5uK+pAdikeXzVhWDq/JRdkXN/V+LokNO7pslN
         R3ew==
X-Gm-Message-State: ABy/qLYsTvdrmCIbbvuhz4F7zySj6zFVtsdxRajPCes2Kb8i4Rwmv4PH
        nb1Mcjtd0lxsyUjkSKJsFOW3gQ==
X-Google-Smtp-Source: APBJJlHLkdms+lG9OGE3bzJfekgpJex4DoVYe3quR18JfSewiMXO/5zW65XnL1HZbhgzDCFzhrfDJQ==
X-Received: by 2002:a17:906:c1cd:b0:991:cf4e:a361 with SMTP id bw13-20020a170906c1cd00b00991cf4ea361mr1521535ejb.26.1689750928736;
        Wed, 19 Jul 2023 00:15:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m14-20020a170906580e00b009930308425csm1933490ejq.31.2023.07.19.00.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:15:28 -0700 (PDT)
Message-ID: <9c540e3b-d8d1-0807-a21e-d01a301c1972@linaro.org>
Date:   Wed, 19 Jul 2023 09:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [V3,02/11] dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring
 up clock macros
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_eberman@quicinc.com, kvalo@kernel.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
 <20230718120501.3205661-3-quic_mmanikan@quicinc.com>
 <9d473f0b-bd6b-f426-3bd2-2890e8a79431@linaro.org>
In-Reply-To: <9d473f0b-bd6b-f426-3bd2-2890e8a79431@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 09:14, Krzysztof Kozlowski wrote:
> On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
>> In multipd model Q6 firmware takes care of bringup clocks,
>> so remove them.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in V3:
>> 	- Rebased on TOT
> 
> No clue what is TOT. We have TIP, but you should not use it as a base.
> Other used names are mainline and linux-next.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Un-acked. I said last time that this does not compile and I do not see
any improvements here.

Best regards,
Krzysztof

