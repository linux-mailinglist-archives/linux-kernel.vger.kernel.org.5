Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CA7C55F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjJKN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjJKN4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:56:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C192
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:56:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32329d935d4so6231831f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697032565; x=1697637365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phV1Eh8dyDwq/UtzOXVkVl989phIpfhIdWj1kthmPMU=;
        b=M196KiNrwuEmlu89slyU5qVl5wqR6OWAEErIeOdYZbXarhi9Qej9QkVaDgxTK4W78f
         33UEu8XxIH9mUSgJV4CmEHXXnSPrSrnOYu+iKxAQfExoVJGyKEtHxNFL0af5KKD+roHJ
         9NkduxXBbz1d94BLBK2GNFXwVauSkJUS6fXv/2qRkmox6kbpIu+X3IpEe/T7KPSZFPpn
         K2F8ZkSJrDO/dofxLOrdvMGNxKZSk9fQR6YEuzaeCEXsq/vWYGhFEdslhIyIPQm3nxW6
         4jbgScqiCiw6yYQQm12Z+4DePnraCBh6ann4Jmua3Fji5JFbQ7VYQjvI8ZadluAb2a/t
         ujkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032565; x=1697637365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phV1Eh8dyDwq/UtzOXVkVl989phIpfhIdWj1kthmPMU=;
        b=Mq88BlBauoQgsLQL43CbDdKGVCJ71cMlGtcSPxJ2/Tz9YMD/qMu8gqwNN9bEp1Ckhr
         0HDobR3yyUjx2gPyjHRkmsuCWUt6ALVvIZZUoDy/J6CeioheFSzNIRruX6flWmZkrdbv
         UT/tIFauFw0Ioo22872YUD7x4I0xAy2oezgQz+xhQEM1UlF3YY75xd9tfhMusN1MTDWl
         rJS4yU5Pn3hhemJ6Qr60FoXP2gSPiXm0cCGwAwKb+/LNsT0mY4+a2+HCmPW645PIIR20
         pqCqqH1RrPf2Re800vCcHzEtSX1cLyYsZyvEQ7X0K7RfdcH2LMM+SiEe45hI7JV+QUMw
         la4w==
X-Gm-Message-State: AOJu0YzfXwimezLyB7R+pjoFqAEMOMPHIK1F5PS3L5x73UeKLBD44eMw
        aSSrK5b/EPH+bVIa1WRTYzND7w==
X-Google-Smtp-Source: AGHT+IHykpxyTqgSJ1JQDn0+8x8DG1N64O/bL8mtwyARRWrhDwMk4wMMZeoYL0N8OiimYgCipr/1Mw==
X-Received: by 2002:adf:e689:0:b0:319:8bb3:ab83 with SMTP id r9-20020adfe689000000b003198bb3ab83mr17524839wrm.66.1697032565036;
        Wed, 11 Oct 2023 06:56:05 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n16-20020a1c7210000000b00406725f27e1sm16826507wmc.42.2023.10.11.06.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 06:56:04 -0700 (PDT)
Message-ID: <a67f5fd1-6b5c-662d-5ab3-b528c2080efc@linaro.org>
Date:   Wed, 11 Oct 2023 14:56:02 +0100
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
 <fe4a2688-079c-a36d-0ea4-c244c6e1a0ad@linaro.org>
 <20231011105829.778bed58@xps-13>
 <490c6740-06cb-9ee6-ca8c-3ab404109344@linaro.org>
 <20231011114419.21821f4d@xps-13>
 <8b8403ee-b610-312b-aa98-3e4fa65a3800@linaro.org>
 <20231011130931.3b6216aa@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231011130931.3b6216aa@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 12:09, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 11:02:16 +0100:
> 
>> Hi Miquel,
>>
>> On 11/10/2023 10:44, Miquel Raynal wrote:
>>> Hi Srinivas,
>>>
>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 10:26:43 +0100:
>>>    
>>>> On 11/10/2023 09:58, Miquel Raynal wrote:
>>>>> Hi Srinivas,
>>>>>
>>>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:45:11 +0100:
>>>>>     >>>> On 11/10/2023 09:33, Miquel Raynal wrote:
>>>>>>> Hi Srinivas,
>>>>>>>
>>>>>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:27:20 +0100:
>>>>>>>      >>>> On 11/10/2023 08:15, Miquel Raynal wrote:
>>>>>>>>>>> +
>>>>>>>>>>> +	nvmem_cells_group.bin_attrs = cells_attrs;
>>>>>>>>>>> +
>>>>>>>>>>> +	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
>>>>>>>>>>> +	if (ret)
>>>>>>>>>>> +		goto unlock_mutex;
>>>>>>>>>> This is going to create groups after the nvmem device is added, isn't this going to be problem with user space notifications?
>>>>>>>>> Greg said it was not. I hope I understood correctly 😄
>>>>>>>>>
>>>>>>>>> And anyway, cells have never been available to userspace, so there is
>>>>>>>>> nothing userspace might expect yet?
>>>>>>>> I agree, but once we add sysfs uapi then this is going to change.
>>>>>>>
>>>>>>> Can you elaborate? I'm not sure I follow you here. Is there still a
>>>>>>> problem you fear or you think it's okay?
>>>>>>>      >> Now that we add cells to sysfs.
>>>>>> AFAIU, By the time the userspace sees the udev event from this device we might not have cells populated.
>>>>>
>>>>> Yes, but why would this be a problem?
>>>>>     >> It will be problem if the userspace is using things like libudev to act on these events. There seems to be some caching of attributes in udev during event more info http://www.kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
>>>
>>> I am already using these attributes, right? The problem here is that we
>>> always attach cells sysfs attributes to the nvmem device, but in some
>>> cases (when using layout devices/drivers) the probe of these devices
>>> will happen after the main nvmem device has been announced to userspace
>>> and thus these attributes might not be populated yet (but Greg said it
>>> was "supported" and I assumed it was fine).
>>>   > So what is your idea here to overcome this?
>>
>> Ideally we should have all the cells definitions ready by the time nvmem is registered.
> 
> I no longer think what you describe can happen because even though the
> rootfs might be mounted, the daemons will only be 'started' once the
> kernel is done starting and starts the init process, which means all
> the devices have probed and all the cells have been registered as well.
I think you forgot about modules in the above flow.

--srini


> 
> Thanks,
> Miquèl
