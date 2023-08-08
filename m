Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB49773F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjHHQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjHHQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:49:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45454AA8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:57:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so18910315e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510199; x=1692114999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Dr4uBy8yn85pCqbCwYWz6mdcEZRikhyLp+nx7E5kY=;
        b=qiYtfYmq99vWkZ50j+Wg0nJEZdIT+Yazsd5xe2BLCL+TKJAPzhvcygKKm1HSSR8yBX
         eAMQADZYvqxfBXyvJ/r9409G+Pop8t+vCrZMGqd4vsvJeVUe8dh30VxXMrJUxflaF8bE
         ok0MugdtffPHQSZemonCi+yNCQj1fYN25lcTXpqFQbalmDuUxKmZ69NEiHfaq3gN08oF
         GUiQsK0SxJM1H+UsDvZoYkfMmsF6NqTUySBqxqTiFsWss8WJKWJkGshr+PtQLia51mj7
         GfPC1yxpCo9XY0diPsoi8xNdl7G7k4ffoZTsAMBNCUthfYUiE6iTGsppPYLxMe9AIrWU
         v0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510199; x=1692114999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Dr4uBy8yn85pCqbCwYWz6mdcEZRikhyLp+nx7E5kY=;
        b=jBrKSPTJe0fRusGAAufar6fdUv+wKBBYZq7offHnTSIxjNueezx2P74a+XonTHdN+v
         tAYHMs8xr2e8fHNqdahMGC9BPRHZDWBpmKeC0I/z13hmzt/XAQW7x6p/ydTN3F/owqkB
         vvUsmnDQuQNpB8sPztVG+n8F3DWMubkU6ksNiOg+/mYGfXZr+t6kPeuc5QabpRRr7TzK
         /FQ8GF1SaTLxPZaij76l0nGXWhJ6OUTWxVug5Btb2/rWUUKVVKXQxXBL8FdNRnTAnilj
         S0sSCHnNvZanpRPE0pixrbsFIgLtTdNKQ3dfTJ+XuW4uNnlFq1kIjoaien6E/cb4Qxu1
         oTnQ==
X-Gm-Message-State: AOJu0YxWcNf57Mn6pM0j+nJndMInt69lAahZ9yvYe3kbqxu4BlpNvBPY
        DG1cWXFQUJ10idBPbaY/eNpjWzIASFPRGkjcFT4=
X-Google-Smtp-Source: AGHT+IHr55DWuuJ6oQRbZHUALhVQ7SfyjKtBYdUEYQHajPEtsiHRJNUzNkHGVDxpBsOOZTISmy4vmg==
X-Received: by 2002:a5d:5651:0:b0:317:7448:6613 with SMTP id j17-20020a5d5651000000b0031774486613mr8140010wrw.55.1691508574150;
        Tue, 08 Aug 2023 08:29:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm13995888wrr.97.2023.08.08.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:29:33 -0700 (PDT)
Message-ID: <f199af27-0332-b01a-0f1c-63f6679eb68a@linaro.org>
Date:   Tue, 8 Aug 2023 17:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND v2 1/9] dt-bindings: phy: qcom,snps-eusb2-repeater:
 Add compatible for PM7550BA
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
 <1691415534-31820-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691415534-31820-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 15:38, Rohit Agarwal wrote:
> Add a dt-bindings compatible string for the Qualcomm's PM7550BA PMIC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

