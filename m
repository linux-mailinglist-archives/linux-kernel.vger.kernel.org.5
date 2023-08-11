Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAC779513
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHKQs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjHKQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:48:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED130C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:48:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3410388e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691772499; x=1692377299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3Gp+IMxKZDgNVcIGMPfvwovFcia/kmOZd2YqdHgfkQ=;
        b=cocZxpQ4GuklgdXgwDuYn/2XPc8o51powTaZwkhviGPsGcBQrvhxfVG5OAhXxd5hr2
         0/m8MF0H643+5Sm0Ptg5cIh8RWGp+5Gh4Cm2v0Nic4S8rP+BgInMTspc+lu9eQtk27iG
         Prs1DoIdO3kekxKplftc7KUaoJveaN79I//OdMNoxQaFhzxjti9BAoxCnTfytCQLIj2w
         oZ5+HN0YoRiZIKumZdBcLEreu/4PIJ1jfVFEvloLWFU1uDBiaDvZLNu1RTQmanyASwof
         BbbTL239CmLGGWrFPq/lAqcznHOlkF+Lp/7B3awUJrDKNdDou5Y8Kg1DcK0OA3pCv3bR
         Qw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691772499; x=1692377299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3Gp+IMxKZDgNVcIGMPfvwovFcia/kmOZd2YqdHgfkQ=;
        b=c7mxQJ+afy4QaxUvYjy8IUqqkAuplH6lUSPn6CKZRmAKSPaGtz1v4mpgOUqHrPsd9i
         KtvhwTWZHMQUiVQgJgrpFps7afPJfoG/5kuVXJuq5bTLasLClp9I3G7rIr0fLe5dnhdY
         Xizx47/Q7hw1wx+l6DKudKBAfTF5c+3pJlx53NrxDHn1IKUVEkOM3leS7nB1fWb806Vs
         +IKGGywAq8FWTCX6Srlkz+XOpnDVHIewtsjJEDRuqxOOdJWhQgmnqD+ZY9zWuLDAo5TG
         3o3roByrRSXVP+PypkPM1SZdrLpARG1E/sQ4oE+D/kJh+jZ6OjzfJIAly7ozf2ATxhM+
         d/cg==
X-Gm-Message-State: AOJu0YxW3MbH7wpfwfTWHi5sbXm3EuzGSXFD9l+HyEKudgHj5XG7v2uy
        kxRhezQPVRN+PVJVu2n45buAiA==
X-Google-Smtp-Source: AGHT+IGH2uzw8VedMkVo75Wd7GgWQupm8Avjro4P9SAFfZJx7T3LbTdKsdhgX+qbuJU+Oolz6QLRgQ==
X-Received: by 2002:ac2:4e08:0:b0:4fe:551:3d3c with SMTP id e8-20020ac24e08000000b004fe05513d3cmr2620732lfr.36.1691772499423;
        Fri, 11 Aug 2023 09:48:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id o2-20020ac24942000000b004fe27212a6asm785748lfi.308.2023.08.11.09.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:48:18 -0700 (PDT)
Message-ID: <dd622171-a4d3-4143-9e8a-f5a47d3e7916@linaro.org>
Date:   Fri, 11 Aug 2023 18:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, ahalaney@redhat.com
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
 <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
 <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
 <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
 <ZLppB67LyWk1kD8w@hovoldconsulting.com>
 <ea41e06c-bd2a-e375-4e7c-8cff85d29627@linaro.org>
 <ZLqAHyD5HH6Ka5pl@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZLqAHyD5HH6Ka5pl@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.2023 14:54, Johan Hovold wrote:
> On Fri, Jul 21, 2023 at 02:10:07PM +0200, Konrad Dybcio wrote:
>> On 21.07.2023 13:16, Johan Hovold wrote:
>>> On Fri, Jul 14, 2023 at 04:08:45PM +0530, Krishna Kurapati PSSNV wrote:
>>>> On 7/14/2023 2:30 PM, Johan Hovold wrote:
>>>>> On Mon, Jul 03, 2023 at 12:35:48AM +0530, Krishna Kurapati PSSNV wrote:
>>>>>> On 6/27/2023 9:13 PM, Johan Hovold wrote:
>>>>>>> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
>>>>>>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
>>>>>
>>>>>>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>>>>>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>>>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>>>>>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>>>>>>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>>>>>>>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>>>>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
>>>>>>>>> +	}
>>>>>>>
>>>>>>>> When testing this on the X13s I get:
>>>>>>>>
>>>>>>>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
> 
>> Sidenote, I get this on any Qcom device on any platform I try
>> to enter suspend on, without these MP patches.
> 
> Ok, that might provide some hint. But on sc8280xp (X13s) we only get it
> on one of the four MP ports (i.e. on one out of six ports in total).
> 
> While on sa8295p-adp there are no such errors on any port.
I've been playing with 8450 and it looks like snps,dis_u2_susphy_quirk
causes this error.

The downstream tree contains this property and I'm inclined to believe
it means that this platforms should define it (as the devicetrees are
machine-generated to a degree, AFAIK), especially since this quirk does
the exact same thing on a known-working downstream, namely unsetting
DWC3_GUSB2PHYCFG_SUSPHY.

Digging a bit deeper, dwc3-msm-core [1], the downstream version of dwc3-qcom
performs a bit of a dance in a couple of places.. Look for that register name.

Unfortunately I have little idea what the "USB2 suspend phy" is.. is it a PHY
used in suspend? Is it the suspension of the USB2 PHY? No clue.

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r2-08800-WAIPIOLE.0/drivers/usb/dwc3/dwc3-msm-core.c

Konrad
