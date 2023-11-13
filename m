Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FD7E9BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKMMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKMMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:02:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0FD75
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:02:09 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e1021dbd28so659569366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699876927; x=1700481727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmMMjSnQ3FfpfMMoO/MXG2pkv68SfbKNHw9Dh8U3V8w=;
        b=L05S2HZLOT3gk7Haxi0oOAc4EMVgTYxSUjuPNxbqiiLC+61k8uhjwXH+c4pv5n9QVu
         uY0eXF5alBCmTRpVeTup/z5YE+UsZBgVzBG6lPHedhzoTH1NIqYemc/EtAXzjjn6Lnde
         jSiEBlmxggyg1uD040rRlMKor2m+FcUbKi7apAW/xMsumY52AuVlDcmV3yn+HfITJCo4
         pQc7iD+UC8z7uYe26aV2J6xvuU9YDZCS2sGf2/KGLbIO7NTu8S3/ZXpY3oqm3VPVWYpY
         7UbqIWGI9UFFjIJ9CnyrO92wU/REO6EWb7XmqaBSlQKoMt31zAv7yX2BxsrnjgPukjJ1
         UnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699876927; x=1700481727;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmMMjSnQ3FfpfMMoO/MXG2pkv68SfbKNHw9Dh8U3V8w=;
        b=wzLe+wTRPG5UpPlkL77VL+TU9epwSO4kZQwDxPlEZCkVDHyMV54JnGYlLPCvD8Qajg
         aC4Lo70Le9GriJ5I6xeWZMsUgwMoYPgejL17sYsYaHRQ7RIywNdD+Mm4MB4Lc0zoLMFU
         jxuUU5yh5dQEYNMzmjDnMdQPbYdd9c5MJORNXmFuOZT3uqUPo6aV3Z8OGC9LdcRK0vVN
         72q9b1JM9C/MbtxXv2aanseMCsqv+pSnWWh/OANU8apLi1OKKI74QBiWGOzaF2TWQJCa
         7SUxk/iZFFxeZBMwdyjVXzIlX9N2xYdQ3f8BPDtEJBeNu6gPg9tf1TQcQk8smDnAR1tk
         3PjA==
X-Gm-Message-State: AOJu0Yz3jrNRGXHjDsqU3jYfxDVEetwuVEjSAt5ujvw7jDGOKzqUlIHx
        BjYVyUVm/Ye08PMA1aN5Ja5lCxzWivOWeXXxbCo=
X-Google-Smtp-Source: AGHT+IGn5axedppVHsMFuYtgzLI973+P0NS6t6H0TPgjlsJgb2j3/qELdRmfQuqih3bVVrFek2rC4A==
X-Received: by 2002:a17:906:4087:b0:9e4:b664:baa8 with SMTP id u7-20020a170906408700b009e4b664baa8mr4427534ejj.7.1699876927584;
        Mon, 13 Nov 2023 04:02:07 -0800 (PST)
Received: from [192.168.201.100] (178235177064.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.64])
        by smtp.gmail.com with ESMTPSA id gx24-20020a170906f1d800b009c503bf61c9sm3868184ejb.165.2023.11.13.04.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:02:07 -0800 (PST)
Message-ID: <747afd5a-f20b-4980-9962-ecdb3922227d@linaro.org>
Date:   Mon, 13 Nov 2023 13:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Revert "arm64: dts: qcom: qrb5165-rb5:
 enable DP altmode"
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231111094645.12520-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJpoK1N1LBY5ZjL7hb0Sqge7iF4X=rm1n9VZPx-0nOm3bkw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpoK1N1LBY5ZjL7hb0Sqge7iF4X=rm1n9VZPx-0nOm3bkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2023 11:09, Dmitry Baryshkov wrote:
> On Sat, 11 Nov 2023 at 11:46, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> This reverts commit b3dea914127e9065df003002ed13a2ef40d19877.
>>
>> The commit introduced unsupported and undocumented properties:
>>
>>   qrb5165-rb5.dtb: pmic@2: typec@1500:connector: 'altmodes' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> We need this property to enable DP altmode on RB5. It has been parsed
> by the typec subsystem since the commit 7b458a4c5d73 ("usb: typec: Add
> typec_port_register_altmodes()"), merged in April 2021.
> 
> Rather than landing this commit, let me propose to send the proper
> binding instead. If we can not agree on a compatible bindings document
> within the sensible timeframe (e.g. 1 month), I'm fine with dropping
> of the altmodes from qrb5156-rb5.
Right, I'dve imagined this was taken care of.. Retain my r-b but have what
Dmitry said in mind..

Konrad
