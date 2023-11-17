Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744FF7EF05D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjKQK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjKQK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:28:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35049D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:28:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507975d34e8so2571658e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700216922; x=1700821722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShhCFgXd2a+dvyNdsyEko8wz3smY5YE3Ye1PpRkAbAg=;
        b=wP94JC0JK9jqluLM6ZH/Ed/oo14Kh0wVK9CU2ZoWdEUC/9XKStHiT5WPN5dSi2JUgb
         KNa+G0gPWLJbP1IzKXXXUrirD/xHiW7D6Xcbd9CohrU9DKnmIL51dweIDdtN3sKn30R3
         F91lM9aYQ7lPlVGckQG3qqIzgbDSwwjwSB0evv/NtBo1s+WZtrmIaIkVdV9vYdo1gvNV
         KX2NOF0APy12alcQvrtunLaLhVl7DmGyNuNgHBluMOf4K3N0a6e7arEk6izYPEgQ8vUE
         tqCYSFaWbDD+FP5hrEMcMxwmOnKbIrG5jQqsxZWabo2q56iBu76DfykFV5KdwT9P+nIl
         9PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700216922; x=1700821722;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShhCFgXd2a+dvyNdsyEko8wz3smY5YE3Ye1PpRkAbAg=;
        b=itri2cYbJwTsEtuvPGI/TxCLWJQACvj42W5sZ78ZcOrQjcWvunO7jjdxOOoZnXeNk6
         GWfzN+W8FOpxWFYB36tCygurhhM+vl+QF3j3Vna+VpLC1bNowMEPfnpy38CAD9d9O9X2
         ykpJVTgU7rednSCvP6dvu6TLiQz2gWtjQ0lZKISgDq3afJ9WsY1IqoCkRAcQH8gsk7AR
         pySyrrWred9LwrZe0k6C5YYA+QAKtcDD3QXPE/5mPebestsNMRR0erL8w38bORwFz/zk
         37F3hMZGhSMZpSswrvBOLtqkzlYtHAixCiZ9ZUSd8eARphD604X/8ggPBXeoi3UY5vMM
         QoFg==
X-Gm-Message-State: AOJu0YwOtqr0Gj+er/sEEqOAn/TZnVPL6odsKFpDHBI2xxgR5QZN/zTZ
        0YRbu6Qo+/KljRwUs22QA01SHA==
X-Google-Smtp-Source: AGHT+IF0BZd04HLR6MOunPzO6jiedB2Bw+xOtumPjIrJ/5/oPAvhPKq1GDMGHAIBn4pDBscR/FufTQ==
X-Received: by 2002:a19:ac03:0:b0:508:1a25:a190 with SMTP id g3-20020a19ac03000000b005081a25a190mr13102253lfc.23.1700216922440;
        Fri, 17 Nov 2023 02:28:42 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f16-20020a19ae10000000b005041a71237asm182106lfc.111.2023.11.17.02.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:28:41 -0800 (PST)
Message-ID: <ec50efde-f291-4d1b-a527-d64e0263beed@linaro.org>
Date:   Fri, 17 Nov 2023 12:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] arm64: dts: qcom: sm8550: remove address/size-cells
 from mdss_dsi1
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-6-quic_tengfan@quicinc.com>
 <a66be060-9941-4c4b-84bb-1fcc554791ce@linaro.org>
In-Reply-To: <a66be060-9941-4c4b-84bb-1fcc554791ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:24, Dmitry Baryshkov wrote:
> On 17/11/2023 12:18, Tengfei Fan wrote:
>> Address/size-cells will cause dtbs check warning, because mdss_dsi1 node
>> have not ranges and child also have not reg, so remove 
>> address/size-cells.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ---
>>   1 file changed, 3 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

On the other hand, probably no.

Panels beneath the DSI node will have single cell of address and 0 size 
cells. So these propeties are correct.

-- 
With best wishes
Dmitry

