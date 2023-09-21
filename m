Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA747A982F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjIURcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjIURcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:32:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E05267
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso12592645e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316098; x=1695920898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEg9oi9fsFQj5N/t7+XiCLJ8W8KXemvDmRrScebryl0=;
        b=An+cvqqTVdQXoWYKWdEkiRWAvhV+NSUK15kKeNySLtRPEg1NVxRzYm4KK9P6qAlY6l
         YyK5bJ6dKIWL29LsOGZII8yEdmzgr0xr0KI1XiKieBoNnW7Cfz9lBZTFzlkVSjg5LvBP
         loh4w5uj9+QmvP4tWvibTaMgkgv/uZqcZKK8MMbmP5pBOYudQCO36zVRkZjgA8bfVzzv
         GsHAwZRzDUmXewMaS048n78j2e934xa1rnZ+5PQlKCIIx4dwO3snAFHLGBLjAEpZ4kII
         Hv5g5Jb4YvKS7fobsPGgLne3l8rpxK8ZnxW7OPsKU/+tUQdu6wgZBIUXMvNimnAY+XXb
         +94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316098; x=1695920898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEg9oi9fsFQj5N/t7+XiCLJ8W8KXemvDmRrScebryl0=;
        b=Bgc3Ejoft6NTmjHfptAzVWoQz6QQfXMJklbBg0k8wbRG5JPJ1OaYI29VM2AowmfIe3
         E0XAl+GCi93OATFPSkMre18MO7/CmF4CZa+ag7m9A+ggH5bydsKB3N9DLwPMGDGSOlSN
         NZqDjYeG/3B+OS9M6+0lnFtrQG8Vu5ircOQ/4TeWTp2s39xAa9UKbf47yM0LHBKWZYgQ
         gn0myMiGtnaKm8ULAqBFVS4NamQwzMUvA5jlHhNW5jKgDzGPZJ8iLIOYszX0gV7WKsQB
         NVHiPA7+N13b1O3aegL7MAjDFk2LPnU2WJnCcS5jXABVBPZU8R9ZSjoB1r/GW+ZjSpm+
         VGCg==
X-Gm-Message-State: AOJu0YyqQTUgVhA4WnRWU+0kuqHaRuZ9BE/Au+up4cv+hOLoHWZZHySj
        Q4VtcAGTA1PXUjHnpNI7d71/cJl139eueQtGO73dbA==
X-Google-Smtp-Source: AGHT+IHQrrrIHyHEDSkfYu9SO7d0pvsOVdZ1oGCXmoscM6UKG4H7ogFMpzJNut6Kcge3kLh4skQepQ==
X-Received: by 2002:a2e:86d6:0:b0:2bc:cc1a:139c with SMTP id n22-20020a2e86d6000000b002bccc1a139cmr4675996ljj.11.1695297522786;
        Thu, 21 Sep 2023 04:58:42 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090634ca00b00997e00e78e6sm931391ejb.112.2023.09.21.04.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 04:58:41 -0700 (PDT)
Message-ID: <707f3f85-d38d-f112-16a7-2c602c453298@linaro.org>
Date:   Thu, 21 Sep 2023 13:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@quicinc.com
References: <1695291692-18850-1-git-send-email-quic_rohiagar@quicinc.com>
 <1695291692-18850-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1695291692-18850-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 12:21, Rohit Agarwal wrote:
> Add dt-bindings for USB3 PHY found on Qualcomm SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

