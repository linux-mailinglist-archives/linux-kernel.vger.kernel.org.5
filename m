Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2524A8139F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572979AbjLNS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjLNS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:28:02 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA3F116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:28:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so126494851fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702578486; x=1703183286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dQ/bNphB3A9w3rMAHBZdgKti0js2ncdlw9oeKElMsk=;
        b=WPtXTk3P+HDrs3uQJk2aSLb/i2+JPz583dRblms8MojCBhue6IkkQ4hi1ZiAzlr1oN
         Sd1wZwilY9O0V0HYHvkqSHWu09cZ40aw2R+83whdMrMqTVY3RzIehv1XFDFoD6DjBHw/
         7A5g+W/y8F5jS7tUOZ0xgGB0cxCl9jBsJXMRjJDnqx0rGM0GM2it64NoPUTRXJeUZ9xf
         4rc137P9ZT/+/YZ0F9Ee27xLZqP7i5rI9c2KPR4z0VFe9OuQ0pLuf+E7mmc7SAhNMBfA
         4vF6HRfOfMz0D40dRaxOtMYR74qi1mjJed/oyUTZ4NzxsMhI6W+ZaEITUi65tqKydfEt
         cHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578486; x=1703183286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dQ/bNphB3A9w3rMAHBZdgKti0js2ncdlw9oeKElMsk=;
        b=tRE8Zz7d6N63Fp/5hgMaBxI/tXCcr2OA//zfJhiQMQhgIDqy3HzdRfFz/IY6fWzrqQ
         fJsA7SRdsksAC4IrrI79AwNGOo0GZ+suTu0JmhOBGFLgtWYIFiCp+hLQIc/iJdrUOJ71
         BxJG5Jnz2M7mrhryZdWkBSywryUOzBKTQZyxhWsVx2D5An4Fa/h8I0o9jewjeOwJpwzb
         KX58QW8rmEdhNgoI6wLZ/wZQaUNz/d9i6OF61OK/ABSkJeGPJBrZI7zVe3S/TeP+47wI
         oHxx2goz1xid3m1Z89TJ9c9D8YIe55tX1xU1WjL88S1wh5dnUG3ane5t2NMl2Fi5w/vl
         SlOw==
X-Gm-Message-State: AOJu0Yw0bpE4SiCUud4gvVXGoLWSbM9w3p+UvoM1+VtufNKMdpm0P2uS
        o2DVDywP0NtVYZF1KtrOmho3zQ==
X-Google-Smtp-Source: AGHT+IGlrjmnV9pxVjOkym/WuJNu96Q2GiosakZnW0q0/cRNqUnsQz5lvmib3MqI4Be8NJa/p3hYSw==
X-Received: by 2002:a2e:a4b6:0:b0:2cc:1d8f:b372 with SMTP id g22-20020a2ea4b6000000b002cc1d8fb372mr3691692ljm.53.1702578486607;
        Thu, 14 Dec 2023 10:28:06 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e7e06000000b002ca25f11f56sm2084008ljc.103.2023.12.14.10.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:28:06 -0800 (PST)
Message-ID: <65c551e7-25f2-48d2-97b6-af609807b7d0@linaro.org>
Date:   Thu, 14 Dec 2023 19:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 initial device tree
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
References: <20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu>
 <e7f8e4bf-080d-4bb4-99ca-727d2d00f55d@linaro.org>
 <1d5de5547d5980da6040bf1c9bfc7fc3c32de88c.camel@apitzsch.eu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1d5de5547d5980da6040bf1c9bfc7fc3c32de88c.camel@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 12/14/23 09:18, André Apitzsch wrote:
> Am Mittwoch, dem 13.12.2023 um 21:44 +0100 schrieb Konrad Dybcio:
>>
>>
>> On 12/13/23 21:33, André Apitzsch wrote:
>>> This dts adds support for Motorola Moto G 4G released in 2013.
>> I have a similar one in my drawer.. not the 4g kind, titan IIRC?
>> Wasn't this one codenamed thea?
>>
>> Konrad
> 
> Yes, thea is the 2nd generation of Moto G 4G, released in 2014.
> pregrine is the first generation, from 2013.
> 
> Should
>> model = "Motorola Moto G 4G";
> be updated, to reflect that it is 1st gen or should only "thea" (if it
> is added at all) have an addition in the model name?
I *think* it'd be good to make it

"Motorola Moto G 4G (2014)"

as I think it's what it was called anyway

Konrad
