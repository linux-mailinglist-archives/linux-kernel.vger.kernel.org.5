Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5289478B872
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjH1Tdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjH1Td0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:33:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B90122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:33:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so4740096a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251202; x=1693856002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXKJ9YSCjc+uvpiGbHAU6z0Pnzn1Gof/Cxg44Dd22MU=;
        b=kgWRDa5GDd0Aj+nyg+JUQbLe5nBZ4OWVsxNaMKUgRaCvMpVlae5b0gkwhgy7N+dl2F
         WePZTOyQl3EtJTSpufJ2ZUlRh8maRgkuAV9lZHxsqLzaASB0/aKPZjMNux3xFF80swF1
         IlB04OxP8z434/crCuzUaRRJxFXcXBCW57F0RJJFJNH7tXg11t+/sxcBm12S/Ht1PA7C
         WB5RKIYfFtHlB+ggcMtD/xI+ZdtJl2/8iEDfSUQX+Kk9wtNzpm/Qsu/lGbM2wPyA89xm
         JxOjmrBJFbsBGqa69UBljK8sVi96RUONBJkJsBkSvMxaow8oFKKE268bLWFp4Fcj0fwK
         7mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251202; x=1693856002;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXKJ9YSCjc+uvpiGbHAU6z0Pnzn1Gof/Cxg44Dd22MU=;
        b=gO586Wj3rTl0INKSHx79KTiAFCB7scxVLHI7qJliDpw2hud2KL8dcpG6+aDTyOpXE1
         deQ1xsA196k3/5S0pZOml4rra/gG5NPG92c0yZ4kdEYvN+fMbz/3pjnvMmxIsGfjC0VP
         zTy52z9KsuWC1yYgdCcmrzVLCabLh3a4ohJzF3s4CFi4My5PdOvjYtSJb/4dFlZQS/Sc
         j+/q7EF6zuaAFf6TayeGC0F12EYL8sEqw1ZVeDkKsbn8CQ6V/N23uGrCLwISPV+BomVD
         iBSeePYWHaMH0oB/Hz65L1sgYAA6KPvHuOpkFRdzkOISMILYajaS724V9uVlBbRO2Qx9
         WQ6w==
X-Gm-Message-State: AOJu0YwsxTw9IYZL8Y4eK5f77yBuiZX/AA1M8ac/yj1nVE/gQUyluUsZ
        vQj64nI1JODLIyQTaJtiJzkh+w==
X-Google-Smtp-Source: AGHT+IEgBOCwkjHNLDNFijHoMW/wM1nrW+YrqvIQrnl/sFAbs0FySay/NbJl0CtHk1RSx6qwczSsKA==
X-Received: by 2002:a17:907:7895:b0:9a1:f58b:96d9 with SMTP id ku21-20020a170907789500b009a1f58b96d9mr11327518ejc.58.1693251202274;
        Mon, 28 Aug 2023 12:33:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00997c1d125fasm5060429ejf.170.2023.08.28.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:33:21 -0700 (PDT)
Message-ID: <d9560045-5c8e-96a6-48dd-c97190d0cdd2@linaro.org>
Date:   Mon, 28 Aug 2023 21:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/7] thermal/drivers/qcom/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

