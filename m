Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD33755CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGQHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:23:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6C1A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:23:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9891c73e0fbso855935766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689578578; x=1692170578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXlP1v4JTk4UUlDV9gDMep4PAb7EC7+xlKa8eOSv/7M=;
        b=zQ6MmYV5cXxNM6W6B0gYcQ6w1UZyWe0xI+RV5oJrvm/zz56RpmxjJCk34+2iYuz4gU
         Xdulo3ebNzZa/bqpUBDiaiM7oAcuavJvbN/Spyh21ivfjZY9EuClFilXLHOTlyGt+bcL
         dFQ4HZzwRLMhe0ElaC5OyYKoxEzGFZhJFffMoQhRFNfEeepZFEZtfkv7Tn8YIpyTs5KO
         MxFfbwyNcsMQUJwz/V6ggfe5Ja1n0KazYjd85aanB4QC05e3Hnc0I9CjzAzEc4jEDVZC
         ONGy75QaY2zAloTWL8fGznepFMQgPKVmbBsj+CjQwMhR4Ac917aNKfq9ZQ2ujMkXWamE
         v4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689578578; x=1692170578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXlP1v4JTk4UUlDV9gDMep4PAb7EC7+xlKa8eOSv/7M=;
        b=QUzSoVFpQRddz3+s4rsxVCHkAfdvndmcDcrVQivFVWzWgqosu8GREydWZmtUj5Vcon
         /4IkA2IGOH7Gvc9jHsFLQkb2xhIsAnHiVD3OrHycn/BoMoPBOkFZw9vk/5OiNTt1WtuA
         M3D7Pw9MfuDVgZgILMN8cBsago2oSWRvkDzUHalUcl/i447Z1b9TidDwr3hD6Zx7fhBE
         pO7Xj0BV6qXWJheiIqQPRtMWcW3uFHKzeSJC+ddm0S1i4kORjdcPb+X6rBQfUMnAfFA8
         8KiIG93muyWiUjlGIYjA5Q7ExDgHA7E9sSZPDUqMdAvnAZ6w5IWzUxrXJukh130gOY9W
         qQdw==
X-Gm-Message-State: ABy/qLauqAr8mzVFJFym4JHI2x7MN7fXQ779n4KuHJhG0MiS1u4AfLck
        aky5X6T4V1u7SPtokMB45iYGTA==
X-Google-Smtp-Source: APBJJlEcoz6WXD4iI09YndhO8+x1wDKKRnsWKBeCe0xmhQcsXEcH2WLxt/q50EyQEchb2dGtCVoxMg==
X-Received: by 2002:a17:907:3f1b:b0:96f:9cea:a34d with SMTP id hq27-20020a1709073f1b00b0096f9ceaa34dmr10446302ejc.21.1689578578593;
        Mon, 17 Jul 2023 00:22:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id va28-20020a17090711dc00b0099364d9f0e2sm8775550ejb.98.2023.07.17.00.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:22:58 -0700 (PDT)
Message-ID: <56feece9-b5e2-c00a-b2f0-b706e4d19f71@linaro.org>
Date:   Mon, 17 Jul 2023 09:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: qcom: Add sa8775p compatible
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1689311319-22054-1-git-send-email-quic_msarkar@quicinc.com>
 <1689311319-22054-2-git-send-email-quic_msarkar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689311319-22054-2-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 07:08, Mrinmay Sarkar wrote:
> Add sa8775p platform to the binding.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

