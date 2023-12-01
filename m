Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842D88015B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjLAVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLAVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:49:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7510EA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:49:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so3166995a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701467377; x=1702072177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19FR1U3AKoV3VyCSX1p0aFDSinYo+NPtX+mnYm5SEjs=;
        b=EnFpeyLuDyabqLZx0ksJuay5T+/8O8Kg/4su82mqD8gLQ7E1QVl0hlVr6JtdxM1rVO
         cbPtIRFf7/36ORx71aqc1ICbWtb75zx8Kn3wghOqAUmdHcYCP/x57/tEhcz4hyZKrToe
         7McNxVPFnEWhKaRZ6TlvBKNm/FDgWqJf1ww6x1DkLTgcLyzCsabdG48U3fW1PSyg/G05
         8FX32xplgBL2ChL70VtG5RGT8i8rNXrKctcMyvAUDaBEKNpYsaXvMLZyY4bBrPASdR/1
         c6waae2MjegHx0SAbFfv4abxx86LP55xQHMLyJdqWJNWcb6p48YuoM/z9umLO+1WvqCG
         WSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701467377; x=1702072177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19FR1U3AKoV3VyCSX1p0aFDSinYo+NPtX+mnYm5SEjs=;
        b=CFa9qflUoNX1TUN+87BrJnXwhQ8QkjbQF6d4DVtuo63qJyrsXFFhQjn5RD/O8rKoRE
         mOEoP8Ffe7cae12z9BF2IUIoSQJefWi3osJDDnawBgdksru0GgwlrnkaK3oYzkxGdkdp
         SNbr+yDm2gob6aE83+is6pRW6cJoMdJNoVqEgwOrXXIofqIj1ByJQLEXreR00jB+milM
         cOPLck550sXdnosZg7XivbbblPRnjR3AsQqtNQW9btDpzWQXxpXbYyEnnAmBIsoDdPXx
         nRxUFjzuUltqquMTB1Qs9ncz9yesV9WS0aycBdZTuT6TbE7WhC0wHBZSiKJ1hMCBKLw7
         oXvg==
X-Gm-Message-State: AOJu0YxiFV+tbqqtO4ZklzHYoQdiBzfzRCIjJTe3HwzNgQe+wlkyVo+l
        WCi9bgaqtCcfhsPh5pTNsdMPhQ==
X-Google-Smtp-Source: AGHT+IGZTFVrozcEI7yuAf9ShkkhnaNmfmSP/AsapXfKp2W9rDfgcdwmtOt+JKK5fNJW5nwVuMS5jw==
X-Received: by 2002:a50:cd8e:0:b0:54b:c880:370d with SMTP id p14-20020a50cd8e000000b0054bc880370dmr1302981edi.36.1701467377445;
        Fri, 01 Dec 2023 13:49:37 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id cf5-20020a0564020b8500b0054c4db03b9dsm1140785edb.30.2023.12.01.13.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 13:49:37 -0800 (PST)
Message-ID: <7dba2fa6-9f9a-4e48-a1a9-4814f488bc57@linaro.org>
Date:   Fri, 1 Dec 2023 22:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: soc: qcom: stats: Add QMP handle
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
 <20231130-topic-ddr_sleep_stats-v1-1-5981c2e764b6@linaro.org>
 <ZWmq619zryYHV_kK@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZWmq619zryYHV_kK@hovoldconsulting.com>
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

On 1.12.2023 10:44, Johan Hovold wrote:
> On Thu, Nov 30, 2023 at 03:58:21PM +0100, Konrad Dybcio wrote:
>> The stats can be expanded by poking the Always-On Subsystem through QMP.
>> Allow passing a QMP handle for configurations that support it.
> 
> I know Qualcomm likes their opaque acronyms, but how about mentioning
> what QMP stands for here and in the binding below?
I'll amend the commit message for v2.


> Especially since we also have QMP PHYs (Qualcomm Multi PHY?), which I
> doubt this is related to.
There's only so many three-letter acronyms that begin with a Q ;)

QMP stands for Qualcomm Messaging Protocol, which is a JSON-like way
to communicate with the Always-On Subsystem (which is responsible for
things such as managing low-power states and general SoC building blocks
housekeeping)

Konrad
