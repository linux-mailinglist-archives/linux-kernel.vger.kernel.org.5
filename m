Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A05813011
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573038AbjLNM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573023AbjLNM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:28:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D48B115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be3611794so9432380e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702556927; x=1703161727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNg5RdjgOpSpN2R15aV/ZbxDJpdIfp+yvD7sH7DN48I=;
        b=Ar4Wl2xbXkqQDenvF2eVSfekB2ktDiLU8CtDphCW/xIQPdxr9Bko6nQvFQuRdJlAtv
         pty/vCZ8Q2xYLpv4h59M0TRrB+qP0oMXcgeB6g2EcNY5FtgOetphN1Bb7kFLv/mRkaTQ
         lZdKo9t4khBXhqj+OgQxWLLAUvOrytCnm8k9jthpmD5//hhGN2949pg9nFdaVSOknPMc
         8Z9V0xCltfJPKgrWkGM5EDp3F8EMG63Gh+Di43TalVdWB9gonc3moPw3qSRqKfBLaKS0
         iZ1/W6PVSbLPA8L7GnokKp7qQwmKK3d7b1fGl3buFDu5bQnbCt9hlR0Ff1l2EC6qjwr9
         fI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556927; x=1703161727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNg5RdjgOpSpN2R15aV/ZbxDJpdIfp+yvD7sH7DN48I=;
        b=S0TLrFWWAWswjXODmT4rzmh54OUYyhLWxKC/PuvzYzXGYF4Gp87Y8Xu9tZAwCDfQfl
         uttMy6V0g7e93eiSXFQ/Nux5bZjpu61KYwshdl25/q5Ogqqk9ZTFVgqE2EsC4DNcIh1B
         BHOAL7QMQ4kbS0cCuY7yuqThX7GAzBm+dZa7ryn2NbTTsZYw5Y9g4A7LoJ+CfhLNLpDc
         vme+bVKxBfAi/Xqei9mhOUPryWSaR5ComV/pRGnnkIgDvSemlM2+OAJy8exsM4IyiBlm
         ULx7IK6O47Ue0tyJMwWgw2eZdgXeaYHNw3Tnxorc9jAd3FWU6jLYYq5UDOC+tT5bJLTz
         IwAQ==
X-Gm-Message-State: AOJu0YxCTD25ejGv/khxw0E7Acbt6DCQ2/53vSxEgPo69ok5t2ZzglNW
        dpYzrTvdGx2Yc1u3bWdIM6o0JA==
X-Google-Smtp-Source: AGHT+IFBnIR+pUPYw6vCh+gevem5c9Q7apgAnqQZxO5JCfBwT9d/oQMgHgB0r0TYcBmu2AoPWRZFhA==
X-Received: by 2002:ac2:4909:0:b0:50b:e693:ee20 with SMTP id n9-20020ac24909000000b0050be693ee20mr3900428lfi.31.1702556927501;
        Thu, 14 Dec 2023 04:28:47 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm1871880lfg.191.2023.12.14.04.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:28:47 -0800 (PST)
Message-ID: <f0edad1d-0807-4588-8dd8-c16709913a7a@linaro.org>
Date:   Thu, 14 Dec 2023 13:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8180x: fix USB SS wakeup
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-4-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214074319.11023-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 08:43, Johan Hovold wrote:
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: b080f53a8f44 ("arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
