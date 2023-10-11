Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB27C501C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjJKK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346256AbjJKK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:28:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE53CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:28:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-505748580ceso8422271e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697020130; x=1697624930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ht5utTuG5wW1wq2rrU2pauj363H+uTmJt1GixQr1DSM=;
        b=EVRtXE67gk+LC0mXBwljVYzi7ZwnklKR9lIwbViIMLS3LuACZ2Ry91HKub8sBBvcuJ
         RkRbXaFKh5xJZypm8mBJf53ajuE+YprOBiwkDheoECB3fBFAxDffEIgfC/svXUpyBfPj
         qfBGh6SeTRH42VEABkdZrlk5pud2VkPC9Z3wbbGwqWg5VJyjGrLq8HWkXltiiObQ83Pm
         0XA3JuhDADijpZMLFoEQaN7adtiB9nl8nENDKH1k35upik1KfHMPW5Y5kD9uPyk8w0S6
         mWAxFA6jriXiW3sFn+uYXhdc/QiYGadLly1xxn3kMJsHV1+R3N4AE8Ww0QOVVu8cEurV
         LPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697020130; x=1697624930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ht5utTuG5wW1wq2rrU2pauj363H+uTmJt1GixQr1DSM=;
        b=CE2W8Tgb1Xn1tn4lIbEQjikqsOWU1dpP2qiOrJVgwrT8QrC3aQiqkGxe5tfLSsXgnH
         Im9xgUGpPzKHGODtJ0ErUw+ata5ecUALsuIiguqqCLEl9s0zR3KK1CcOinthyPObVoU8
         kPIY4Hy7D2CXLhRcAFAgoxBOGt+xFazfFfUrkJa5ac19axg7dh1lw4XI5GGEL97wJ62V
         f1G3EOgOF6qPdzXnF21U2A8PCfNfogWJ2zI5o5RGw052NWJyZa7K3EyfyJvCG7rI/fGP
         5ouGIGRJulBZKDK7c4Ova3fsseRB1dpBxJabLCuuuuAZtxSAAc1a7HJrQUgIQpUFrw1P
         6Ycg==
X-Gm-Message-State: AOJu0YxDJujENBfHkvDcA9Ohh9SfO1gNTTauWu01c340Lc3LpZapAt9I
        ewH+pxstaWK1vkpsHXafiOw2ZQ==
X-Google-Smtp-Source: AGHT+IF/+tcyWJy167xh1iz46cHV+3zXA/HdYlUn1jZqjis4ijk83UImTqPXKpAuX5ROU8uJiy4E0w==
X-Received: by 2002:a05:6512:34c8:b0:503:200f:47a9 with SMTP id w8-20020a05651234c800b00503200f47a9mr14500380lfr.15.1697020129912;
        Wed, 11 Oct 2023 03:28:49 -0700 (PDT)
Received: from [87.246.221.93] (netpanel-87-246-221-93.pol.akademiki.lublin.pl. [87.246.221.93])
        by smtp.gmail.com with ESMTPSA id v1-20020a056512096100b0050480e8a676sm2213434lft.268.2023.10.11.03.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 03:28:49 -0700 (PDT)
Message-ID: <427980eb-3235-4d63-bb8f-3af06978a3eb@linaro.org>
Date:   Wed, 11 Oct 2023 12:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Add support for Qualcomm ECPRI clock controller
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 11:00, Imran Shaik wrote:
> The ECPRI clock controller support for QDU1000 and QRU1000. The clock
> controller has a special branch which requires an additional memory to
> be enabled/disabled before the branch ops.
> 
> Changes since v1:
>   - Updated the dt-bindings
>   - Modified mem ops logic as per the review comments
>   - Update all the hex values to lowercase
>   - Aligned the clock entries in DT as per the review comment
> 
> Previous series:
> v1 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=774092
That link is gone by now, as patchwork is periodically purged.

Please use lore links instead.

https://lore.kernel.org/linux-arm-msm/20230808051407.647395-1-quic_imrashai@quicinc.com/

Konrad
