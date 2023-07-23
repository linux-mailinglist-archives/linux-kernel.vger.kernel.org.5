Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2075E273
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGWOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGWOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:09:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19C3268E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:08:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3159da54e95so2454279f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690121294; x=1690726094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMHFOpN8dCQzirwYvbZZTFJXmJn2LDjFCTJbeswbnxU=;
        b=AybzwgJxFuP9CrSMbDFqwc9vfK1aWKwjbmr3I+J4qLtyy7cs0qUWc0KnAOEzti6pXU
         71ZOR02RCER5QiscQbcQtuCfuwk3Hyxpoo6535locnTpu8TJ62ENJo+L8u52FZclPqCE
         BF8uhjcrgZqApvxcNo7KygQ5Qxw5VH51nvx6MVPDU6GURGW8AAkyiZYoofbG2o4lTM/n
         c/KzS53tEvSRb4D+QXXv15ECTPMJ/dltRZDmthzGF+f6qulowA6zM3w0iB8Kg+YICScb
         nO9FlpioZkjI6ykDR9FAmcseHtAHuGt1UzNi0ZXOs5uGoRH/UT15Vazuws+kAIqFDEDW
         747g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121295; x=1690726095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMHFOpN8dCQzirwYvbZZTFJXmJn2LDjFCTJbeswbnxU=;
        b=R5F3/ePOA6CZle+PM+e7lYgcgATBsWNkJLwc8odxJPMvfQh8eMWKvXGEaMEElboTtA
         dI4FYNO0cR9cs5+Gg13zuZhJ+d5JrTTrtLM8x8I1ciwXrZArRiwwljSmEqBwlyqxLSFJ
         S81Ecc1WPBkESqOdf7l1qx6hdZSwkZ/MVaSk+/QMgNxBoXKhDO6QX2pHUs5qi+5pyz0/
         bwZ/8H1/BFD0eQmk8ffkfNVul2uDAQw7Zm/ycJDzDLC9bI5Yw7SE8K4Ylsa3I75XchKx
         FDxuVNuhCOXiI8w6aSqq2WNzGjAEObapsdoLd7XDdar5x2SeZgo2KO4l6F36UPJCvkHE
         xQBQ==
X-Gm-Message-State: ABy/qLZqrjOzC7eU+bYBjHtrAjag0umAjmY7vvs6DQyUxxf8L5PY65ZI
        IaYZswUEJrzriWNy2Vr4NMMFgV6jySiP5sKSNWo=
X-Google-Smtp-Source: APBJJlGAvQeJv6UVRWAgX5S6bpwg7RgpsSx8o9aqpnbM+/1UnHXuubPaYqr8YPDHeNKkw4BzfUq1sg==
X-Received: by 2002:a5d:4a06:0:b0:30f:af06:7320 with SMTP id m6-20020a5d4a06000000b0030faf067320mr4579891wrq.23.1690121294681;
        Sun, 23 Jul 2023 07:08:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b003145559a691sm9822586wro.41.2023.07.23.07.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 07:08:14 -0700 (PDT)
Message-ID: <24ea1af2-2304-f4f9-e83e-7ae7101e7edd@linaro.org>
Date:   Sun, 23 Jul 2023 16:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: sdm630: Drop RPM bus clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v1-4-cf6cd5c621d5@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-4-cf6cd5c621d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 17:36, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 

Are you sure you removed all of the instances? I think usb still has RPM
bus clocks.

Best regards,
Krzysztof

