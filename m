Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCC7CD695
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJRIcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjJRIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:32:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67922BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:32:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso92849821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697617950; x=1698222750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT7FrcDEpu4yl2NICPsR7VhnQlPQr6RPzm03dF3NO8Y=;
        b=bEdhttRlvYfHs/Pm3SNLzEy095LELKZzhztuXEGwjA5aw+vjw6uEhyLZlC1Nx0Rg78
         QCyIln7TckoHeZn2Qi/h4zo+S650D/Sm9AZeIYK0JmGSLm8oBfojfO9xb+4nWrhgVFbe
         /KfPBNVe1UtmbnShyFwJjhDuqSUTa0NVHXzcxEkHiC6bBP6EeI0DC5CF6YtYxy8GRyEH
         yx/nK8Quagk0VVDr9Li9G9ftnH+xi2k0H4L7l1lu8xbCUzq93CwbTtb3gw8vfY2gtpjs
         dIWVIIP9yjW+qRbW8/THy2kHYeUDnQBAmo14RGU8fuZUBmv2Efko1F8JDzKJKLRwznDy
         DvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617950; x=1698222750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT7FrcDEpu4yl2NICPsR7VhnQlPQr6RPzm03dF3NO8Y=;
        b=f+LcBORooUT+bQ2bt0Jb1KpQdytsmSVue/7L8AuECtsQ89mPoTC+ks0Kbu3Myr9ctZ
         xVqmP5v5jqs1kx49Dx8geSfx/fyujscxaq/HeK0EJvKs+mUqSWWBCDfBhsLySpwhKdpt
         dfmhlS+Gu0DECRQHbROmCM//oKKD7A9QOjoqZrrlKF5Levvtn5BglU2xUooIqMWW5c+E
         bNPGdaHbggbK1zff7yMuON33GqbvKoasETIDn04NC3Xlq0sqh5rg65DLcfjB6AtUAqJ5
         76UC/FezjXhiVillqwtWNFWcz0OEMGykpcExtbp1Brl7F/Qa2JlgaYWwsMocl53b6LBQ
         43gA==
X-Gm-Message-State: AOJu0YxrjJ+xOivUXnWmVpbg9PMfeDwEMTw4OBOU87D51eFjQvlSDfpc
        2L2exowO3al+WTYrllrIR3QJMA==
X-Google-Smtp-Source: AGHT+IF6n4gFncLoJDBDMzi+HL0OIP90t/LvbDcJiPonVILAGg4jFXxUKPf8y8Djp77SFQSHCfhX7Q==
X-Received: by 2002:a19:654c:0:b0:4ff:b830:4b6b with SMTP id c12-20020a19654c000000b004ffb8304b6bmr3224287lfj.14.1697617950642;
        Wed, 18 Oct 2023 01:32:30 -0700 (PDT)
Received: from [172.30.204.55] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h9-20020a197009000000b005030cef433esm605906lfc.94.2023.10.18.01.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 01:32:30 -0700 (PDT)
Message-ID: <a640a6c2-5b5c-48a5-9680-bec9514bd068@linaro.org>
Date:   Wed, 18 Oct 2023 10:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 proximity-near-level
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231016-bqm5_prox-v1-1-2acdc732be9d@apitzsch.eu>
 <3aede886-3219-4b9f-a44d-0c414979c260@linaro.org>
 <65214451e02a38032e9fc6ac4cff185c6b2b5fc8.camel@apitzsch.eu>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <65214451e02a38032e9fc6ac4cff185c6b2b5fc8.camel@apitzsch.eu>
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



On 10/17/23 22:03, André Apitzsch wrote:
> Am Dienstag, dem 17.10.2023 um 18:25 +0200 schrieb Konrad Dybcio:
>>
>>
>> On 10/16/23 22:18, André Apitzsch wrote:
>>> Consider an object near to the sensor when their distance is about
>>> 4 cm
>>> or below.
>>>
>>> Signed-off-by: André Apitzsch <git@apitzsch.eu>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Out of interest, what is it set to by default?
>>
>> Konrad
> 
> The default value is 0.
That much I could guess :) I was wondering if it meant more like "it can 
detect movement from 1km away" or "disabled"

Konrad
