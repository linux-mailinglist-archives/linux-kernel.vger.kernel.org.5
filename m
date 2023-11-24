Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601547F7815
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbjKXPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbjKXPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:46:06 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9701992
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:46:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a08e4352992so116439366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700840770; x=1701445570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d9wSiZKBdjfk9WzYTONxAZ9gvH4l3ttkbnn/4rhktlQ=;
        b=ItUZL7O+Spdo5mhWiQhw3cVmhiv8+EQrtHcOV0b7rP6+k4B7OhE2/fiW43xF4G83iO
         bMS8wE52QsVHyvPsi2+Big0irmUgK/6BxJEnzHkOBDJImcc+WjF/OfaeTMX3GXXHxygC
         Y7mNaLKZmHpWEmxxCSU0WUlfFYm28QIOR8AcVkrLSP09tIv8fNQgqaCP/34SY9C9V1JX
         u89UvRO2JmRjdJDZfVrvyuKLq6yfF76XVpsnX1+QXp4qFf8v5ki5X4p/g04uXKnpaA/p
         RaAcjWdM3rIb53HPtFQnQxT/vCrCkL5dbMS1OQL4RJiYRWWkrtJqoiUcMErZd8Xup+5y
         V5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840770; x=1701445570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9wSiZKBdjfk9WzYTONxAZ9gvH4l3ttkbnn/4rhktlQ=;
        b=poZGZJo8onSncklaQ/EBlFxMc4UMnChW0g3WWpRF29uWbFWSqTtUx10Auo39Szdp1a
         WW2pgY2fYzQsuV8DGt2LBdlBg9mNQeYiNnmepLGkzxqhLEm9NWVV+6mhou2/EuSly1Nk
         bTV/m2rTfzgnchAH/4SVFWGibp4htimtV0D9UW4Tgq5gSXtFD6nePPY1lLU+PjnG6gXR
         o9EKZWOnd0JD5xgAmkP4kQbAW/JOtOVXRdydvxro61UvUFLHYyTw2sqlwF8CSNtjqzVM
         OUHxe0MuiJUM8pB2CeHzlLTpg0Lrh48AJmuZkXUXhGIJIts/3LTXjKJuh8KWhQ6ouzIs
         ZhJg==
X-Gm-Message-State: AOJu0YwwEQo6UCABFHHMGGWvRxc+aDij0iSli7THbMdC/rQTwmZBpfQy
        XMzxFjhifrCBQdhtk1D8W2bwPg==
X-Google-Smtp-Source: AGHT+IEksiLkwKJQbymecKFwdLHhu3BPyuhIcGdFn8R9s1GjBEva7JTyYDQrcquzbeC14VA7EPVqXg==
X-Received: by 2002:a17:907:1a42:b0:9be:77cd:4c2c with SMTP id mf2-20020a1709071a4200b009be77cd4c2cmr1951910ejc.28.1700840770183;
        Fri, 24 Nov 2023 07:46:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b009f2b7282387sm2176544eja.46.2023.11.24.07.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:46:09 -0800 (PST)
Message-ID: <a90d980e-71a1-4b90-b1cb-66ac45d79031@linaro.org>
Date:   Fri, 24 Nov 2023 16:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
To:     Conor Dooley <conor@kernel.org>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "dhaval.r.shah@amd.com" <dhaval.r.shah@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
 <20231122054404.3764288-2-nava.kishore.manne@amd.com>
 <20231122-exert-gleeful-e4476851c489@spud>
 <DM6PR12MB3993F0EC4930E68C54299B36CDB8A@DM6PR12MB3993.namprd12.prod.outlook.com>
 <20231124-tweezers-slug-0349a2188802@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231124-tweezers-slug-0349a2188802@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 13:48, Conor Dooley wrote:
> On Fri, Nov 24, 2023 at 06:35:19AM +0000, Manne, Nava kishore wrote:
>> Hi Conor,
>>
>> 	Thanks for providing the review comments.
>> Please find my response inline.
>>
>>> -----Original Message-----
>>> From: Conor Dooley <conor@kernel.org>
>>> Sent: Wednesday, November 22, 2023 10:21 PM
>>> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
>>> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
>>> trix@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>>> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
>>> mathieu.poirier@linaro.org; Levinsky, Ben <ben.levinsky@amd.com>;
>>> Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Shah, Tanmay
>>> <tanmay.shah@amd.com>; dhaval.r.shah@amd.com; arnd@arndb.de;
>>> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; linux-
>>> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
>>> encrypted bitstream loading
>>>
>>> On Wed, Nov 22, 2023 at 11:14:02AM +0530, Nava kishore Manne wrote:
>>>> Adds ‘encrypted-key-name’ property to support user-key encrypted
>>>> bitstream loading use case.
>>>>
>>>> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
>>>> ---
>>>>  .../devicetree/bindings/fpga/fpga-region.txt  | 32
>>>> +++++++++++++++++++
>>>
>>> Is there a reason that this has not yet been converted to yaml?
>>>
>> I am not sure about the complication involved here why it's not converted to yaml format.
>> Due to time constraints, I couldn’t spend much time so I have used this existing legacy format
>> to add my changes.
>>
>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>>> b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>>> index 528df8a0e6d8..309334558b3f 100644
>>>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
>>>> @@ -177,6 +177,9 @@ Optional properties:
>>>>  	it indicates that the FPGA has already been programmed with this
>>> image.
>>>>  	If this property is in an overlay targeting an FPGA region, it is a
>>>>  	request to program the FPGA with that image.
>>>> +- encrypted-key-name : should contain the name of an encrypted key file
>>> located
>>>> +	on the firmware search path. It will be used to decrypt the FPGA
>>> image
>>>> +	file with user-key.
>>>
>>> I might be misreading things, but your driver code seems to assume that this
>>> is an aes key. Nothing here seems to document that this is supposed to be a
>>> key of a particular type.
>>>
>>
>> Yes, these changes are intended to add the support for Aes user-key encrypted bitstream loading use case.
>> Will fix it in v2, something like below.
>> aes-key-file-name : Should contain the AES key file name on the firmware search path.
>> 		      The key file contains the AES key and it will be used to decrypt the FPGA image.
> 
> Then when someone comes along looking for a different type of encryption
> we will end up with national-pride-foo-file-name etc. I think I'd rather
> have a second property that notes what type of cipher is being used and
> if that property is not present default to AES.

I wonder why does it need to be in DT in the first place? Why it cannot
be appended to the FPGA binary image itself? Which also points to
dubious security aspect of this approach... Shipping FPGA encrypted
image with its decryption key sounds like marvelous idea.

Even if this is suitable, why not using more arguments of firmware-name?
This would scale even for multiple FPGA firmwares with different keys
(although such need seems unlikely).

Best regards,
Krzysztof

