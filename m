Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDEC7F4C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKVQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjKVQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:32:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7641BC3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:31:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507cee17b00so9097665e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700670703; x=1701275503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcqAwLBMHhKbnOXIvbwhk3murLO6VoRY+tmVMJbtNr4=;
        b=BcIvQlFHZdiaBp41gYdVyAoB6H1w64isIswb9Yb3ht1EZg6t3HW/aUea0Fkr6njjhw
         DwGvLRVUd1dsH47R6Ov07uHVLUFUeWCcrlmGOfXxibbQYO0Cmjcdx8NF74Ogmud6Ifff
         n2Z3VM1Qomriq1a9+nfKXxnk+A4nhV+lMaW8PZQXqfcPvgSNllGUGY3SiyVa2I2Y7Qo2
         sMTXA+2SGXaon9hswalDFSgUFXDQH+HEepLF5qdxYNEbbrR/frznr8XTAk9CvDR+Bkn0
         1U/cof6qx4HAWO7rN7Wmz7gciQDfpyLcGWxd9kNwFJg2SE4UMZ8MLz/Ij3myTFRgZkaM
         J8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670703; x=1701275503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcqAwLBMHhKbnOXIvbwhk3murLO6VoRY+tmVMJbtNr4=;
        b=Y3/aKrnoegXfoTFwCvA1jcQZ7nrwc215C4v8sGYzD3GkE79vPkIVezmkMhehj3IyIM
         7mLMSEV21uU0Ua3h6+dkO38WS5Q7UMnXDB8nNfXzC1TzWiRtGpa6hw84p+4TwX8JxxaH
         Jjo/xkiPMFEZBUy/fzFxIT1DtTVpCNDA1j+AuANPWKKdTM5K5uQ/LwAa+GZh+f1AGyGu
         dOCwS+5Cznb6SL0SFyiafHDgmCSSK49xwuaDEJfmFBvjeNDEl0OOzVSlnzKBVjdWIw7b
         z2JMtXOMzEQtDJaQP3KRTgHY5sKlNT1/G5PlwDoIfiwPmaci8XGiU0ym9FE3JGRci155
         nVnw==
X-Gm-Message-State: AOJu0YwMFr4R+qEgeOdjgi6x1UvkwBHuh9/Atn/A7rBEmBO5TKxOhf5x
        PFnJmiNvVmS5IgIhlQ/IP+YY5w==
X-Google-Smtp-Source: AGHT+IGuzRySC9GW+hhmPSqezL7u+4165dM0VrY/tM74yR1+spUW69ro9qbJ5M3BqQGA+HXaHLzNpA==
X-Received: by 2002:a05:6512:6cf:b0:507:a6a5:a87b with SMTP id u15-20020a05651206cf00b00507a6a5a87bmr2466750lff.51.1700670702937;
        Wed, 22 Nov 2023 08:31:42 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k7-20020a05651210c700b0050a6fd7ec34sm1886640lfg.191.2023.11.22.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:31:42 -0800 (PST)
Message-ID: <d0620c39-9c27-4f25-a160-0e21330448bf@linaro.org>
Date:   Wed, 22 Nov 2023 17:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] clk: qcom: ipq5332: add const qualifier to the
 clk_init_data structure
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-1-a7ff61beab72@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-ipq5332-nsscc-v2-1-a7ff61beab72@quicinc.com>
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



On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
> There are few places where clk_init_data structure doesn't carry the const
> qualifier. Let's add the same.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
