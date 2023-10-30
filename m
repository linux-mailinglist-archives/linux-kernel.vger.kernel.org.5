Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7528B7DBF96
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjJ3SQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJ3SQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:16:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCFEC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:16:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso52355339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698689790; x=1699294590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFDqrbYKOqLwZznuHEkDhT2cZTWKmKTM7km9nXzpM1Y=;
        b=G/tX8GB+wnip1eZtZozpCh0Kl1R3PiHlJGiO9gIbvxR5Eh6mqmaQu1dw1M8KQx6DE7
         4Xzi4L2+rfOW3qQYRHg7tqE0BNza6IGLidphF9VsG/J2fMJGJfocVOdpnIFLkX/wngMt
         pUmOmpOEn+IVO/CNYRIwR77SbELHLLYcwZUp793nE29boi/AF/XMCuHuzAzaoYFS1qnX
         4+sHvPa1E+hWTyA+CMUJYHfXFLv9OlYsfctfYu2r95HhdJQV3s7EAwwQHY0eYY0tPwk5
         CWe8YpVOcl3lBjcnYcm+pex7Aw2jqZAu6OVFoug3JKUhn9ltANFW70MZJSKsA1g1GJXk
         HGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689790; x=1699294590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFDqrbYKOqLwZznuHEkDhT2cZTWKmKTM7km9nXzpM1Y=;
        b=g+Zu4UtwO0VDyXqPndfjktzVlFBkXdZjLjGuIoyaG/R4ISgIQK8rPjC14kaZ8Kis7V
         NniObahDKOeSWDryjTseuQ0//7vIfu8QFpoYi8gpOvXXuZPae+dn2cvJ9ZlnzMvyVxVo
         TtWPf4nir8Ho9MNMU8io0Unnt3zqR+qTAb+TlPpkhT8QBfTTfqoH4jSC7rUNRO2Tg01W
         qrAViPC/HXPrQ0myiMQwZovAPQs4KA/x8yaIP+w9tVT2P3meB5bWaZl4sUG4DPYclrKK
         terQhwK6gcobQQXEPA2aXdRNEm4wjh7PUJNjbbwjPRjtNvDovf25Ta5N353xMormZxjf
         NC9A==
X-Gm-Message-State: AOJu0YyPAdMxxdLFx+Key+GtCbWrM5rx5n+OmS7BJj/GTaBQlQnhur+b
        92kODKNpL0IkkpqZVymf5TI=
X-Google-Smtp-Source: AGHT+IFyZz12GsPq2t1rm2RNfrRjgktUJJa5l2t6X2bfS34Okyj0eM3kV0jyRHGuP2Nd53ccrCnT7A==
X-Received: by 2002:a05:6e02:1d1c:b0:358:a6e:71b7 with SMTP id i28-20020a056e021d1c00b003580a6e71b7mr13811660ila.0.1698689789921;
        Mon, 30 Oct 2023 11:16:29 -0700 (PDT)
Received: from [10.69.0.11] (c-68-55-100-39.hsd1.mi.comcast.net. [68.55.100.39])
        by smtp.gmail.com with ESMTPSA id d1-20020a056e02050100b0035268f0794dsm2516838ils.18.2023.10.30.11.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 11:16:29 -0700 (PDT)
Message-ID: <49a2e942-97d2-4b9f-8151-e6a8b85514cf@gmail.com>
Date:   Mon, 30 Oct 2023 14:16:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-cfg: Use AVS driver on SKL/KBL/APL
 Chromebooks
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
References: <ZTz9orCylVwn3Pye@arch>
 <257609dc-8fa9-40e0-8730-29e45af93878@linux.intel.com>
From:   Brady Norander <bradynorander@gmail.com>
In-Reply-To: <257609dc-8fa9-40e0-8730-29e45af93878@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 12:08, Pierre-Louis Bossart wrote:
> 
> 
> On 10/28/23 07:25, Brady Norander wrote:
>> The legacy SKL driver no longer works properly on these Chromebook
>> platforms. Use the new AVS driver by default instead.
> 
> shouldn't this be used only if AVS is compiled in?
>
Good point, I'll send a v2.

>>
>> Signed-off-by: Brady Norander <bradynorander@gmail.com>
>> ---
>>   sound/hda/intel-dsp-config.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
>> index 756fa0aa69bb..1045be1fd441 100644
>> --- a/sound/hda/intel-dsp-config.c
>> +++ b/sound/hda/intel-dsp-config.c
>> @@ -16,10 +16,11 @@
>>   static int dsp_driver;
>>   
>>   module_param(dsp_driver, int, 0444);
>> -MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF)");
>> +MODULE_PARM_DESC(dsp_driver, "Force the DSP driver for Intel DSP (0=auto, 1=legacy, 2=SST, 3=SOF, 4=AVS)");
>>   
>>   #define FLAG_SST			BIT(0)
>>   #define FLAG_SOF			BIT(1)
>> +#define FLAG_AVS			BIT(2)
>>   #define FLAG_SST_ONLY_IF_DMIC		BIT(15)
>>   #define FLAG_SOF_ONLY_IF_DMIC		BIT(16)
>>   #define FLAG_SOF_ONLY_IF_SOUNDWIRE	BIT(17)
>> @@ -56,7 +57,7 @@ static const struct config_entry config_table[] = {
>>   /*
>>    * Apollolake (Broxton-P)
>>    * the legacy HDAudio driver is used except on Up Squared (SOF) and
>> - * Chromebooks (SST), as well as devices based on the ES8336 codec
>> + * Chromebooks (AVS), as well as devices based on the ES8336 codec
>>    */
>>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
>>   	{
>> @@ -81,7 +82,7 @@ static const struct config_entry config_table[] = {
>>   #endif
>>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
>>   	{
>> -		.flags = FLAG_SST,
>> +		.flags = FLAG_AVS,
>>   		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
>>   		.dmi_table = (const struct dmi_system_id []) {
>>   			{
>> @@ -96,13 +97,13 @@ static const struct config_entry config_table[] = {
>>   #endif
>>   /*
>>    * Skylake and Kabylake use legacy HDAudio driver except for Google
>> - * Chromebooks (SST)
>> + * Chromebooks (AVS)
>>    */
>>   
>>   /* Sunrise Point-LP */
>>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
>>   	{
>> -		.flags = FLAG_SST,
>> +		.flags = FLAG_AVS,
>>   		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
>>   		.dmi_table = (const struct dmi_system_id []) {
>>   			{
>> @@ -122,7 +123,7 @@ static const struct config_entry config_table[] = {
>>   /* Kabylake-LP */
>>   #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
>>   	{
>> -		.flags = FLAG_SST,
>> +		.flags = FLAG_AVS,
>>   		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
>>   		.dmi_table = (const struct dmi_system_id []) {
>>   			{
>> @@ -667,6 +668,9 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
>>   		}
>>   	}
>>   
>> +	if (cfg->flags & FLAG_AVS)
>> +		return SND_INTEL_DSP_DRIVER_AVS;
>> +
>>   	return SND_INTEL_DSP_DRIVER_LEGACY;
>>   }
>>   EXPORT_SYMBOL_GPL(snd_intel_dsp_driver_probe);
