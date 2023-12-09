Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AA80B5B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjLIRrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:46:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAEFD5B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:47:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54cc60f3613so4067852a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702144024; x=1702748824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg/ZHOS0VL4Nf8G+0mW63NIqEBrZ4JhvgjdkN33zotw=;
        b=Z+DYad8OFy0NALPzaKHfhMccb7hO7KM9EE/kwiHEwpRvacThk8ESJlqthdVlisIb7u
         17QNyCikdE5VhaC5ViP2+8DjY1RIAm+UcgTNqggbsgiV3J/XZuiRIOk6yCUDlaRECOX+
         yuZuy3R5HJ0bqchIgbCP3jn1BubYAMktAMBd+vO6VwggtlDYYqos8BCe5U0GkzM3os9y
         yNVAzpC2TnraxtJtK/QcMa4xJ7GDu7D/JW4HFBsB/Eh0wnqy7efE204Pqx5kRFW6L//Y
         U4SHYFr8NUKK7GNOqsMCYQfbNBqDsEr3v34x7TdUcEMZwqdRbDCC+44rfuTwLPCMEmHh
         Er1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702144024; x=1702748824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg/ZHOS0VL4Nf8G+0mW63NIqEBrZ4JhvgjdkN33zotw=;
        b=B/4W19KtKAQ8+URZOmaX3r9b2UdOFsTvmxHQN1tby6dcvahcq5MsaVuBgsRq0GOHdL
         z+Bz1aXKkLeWjRal7rFDlRlLb5n2hYGHfj/D4tpKhzNPYYPw0zb5VEb1f8qr+Y3jnIw7
         gDGMypU5ob6rcGunmzdvtO1hyFL+h2AeYm0Bu588hNkrqFn2tTP+mjstuOfqFBK5URMi
         zwXqCgGAXd613KEryCEZGSEVlMZDUdBT+uZAQ0Ae0z/0mKrTrqOumMOvMvzx9stmIr/H
         9MAvVHHruA9gY/bXm53cDmdgDLQGIIgUvpTLmDFrXpaSjua8fHua/AVx2e2aytPFf9UM
         losg==
X-Gm-Message-State: AOJu0YwySKCQzS9lKhP/sTRhxZcwcSo78KdCbWy9HUnvxTe0Af8rbMue
        J7gu4KiiXhP066KE1ZE6GYZpfA==
X-Google-Smtp-Source: AGHT+IEXZJMODaq91N5OUX8Oy5Bqg+b8kDIzEei+JNjhZRFUDiQxQs8FNVFhChAVdm0MBnfpo2dy0g==
X-Received: by 2002:a17:906:1083:b0:a19:a19b:5608 with SMTP id u3-20020a170906108300b00a19a19b5608mr883612eju.152.1702144024279;
        Sat, 09 Dec 2023 09:47:04 -0800 (PST)
Received: from [192.168.36.128] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id ss27-20020a170907c01b00b00a1d9afe42f0sm2447390ejc.35.2023.12.09.09.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:47:03 -0800 (PST)
Message-ID: <0af91794-69d6-459a-8566-c8c408489f2b@linaro.org>
Date:   Sat, 9 Dec 2023 18:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
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
References: <cover.1701939695.git.quic_jsuraj@quicinc.com>
 <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.12.2023 10:21, Suraj Jaiswal wrote:
> Add binding doc for safety IRQ. The safety IRQ will be
> triggered for ECC, DPP, FSM error.
ECC is widely understood, but the DPP and FSM acronyms could be
expanded..

Konrad
