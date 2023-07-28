Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27763766F76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjG1O2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjG1O2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:28:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A23A97;
        Fri, 28 Jul 2023 07:28:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2680eee423aso1247150a91.2;
        Fri, 28 Jul 2023 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690554518; x=1691159318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtDsi+pEp/nNRMu+KQzhU8MBpSDJijbUVBsN9cf24GY=;
        b=OmGn8k07nYiaEegv+GN8Im0wQ/MpUTRCtGXnxVIXHRXZhnkinbLI1dHjM0Wy+8280B
         0B7Tj81pS5VPYDyNSntXbAH52kvELUz6/AeraNGj2ls6QGAi41zzdb0p8Ep63toSfeX4
         i4wgVCtgk4vvbeJwonFdItN3LBliaSw5obqJjYw9s0D4oyblTc3wvEMSPo1K8+QncJDl
         N6UN9YdNm4w5hvjkCZ6tAXTBJy4oiit2eN4Zm7QcW4kaWiWA1MtN0VDtGdVwUmAl4mfu
         FUbLag8pu2jGxZfma8MfyBl+UcQan7RkBzSI14+VZ8wbIlYVlDmqaN46fYGFO5ODfo1e
         haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554518; x=1691159318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtDsi+pEp/nNRMu+KQzhU8MBpSDJijbUVBsN9cf24GY=;
        b=S4CDW/0GgHEGjcJ/zItdMlh/Ka3NaJHmk6v/uCflY6lCd5iX/qgOVD3AEuTobGWNeU
         ZQ1oUpADr+tpyQuvDbCTh8kypWeixEHxC1v9VOg0ja9dryqMilBZBwg0/A/U1uQy3rEM
         L1dpj5n0Ls1/UTec57s7VxyiLzSrRcrrtT0FOkshWrf+czDF7tf1yiNtDCqypz2TnCMg
         PrflM6T6Ow/ME4snhxX3z0zYBqFv7Bqjwfjyj5yLZAUDUXms6CljKAIJ25Eue4GiDuq8
         uUHIzIk7SMbBqRTVT4mj/qhuxpwOGJ8j4wo+PkHaayJJ40MuFDxXHdaYQv/DkIqVTv4R
         V8rQ==
X-Gm-Message-State: ABy/qLb/Wh8Cr3MrOOlwnZ7ZvWgVDZiUiNs5FeS2nXu2YYGD4VQ4X8fg
        kQVjQTHVFxv9kHTxgu0mBs0=
X-Google-Smtp-Source: APBJJlGq9Ppy+Td/hyv0vhyaQQiigQlnAv2Qg4dsZhHVbEQ+e/KYrMad5RnxSg1dauRUoujuBVziQA==
X-Received: by 2002:a17:90b:38c6:b0:268:8da4:72ac with SMTP id nn6-20020a17090b38c600b002688da472acmr1145098pjb.22.1690554517616;
        Fri, 28 Jul 2023 07:28:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00263f446d432sm4381643pjb.43.2023.07.28.07.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:28:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8686c5c3-81b0-278f-d81b-0c906bac62a8@roeck-us.net>
Date:   Fri, 28 Jul 2023 07:28:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Add Silicom Platform Driver
Content-Language: en-US
To:     Huibin Shi <henrys@silicom-usa.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 05:59, Huibin Shi wrote:
> Christophe,
> 
> Thanks for the comments. See my comments below.
> 
> Updated patch will be sent out later after review comments from other reviewers are addressed.
> 
> Henry
> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Tuesday, July 25, 2023 5:03 PM
> To: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org
> Cc: hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> Le 18/07/2023 à 18:01, Henry Shi a écrit :
>> The Silicom platform (silicom-platform) Linux driver for Swisscom
>> Business Box (Swisscom BB) as well as Cordoba family products is a
>> software solution designed to facilitate the efficient management and
>> control of devices through the integration of various Linux
>> frameworks. This platform driver provides seamless support for device
>> management via the Linux LED framework, GPIO framework, Hardware
>> Monitoring (HWMON), and device attributes. The Silicom platform
>> driver's compatibility with these Linux frameworks allows applications
>> to access and control Cordoba family devices using existing software
>> that is compatible with these frameworks. This compatibility
>> simplifies the development process, reduces dependencies on
>> proprietary solutions, and promotes interoperability with other
>> Linux-based systems and software.
>>
>> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
>> ---
> 
> [...]
> 
>> +static int __init silicom_mc_leds_register(struct device *dev,
>> +                                        const struct led_classdev_mc
>> +*mc_leds) {
>> +     struct led_classdev_mc *led;
>> +     int i, err;
>> +
>> +     for (i = 0; mc_leds[i].led_cdev.name; i++) {
>> +             /* allocate and copy data from the init constansts */
>> +             led = devm_kzalloc(dev, sizeof(struct led_classdev_mc),
>> + GFP_KERNEL);
> 
> sizeof(*led) is shorter.
> Mostly a matter of taste.
> 
> Maybe even devm_kmemdup()?
> 
> Henry: thanks. Devm_kmemdup() API requires additional argument that is not necessary of this driver. I prefer devm_kzalloc for now.
> 

I am curious: What would that additional argument be ?

Guenter

