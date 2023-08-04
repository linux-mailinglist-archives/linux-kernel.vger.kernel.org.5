Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C2770A97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHDVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:11:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B85264
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:10:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2205024f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691183414; x=1691788214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BY93P7UHnCVF314RaxxZf9G+0fFQim54qLdD3evbkg=;
        b=PzgpS1DX6aKrIudT/jiawRyDxUQU6WO2fhLKfrvLJ6lbG8b/2xgem5S0qyz3ty3LuC
         RPpO3dMWq1pM/xmnJoEvrtF92eqI1F02sUrn4c178joE2kI5IKGgyXj2mnQNBStLeW2u
         4Gk2WiAR0dFMUjNSYah8+SJWcrwG8TxWqR0fDKedTea6EYBuCr8gCOONiGgvY5cRExWn
         dPX7PAxr3njfmtpUL6d8+56S9po0awk7R1NGrnC4lx2wNfneqL+BiKNaj0nF0JMJHfWu
         C/WK7cTngrrbkSI5IFE1WP2iWf9/En+F0A57RlJ13mJ1zbriJG+eTzA0Ndm/OVybH0cM
         q2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183414; x=1691788214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BY93P7UHnCVF314RaxxZf9G+0fFQim54qLdD3evbkg=;
        b=hOxIEgs8ApRuPPo8FyRZ9XM9wqWcxyGU1CNFkYkG8jg/DWXWCU717xUaCIY+N+iunh
         x6YGNwxdn68cM0zekgLa1YdXVNAgKqEcY1f36R/qSwUmfAIQj33fhJBkUiulx5RQo6og
         j7vGHfXEtDGXOcIRYNisRvFA2LuL8vIDqW8MXk9ORjXvfx1AIHLsqc0ihyqgas6r6tcd
         ff/DERQSYohcSlOWjvbGdYzWaAdA2KwmX4twEHrTvuvxn+hGMPlltpzklm67kxuZJ0os
         i2dyR5TufbGlWMDeVHb0TNtp54RxLua5cbj9Ql1SFJtWv2agQoyPs0Xf5ObFDkcbaDrA
         dC/w==
X-Gm-Message-State: AOJu0Yz+EJWzNbdEfYU2FgvkLCUVDTAnBpv0aM1puJThokdGKxvvK3I5
        gGJNYuPEgNSgNWYa9TWlmV13e2aJ7WuT2FLHIBc=
X-Google-Smtp-Source: AGHT+IEplYG8VNYd6oXQL+qTc4J6NbxCuxN0tO2WG5BTlllULHzIak8a0WVBKf7RehUFkiByHy1TjQ==
X-Received: by 2002:a05:6000:367:b0:317:734e:3614 with SMTP id f7-20020a056000036700b00317734e3614mr1997556wrf.39.1691183414573;
        Fri, 04 Aug 2023 14:10:14 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003fba2734f1esm7573095wmk.1.2023.08.04.14.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:10:13 -0700 (PDT)
Message-ID: <989aea4c-50e7-8141-dd60-3f41058192f8@linaro.org>
Date:   Fri, 4 Aug 2023 22:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/6] media: venus: core: Add SC8280XP resource struct
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-6-8c8bbe1983a5@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-6-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:09, Konrad Dybcio wrote:
> +	.freq_tbl = sc8280xp_freq_table,
> +	.freq_tbl_size = ARRAY_SIZE(sc8280xp_freq_table),

Would it not be more legitimate and logical to have 8350 use 8280xp's 
frequency table, instead of 8250 ?

---
bod
