Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0737EF03D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbjKQKZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjKQKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:25:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D4D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:25:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso2654618e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700216702; x=1700821502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLXI9Xt4UVPpx5LWxP1RlOZuVkuXv/tUB5AZ2nCxcL8=;
        b=GQXBO0KZNaY1QoTPvqKxvNJMXzDpkBfTZLWLR9jo50ztS39gvl0hboAlp/Hh+usKaV
         4LULtBZD9Vt9tLa4U5YTRqLeZSDS5fEpQ8r95o9H/L9OKopTqEWWtybkvSGb0JWa7Yw+
         45yUjuHcA3Qmnm8TP5uBDqhxaa6zMvVsp3nYYAx1x9eBYpmILhs4zMs6TtbPWD5jqHqD
         CWo8UAYPw94CFmYQ3VRE/C7hn8lLEmRyDvtHoyycJXVQSpX52MMwFSMGZzWO+HlYA4kp
         JkDuG0lEKKkkFOU2IcNzp4BXZsKTQs6RjasR5LI44rWdoXnF1kk11GuYzFcg7Iq1mq8U
         WvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700216702; x=1700821502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLXI9Xt4UVPpx5LWxP1RlOZuVkuXv/tUB5AZ2nCxcL8=;
        b=gkZF0cJFHi1kMx5m6718iD78XbnCOtpSe7dESTgZVbVHTNNX46y4n8o11xVpTv/9JO
         adCYs9/Ms22ROucO4KNBHnarfOokXn4x0/KEUsquYMAuzTvblm+Olv7ScGdZkaciwbT5
         K1JUW6FAKkO3lXVqPYUrUcgg2lXLXnKOe1zGudRp7egyTYh63Fhl+wC4d/HgpupCSV+y
         6s49DpKvZwcnnP6tceZZ6vzUqxGnV3ejB5s+6+NyGZg2txNTlV8Yu+iUqRNtbxDopzYu
         CIqCnytYKpOgNYrV1AMT+qwwrncrWPCTCYr72nPfLE+chCQN6Y4YJDNbLduUSt2pGZzF
         G/dA==
X-Gm-Message-State: AOJu0YxY8Wqg7+bDJbrOaDUJourqZ1OxoD4hIpYBUSEL1az8pVNeT/mR
        e1CwPY/8Kut8pQHTOAXAGuVTAQ==
X-Google-Smtp-Source: AGHT+IH8Fmec+7T4NatGDuj9tyynxLUtAtWwCu7h5QwDdtBaylwLKCJMWtXd/L4QlzJ8GhaQCLEkjQ==
X-Received: by 2002:ac2:5475:0:b0:507:9b70:1f0e with SMTP id e21-20020ac25475000000b005079b701f0emr12508111lfn.24.1700216702271;
        Fri, 17 Nov 2023 02:25:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d14-20020ac25ece000000b00509447753c5sm181454lfq.308.2023.11.17.02.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:25:01 -0800 (PST)
Message-ID: <dce6ae40-1ed1-4a2a-83aa-283d0188a9cd@linaro.org>
Date:   Fri, 17 Nov 2023 12:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] arm64: dts: qcom: sm8550: remove address/size-cells
 from pwm
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-5-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-5-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Address/size-cells will cause dtbs check warning, because pwm node have
> not ranges and child also have not reg, so remove address/size-cells.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/pm8550.dtsi | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

