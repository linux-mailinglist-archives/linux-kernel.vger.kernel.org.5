Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5A7C4D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbjJKIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjJKIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:45:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD39199
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:45:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-323168869daso6400405f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697013912; x=1697618712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaocntqyQzYgAwhSvsMlbrVo4KLCdhpxDy1Xa0mJIr4=;
        b=nc2pKcn73o23f5zwlyDYDl3dxK/VCguioFBtlV3g/TzlPpbPhJ7Hv+RQpwn8tkiwsX
         MSfJM9CY9cx3hedBpv7AAVNDtjg5c2EWcmpmlQiP5qvn1BGpDDb+nhhYMMvNoxk0+ChC
         0o3GLNGZSCgGi4YvSuGTDXQEKW8o/oxagrhLgo2z73ncnGHWA59OeeCwkpL6/r5cHvnL
         ersbjg49QS+YqpY0WYSsmGY3NeGEUXcRMyGzLJqHqrfxrZogrGZssZCFZJLOm6W2R109
         3V7krAyEpm58Q/kio8wncCwqbPZw4meH7OaH7iOx6Qu3v37qjK3fbgnpDj5OchTTBXJE
         PIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013912; x=1697618712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaocntqyQzYgAwhSvsMlbrVo4KLCdhpxDy1Xa0mJIr4=;
        b=tDDEW/D/ACFwZ9FnMGxdJKjh/W/p0zHDl4lEya1m6PQV93YxsNUcc2iGIvKEPj9PVv
         0mmZCmdXAasWc4PAfXhMgVQ68xeVo2SBytmmCZmzIFRcejp3gEilVBVfGOTBBbvcnlOv
         BfT6yAtZT1/2KRDKBBx3gV5z9HMu9J6idasSAQXG1nUlosfY0Y2zVH+5kuO0rf3JMbhr
         pw0gtTUfQB69cIVHZ56DqI356XS4+4/YpEZhA6l3NNLeAZgj2IFeiWXuqsdfk7RKE/Cw
         iMnRB0vt953Nhrz/60RSmnNzTWB0CyH+mUzichdCFppC6xPvrN43JY93ZAnE0ZaCpw9k
         0StQ==
X-Gm-Message-State: AOJu0Yzuk2wpAGFCXHxIhTs3Z3I1m5isJtUgSMt6v3+3VGpmI+0hXAZd
        EIKsgzmFqYIl7d6DYObHF9ZF1WWGSqTxoRjCqmPCFA==
X-Google-Smtp-Source: AGHT+IFYKGKvVU6TEAALTI3kDI+OtOGIFKfx+JvKnk0zLNM+JhrRVlD7N9TsVfs0DnACOvAEkE9xng==
X-Received: by 2002:a5d:4149:0:b0:31f:eb8d:481f with SMTP id c9-20020a5d4149000000b0031feb8d481fmr18350562wrq.29.1697013912550;
        Wed, 11 Oct 2023 01:45:12 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q15-20020adf9dcf000000b0032d2f09d991sm3820302wre.33.2023.10.11.01.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:45:12 -0700 (PDT)
Message-ID: <fe4a2688-079c-a36d-0ea4-c244c6e1a0ad@linaro.org>
Date:   Wed, 11 Oct 2023 09:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-8-miquel.raynal@bootlin.com>
 <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
 <20231011091524.0c9ecc55@xps-13>
 <548849a8-9f11-5274-778e-f291267603bb@linaro.org>
 <20231011103306.08f1fbd4@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231011103306.08f1fbd4@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 09:33, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:27:20 +0100:
> 
>> On 11/10/2023 08:15, Miquel Raynal wrote:
>>>>> +
>>>>> +	nvmem_cells_group.bin_attrs = cells_attrs;
>>>>> +
>>>>> +	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
>>>>> +	if (ret)
>>>>> +		goto unlock_mutex;
>>>> This is going to create groups after the nvmem device is added, isn't this going to be problem with user space notifications?
>>> Greg said it was not. I hope I understood correctly 😄
>>>
>>> And anyway, cells have never been available to userspace, so there is
>>> nothing userspace might expect yet?
>> I agree, but once we add sysfs uapi then this is going to change.
> 
> Can you elaborate? I'm not sure I follow you here. Is there still a
> problem you fear or you think it's okay?
> 
Now that we add cells to sysfs.
AFAIU, By the time the userspace sees the udev event from this device we 
might not have cells populated.

--srini


> Thanks,
> Miquèl
