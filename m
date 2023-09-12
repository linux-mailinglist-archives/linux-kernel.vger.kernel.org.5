Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F179C891
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjILHuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjILHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547710C6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:50:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b974031aeaso90722551fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694505013; x=1695109813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeDH5WdvH/U/z7/AAdgdrj6NUsKGCWaOFn/HcXik+/Q=;
        b=eQNKmP/wF9GvWbBYRvdYiE57JyC2+d480HLI9dmTCxGWusWeEMRi0Nhqffzt/45pBW
         Zwdq1vdsvjt4jEyJaC2iWQi9CBf7WFopArKXWz4UKUBVbPyXnr7Xy437MS5CRmG17ryW
         DnyH2YWZ42jXDCl9p5uRyL3TNzq9rKJqDTGWqrOWw/Zr4nZTFAKdvr5yapdYlNjr6iow
         dO6bTzipvvXvEyLs3EWDxqhANWDP5n3A/DYPHojPUKk9E2mHmA/8wPJKjFsaPeYqAT6s
         P+LBzKR5L8dTMXXmIFAszjvOhcfbv1ZYYtP83rSSEccvmSpwO3AiQbP7xTjZuWC/38gk
         T6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505013; x=1695109813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeDH5WdvH/U/z7/AAdgdrj6NUsKGCWaOFn/HcXik+/Q=;
        b=mAAo4Pfnbn1tLi3r0rkI+fMr7OllOBQDZGYFCYB6u1W0mi3cz/Z70rNhARiJNCRLmV
         9lP6x+JmKBk5bg7zqGdAq8fuKemw9UprKhlXsDF2nK0htvulUCjqKuoQs1WeJ1MIiqzK
         UERedTHjDvb6fHq/8M2UrxrIF3e6/xhfyR+joKAhwRi/aaOQ1zjyUsV0s30Sv1yYdvu7
         /VpfUKsMn768hURf4B87qhgiHpNK8lLspJI52fPNcGOvsatq1NMzHBlfFgR4L7jFEdWW
         29j1mFQjDavmwPMoLinrdDSb7LPYAWqpfS6aO5SCLe5nAjIBExujXbG+u0G+dSLhffGE
         zlxg==
X-Gm-Message-State: AOJu0YzDrMhdTrc9bR1NBRx4Yp/5baHz1iMaeXCeM51dILqx1vDU+no3
        oGzCQ83oAtUt33U189+eDNqEGg==
X-Google-Smtp-Source: AGHT+IEQ4aMyt0DasnjwDIqUS0vSAFixS6ecUzgER7BTHB5ht7AbeeOoQpXxmLJhkqPNo1OqWzFUjg==
X-Received: by 2002:a2e:9c95:0:b0:2bc:dd6b:9220 with SMTP id x21-20020a2e9c95000000b002bcdd6b9220mr10187800lji.24.1694505013180;
        Tue, 12 Sep 2023 00:50:13 -0700 (PDT)
Received: from [192.168.37.85] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id f25-20020a2e6a19000000b002b6e77e87fcsm1798627ljc.68.2023.09.12.00.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:50:12 -0700 (PDT)
Message-ID: <8fcea134-62f5-4de0-9098-e0623be84fda@linaro.org>
Date:   Tue, 12 Sep 2023 09:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: qcom: msm8916/39: Fix venus memory size
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-9-b7089ec3e3a1@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230911-msm8916-rmem-v1-9-b7089ec3e3a1@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 19:41, Stephan Gerhold wrote:
> Both MSM8916 and MSM8939 have unnecessarily large reservations for the
> venus firmware for some reason. According to the ELF headers and
> downstream [1] 5 MiB is enough. Let's set the minimum size as default.
> 
> With the dynamic reserved memory allocations boards can easily override
> this if needed, although in practice there does not seem to be any
> device with a different venus firmware size.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blame/LA.BR.1.2.9.1-02310-8x16.0/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L69
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Every meg counts when you only have a gig and change!

I'd prefer this to be separate patches for 16 and 39 though..


Konrad
