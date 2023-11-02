Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55F27DF415
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376601AbjKBNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKBNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:41:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45965134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:41:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso7292835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932502; x=1699537302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoVEsKSH/yNeagUTIKEYKzFjL77Kn7w6UCVXwC/EZTo=;
        b=l5g8lpQvalw6HrQsu/Vd2NquW68VNuOqBDCWpBlqMhtDr405yTHprSD1T+2og1UVnZ
         HXWk8xbZFLFtelXUk9NL6hIues7l74WgSdjnUi7I3X4V09YEFvaEEiRplAQkhB0pEAl/
         +Ju+z+ncXd87L8+MfT0xzXdxknXVAnOWi1ydOLO0VlkcVxpg6dB183rYnuDPO7OQQRXc
         Gi15TMcIRk0EmIWbR1/mbNJygBXL52k4A6P00BAATJ+7IafzHs1tmTH26sNfAwYuYDNW
         gAMerv2s1J+biCZleGbDRjonuo8hWsToGxGxHmCMR9zCXOJtFc/vvvxSMtivDnzrbPY2
         LYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932502; x=1699537302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoVEsKSH/yNeagUTIKEYKzFjL77Kn7w6UCVXwC/EZTo=;
        b=VWv9nChElOy0f2mt3QtH6nnTKpYU6GMl7mk6khoqHgRF2C7JOvoh7yg5T+5NEyDIU8
         TF07+NKa5r/yJ2UAwR3/6SiGKsDuXySvMhqtw1JaGRFlNBJy3C0GoqZZTcoi54xhrBtH
         06NgcKgsrBXAmEpBdFVuw0u77qrsX1nMhDkCKGdDB6+W9BbPzzDayowdaa1J3ocd4VZb
         CRjeSUqE1fdXxUOWFg2EKtVxx1Hn5QZeNI/B89Nqt9LokelsdZSTul0i4oXOa6d1K/mQ
         poACUkLzX00mG1Yg+afjf6qIK4u8CcDeQYlCXvcmup5um77vuqaHMsqd/51JBDtrCWwx
         VxCA==
X-Gm-Message-State: AOJu0YyOHi6NgOV8nMMhAJB42q1vwoX7J9Tbz2SFIwPh9cFmSUcQkLL5
        oUoFZElwPu9srfATfEOLBeLFVg==
X-Google-Smtp-Source: AGHT+IHyBXWc+KI6xooU7XYG0cVyd6LqTw2hPtbNe+ESLIHGp4Y73tjmno+Nuxo9WyhibCNdfnnajw==
X-Received: by 2002:a05:600c:5110:b0:405:34e4:14cf with SMTP id o16-20020a05600c511000b0040534e414cfmr15687654wms.4.1698932502266;
        Thu, 02 Nov 2023 06:41:42 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t25-20020a05600c329900b003feae747ff2sm2902604wmp.35.2023.11.02.06.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:41:41 -0700 (PDT)
Message-ID: <70dff468-3405-41f6-9057-6a1eab3de75d@linaro.org>
Date:   Thu, 2 Nov 2023 13:41:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] media: qcom: camss: vfe-17x: Rename camss-vfe-170 to
 camss-vfe-17x
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Andy Gross <agross@kernel.org>,
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
 <20231102-b4-camss-sc8280xp-v1-6-9996f4bcb8f4@linaro.org>
 <4b8dab99-05aa-9f50-def4-85058294f069@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <4b8dab99-05aa-9f50-def4-85058294f069@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 13:40, Konrad Dybcio wrote:
> 
> 
> On 02/11/2023 12:41, Bryan O'Donoghue wrote:
>> vfe-170 and vfe-175 can be supported in the same file with some minimal
>> indirection to differentiate between the silicon versions.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> But you directly assigned v170 to sc8280xp, without any renaming or
> meaningful changes I think?
> 
> Konrad

The specific version for sc8280xp is 175-200 => the motivation for the 
name change.

I'll amend the log to reflect.

---
bod
