Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064B277E870
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjHPSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345454AbjHPSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:13:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111662724
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:13:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so10758102e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692209611; x=1692814411;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=He2Vi01OM0xQbiWEhMR2AG6yIZ5VOc+VfT4ogc1IVgM=;
        b=EVh0vaKgOHEyEfjyAprJdnGfqqTvFyPOV8d6FyF6+towIuL56SVzHr7V1qi2OKgi9T
         qNe0WSosZF4jA8NZNs52+JeRXOAuUCaiAwmOwFBcblBmHUGlIiVj28N+h8c/N9gMUhN1
         QKjYRiZRw5Le6aPCTOHwSPc1dM5US/BaXovHNsk7nU51CLqariRAF9BddHpofqbkmwOM
         dhYYllNHD0Uxq12exbogcowtm0+ksBaESJlXb7ewo4OG3LJOR1/Pwd24P9+aZ2Fe9sm1
         tx9IBh0WU6BFdqBQ6vSahD6GrVV+UDp85znRHleGACFAe+ByI1zLz4Lr+x2SCDMP3Dzp
         iU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209611; x=1692814411;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He2Vi01OM0xQbiWEhMR2AG6yIZ5VOc+VfT4ogc1IVgM=;
        b=CrYJzX+HK3Ijpq7EQynutEjbLkAj/Z6U/jA/N/eHwpkyh2lF/mu1rFRrOJtCcJEmrX
         aOcemFAY3wFeYMsd8GpldpmK2rpdg84/9dV/tlkLNujmze5NbkaYX6WnLj4xoo02++NV
         imnq41lt8/Y8latQkPKEAoP27WYDDLrMEyZVz0lJy5Z61Rb3ql+ymtz78yWaLuMPCVuk
         6za/t3RjLaQwsiC4XUTkJIIHhJs9vbzrvjZER4Xr025SPKe8rnu6Syl80J+L2JGJ8WQO
         bFQXHLbn2S5JP0W0uQtnnvMLP33zrC5/PrKJT3Tq2PmsgNiN/KmQI+UMhwgMBxOQaKVR
         Vw3A==
X-Gm-Message-State: AOJu0YxXv8//tdwDmMEJqZqUp/BH7MafXvja4tsgqAdWX0Iz8IEHzPlv
        aaLL/0P3K5p7mVQfKYI/7H3++A==
X-Google-Smtp-Source: AGHT+IGoQyPdyTc0hbvDhzHWSqUSwWA+hrKfCv4V5ESd6ZBTovqewsPWqC4wFRcMjz11FIE0ydj54Q==
X-Received: by 2002:ac2:4204:0:b0:4fb:7559:aea3 with SMTP id y4-20020ac24204000000b004fb7559aea3mr1866634lfh.39.1692209611440;
        Wed, 16 Aug 2023 11:13:31 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id i21-20020a056512007500b004fbc6a8ad08sm3008542lfo.306.2023.08.16.11.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:13:30 -0700 (PDT)
Message-ID: <538aa051-e263-4ae5-bd32-9e3d106701d8@linaro.org>
Date:   Wed, 16 Aug 2023 20:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, andersson@kernel.org,
        vkoul@kernel.org, agross@kernel.org, kishon@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manish Pandey <quic_mapa@quicinc.com>
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
 <20230816154841.2183-3-quic_nitirawa@quicinc.com>
 <cb1df40a-e879-4095-b5e5-f71a46e92120@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <cb1df40a-e879-4095-b5e5-f71a46e92120@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 20:12, Konrad Dybcio wrote:
> On 16.08.2023 17:48, Nitin Rawat wrote:
>> Add SC7280 specific register layout and table configs.
>>
>> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
> Looks very reasonable compared to what I can see downstream.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
I guess one nit I'd add is that having the compatible list sorted
alphanumerically would be a nice touch

Konrad
