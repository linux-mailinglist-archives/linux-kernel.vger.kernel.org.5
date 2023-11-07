Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7F7E4AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjKGVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjKGVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:41:42 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D5110DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:41:39 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5720a321aso81757341fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699393298; x=1699998098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOUEzdR0Cx5aI5BrhAl9c27GtPSKarxoejL8ISU+wEI=;
        b=P7mPdNtS3LWkSshWb924y8h9udnZisx9DACuQne8B5b11RmLqcmIccgVfVeI0cT8gY
         sZIIxHAN2FD+YkLHZs43cuzVXJuyRPtwZpmToZbb8RWcXCU47Ek9M8XkRZOzeCv7ktTE
         5GjznURQYknaBMK5qLZ7hW7Kfs6fjqa6H8nXoEv9n5KazoZg5oIxTsG6GqbvPrunnfhL
         YN9vdIJfvzmOkt5WfRORVl3dQBqDjJ25bie3EBmlHPBk3tAAO14i5470b9MBEdj3tii0
         gQv/hbK9LQjx3oYtCsnu1GtmYQpV/zPXJPM0V8UxARKHvmRKH7oSzS6YNltw+HUpSgqf
         Kq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393298; x=1699998098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOUEzdR0Cx5aI5BrhAl9c27GtPSKarxoejL8ISU+wEI=;
        b=ZvbXDHYDzEQNhQq4M0dOE968NZsxmtFnbCgu3WGTo367JH55i+X+zIGkMDVJ/eQyBW
         PTv6fQdIQNXLYkEXdofzDQf5Mb6zN1v1rs/+pYN5W3X7Wn4IHTIAp+BS9XzWGQVfujF2
         GGo0nEXCiTc/EcF/ya0wFsnfVOhjGHwdbtknq3KZK4/29iD4tkVUe2SHOjSRsz3d+KEY
         dnbQnDkavVaIazcgBDt5UUmO5r6bkb06bXj+Gt43vW5fYt/LVYsqZ893b52LVJpnrTZc
         V1gP1YfG4uLaAZ0myNXPpj7ln4uNu7ki4vnkJiDYH/eufq4SFYpK8Md/pItXVcST33Kd
         gsNw==
X-Gm-Message-State: AOJu0Ywd7+VrIflKgEiwP0phpny1qaBe07ujKJaSh9agog0NZy0fm8or
        utyY82Ar6YVlQ535Idw2+oymkQ==
X-Google-Smtp-Source: AGHT+IErEa1Tr4HT5ERsF8J6zUAe2Oe03GIPj+aU2/8QqeVpAvooAUrWGcH/t14PC1wMPnG8hz96RA==
X-Received: by 2002:ac2:5928:0:b0:507:984e:9f16 with SMTP id v8-20020ac25928000000b00507984e9f16mr25155506lfi.36.1699393297841;
        Tue, 07 Nov 2023 13:41:37 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b00509366f4f7esm460879lfm.121.2023.11.07.13.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:41:37 -0800 (PST)
Message-ID: <ed074396-8c6e-4e57-85c5-d54187d901d6@linaro.org>
Date:   Tue, 7 Nov 2023 22:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] media: qcom: camss: vfe-17x: Rename camss-vfe-170
 to camss-vfe-17x
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
 <20231105-b4-camss-sc8280xp-v3-6-4b3c372ff0f4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-6-4b3c372ff0f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/23 18:45, Bryan O'Donoghue wrote:
> vfe-170 and vfe-175 can be supported in the same file with some minimal
> indirection to differentiate between the silicon versions.
> 
> sdm845 uses vfe-170, sc8280xp uses vfe-175-200. Lets rename the file to
> capture its wider scope than vfe-170 only.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
