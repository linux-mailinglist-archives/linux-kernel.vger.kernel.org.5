Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B4780829
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359017AbjHRJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359018AbjHRJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:19:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7135A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:19:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso85272066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692350378; x=1692955178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DY8KEU42wJyONdvFAuAwtQpgN/LqKQPJnRBi7LCo0Jw=;
        b=PGCZDux2vtV7ztu4QilXBDEBove9IzsV9bl/zTfi31T6aTBe71Vb1BXL5UTCJNwAvH
         cFidTdHFSiaLUP+m+db/JpNKcXmUy/60trAlwsWokAy7/+5n38qmS/NUgRQ9lCZuQoFM
         T/3KbwyjXEstRavj7uXJb3yXZL4/TuStlvWVvtjkU2RUwP5GV1QZh7riYtq+y7PXhb/B
         ezlGCmkrUsVVr3SWhNe9CdvyFuK1n+0M622BRRU0c1Wac/rxtEiPt2zWGJ+T+eQFGxAM
         rGNNbgbmSlewKRSOfu0ubc/S9tM5+u6MWBW9usCMVQ0XZULry+Auq4oNKgXGsjURb2HI
         lElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350378; x=1692955178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY8KEU42wJyONdvFAuAwtQpgN/LqKQPJnRBi7LCo0Jw=;
        b=kVB66kn8+e8fet6pB8PQguXsjz1z0i/wfVXpk69OSfrmxs8+JQzKxvUXEtufAxHAgZ
         Wbdem0xsy/zQ6d5lrpNTsywuRkGg1x4mGc+7PyARnyTR8Ad3lfKcwNEnQmZMiqlTQN/Z
         4UtiOf60faZv6bseJLohrQKUqBqAfgNm1HnJoRPWH2sikvuULMLGONdKWYDdzsdg8Pez
         9w+5QkrpdhC/X+mdKj/rUN2Jmmy7NYXCw9k8w5RYtjshQRLO/J7YE88j4Fxi5T8WvqNm
         YVOq8y7gG6SnK0wXs93584+AVZM3dTBe2+b17iXDjBxtksrPJcgokscz+AIl51tzJ2hA
         DS+Q==
X-Gm-Message-State: AOJu0Yy3HTb86zECVWYrNwi2NgjfN5A7z9laHF/j9EGe5q7FxmvpAPZC
        xbXqrXiRkUPw5UL0ie/FrgNTjHnYW8RLBHp+u/wP/g==
X-Google-Smtp-Source: AGHT+IHBgmT3LP7egpVe8pisvlD08m+U3szA9+vzZ9fLwy3b5TghIPmErMjDWF2xtxDtB8hW1zNRbQ==
X-Received: by 2002:a17:906:7395:b0:992:d013:1131 with SMTP id f21-20020a170906739500b00992d0131131mr1663697ejl.52.1692350378359;
        Fri, 18 Aug 2023 02:19:38 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b0099d0a8ccb5fsm941471ejc.152.2023.08.18.02.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:19:37 -0700 (PDT)
Message-ID: <05550eda-d95a-6847-ad5d-cdc64b7f4bbd@linaro.org>
Date:   Fri, 18 Aug 2023 11:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] dt-bindings: pci: qcom: Add opp table
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692192264-18515-1-git-send-email-quic_krichai@quicinc.com>
 <1692192264-18515-2-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1692192264-18515-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 15:24, Krishna chaitanya chundru wrote:
> PCIe needs to choose the appropriate performance state of RPMH power
> domain based upon the PCIe gen speed.
> 
> Adding the Operating Performance Points table allows to adjust power domain
> performance state, depending on the PCIe gen speed.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

