Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD44752014
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjGMLh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGMLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:37:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC02715
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:37:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d20548adso712883f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689248260; x=1691840260;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3afv1tSDU+ds9Iq1atb1848uSvv71WrQkCzCJYr8Bqs=;
        b=tSq8h2z1jv2RYQQbrpUcMJPfWS6sp/lKir2DVDt9mM9qskZiWfnPgd7oSiNUBKfyYy
         YLuRtG9KkSzbuQzOEkv1lcPTMPmGuwVvkAqjHV6Cdm90Jsyfu2yIjZGg/Rs+fokaK+kY
         S7Zw/J4pHwJH3nArFvtTEpZSQZhlEfurqlTUlBu0s0LgWaxkVO4t5zBn/z9sAhQWS8du
         6WcyHesVmsA4n5p4DeiywZmHk503oxOeIYWKIOorrmKgJ1NWQqiX7Z5jUyBIOfo+lrxQ
         BW0ulKZ2Og58U4e+2oz3C04uWD/z6cngbW/nDFdk9myFW+DagCED0iSrAolVJqWRg6YQ
         dQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689248260; x=1691840260;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3afv1tSDU+ds9Iq1atb1848uSvv71WrQkCzCJYr8Bqs=;
        b=f/O5JrDNVicm05mpK1GRfUxCXyRQAcQLS0DIDHSdSGNm1KAlGWtO8FEa0eQaBZLUrT
         Y2oP1dnvPNmxT2LY4h0sEjMa75Q67TrFkaoBaGotP02OmzZ0Kb0PYk1XOE1rVVTMZQeK
         iOHuKoQRyWYHatgspA42NRwg7ZhrxI8kNgI8mPJu21tBJGYvdUr6M4L5HHktsxK/yrVM
         6gWGfHISfr6oiNCl3wi98xj9/BzKwKacyEtANZLyfu05BMtb0052aSFToc+byS5hVDdO
         7UrI9E6Yvt/OWkgdGtLBvWbtHRSbDxLSQnKnkFSLM3UsLXxCvVQ2TUsPF5cYssiISdAZ
         n+6A==
X-Gm-Message-State: ABy/qLaz9yWtTGxM28+8bjxmmhcKd6y1GYubiP+Pps6UQ3fr7RHUdndE
        76zG3wQACgUEx7L8gkWlJdZIog==
X-Google-Smtp-Source: APBJJlGSdUl2/024KdAAcm1SL/4eEW6C1Ed46QDF+qd36ywSCEPwDoG8NweOZ+ffKG0UE87W0Lom6w==
X-Received: by 2002:a05:6000:87:b0:314:449e:8536 with SMTP id m7-20020a056000008700b00314449e8536mr1287763wrx.10.1689248260130;
        Thu, 13 Jul 2023 04:37:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm7748394wrv.13.2023.07.13.04.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:37:39 -0700 (PDT)
Message-ID: <da502dd4-2718-ae9c-51c2-7c9da5c3208f@linaro.org>
Date:   Thu, 13 Jul 2023 13:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_varada@quicinc.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1689160067.git.quic_varada@quicinc.com>
 <e3a6e5cf68d67637fa541f6dc690dbcabd5e3fec.1689160067.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3a6e5cf68d67637fa541f6dc690dbcabd5e3fec.1689160067.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 13:38, Varadarajan Narayanan wrote:
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: M31 USB PHY
> +
> +maintainers:
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.org>

Still wrong email. You should also receive the bounces, didn't you?

Best regards,
Krzysztof

