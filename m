Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC647CD6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjJRIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJRIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:50:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF0FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:50:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079fa1bbf8so6148117e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619008; x=1698223808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VY8V074ZaWHR3uxPsaqqpbxmTtftcDfFzH7Dssm9LII=;
        b=p5f7KhhSc7cBaTlx5VdOHiZxPxaZbsYhD5lw4ZBavMdgIgM/Vb6zaSFd6hl3orzys3
         p9qKMeHQFkcQF4RrD7+t27oYC3f9U5jSzRAv3bIpWcITG/8D74GyWOREX3yGcmZXiO7b
         a8Nb7uIgIgNJKTkHrz6P9Z9VLntIh4Vj72C5RC5IsCHfTiKdBPIhtlIW5l3d3triwBfI
         RodFmm7ucL6GIWiY8wmtTPr07rhHDXOnvSoGj1aR9THKp8Of8ZTYwjHFcF3Q/r+CKmvL
         aO7VFWJSJB3vzAZfi66DdWSTJukO9UziAZTuSyR5oFTV3MOtko17/iWfEXB61KosHiK7
         Eouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619008; x=1698223808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VY8V074ZaWHR3uxPsaqqpbxmTtftcDfFzH7Dssm9LII=;
        b=cKk9D1/Y/w/0bJG9jvHJTC4oCHxrD5eqsQ2VrFiK1+CAfxM9f3Mvmn6I46dNeYtRF6
         35Exp/wFF7FNBDwLNUwMWi8/v2wCllLSAgOFzO19DBx2JdFqpk10PFjojAkJkBb1Axhq
         Pu5zpC/0Yly3XF/4IIjWiynjuS64YuIzwHFtR2spDMicztSDks0wND6Wr3U8Lg9SotN3
         hvE6xvA6gM0uzavpZeOhHRWFgCS/CSXnOHmcm0O2mSDQ7Tw2RytrB3ntajtSAAZfNH16
         Y90tEAnTytV+3TsHWISHXVd+CJLPR9HT7dKfrhiMWX05titZKJFOj9sAutxDuJi9fT2+
         d+Vg==
X-Gm-Message-State: AOJu0YxlQMSetNDz0qCUwYyKsD7iiyKWJpKSs7Tei6SRQO4iJSCD8XrB
        JKnvN+tjk2w6axNU3tR0Ae1ywIyAa48eT5gyaqY=
X-Google-Smtp-Source: AGHT+IF5XWZCdhFd+sdr7SW9sr+WDumaME1Zk8oICpesr0u85VtPi3laTpJVUkx0QZ0bIQz0st1WIg==
X-Received: by 2002:ac2:5586:0:b0:500:95f7:c416 with SMTP id v6-20020ac25586000000b0050095f7c416mr2891199lfg.7.1697619008563;
        Wed, 18 Oct 2023 01:50:08 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x20-20020a056512079400b00507a3b8b007sm615700lfr.110.2023.10.18.01.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:50:08 -0700 (PDT)
Message-ID: <6b4c544b-5325-42cc-9479-bd4db7250687@linaro.org>
Date:   Wed, 18 Oct 2023 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8916-longcheer-l8910: Enable RGB
 LED
Content-Language: en-US
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
 <20231013-bq_leds-v1-1-cc374369fc56@apitzsch.eu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231013-bq_leds-v1-1-cc374369fc56@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 22:51, André Apitzsch wrote:
> l8910 uses KTD2026 LED driver. Add it to the device tree.
> 
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
