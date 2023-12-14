Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747978139EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjLNS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLNS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:26:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02611B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:26:28 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so108101301fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702578387; x=1703183187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr8aBcNe76U8Il1/cEacG3HGI0OPPwZhV24gYNt7zEU=;
        b=vC9wRIYbgsj5qR8bpg3JL9/k6obn4iU2RJXniBs6pYDvyLMZZlc+EnFXkjmQ06Mn3d
         DogHtyY64dEGaR3N+Rg6SzPg+ufJMnYTAyVUrDJnxEE+CJTvWTBHA8kviLzirYXlLrRt
         K/6r7tEwjwQs5wo6Oxy2YqcoHae+nbFLN3S6kpLfqChxWxWLKe1VobQaa6BujqqX/j8W
         8vsJlFfBzN3TAzpx/SR7/TsFuPz9cEUZeMG8Pv9kFTUtNkrMzzuRUzkTrfPH59Q1tSb3
         ITbMNkn9WPcvgMHuOjneiLX3PPK0sizKN2KgbQtm9JXHTW7Bg5/fwFwOioE3F72Nunq2
         n5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578387; x=1703183187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr8aBcNe76U8Il1/cEacG3HGI0OPPwZhV24gYNt7zEU=;
        b=kPlzWn6XzdlyfhpV+OnEU4xZ61MbkuY57FGB5RSgwKHE9FbmGDl8vfS98hBFd1F0DC
         /N3ygr59ue2svZP8Ca0KfDC+mBuqgPYikCXUCTEHM4PBOO38+MLurXfj7aofQ6h8EYcT
         jHj1ZkFX3IIgIXc1pDknyUH+EFkqDatCf0wyfjT52DCXRSnel6pU3rhGyiqhkW2/fXLG
         aCICHnTb+9VUH0+1k/FhCCFfRJocL57N570+GWxjCuIm2Jcj+OGuGLRAGPuaFjLGb1m9
         qScxTnrGeIkw0dG4GNWDU/ptYLnYlrCWDyOzwl7oDoxViy9xs73VJZp3lx/emZK3MHop
         IOxg==
X-Gm-Message-State: AOJu0YyeYN4tPVl9iRA9fK3APFjk0JZbRTowCeldbISjBx9dRE/cj0+1
        PcrSRSlLtOvvDWRyhJQ3He3AuQ==
X-Google-Smtp-Source: AGHT+IE8FvYLdfSsTVvxxEzpSNwIOQzkUazEyMdwnd1Uk4XIfWCU9lnASlW5rvasvN8rqK3jCKhY/A==
X-Received: by 2002:a05:651c:2112:b0:2cb:2c27:57d9 with SMTP id a18-20020a05651c211200b002cb2c2757d9mr5247773ljq.16.1702578387007;
        Thu, 14 Dec 2023 10:26:27 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e7e06000000b002ca25f11f56sm2084008ljc.103.2023.12.14.10.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:26:26 -0800 (PST)
Message-ID: <93bec6b7-78c3-4064-9775-b27c5ac511fb@linaro.org>
Date:   Thu, 14 Dec 2023 19:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom_smd: Add LDO5 MP5496 regulator
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20231214104052.3267039-1-quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214104052.3267039-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 11:40, Varadarajan Narayanan wrote:
> Add support for LDO5 regulator. This is used by IPQ9574 USB.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
Why did you remove the bindings since the last revision?

https://lore.kernel.org/linux-arm-msm/cover.1701160842.git.varada@hu-varada-blr.qualcomm.com/

Konrad
