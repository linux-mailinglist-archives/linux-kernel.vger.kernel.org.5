Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A847DF441
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376645AbjKBNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKBNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:47:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B5182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:47:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507cee17b00so1118262e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932853; x=1699537653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVRSWnlyu8gdIYg1ZZClUvvLadGrYWDf9Lfi6rPv/mo=;
        b=A2MCWty7H7Vw8GRzvKc/uGXY7NSHMVd4jdiSNZ1url0eNuJS/JXQK9w+C7kgJMFA3r
         4iOhwEBQ7RziSH4UttdipIfL2YYJlf1Ox9UtRbdw29p56bTvt1o1G94V1nRLcc1SkJmw
         TadWxxA6tGJkpdHZJouAgjsNeEOStRhtOo6g4aecRlq2PrKbMHcj2vAEFEQl8XIwEAak
         PbDH1uTA2fxC6m32/+RQZDRzwDre/sRMkepEVkHJpglVm3pV/4YWVQOWgGi7j44SYyeu
         z4KVD6bPJzQGl8TpdxEB7ZUMc8X90dp1FO4TxACJlrJ4aOZfahCqRlB/StptdwFNB28M
         zczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932853; x=1699537653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVRSWnlyu8gdIYg1ZZClUvvLadGrYWDf9Lfi6rPv/mo=;
        b=cYNE1W3fOixQ3r6nn+f/UyuIqgZrkeF5cl62Kqnfqic48M27Li0B+u/h/TU5Qix3h4
         sf9FwFvFsK4jO8YUiNtSefLsh9mXPl3szaXF6KkQufvvzJqUfiBrOVdhs22g5IvzP7N6
         GwWtNR6ya2SYraOEmNPgAoqi0OZJukjO0lMjO7yrjnIhrfDyxQn+qBjT9uGo6p1p+4DW
         4o4QFUFsYqSi/acDC4CxhMjh0TkI8yzgQlgeTGcmwv0FOokFNKG3x10+aROkJGRlW7Fi
         vS87IBql0fhdD4oY+GcR02f0L4k/V7dPMwyhFIdB0ooVcXl5symY+7bhXLoZ2GXe1OOK
         jrDQ==
X-Gm-Message-State: AOJu0YyR1E8Qk0ALi3SDOc8W8e40iLubV1IkSjqB9C+EahR9u2WJQrqC
        TK8hDIENULsvzsXdPwh0V2lmSg==
X-Google-Smtp-Source: AGHT+IEL6iiaR8yLtsrn7x6/zQGzeDyvOsggtK8cSwtByG0YhdsfLuNP63m2+nKbYCpUVbQCD5VjKg==
X-Received: by 2002:a05:6512:2309:b0:509:497c:9623 with SMTP id o9-20020a056512230900b00509497c9623mr2204823lfu.37.1698932853135;
        Thu, 02 Nov 2023 06:47:33 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d4f8e000000b0032d9f32b96csm2534757wru.62.2023.11.02.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:47:32 -0700 (PDT)
Message-ID: <58965dd2-878c-4530-91bb-03db02517dd6@linaro.org>
Date:   Thu, 2 Nov 2023 13:47:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] media: qcom: camss: Add sc8280xp support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231102-b4-camss-sc8280xp-v1-0-9996f4bcb8f4@linaro.org>
 <20231102-b4-camss-sc8280xp-v1-5-9996f4bcb8f4@linaro.org>
 <9f088cfc-7b01-524c-1900-5acee6919ec4@linaro.org>
 <d26a975b-7a66-46db-af1f-685273f64faf@linaro.org>
 <e95642ea-14de-8ec5-11bf-1218426a23aa@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <e95642ea-14de-8ec5-11bf-1218426a23aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 13:45, Konrad Dybcio wrote:
> 
> 
> On 02/11/2023 14:38, Bryan O'Donoghue wrote:
>> On 02/11/2023 13:35, Konrad Dybcio wrote:
>>>> +static int vfe_bpl_align(struct vfe_device *vfe)
>>>> +{
>>>> +    int ret = 8;
>>> return the value directly
>>
>> What's the motive for this comment ?
> stack size

An optimizing compiler - older than me - will not differentiate that at all.

:)

---
bod

