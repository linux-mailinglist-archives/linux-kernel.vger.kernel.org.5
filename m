Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5F7EF03A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKQKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjKQKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:24:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12661129
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:24:48 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50aa2abfcfcso37277e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700216686; x=1700821486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o73LkhBrE6yDY1mbFZM2m+HTDKhAaqVyfeh8KQogz8A=;
        b=OdSQzL/IcwLWgDPFqxppbbMUGDB9JYS9klZTWFlcXrDeLoPAEZFX527eGPP9oXYVWW
         trHEDtEq93Ci2gacknqmrjVWDm00JKZGSFmpHw0BrbltWANgmGoAbWYv146j69zi5NPU
         sjInknUBWQmt1QhZGa1nlzo/MZE20ZCrayC5ExPic88bKQL9yp44jIfEFYQrBq13nbVY
         IxLPxNVFksW1ki0h3L1INNki21PzfwVfmiWxmAJFlMR6USS9OUOHFJ2Emm9oMlHa7nWQ
         A/uZI4oabF0mx8KjL0s0xmH48/lp7MfnGSTZQ6+uvRpgIfvwClJTtKCTyvL0W54pLHJ0
         uE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700216686; x=1700821486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o73LkhBrE6yDY1mbFZM2m+HTDKhAaqVyfeh8KQogz8A=;
        b=LZErigNcedxKKejq/dyBu0l9XzCMkQdzEEEI7VGwi+97IMuqzphbF3JCi5mNvng1aS
         m7DhfrItkRwBdQr2TACNv49g/x3I24paf6x7mrHesS3ZX00/o5tHBVrNyHn84JnATA5u
         bJJ9JY827dHW/MZyo1ZJ+MfL15BlZKuPyGFG/FTGRKFcK99nQSvgzySuJ862OzuAw7B7
         twp22tU/075TUSUCwwbsWHvDsRqRRakSVevFGzF5PhLTHeOTFEJX8mICE/jGSdgTbMOZ
         NlYM6rAFK+CqBVM9f8zYUzIqiIRvME5cWl9jS8Ny19mCISgOzToQS3jUN4IHvFJku4Aw
         fpxg==
X-Gm-Message-State: AOJu0Yz8mIRqefYzcPtzf38WEah/0yklMZWkSDQQGcQkdXyjQZyfNEKf
        5/fgfB1ExQz0VbLpUeIZ3mWDGw==
X-Google-Smtp-Source: AGHT+IG/gL9yn8RBag2pQ5TmNhywUp7z0stEM0uETbIbEKL2FmgUsAlBhAtPzVHqbIv9HZX8h3ZZvg==
X-Received: by 2002:a05:6512:3f1b:b0:50a:2720:eac2 with SMTP id y27-20020a0565123f1b00b0050a2720eac2mr14371838lfa.4.1700216686107;
        Fri, 17 Nov 2023 02:24:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d14-20020ac25ece000000b00509447753c5sm181454lfq.308.2023.11.17.02.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:24:45 -0800 (PST)
Message-ID: <a66be060-9941-4c4b-84bb-1fcc554791ce@linaro.org>
Date:   Fri, 17 Nov 2023 12:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] arm64: dts: qcom: sm8550: remove address/size-cells
 from mdss_dsi1
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-6-quic_tengfan@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-6-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Address/size-cells will cause dtbs check warning, because mdss_dsi1 node
> have not ranges and child also have not reg, so remove address/size-cells.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

