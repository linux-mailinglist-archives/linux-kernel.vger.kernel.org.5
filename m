Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6346B7F5E87
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjKWL56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjKWL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:57:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBDD6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd644a96so1023641e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700740675; x=1701345475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PIIYPDZcaUUtbo5ldUSpIo3Jpbx+2SXqPzhdvBEuU0=;
        b=G3L6YooF1ZayRNxRr3E/4rHAzdFlAVRnYgCn2GGvqzzr+LaQyBi1LeYjXz9xaS2Uhp
         ZmhiJ2Dk2ozUH1mRD09uFdyfDT5iwn9/5FWD54YUjRsKxx4rB6CqJP0QUfxdVnsn9Dr6
         ae62hPqryDDW7HOc2mnlnHZnCy+4K5zwoc760/AfyCQgraEjvorw+I7Z9tR+FfK9bvHs
         FXT8EjVjRUQTEIOgyomuN1RJzo1Fh4k7eQU8Fql+AuTSk0jSKZK32xZvJ9VzUjbOync9
         bAOc5DAa+ttACNbkPIl6DOzuVOGH5112Rr2Q70/RJ5rBuiN1F7/SjiF4ZQNDInUpkRZK
         2pnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740675; x=1701345475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PIIYPDZcaUUtbo5ldUSpIo3Jpbx+2SXqPzhdvBEuU0=;
        b=WxuPv2cKxwmaJAVeAk7cHEV31WEw2FOemhHIkM9B/ihA7ZcQd1TkIisjtbLhW0aN4q
         GTMTp6m4Yo+PXufDGC3hlYLPeZkNbcpKaYJdKvHNBl2QFB30jaiH8KKx90LyYckNSdif
         Za88JmBs+YFA+lvL62egkV/uI1IuERrnuROisH9G9ZA0PPbGsJ8cfNVDm/3F+q2zkLSY
         lcpE3MoZ+XjzS57h99JQ+nS0cHwC9z+sNRvFbvfbzk/fcbseytIXOgbhvmsUxbUweZqu
         weXNx52Vi0kU1GfYrWH64/r8Ov+6ndCGhHuUnsCrFVuHwICWMKubamepmbtBhoS0RcoW
         +THg==
X-Gm-Message-State: AOJu0YzZu2EsM/B+4BrGuD+hUmUrAPFEL0p7ybAWREawhhkzi976S1Yg
        nPCOpzY2brGzPxOWp7KDWU1/LQ==
X-Google-Smtp-Source: AGHT+IHEzwFsSiUrHxerkzp2AE6ef97hiVMKuGwN8td7j6ph1CSPFLbE8yWNAIQwxbq6Fe3tMk0EHw==
X-Received: by 2002:a05:6512:3d0a:b0:50a:aa30:f9d7 with SMTP id d10-20020a0565123d0a00b0050aaa30f9d7mr4942548lfv.67.1700740675512;
        Thu, 23 Nov 2023 03:57:55 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651204dc00b0050a71f99960sm167359lfq.197.2023.11.23.03.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:57:55 -0800 (PST)
Message-ID: <3cb4834f-18c0-43d6-8c81-5689df7b1d60@linaro.org>
Date:   Thu, 23 Nov 2023 12:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] Ethernet DWMAC5 fault IRQ support
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <cover.1700737841.git.quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 12:38, Suraj Jaiswal wrote:
> Suraj Jaiswal (3):
>    dt-bindings: net: qcom,ethqos: add binding doc for fault IRQ for
>      sa8775p
>    arm64: dts: qcom: sa8775p: enable Fault IRQ
>    net: stmmac: Add driver support for DWMAC5 fault IRQ Support
Missing cover letter with explanations/an abstract

Konrad
