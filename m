Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093027E1046
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKDQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjKDQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:01:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD91D45
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 09:00:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso4368634e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699113654; x=1699718454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSOeu9EpYpJ/96EOikBzVA0+kSTrdPO9sr2PRTgzQXk=;
        b=L9p1U/n06CMh0kWNYLt8Frl0ERyF7jb3AtOG+1xuRLrcIaTXQBi3LkoWmd9RzI/2HU
         yo1RhAU+8ImATj8CbYSjkNz6F02PpQsfx7V3kRl1Vsj4cfi8zDRuhRxAlp7f6P5zmaqO
         ge0/3pxqxu0m7XXDgIQljyLW/SKAJrAkKlYvZgMxH5/TN7RMyC9jUDTHqit1nA5xKtcS
         +poN0wtJsN7LNy+SAaJ3UdxBRmjUZuXLg/ffq0rOLp6QpsIeMp84qZ4VgD5oD/5bUoi8
         aWQT72q4m6xXjPyfTGMAVQZojmoGJiFA4NUImHbU7FfGdNH5epx6OD6SeUHX9EH54Tvf
         WNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699113654; x=1699718454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSOeu9EpYpJ/96EOikBzVA0+kSTrdPO9sr2PRTgzQXk=;
        b=G+emrW7VetjFthgfSAnP4f2QCOBQE9zXfaOSgqINCLmmmkyccKFQue/Tz/x9bIa+RC
         jzHxx7K+I0vwUroHtV2K/gWZYoluznmSywoUHcBKhMWsX1isF9JXH8fJyKwDcyi0I2uX
         2TU3rTW/40L9jxuCDHJMJt4FbiaJ9mkP8Zjzg6+XzplQtoFGg2i4ShWL7mjA39I3FCcC
         HIkJDZTPi6O+X6ujmDCH6yosa8KMKvNL/fFodkPz6a/WbNS5amPO4REJhse8yoMx8a9P
         PRufzZOGVHAe/Ptjwh0YtwBr0y7iaRMKKe4km7r2ry05EYOOrQ7Yelg7oLB+Msh6dRxD
         4hmA==
X-Gm-Message-State: AOJu0YwggaRaB7KQ8bIbhzAiQj0JzpOxlkdA+zluXWoSGxaeKbxrxdem
        qiny840iIhbtdMV+1ULqpQdtsw==
X-Google-Smtp-Source: AGHT+IEPFqS5qonFd1aRtub85qdr3gusVqvFUojB09NVZXRDEniZKfoVgllNgXVG5nE7usZpKuyvZg==
X-Received: by 2002:ac2:5306:0:b0:507:9d5d:5901 with SMTP id c6-20020ac25306000000b005079d5d5901mr17819048lfh.7.1699113654226;
        Sat, 04 Nov 2023 09:00:54 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe2cd000000b0032ddf2804ccsm4683537wrj.83.2023.11.04.09.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 09:00:53 -0700 (PDT)
Message-ID: <cf553cd8-45f8-4a61-b016-69e7a80eee9f@linaro.org>
Date:   Sat, 4 Nov 2023 16:00:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] usb: dwc3: core: Register vendor hooks for dwc3-qcom
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        quic_wcheng@quicinc.com, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-3-quic_kriskura@quicinc.com>
 <e700133b-58f7-4a4d-8e5c-0d04441b789b@linaro.org>
 <5ef66bdc-9645-4bbe-8182-baa7fe4c583a@quicinc.com>
 <3be5e95f-85d2-4abf-a8b4-18b019341602@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3be5e95f-85d2-4abf-a8b4-18b019341602@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2023 18:49, Krishna Kurapati PSSNV wrote:
> 
> 
> On 11/4/2023 12:15 AM, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 11/3/2023 8:44 PM, Bryan O'Donoghue wrote:
>>> On 17/10/2023 14:18, Krishna Kurapati wrote:
>>>>
>>>> The following are the requirements aimed in this implementation:
>>>>
>>>> 1. When enum in device mode, Glue/core must stay active.
>>>>
>>>> 2. When cable is connected but UDC is not written yet, then glue/core
>>>> must be suspended.
>>>>
>>>> 3. Upon removing cable in device mode, the disconnect event must be
>>>> generated and unblock runtime suspend for dwc3 core.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>
>>
>> Hi Bryan,
>>
>>> What happens to this code if you
>>>
>>> static int count;
>>>
>>> 1. sleep in dwc3_probe for 10 milliseconds
>>> 2. return -EPROBE_DEFER
>>> 3. if count++ < 5 goto 1
>>>
>>> i.e. if we simulate say waiting on a PHY driver to probe in dwc3_probe()
>>>
>> The vendor hooks are used in __dwc3_set_mode and role_switch_set calls 
>> in core and drd files respectively. These are invoked only if we are 
>> OTG capable. The drd_work is initialized in core_init_mode which is 
>> called at the end of dwc3_probe. If dwc3_probe fails and gets deferred 
>> before that, none of the vendor hooks will be fired and 
>> dwc3_qcom_probe is also deferred.
>>
>> However I see that if core_init_mode fails (the cleanup is already 
>> done in drd to prevent set_role from getting invoked already),  I need 
>> to cleanup vendor hooks in error path of dwc3_probe().
>>
>>> and what happens if we introduce a 100 millsecond sleep into 
>>> dwc3_qcom_probe() - and run a fake disconnect event from 
>>> dwc3_qcom_probe_core() directly ?
>>>
>>> In other words if make it that dwc3_probe() completes and struct 
>>> dwc3_glue_ops->notify_cable_disconnect() fires prior to 
>>> dwc3_qcom_probe_core() completing ?
>>>
>>> i.e. I don't immediately see how you've solved the probe() completion 
>>> race condition here.
>>>
>> Just wanted to understand the situation clearly. Is this the sequence 
>> you are referring to ?
>>
>> 1. dwc3_probe is successful and role switch is registered properly.
>> 2. added delay after dwc3_qcom_probe_core and before interconnect_init
>> 3. Between this delay, we got a disconnect notificiation from glink
>> 4. We are clearing the qscratch reg in case of device mode and 
>> un-registering notifier in case of host mode.
>>
>> If so, firstly I don't see any issue if we process disconnect event 
>> before qcom probe is complete. If we reached this stage, the 
>> clocks/gdsc is definitely ON and register accesses are good to go.
>>
>> If we are in host mode at this point, we would just unregister to 
>> usb-core notifier and mark last busy. If we are in device mode, we 
>> would just clear the hs_phy_ctrl reg of qscratch. After the 100ms 
>> delay you mentioned we would call dwc3_remove anyways and cleanup the 
>> vendor hooks. But is the concern here that, what if we enter 
>> runtime_suspend at this point ?
>>
> 
> Just to clarify one more thing. The probe completion requirement came in 
> because, before the device tree was flattened, dwc3-qcom and core are 
> two different platform devices. And if the dwc3 core device probe got 
> deferred, dwc3-qcom probe still gets successfully completed. The glue 
> would never know when to register vendor hook callbacks to dwc3-core as 
> it would never know when the core probe was completed.
> 
> That is the reason we wanted to find out accurate point where core probe 
> is done to ensure we can properly register these callbacks.

Are you saying to you require/rely on both of these series being applied 
first ?

[1]: 
https://lore.kernel.org/all/af60c05b-4a0f-51b8-486a-1fc601602515@quicinc.com/
[2]: 
https://lore.kernel.org/all/20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com/

Must be, nothing applies for me in this series.
