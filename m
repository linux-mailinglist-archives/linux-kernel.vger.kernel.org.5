Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030D811DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379227AbjLMS7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjLMS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:59:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B41E114
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:59:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bffb64178so8627459e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493986; x=1703098786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNrE6iOMC6ZmXH10NKi8LKgjS0EPT4eglJncC3DzCT0=;
        b=nh42G/pSI3IZihlY3nlnGj1Z3zDQ3wdeQ+AHIVrUeha2IasAhyVaWt5CfF4nPqCZHz
         /5o2DInwrtIiHbOzYqxCO1IfUSdA2NEIodyv4lpbgFZZ3cq3nibK6kqd/MlR7XNHkAjs
         KvMc9u7SOY4Xu/oaSCd5oAfwYWyuEpEs3LbUUV6D8DgK4/9MG3LplRioGnk3h319wH8B
         DcV4XEzOJc9GHnrylDB3PScl5vdxbQl2iBfBnrbvJJKGpZmIi04CacdoyGDuLax3lhBF
         ZPKCGX40cfuScAZWRMxqB5V1MrMH145nZSjO6M2ykhf2xfsZbuvbYoq46C/XZehb6ZKZ
         LQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493986; x=1703098786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNrE6iOMC6ZmXH10NKi8LKgjS0EPT4eglJncC3DzCT0=;
        b=hQNDrzdVwsHzTYZ3nYjUru7vUiRfg0nKrA0BZ1uNik8LExgIu4i55irTGHyREcmjgz
         krKTRwv9DaWDC78fZ6+MHuX1rxGOERFO514eXct6eFFhAYAt6OtJLaBIvRZJO8W35GSA
         7oatgID2nW9EeW8OMI3/0vQS10BUyHzCoZEacE7GI9s9a5u3AQI5iE7KcVy4xfHT1inE
         SpoI99m2UBdXvNwFuU99F/2eS2ndD8l+ZmlD2uRFIduk5WPprnEgXe3MrUik+sZwXoj9
         78r0pJsr946w4xa2Q3N5lpD36mHDJoKqyYAvDwsjgsmXC6HTNV0zQJ74HKB/SX8CrDbK
         A0kA==
X-Gm-Message-State: AOJu0Ywxz/DqA5PcM7qcr5dJNudTjG13N4/v4PAsr0l670JU72hHKSmG
        e0cHmc7fmS7IJ6/6MdcBVk4P7Q==
X-Google-Smtp-Source: AGHT+IHcw2PlO89hKXFwUl/TAuGJKffMwWbwYyqvDxXvI+D/RA+jlT6rS7rVGkiS+uTeHfXx65ZmBw==
X-Received: by 2002:a05:6512:159f:b0:50b:fe57:c7a2 with SMTP id bp31-20020a056512159f00b0050bfe57c7a2mr5427381lfb.5.1702493986418;
        Wed, 13 Dec 2023 10:59:46 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.10.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:59:46 -0800 (PST)
Message-ID: <04f0102d-fed9-41ba-a93e-2d0347d555f0@linaro.org>
Date:   Wed, 13 Dec 2023 19:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jack Pham <quic_jackp@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-5-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 12/13/23 18:34, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: 54524b6987d1 ("arm64: dts: qcom: sm8150: fix USB wakeup interrupt types")
> Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
> Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Jack Pham <quic_jackp@quicinc.com>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
