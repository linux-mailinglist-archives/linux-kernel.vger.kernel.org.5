Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7342758E80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGSHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGSHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:14:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6461FE1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:14:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99454855de1so606501166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689750845; x=1692342845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSuzImj8Lb6e1WbRzxnhMveJALtbCQgV6WqSEQlBvUc=;
        b=i9XvFD9FoG1guW6kBV01ylznweERqqkNDGmEaH+pLF3Fi9mP3yc9wFhik2dyWNDpkn
         neaBKR3WA49JKbl7cnvTJMnlMP7VWe5JZ+YCBehZcrXnstTYUR1LDiIauBmnVD98d/M2
         eLCH8mIZcvZRbk41G7j4uBIh8GpQojw42JUJ6g0Mu5bqwxfh0CA98SLdrHWx4Z6Ui+N6
         N2FM3tt3t7FQw84cMXa0zkuLslMmMYASnbe5o2GzraHYJIxJx9XYaT4gB5G2y0qyCqkc
         9pSN0ewi6lB7lENkjkTGaPRaPfV3uh28NlG3Ldq0W5M0oUxACZJPIZYNgA9d52uYb3hk
         U3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750845; x=1692342845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSuzImj8Lb6e1WbRzxnhMveJALtbCQgV6WqSEQlBvUc=;
        b=SvlByC0U1U/V/eN6rkz8pvD1skbz1+gbhkyNLuJ7seaCK01hpWu+UCTN9PLgae7pzS
         jtKQL4L8U4EGYxjenh8pm39GCK8ky8s1ISBvTKi7GeTGG5kHKnGBvJJVEVx7bhgKdcI2
         fbx75lwJXcYaYsJkmqce29njT8oDaVPMmhjHFXN1wvQPpl6DbPSpHtCFJX5yX8mtTVaX
         A5gEZ/XpDDgjP2ZSQdMfcHWwZtOO3lFM9710aMELl/PxmDlzwHqfbLoSjXQV/3VvWgdH
         qXBPhU/K7DMw3gpVi9F3FZgNVzgiKF8TyHfeY/1+RQ1douthWeauR3mKc3ny2fjc9VvQ
         sBDQ==
X-Gm-Message-State: ABy/qLbHoaeyUO+JGygqh6SXz8WdWXujpt/1t206plvFcbfeYaWO8Zz5
        mVCO86+SlXp6mD5rZBG6JooSMg==
X-Google-Smtp-Source: APBJJlE4Sxt9jUIzu7cgE+5AockVrEmUMad2CT7N9xqyjXG/icbCxz2K8Ype+QUrEHJMuw1mAQh1Ig==
X-Received: by 2002:a17:906:73d2:b0:982:8c28:c50d with SMTP id n18-20020a17090673d200b009828c28c50dmr1784098ejl.58.1689750844498;
        Wed, 19 Jul 2023 00:14:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m23-20020aa7c2d7000000b0051def9be785sm2262403edp.85.2023.07.19.00.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:14:04 -0700 (PDT)
Message-ID: <9d473f0b-bd6b-f426-3bd2-2890e8a79431@linaro.org>
Date:   Wed, 19 Jul 2023 09:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [V3,02/11] dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring
 up clock macros
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718120501.3205661-3-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 14:04, Manikanta Mylavarapu wrote:
> In multipd model Q6 firmware takes care of bringup clocks,
> so remove them.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V3:
> 	- Rebased on TOT

No clue what is TOT. We have TIP, but you should not use it as a base.
Other used names are mainline and linux-next.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

