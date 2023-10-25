Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2537D75E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJYUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:38:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831EEDE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:38:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9338e4695so1971911fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698266285; x=1698871085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkNNejbCmL/k7pWRnrsJGwZqih1Jcn9nw5isK0ZcLhI=;
        b=BqFf2MHxH8RheMmwKqkJvx6gQAkizRpw+qnQqERHcsX8hjnF0eMrGg/5S0z1V5f7Dp
         mS5G+ZEcT3GDbiC5U7PvMZp2Fe6+T6ETsN2fNvz7XXSH+HTOsyy3xSv0EvzvI71FteF9
         QJZSJeVGkmq6aZVucENJgTZ7KFmm59YtZkiVPM34VvsIOeOhZrxCW5RMY1SdmZsDC86j
         pyU7b3eUsrhGVCgyYPvCDV+/kMWE+6PLAqcpMtd+ntEyP56O8qBDk9NRvrlPZyKXpnRb
         X1wgeNtQg6epvPnpGIJQ5vlG6SK7/wY9kLDhYWqKUSd1WEN2TlzmW53HbQMmlQVQKsjD
         zhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266285; x=1698871085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkNNejbCmL/k7pWRnrsJGwZqih1Jcn9nw5isK0ZcLhI=;
        b=lhjHr++VmKicmJeC8IPVlSbZksXTZQ3uZVKrLwWbW5TUDrk2It45FTZIAlNLYreKT/
         ssQiDbifewNhWrzmfz5dOOKErPLcq7u4A8uYtkx7PLpWbKn9C4pmcaBvXE4iFTOQ19pL
         f6cBduVcKBfihibUTI9+5KHjXWxdheXBHClvkydEd4tikvsNSOIEjEQXEjh5g0WgiI5P
         9swQFCl/PS+JzOljxXolkCtm9bRaxI8goMOC1qWx36+5JHvWFcTPcVpS4ir0EHdYQeij
         9YUgT+g/AWEfyPv2dHb3thbWVgXpS8ZntWOKdTFnGw48QCAIqpPQ9P7915NURk3vM7fh
         HYxA==
X-Gm-Message-State: AOJu0YwND+RaBjXkX0v6cAlSTs4ntMF7Xf5g4v0CTVMlh/w9PbryWBXI
        8yYh46rg8KfUy9UwCQc+PrRhDA==
X-Google-Smtp-Source: AGHT+IFEsNWUEVHLgy9no9zt5n/oSi9ff1FZksTxjp/VP/wDM1Yxxc6Zxk7YI/vaALGIt3FYIrQlCQ==
X-Received: by 2002:a2e:bb12:0:b0:2bf:6852:9339 with SMTP id v18-20020a2ebb12000000b002bf68529339mr10819527lje.3.1698266284776;
        Wed, 25 Oct 2023 13:38:04 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b0040770ec2c19sm669758wmq.10.2023.10.25.13.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:38:04 -0700 (PDT)
Message-ID: <c9c6b20e-cac2-43a1-a026-ea01b0e245bd@linaro.org>
Date:   Wed, 25 Oct 2023 21:38:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: qcom: rpmh: Add support for SC8380XP rpmh clocks
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-5-quic_sibis@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231025133320.4720-5-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 14:33, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Adds the RPMH clocks present in SC8380XP SoC
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

This looks pretty straight forward.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

