Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273387C4F19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjJKJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjJKJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:35:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADF94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:35:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50336768615so8665776e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697016899; x=1697621699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTb+BC97Rmfw2v9f1zxZNHOqcWwQx2NwvNoBl72WQbk=;
        b=IHSQsp+X+DVapGHCfyAPWG4945+hUcPvDiigKzOScHq1M2VRkoeSn48qS4gsdaw/ZY
         iVBKkpyctb02u7SN5cEiLsN38PMV/H5pw/NHvnK6xpKgWABxA2bM9xpimmTHcq4TuRrx
         52w4If3jGJ+3haYqfzOk0RhWIY6bspQszEYjXY0LlatYYCowCbCs3gdLtkeOOMkwFc7y
         Kfn/FdLuXo2eBqJ1b6qAnrAV4zc4QOnvLhfXKPcv3jNTHX4NptQyFRq7BRC2N5A4jbX1
         qCPHwyt9KTbWlCQT2v9PwNu5zyG19qK2wj8z7juEPDBkxrfkCTA+cZxDqPqncn45xR1O
         o81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016899; x=1697621699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTb+BC97Rmfw2v9f1zxZNHOqcWwQx2NwvNoBl72WQbk=;
        b=vf5h2KjLra1IVMrqir2N2v8yGbZqRYXTi3E7HSabGgS1AIJY+aShG97NuIz7F5wsyS
         nmRoFQp6Ynb6RDi4gY5TXdY7+Gd5cENBgITnhD4CTAbNZAcC1sOtIVjt4iEJLxo/GY2k
         6LUeQ6h9WZP553RaIeusFZ+VqtIjyiZumbpLXTkSyVz2EmyNQYZutOGJxWoRItvxMRDn
         Y+gQOQ0sQ7IQBXC0CCR7lfwkAM14y+MydyHGKQTDiBs+H+YW9uQcpSAu6C8wUzad3GPX
         bvSG5M2y9/mK1z6F5sx3guDvSPuWCBfMu5LchrnSkqs5Zh0p6K1McTEcZfq/p0xtzqY8
         oEQw==
X-Gm-Message-State: AOJu0YyG43dXufr1I/jD3RzCQV+9kzEM0QDtfiP57toIPKsVNKs0bAv2
        YEg7EsaiX0y+d2E/2VuJUcmPnoG7lhrDZ1lHzkA=
X-Google-Smtp-Source: AGHT+IFJlLI9YnlJYD1w9CjE4Ygsx3wdxgdFBI2HqW3ROvAa5SheRB6Z7Int2nygQUmbnYk7UMB+uQ==
X-Received: by 2002:a19:385c:0:b0:503:6e8:1008 with SMTP id d28-20020a19385c000000b0050306e81008mr16146349lfj.36.1697016899282;
        Wed, 11 Oct 2023 02:34:59 -0700 (PDT)
Received: from [172.30.204.44] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003fbe791a0e8sm16376359wml.0.2023.10.11.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:34:58 -0700 (PDT)
Message-ID: <a8493160-6417-4366-957b-ea4ac68f8926@linaro.org>
Date:   Wed, 11 Oct 2023 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] Add multiport support for DWC3 controllers
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <537d59b3-0e40-4d4d-80ab-b99028af6ec2@linaro.org>
 <2c325941-0fcc-4092-9581-dd6ebb067163@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2c325941-0fcc-4092-9581-dd6ebb067163@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 07:11, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/11/2023 2:21 AM, Konrad Dybcio wrote:
>>
>>
>> On 10/7/23 17:47, Krishna Kurapati wrote:
>>> Currently the DWC3 driver supports only single port controller which
>>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>>> DWC3 controller with multiple ports that can operate in host mode.
>>> Some of the port supports both SS+HS and other port supports only HS
>>> mode.
>>>
>>> This change primarily refactors the Phy logic in core driver to allow
>>> multiport support with Generic Phy's.
>>>
>>> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
>>> are HS+SS capable and 2 are HS only capable).
>>>
>>> Changes in v13:
>>> This series is a subset of patches in v11 as the first 3 patches in v11
>>> have been mereged into usb-next.
>>> Moved dr_mode property from platform specific files to common 
>>> sc8280xp DT.
>>> Fixed function call wrapping, added comments and replaced #defines with
>>> enum in dwc3-qcom for identifying IRQ index appropriately.
>>> Fixed nitpicks pointed out in v11 for suspend-resume handling.
>>> Added reported-by tag for phy refactoring patch as a compile error was
>>> found by kernel test bot [1].
>> "If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags"
>>
>> the issue your patch resolves is not one that was reported by the 
>> kernel testing robot, it just pointed out that you need to fix up the 
>> next revision
>>
> 
> I Agree. It sounds wrong to add a reproted-by tag making it seem like a 
> bug instead of a feature we have written. But if we fix the compile 
> error mentioned and not add the "reported-by", its like not giving 
> credit for the reporter. So I put in the reproted by and closes tag to 
> give a view of what was reported and the feature implemented.
This is a normal thing in review, people spot mistakes, null ptrs, etc..

If I had a reported-by for each review where I pointed out e.g. device 
tree changes that don't compile i'd be topping lwn charts

Konrad
