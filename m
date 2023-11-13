Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBA7E9C00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKMMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKMMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:17:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2E10C2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:17:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d9d8284abso2748597f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699877857; x=1700482657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdu6AREK1CJaiuNpOZl+mqEf4c5i61NveanJG2+Ep8A=;
        b=GMC6oZhHowudrxg3G36/cF5bqzs8GwLZORTgoebGHacd4PEQg936JbIMc8oQoXQX19
         9hDU3OBIZU9CxHrgaIOMdJInSuk+j/VEIwQdN9V12nKkNrO+2z0UqEyypTml6AWL3j4t
         ZScDNGHLYudLKNJCMaJNcIHkYYCOHyU/DHJE+bwq1AE0mRAE2UV6tnqxlwvQuuo3N3lZ
         g2++3BBd6sIfrbdZpj+FVwyMEKK6B42A0HNiRzpgxqFQlG0GzVlcrgGBe1aFJqGG6Gis
         sGRwRFI14PKVUxgV0Xrbj9XVxD0DjuhCCoXIi08/3CMrGlA2KclqVWUQGUmQ9E73JbhD
         T9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699877857; x=1700482657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdu6AREK1CJaiuNpOZl+mqEf4c5i61NveanJG2+Ep8A=;
        b=FPcWDR0V91vP9ScBRet4/tLH23RZfJ5zG04GiUiiOGdw9C+jRwU1OXipo/THBhjapu
         I9gxDUDev6oH80J7wbyS63rJMpGIMn5AJ1Wy2l1IZU/AHHeyqLfLOGBw0Jd2MWnxwrja
         VGtbMBtPPoIeB/7GTZlUgEoOq1jNJ0N46TnaPApugukmBWfVim2ChMSA5NfQrZe2watR
         dTzd99QdnI8/Wd7mwmdHcT93XGtJ0YecuXcHFdRryAEEJw1ciyrGbWJDt/v4NcvbxPdR
         czUIFPsGxBaMVpX0TOCUkOfQvh3C5BOAasrJZ4fXO5OBIIhEGLak70+KVGnY9Y61i9pC
         +5gg==
X-Gm-Message-State: AOJu0YwQkZDSDVzDCylCG90yyThHzi8ysTY6A7gBt5YbLE1v+R/Oq7ty
        TvLcqLNfkgWtg+xUcjo2i6ozWg==
X-Google-Smtp-Source: AGHT+IGPRucyRkefaln0OoUDtqab6LVoFTHMQsKZCVOghxij56tFONGg/WdB9Nv9yySzSqMA7VEzSg==
X-Received: by 2002:adf:f601:0:b0:32f:7c36:228 with SMTP id t1-20020adff601000000b0032f7c360228mr4077942wrp.6.1699877856816;
        Mon, 13 Nov 2023 04:17:36 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b0032da319a27asm5330647wrq.9.2023.11.13.04.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:17:36 -0800 (PST)
Message-ID: <9a13471b-fc39-4081-8905-9d0d7c28b501@linaro.org>
Date:   Mon, 13 Nov 2023 12:17:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] media: qcom: camss: Add sc8280xp resource details
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Andy Gross <agross@kernel.org>,
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
References: <20231110-b4-camss-sc8280xp-v5-0-7f4947cc59c8@linaro.org>
 <20231110-b4-camss-sc8280xp-v5-4-7f4947cc59c8@linaro.org>
 <ea15a00d-a60c-460a-8d3d-f6cb4cea46db@linaro.org>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ea15a00d-a60c-460a-8d3d-f6cb4cea46db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 11:57, Konrad Dybcio wrote:
> On 10.11.2023 02:04, Bryan O'Donoghue wrote:
>> This commit describes the hardware layout for the sc8280xp for the
>> following hardware blocks:
>>
>> - 4 x VFE, 4 RDI per VFE
>> - 4 x VFE Lite, 4 RDI per VFE
>> - 4 x CSID
>> - 4 x CSID Lite
>> - 4 x CSI PHY
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> [...]
> 
>> +static const struct camss_subdev_resources vfe_res_sc8280xp[] = {
>> +	/* IFE0 */
>> +	{
>> +		.regulators = {},
>> +		.clock = { "gcc_axi_hf", "gcc_axi_sf", "cpas_ahb", "camnoc_axi", "vfe0", "vfe0_axi" },
>> +		.clock_rate = { { 0 },
>> +				{ 0 },
>> +				{ 19200000, 80000000},
>> +				{ 19200000, 150000000, 266666667, 320000000, 400000000, 480000000 },
>> +				{ 400000000, 558000000, 637000000, 760000000 },
>> +				{ 0 }, },
>> +		.reg = { "vfe0" },
>> +		.interrupt = { "vfe0" },
>> +		.pd_name = "ife0",
> So, the comments before each array member, the reg/intr and pd names
> are all over the place between IFE and VFE.. Is there a reason to this?

So what we have is older VFE - video front end, IFE - image front end 
and SFE - Sensor Front End, which do different things -> VFE raw, IFE 
pixel processing i.e. hw accel processing and SFE - sensor specific 
stuff I'm not across the detail of.

For our purposes in CAMSS => delivering simple bayer to user-space at 
the moment VFE = IFE = SFE.

We could rename vfe -> xfe but then again the presupposes the next 
iteration of this hardware block's name != xfe.

I do not believe there is a namespace deliniation for power-domains 
between 'stock' VFE and IFE.

The PD name in qcom namespace is 'IFE' the existing upstream code VFE 
but the capabilities we support are basically VFE, for now anyway.

> On top of that, another ideas to add onto your cleanup stack:
> 
> - Are VFEs within a CAMSS block actually different? Can we just do "vfe
>    data" and "vfe number" + "vfe_lite data" & "vfe_lite number"?

Yes.

The last VFE in sm8250 is "pix" capable. VFE Lite is not individually 
power collapsible and I'm quite sure if you start trying to "push" more 
advanced features Lite unsurprisingly has fewer..

> - Should we move these platform structs into separate files?

Yes. I'm aware of a group working on this and anticipate their patches soon.

> - Reminder about the clk_bulk_enable for clk_rate=0 clocks suggestion
> 
> - OPP

There's a Jira ticket in Linaro's system for this if you look..

> - Use _num instead of sentinels and magic scary while (not null)

---
bod
