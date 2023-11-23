Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3EA7F5E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjKWL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjKWL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:57:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C67D62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a5f2193bso833152e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700740668; x=1701345468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQKfSQzvl6n50M4875CnD5xT+T/rNm01RbmwONA33QU=;
        b=RXsw4eQfbefoggqIdo/NjV3dj1Cfogs0lDj3vVTfE12CAjuR4RkoRPwtPtDHaGIpqm
         QiS6fg7zfyvjouoJW6hK6S7gFYYssJ8ormWSWJwh/1qOacejZHmT8iTJMc4cvn68gVju
         pV7YWSW6UgHxOERcbDAaDRd0BK9tC/rHjGKr2HOnAwvNW8koCmEg04E4beKhZnrCTLbb
         PSgnnwiLP6sTryEQ//04uHmzNGYSjYuOhrFLwmzbu3snaFjvbPkDK6JV0VSoLCVPgP75
         0vETqvpUAi2+MFa/Dwm0faJdE3fZyyYmsULnKhHuybZZSiQCI0rZ0azi68fSoQvWNhgM
         v7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740668; x=1701345468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQKfSQzvl6n50M4875CnD5xT+T/rNm01RbmwONA33QU=;
        b=LfKrJmseP1h1hNjGB+by1zcXElS091hRNIcKdKvCQTSMvOgVQ/PKPymJ5hIQFitNeI
         7FaygtpmM7rgGn/k/8V+H2haafskyes0XM0/3PU2R/gnhow0yGtew9z/DxLTakHQ6LT7
         24/fMT0kLMhf3Vk4KbZ6bVm9np3MVAuh+TU8wdwA5316a7iQMrmDgUhyks8YDqE9p62J
         BEXLOlV2xfls+ob92QTuPGjikmz8q1WnkWx2TAft2WxDZLHWMv3vs9IzTa/k/DhKyOw0
         uhsiB/l9DW2QT+N/FG4qEd30BPjIzf9AcsuUuArAE1gvsdRvGpMxGTL5JAoFPhiE0o6R
         Mrng==
X-Gm-Message-State: AOJu0Yy33tzvnXFALbuJVvrr6454ILzID3jHZ7Zqf6NB4dxRncqFlgcy
        AvenepHjPSKTbZIoDOBCXk+8+w==
X-Google-Smtp-Source: AGHT+IE+19JiYtimOS/PBEDLWjSlimik3++amKqAhSSo37eVU9RxdRbmAlBsZzwdcxUkAGtJ0DjG8g==
X-Received: by 2002:a05:6512:3710:b0:507:9b69:6028 with SMTP id z16-20020a056512371000b005079b696028mr738559lfr.24.1700740667712;
        Thu, 23 Nov 2023 03:57:47 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651204dc00b0050a71f99960sm167359lfq.197.2023.11.23.03.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:57:47 -0800 (PST)
Message-ID: <1846a5c7-da25-4cc8-992a-3898bbf403d5@linaro.org>
Date:   Thu, 23 Nov 2023 12:57:45 +0100
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



On 11/23/23 12:53, Suraj Jaiswal wrote:
> Suraj Jaiswal (3):
>    dt-bindings: net: qcom,ethqos: add binding doc for fault IRQ for
>      sa8775p
>    arm64: dts: qcom: sa8775p: enable Fault IRQ
>    net: stmmac: Add driver support for DWMAC5 fault IRQ Support
You resent this series 15 minutes after the last submission,
with no changelog, with no increased revision number and no explanations.

Please refer to the following documents:

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
[2] https://b4.docs.kernel.org/

Konrad
