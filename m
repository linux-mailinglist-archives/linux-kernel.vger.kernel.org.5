Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7931D7CD7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjJRJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJRJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:16:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168D127
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:16:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507ac66a969so4113375e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697620580; x=1698225380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ41pRho0HuiZRS9gRgVWISrteNQCafxPgDs5lLN4nQ=;
        b=SWsNyyAC/BpKYxfAc+tWplOzVjgCRz2e+p9hX9/stjmqYjPVT0orwKzcHOBqWxYfIy
         yYl5hZljMrposxTNdPls4ifEvAAwZt2j1GDrDrpnzOtPcIeINpU3CrbDPiT6eLGuvZGH
         1goUVKPrRApJuci57HPwjt6xJORU+kaHnGoFiSvevASNmFpU/Sxy6HuyLrf3ZL7tDtqt
         0snjwwSxvK918bJi4kXccyOsaX6K1Zv7uT1peNCx8MmawtyfT6NPEaL/bgDvDNCplmx9
         U9F7Jmwqlpz/9NUHfmNIQIIXYSjNdZbscyAPW2PkOb7msBO3hgmCHErqv3LBFmyXimzc
         vtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620580; x=1698225380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ41pRho0HuiZRS9gRgVWISrteNQCafxPgDs5lLN4nQ=;
        b=eWFwro6WdlJLutAkwtsI4QqWLLEvFmu5x4fzxwyIeyu9HQqBzEPoQ5szKgAOwkg6eQ
         esXa3TojafE7VCTbj9BrWNq3AG7jDfnM14+VfkhIfw1p4A6C7ok2TweOYy0MqcHb9Gyb
         dGhKIoF3QyntPTreo6f+/oihZ7880GwpdxvJ5zM650MPN4IUbFDpfllFj98HI7oOBt7u
         SddADQkKff0G4PwB78ZVb16oZuyIP9jOmE8eBVSNZE+ma6iqt+KEe1Qgmx4Yif7u03ME
         wvileMR7INhlXPteTe7V7SS5yDJ7OPF/zo2ST0+heYNHZbrVrZ2SzoxxUIRNxKhG2m7h
         M33A==
X-Gm-Message-State: AOJu0YxRNJauxTEj3aFcdhyCevBbjkYRU5vAiZ+5pidrqUsQ4klxG4Is
        rPcWQx+D5gZADbY0aYW440tzJw==
X-Google-Smtp-Source: AGHT+IGfutiJM8gG/RzWIslBZtWh5qieWDLLmmPzfMwJAmj4O9Zs/iCZCRzPD03dztF50asWIr/W8A==
X-Received: by 2002:a19:e041:0:b0:503:99d:5a97 with SMTP id g1-20020a19e041000000b00503099d5a97mr3576574lfj.20.1697620580116;
        Wed, 18 Oct 2023 02:16:20 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b22-20020a0565120b9600b004edc72be17csm619367lfv.2.2023.10.18.02.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 02:16:19 -0700 (PDT)
Message-ID: <4469ff06-fcb1-400d-848f-77c4b139a20d@linaro.org>
Date:   Wed, 18 Oct 2023 11:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8953: add SPI interfaces
Content-Language: en-US
To:     Gianluca Boiano <morf3089@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013110531.84140-1-morf3089@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231013110531.84140-1-morf3089@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 13:05, Gianluca Boiano wrote:
> This change add spi_3, spi_5 and spi_6 interfaces to
> MSM8953 devices.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---
Generally when you resend an email, you should edit the subject to 
include the word "RESEND" and state the reason under the --- line.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
