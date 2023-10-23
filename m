Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D37D3869
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJWNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJWNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:50:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F0E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:50:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so49727521fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698069006; x=1698673806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4dzCg7KZAa1pqs+2lmIym8cEv1bEx0TEnLwptO2/Vg=;
        b=bF6GF3aa+B8fKRZaclavnJeA26/axrIhpi2izruqx39LdI6xayPUjC8KtCXUIYrxAV
         VlwB+h65a2VcB5WEOvXuY4Vx5cWDYTP84TXmSh09EDJLWMun2FHgyNwWtMKwiAbY+0Ud
         Elx2aEZPriKRo8UmWP1+mTs//CwBjdyXNN2SlTyIiF2McctxxfL59s91SSF8b1VQoGJW
         Ilj2cb0iH7SVWcmNzmIaCc6fvg3H2ekWhDoXxbQiaBaN3zZ4vpH62Zfu3PtC5JWBlOT+
         m4/DveEhus9AdOluA50XIR5v9JNJ9Zac23t1+HvRGjmRPDyixSfy0AQp37ZhWkHiHwy0
         dIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069006; x=1698673806;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4dzCg7KZAa1pqs+2lmIym8cEv1bEx0TEnLwptO2/Vg=;
        b=oo7DfPdeS3d8F2/UKRRpiMgcNfmY7Y+5xb7dM5Howw0wVfFflZ25pv4ctyJFGKb0d7
         4Ah9GWpd4KXWGryUO7KqAR9s28fzQGg+PtnGm8rSxc6oyXHSTX2JHPGTmQZIGOr5deai
         9NOq5XVbkYrf58I4q3IgpgYRPh63yJkNiL3fgbicWpJMkB7JRlP8OnLEGyuU+gs+bTRx
         Ya1le+S+8FJk4lU9HoNSrpTJ2SyrsJmGCApl5MZXt/WZ6LuP4y1kF9YhNVLwnP71KpMF
         TApnMY9k99jwWu7AWgtQyBQexnFsJdh+RY2bDjPGu0RISw7a2WTT3FrNvpdIxrbOZ5B7
         Hstw==
X-Gm-Message-State: AOJu0YyievpJeV1g51ErQ9O4Zn6tl3mQ70XixcppMOU+Gbey49hV1srK
        7Zfl9L70kKJfYaHvdB+UEuPAcQ==
X-Google-Smtp-Source: AGHT+IEQ4WBPBtS2Ox9Bm+ePm+PXigmAVHXAmyLqEzyDaPgd1UuV+VW7vRb0C23sGArP96jdeblznQ==
X-Received: by 2002:a2e:3c03:0:b0:2c5:2357:be98 with SMTP id j3-20020a2e3c03000000b002c52357be98mr6559362lja.44.1698069006480;
        Mon, 23 Oct 2023 06:50:06 -0700 (PDT)
Received: from [192.168.204.110] (178235177080.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.80])
        by smtp.gmail.com with ESMTPSA id c15-20020a2e680f000000b002c504d8260esm1596302lja.24.2023.10.23.06.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:50:06 -0700 (PDT)
Message-ID: <757382c1-142b-454c-b2b5-7ec97bd7328d@linaro.org>
Date:   Mon, 23 Oct 2023 15:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] soc/arm64: qcom: add initial version of memory
 dump
Content-Language: en-US
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_tingweiz@quicinc.com
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2023 11:20, Zhenhua Huang wrote:
> Qualcomm memory dump driver is to cooperate with firmware, providing the
Firmware == The hypervisor? The TZ? Some uncore chip?

> hints(id and size) of storing useful debugging information into pre-allocated
> memory. Firmware then does the real data capture. The debugging information
> includes cache contents, internal memory, registers. 
Exposing all of the user's data.. Is this enabled by default?

> 
> The driver dynamically reserves memory and provides the hints(dump id and size)
> following specified protocols with firmware. After crash and warm reboot,
> firmware scans these information and stores contents into reserved memory
> accordingly. Firmware then enters into full dump mode which dumps whole DDR
> to host through USB.
Is that only something that works on engineering / prototype devices?

> User then get full dump using PCAT and can parse out these informations.
Is PCAT open-source, or at least freely available?

> 
> Dump id and size are provided by bootconfig. The expected format of a
> bootconfig file is as follows:-
Is it the same bootconfig that Google invented? Wasn't that just key=val?

> memory_dump_config {
> 	<node name> {
> 		id = <id of HW component>
> 		size = <dump size of HW component>
> 	}
> }
> 
> for example:
> memory_dump_config {
>         c0_context_dump {
> 		id = 0
> 		size = 0x800
>         }
> }
> 
> Test based on 6.6-rc1.
That's sorta ancient, especially since you're likely looking to get
this merged in 6.8.. -next would probably be a better target.

Konrad
