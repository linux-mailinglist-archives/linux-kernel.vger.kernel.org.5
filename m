Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFC7CD6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjJRIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJRIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:50:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2310A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:50:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507b9408c61so2817084e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619021; x=1698223821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYwjEIsDAOJ6QvGGA1UdoS9AIT92GPKHL+44Ytf60aA=;
        b=b71JvMbCUSTLCvAxnx38Bb/IuvTp4yurB4JJqiiZp8Gns6UjB3D/elG31bTeV1CLp1
         yq0Fd2wkALIB5Z6lhrXTmfuYsAAxmXurSVHTjfd3tgvQcrIuA8u2u/cBvxUOp9Duwhcg
         X5lmmmlwXCsVbdO34PXmDAk5qkh3s1PWNnuqQbyroZUgwBErkqYpQjle8+JG8NEAV2Ge
         5O4PhLSdtBk8oco1gzIppUsALJ8UXUzjluzAZDZHTn6PiYix/8vnI5ARM0o7+gwnPGfF
         zsj+CK+YsF9PkkSyOJgEh+sQsTmz2BAeu9Hm4AHtP8uuWp5TyQ3d3kvbPAZCd9Uk9R3f
         WOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619021; x=1698223821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYwjEIsDAOJ6QvGGA1UdoS9AIT92GPKHL+44Ytf60aA=;
        b=pDaLCLa3LKP/I2n1N8YoB5qDGb3H25MX5+mUZGdUCmgInO01dPwmywvXcJ1+vkrmFq
         p4/qxL+41JcN9oifEBWoS0p2e9rYmkvTzbx7R6WbaU/Kfxq3lQnTsK5WQL62+V8DUbrO
         CR2hVI8BteY7gjZB2HJ8ITZZDTqKuPgM/EqVfZE1FkigreXX+SuXLBxpD0kiwTGPGJq+
         bDjJTLi64Rk8tCxwn32ZsfnzFMaN3HYQplatitL8Q+cQM9po4vWouczM2ev28gBNHPgW
         RWrMAao5VER1cakZi9b0Pz/GNqcAVrw22fPEklNmfDx7rZmGMOGCfFx/R8TGGrWW1SJ7
         a9yw==
X-Gm-Message-State: AOJu0YzyuY58lwc6jOGOymY06kHM6buUpWH1yme+8OHw8Chjtn5MXsmR
        c/Q4CMPCNTnPEFU/JxZ3mDr86g==
X-Google-Smtp-Source: AGHT+IE47qfwBPgQ/N38nc97qlSrQIHT4r8GN6vl1gvPY38d1Es3r1wgdTuPxA8CDWKYgtog+6RYnw==
X-Received: by 2002:ac2:484c:0:b0:503:2dce:4544 with SMTP id 12-20020ac2484c000000b005032dce4544mr3457302lfy.59.1697619021490;
        Wed, 18 Oct 2023 01:50:21 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x20-20020a056512079400b00507a3b8b007sm615700lfr.110.2023.10.18.01.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:50:21 -0700 (PDT)
Message-ID: <0ef687f6-988f-47a5-b8df-b24bab462026@linaro.org>
Date:   Wed, 18 Oct 2023 10:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-longcheer-l9100: Enable RGB
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
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231013-bq_leds-v1-0-cc374369fc56@apitzsch.eu>
 <20231013-bq_leds-v1-2-cc374369fc56@apitzsch.eu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231013-bq_leds-v1-2-cc374369fc56@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 10/13/23 22:51, André Apitzsch wrote:
> l9100 uses KTD2026 LED driver. Add it to the device tree.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
