Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8C7D88F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjJZTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjJZTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:31:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F441AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:31:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507ac66a969so1579889e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698348696; x=1698953496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ywy6fWVLvmJZckMh0b8tqYAFdaL2mApdB/loN0g2f0E=;
        b=jy3P1kNY8nvwnGdsS33FAuuv9IH6Phd6MVXSvNePNuZonbZOVIfG5XECi7VFkiNgVl
         qtf8tnEIuETTGTG6QQU1mYDLg1Y+M8QYF4T5FsyO+xFGs/8yS4oJQujREnK4CP7KDUuR
         ifSGc8NIVC6mLZdNeGBLsp6VCHXYdL5hbFQD4XeDgSDkIkN/0P+GSU210Rb5tjBZfBEy
         bUrDczpNRAKfBptS8E/1/c6ygUsBeKh1r5GkC8HD6mDk2k3v9DZcruB5NT1z8usZwzB6
         bXrSL9Z4nEW8mEucO6kJpAhwPeKaaIr4UPc4Iq8WHVjAznFrCnulCIeSSx1mjuY1yDtn
         hG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698348696; x=1698953496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywy6fWVLvmJZckMh0b8tqYAFdaL2mApdB/loN0g2f0E=;
        b=eWlYJ/NjkWnI0meRix3e5Q0Oo15dElN55k01vK6I4xULWpOjHtCcAZ2NtIjciPvMEC
         +wJy53b6ZSNvaS3g+zjAouJ6aj0UcX1sbDsruzR82LbCm4zq4u93ePpuwqGnx5JLxwyQ
         OjX7vc0Clqt98sate3UbO4M55r9KjBCDah05GkOMQKZg5PKDnXriXgMDvF2AmcdGkr9N
         z8UBEsPJZFtrhoJINXDO2MienfNBQPgs/0pU5T07wPMTsyDzWbF6IJYJKf5C3ILqnjYA
         Up99r9FaHs54jd4dLuTwprlLdjPfhLrAJrBB8MqTH3fbshjfnWYEyPnjSqsGcjCR3ib8
         /Wpg==
X-Gm-Message-State: AOJu0Yy3ggcWeSSWdYvvHyGI//fG/dL/mFj6UQBaY41QiQS0gPoZ1H7a
        NSPiPC3n8C1Jycx4KwZineugHQ==
X-Google-Smtp-Source: AGHT+IFWDZS34rvspUgwbDHXK7kc9utTg6aVksJEARy6vQoLFoqbqsEj13cqR6sg0rLi/wgb+XBc2A==
X-Received: by 2002:ac2:52b0:0:b0:507:a86d:89bb with SMTP id r16-20020ac252b0000000b00507a86d89bbmr226981lfm.23.1698348696571;
        Thu, 26 Oct 2023 12:31:36 -0700 (PDT)
Received: from [172.30.204.84] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j19-20020a056512345300b0050336e38735sm3107145lfr.92.2023.10.26.12.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:31:36 -0700 (PDT)
Message-ID: <3109efe2-120b-447b-ae7d-16f03e3dc3a6@linaro.org>
Date:   Thu, 26 Oct 2023 21:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
To:     Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
 <1413119B-8B9C-4DE4-A086-476B2BAA60AD@linaro.org>
 <20230919120829.GB4732@thinkpad>
 <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
 <20230920102327.GH4732@thinkpad> <20231018124741.GA47321@thinkpad>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231018124741.GA47321@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 14:47, Manivannan Sadhasivam wrote:
> On Wed, Sep 20, 2023 at 12:23:27PM +0200, Manivannan Sadhasivam wrote:
>> On Wed, Sep 20, 2023 at 01:27:59AM +0300, Dmitry Baryshkov wrote:
>>> On Tue, 19 Sept 2023 at 15:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>>
>>>> On Fri, Sep 15, 2023 at 05:31:45AM +0300, Dmitry Baryshkov wrote:
>>>>> On 11 September 2023 13:02:50 GMT+03:00, Can Guo <quic_cang@quicinc.com> wrote:
>>>>>>
>>>>>> On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
>>>>>>> On 11.09.2023 11:42, Can Guo wrote:
>>>>>>>> Hi Konrad,
>>>>>>>>
>>>>>>>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
>>>>>>>>> On 11.09.2023 07:59, Can Guo wrote:
>>>>>>>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
>>>>>>>>>>
>>>>>>>>>> Retrieve UFS device version from UFS host controller's spare register
>>>>>>>>>> which is populated by bootloader, and use the UFS device version together
>>>>>>>>>> with host controller's HW version to decide the proper power modes which
>>>>>>>>>> should be used to configure the UFS PHY.
>>>>>>>>> That sounds a bit fishy.. is there no bootloader-independent
>>>>>>>>> solution to that? Can't we bring in the code that the bootloader
>>>>>>>>> uses to determine these values?
>>>>>>>>>
>>>>>>>>> Konrad
>>>>>>>>
>>>>>>>> Agree, it is.
>>>>>>>>
>>>>>>>>
>>>>>>>> All these complexities come from one request from PHY design team - power saving.
>>>>>>>>
>>>>>>>> And to achieve power saving, Qualcomm UFS developers are requested to use the
>>>>>>>>
>>>>>>>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
>>>>>>>>
>>>>>>>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
>>>>>>>>
>>>>>>>> request does not apply to bootloader, which works for only a few seconds during
>>>>>>>>
>>>>>>>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
>>>>>>>>
>>>>>>>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
>>>>>>>>
>>>>>>>> register.
>>>>>>> First of all, your email client seems to be inserting 2 newlines
>>>>>>> instead of 1. If you're using thunderbird, you may want to edit:
>>>>>>>
>>>>>>> mail.identity.(default or your mail identity idx).default.compose_html
>>>>>>>
>>>>>>> to `false`
>>>>>>>
>>>>>>> and add that to your internal wiki page, as I see many @quic folks having
>>>>>>> this issue.
>>>>>>>
>>>>>>>
>>>>>>> Going back to the main topic, I don't think we understood each other.
>>>>>>> The commit message states:
>>>>>>>
>>>>>>>
>>>>>>> "Retrieve UFS device version from UFS host controller's spare register
>>>>>>> which is populated by bootloader"
>>>>>>>
>>>>>>>
>>>>>>> Which means the bootloader is able to somehow determine the value
>>>>>>> that's in the spare register and write it there.
>>>>>>>
>>>>>>> I'm asking whether we can take the logic behind this value and
>>>>>>> move it to Linux so that we don't depend on the bootloader to
>>>>>>> guarantee it (e.g. Chrome or some other devices with more exotic
>>>>>>> fw may not work this way).
>>>>>>>
>>>>>>>
>>>>>>> Konrad
>>>>>>
>>>>>>
>>>>>> There is no logic behind this value at all in bootloader, as I explained, after bootloader
>>>>>>
>>>>>> initializes UFS, bootloader simply reads UFS's device version (the value you are referring)
>>>>>>
>>>>>> and write it to the register. But in Linux kernel, we need (or want to know) this value
>>>>>>
>>>>>> BEFORE we initialize UFS host controller (and UFS device).
>>>>>
>>>>> Depending on the bootloader behaviour is not an option. For example the kernel might be started via kexec. Or via u-boot. Or grub. Or any other bootloader. So please duplicate the logic to read the UFS version instead.
>>>>>
>>>>
>>>> As Can said, there is no logic in the bootloader. What it does it, after doing
>>>> the UFS initialization, it writes the agreed gear (between host and the device)
>>>> to this register. And in linux, we use that value to initialize the device
>>>> (i.e., not doing init based on the min gear).
>>>>
>>>> But the important factor here is that, we use this gear value to program the PHY
>>>> init sequence. So if there is no hint from the bootloader, linux will program
>>>> the min phy sequence (G3/G4) and then once the gear scaling happens, it will
>>>> program the max phy sequence (G4/G5).
>>>>
>>>> Now on recent platforms, the init sequences are not compatible with each other
>>>> i.e., once the min seq. is programmed, then before programming max seq. the
>>>> registers not common to both seq. should be programmed to default value. In
>>>> other words, min seq. specific registers should be reset to the default value.
>>>> Otherwise, there will be stability issues in the PHY.
>>>
>>> I see nothing wrong with adding 'default' register programming to the
>>> gear tables. If we have to reset them to the default values to switch
>>> the PHY settings, these writes must be a part of the corresponding
>>> tables.
>>>
>>
>> Yep, that's what I initially proposed. But Qcom wanted to avoid the cost of
>> programming the reset tables in the PHY driver.
>>
>> Can, could you please check if programming the additional sequence doesn't cause
>> any power/performance effect?
>>
> 
> I'd like to simplify this conversion as there has been some misunderstanding.
> 
> First of all in linux, while probing the UFS device by the host controller, it
> needs to use _some_ gear. So far we were using HS_G2 as that gear and using the
> PHY init sequence of G3/G4 depending on the SoC. We do not need to use G2 init
> sequence because, there are only 2 init sequences available for any SoC and
> since the init sequences are backwards compatible, we mostly use the min init
> sequence, G3/G4. Even though this incurs slight power consumption during boot,
> the ufs host controller after probing the device will switch to max gear
> supported by both entities. If that max is G4/G5, then the respective init
> sequence will be programmed again.
> 
> Now the issue is, for the automotive usecases, switching the gears 2 times
> during boot is affecting the boot KPI (Key Performance Inidicator). So the UFS
> team came with the idea of populating a spare register in the bootloader with
> the max gear info that the bootloader has already found out and using the same
> in the linux for first time itself. This helps linux in using a single gear
> during probe time.
> 
> This is what this patch is doing. If for some reason, that register is not
> populated, then we default to the existing G2 gear and do init twice as the
> driver is doing currently.
> 
> I hope this clarifies the intention of this patch.
Yes I understand this, but I am not sure if such tricks should make
it upstream.. They depend on specific firmware (unrelated to the hw
block itself) and only exist to improve boot times. If the firmware
requirement was not at play, I would have no issues with this.

Konrad
