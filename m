Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0947D1E77
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJURDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjJURDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:03:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60FC10C3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:03:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507c5249d55so2644559e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697907781; x=1698512581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSb7kDqnL0e0m5qYiaEQPSJy4QoRklt5XP7ajpYmJuk=;
        b=j0nvX3sbdsHiezzlU0qrJtbfCalhKvoa4L6j3bJANoBBo378SEb1eRibwlVQVbR8Dk
         BKr7jUOqoNnR2HhMEWfr/ZRl0J/IBZezXg+FqD6MH2h6qFW12IuXQWZgVdsdhb9tsVQR
         j5SLYIjzgeIdLNasDZIGSxfkaDp+cjM6taP9RfZvGl+3x9RYNOtSxoH1p2rUt3y8PsRF
         +wL4bCieR40k+jfMjgybI2vz4POyw9PJZcnCLowzd43BZTtFY+oS7KKq6iLKwU61jxwo
         KC/ssSosO581+AecsOfDWu2NYfL55HUMSxWcdaR9Y4Ksnq0uu4+NZUgio50DRFVs4NJt
         do7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697907781; x=1698512581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSb7kDqnL0e0m5qYiaEQPSJy4QoRklt5XP7ajpYmJuk=;
        b=r3vtBiW+Vj5ZK3Qe1DEU0cf32juT3PsPKIZ0CvrFqX08O/NtSDIeKLQYNDynOWxhML
         r4DcLkKhWcGHpllWjokCwGS7AxnduPrH0bulTBTt4id70zCDIqc2ppiqxsJpcHYySuQs
         ZlbXM8sEMVMZOcoTRnjzPTAHNwS1YtdfT84HnpFTo8c+50c6INEFmFaI7a/kDa5usJrH
         uPBSHsg3P6+NNNt311TdVc2c7kXW4mqcmC/Vzt0U7HTjaI5X+XFhffZlw+TxgObrhVkz
         C0YHyyMX9LarpJdfPkmLm4fdaxuJUvKK4tSg6faHPYU+5H9RVAzqNt9fY7XIPiatYMBJ
         MJrQ==
X-Gm-Message-State: AOJu0YzoxGPjUCCyq7PdeB6PJbTW7BvGxdZ37+8iPRlT0MdeD2K4C9kB
        XMn4RicqQts4Iyj/aswemWHoVQ==
X-Google-Smtp-Source: AGHT+IFkFBT1w2NRKYUC95udCqUO8PW+c54EilqbVJSiejPFDB94seKhSS6qk1cJzYHca0E65b5Mag==
X-Received: by 2002:ac2:464b:0:b0:507:b15b:8b92 with SMTP id s11-20020ac2464b000000b00507b15b8b92mr3045935lfo.59.1697907781059;
        Sat, 21 Oct 2023 10:03:01 -0700 (PDT)
Received: from [192.168.1.116] (abyl4.neoplus.adsl.tpnet.pl. [83.9.31.4])
        by smtp.gmail.com with ESMTPSA id f10-20020ac2532a000000b004ff8cd27a61sm924443lfh.213.2023.10.21.10.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:03:00 -0700 (PDT)
Message-ID: <808d2409-09aa-4adb-9d91-46f97cefc6c1@linaro.org>
Date:   Sat, 21 Oct 2023 19:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] clk: qcom: apss-ipq-pll: Use stromer plus ops for
 stromer plus pll
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1697781921.git.quic_varada@quicinc.com>
 <c86ecaa23dc4f39650bcf4a3bd54a617a932e4fd.1697781921.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c86ecaa23dc4f39650bcf4a3bd54a617a932e4fd.1697781921.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/23 08:19, Varadarajan Narayanan wrote:
> The set rate and determine rate operations are different between
> Stromer and Stromer Plus PLLs. Since the programming sequence is
> different, the PLLs dont get configured properly and random,
> inexplicable crash/freeze is seen. Hence, use stromer plus ops
> for ipq_pll_stromer_plus.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
