Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8997F5E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbjKWLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbjKWLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:44:36 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE7BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:44:42 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5071165d5so10081421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700739881; x=1701344681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVW8XA5bzUo8eqk22K5VEvjyNNkbbnblzFQyRhQLgRc=;
        b=b9X1F/fVFdOJysikpPD54txxYYv92EGPU9Ssyuh8M3C2FGG6ZxWHZ0758+eaSVqkQi
         wnZKx54Xao062CVwfsKirh9M7Sza5plGE9V5xetdCDy/KdDSkVtNHzLvcWYAIAKmWTd1
         YMXr2agOgSh0i0yuwsR32Hclc/71YngKZvL9cW0NQgmT+SBLs+RDmYjnjKlLhwFHjGyG
         Rpm6Z+AAxHfble0IsMhx7YLvQvPzkYQtGl3GOnRl3coLvT084BF9uAitQ6IgtkDvl31f
         GZ+7SUOIiCPTXTk1m5S/1nCPAvlZClnXdyH0MmKwUCixfSqU/2/MBXvW0VyoETAKD2cG
         XfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739881; x=1701344681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVW8XA5bzUo8eqk22K5VEvjyNNkbbnblzFQyRhQLgRc=;
        b=Aph2Amc7x4gWEgpYbq1IUybWoNVIkIapB/eg7TCE1s72LZWa1cKiojbNKINuppKipq
         bEVtri6+8ITyNTOKpzUan6ZXo7tN6kgVdG/CI2uitSkUhw56jYljbZGrAhQMWY7aP/w1
         0taZVEBLQq5GX++e92OmakFEFIC4//mKtDKykF2EZpfdS+6diqvBYNMy6XwcBOcFYszx
         1uMasGEVW+DC3u7g+xep+wFpPP4CETYmOF0400uKh60kl/3zXlzPXq1esUS71EnB/jZC
         I9jBSz5V8fSnxAs+uM81lpc6Y75IzCmeWKB54wWwySoQXcdmeCJuIU//xBB3fDFEqDu3
         y/eQ==
X-Gm-Message-State: AOJu0Yw0JTaDWZ4kHIke5D510iBvDPQx5bc36/dFea5U9vHwpN47vCDy
        7Ixfe+pDiV67unEWqchB42Q3Iw==
X-Google-Smtp-Source: AGHT+IH0pakFkfqc+E3mM99GckC/gqD782WjMYSnP3CbEroBmmgrEWC9XGMB9xC1wTLYk8jGpNMxhg==
X-Received: by 2002:a05:651c:11cd:b0:2c8:33fd:ca8c with SMTP id z13-20020a05651c11cd00b002c833fdca8cmr3290024ljo.45.1700739881118;
        Thu, 23 Nov 2023 03:44:41 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002c884919bdfsm171902lji.10.2023.11.23.03.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:44:40 -0800 (PST)
Message-ID: <8c43228b-43bc-419b-8620-b8f8401fa59a@linaro.org>
Date:   Thu, 23 Nov 2023 12:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for fault IRQ for sa8775p
Content-Language: en-US
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     kernel@quicinc.com
References: <cover.1700737841.git.quic_jsuraj@quicinc.com>
 <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ff458955a24c0cb4ba41158b8b53fbef00c8237d.1700737841.git.quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 12:38, Suraj Jaiswal wrote:
> Add binding doc for fault IRQ. The fault IRQ will be
> trigger for ECC,DPP,FSM error.
trigerred

spaces after commas

> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
You refer to the IRQ as "fault" in the commit messages, but call
it "safety" in dt.. Any reason to that?

Konrad
