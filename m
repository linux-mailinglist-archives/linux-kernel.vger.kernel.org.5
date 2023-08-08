Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE132773BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHHP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHHPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:54:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F859D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:43:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso804236366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509394; x=1692114194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFQCxsSM2uVo6fho+aJ/OGP5I8Vv4VqgpwCByYL+BHc=;
        b=grgSO98QbHiSVMn+ahaSj7ZfcqJi9juMLcxRMLCjiDrEpIhya2vxIriGWCtyczXfys
         VgIhNw6dWXrRmyiDdbaMUMLBhFzYU4hwC31uzSDngyBkc78rLNk54t8zw3r72FhwSHlo
         dhuMkgKvTxcWpD0Q7ltdYFtfuXYiMS5rzKy9oLQVoJH89Omrv5pLII0Y2hQApRslgyRP
         P5w/547UkuUQKfcBGxU0Ms54OMt2ErZY9bsdy4aioTxzF+fJCcIC3vHOD7/gAc9+96et
         gFqOXwh54aPrsymf7iSDNyntGW4DddQvauGAKhCwmKlY3oyPtQDfD6HzwaiUlpVUqE8+
         CGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509394; x=1692114194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFQCxsSM2uVo6fho+aJ/OGP5I8Vv4VqgpwCByYL+BHc=;
        b=HA9PnLxqtL9hCkQivYzXLzliL7KwarWkRVlf/SE0PXpKZznmmPc+VSOkbnxK4QtlA9
         aX4Zmf/lAulQIZWtDS/9O1z4j5MJ0qwuu5nRkK5yOa+udwyjiY0pUORJuQvgoZClrM/e
         NBHpnkLAlNS9sswcW7r7lv/qC2ZGcTsL0sRmFnRjxMDKUHzYzLG+9U/FMNlhxwkl45OM
         Fa8MKMFd7h9/3lIkkMJxh8j94nQMYmbqstIBEwH82sRGNJxBRpKyW63LtwWw9WzWpYCQ
         MAKreQc+drE3nzc0EskE5KnMBLcw2oUxWBMcimpf6tYUI691CucdoyQ1EruHyzl+LOD4
         Tpcg==
X-Gm-Message-State: AOJu0Yyu/bu9+b9SIPxVhfSBbCBE24LddoePChG3+3FNQIMfMNn8IzBI
        pRfQF4GH+Tl/+glJiXIx1iXGYpOqDDaNwq0UA0c=
X-Google-Smtp-Source: AGHT+IGHV9+UYzYvn5Ls/Ez67OotAAo6suz5ZNdonadR1VetzpLzmLYFNFXgqtoLI29IJKXXrA9EdA==
X-Received: by 2002:a17:906:220e:b0:99c:7333:199d with SMTP id s14-20020a170906220e00b0099c7333199dmr11376507ejs.30.1691507449835;
        Tue, 08 Aug 2023 08:10:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709063a9900b0099bc80d5575sm6773608ejd.200.2023.08.08.08.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:10:49 -0700 (PDT)
Message-ID: <f7f9b3a6-7ba3-3ac1-eb8f-4973d31690f4@linaro.org>
Date:   Tue, 8 Aug 2023 17:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 6/6] dt-bindings: arm-smmu: Fix MSM8998 clocks
 description
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
 <20230531-topic-8998_mmssclk-v2-6-34273e275c51@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-6-34273e275c51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 11:44, Konrad Dybcio wrote:
> MSM8998 was abusingly referencing one of the internal bus clocks, that
> were recently dropped from Linux (because the original implementation
> did not make much sense), circumventing the interconnect framework.

Please mention here that effectively you are dropping bus-mm clock and
the rest is the same as before. It's not possible to figure this out
from the diff alone.

With updated commit msg.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

