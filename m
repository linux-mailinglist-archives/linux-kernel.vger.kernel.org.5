Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953577EEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbjHQBfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347584AbjHQBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:35:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2837271E;
        Wed, 16 Aug 2023 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=zvtP8BIj97o/Cat7fAMVWEk9H3Ye1GKUu/8P+69LdpY=;
        b=K74aLUTwswuScRZAby7DmCBTBFhfvBzMuBsesxW4QWoE1v573SKtvE3h+Z/Jr9
        +4WkJJ3e6yoAaVYR1g2RfkNHXnhBV7sN9x+tmpjlf49qwEmCJoFHvwiBD57bYg6h
        zT6SymVbpM0LCkDRPlGbkbHmNUYMYyplJJOwqamDycrzc=
Received: from [172.20.10.2] (unknown [39.144.139.14])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wDnXhs2ed1kS_P9DA--.9791S3;
        Thu, 17 Aug 2023 09:34:48 +0800 (CST)
Message-ID: <0a50f81d-ffc2-9a24-9798-424f353d209e@163.com>
Date:   Thu, 17 Aug 2023 09:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] platform/x86/siemens: simatic-ipc-batt: fix logic
 error for BX-59A
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com, Ashok Raj <ashok.raj@intel.com>
References: <d41d3ae3-9c1b-661-4664-51d62ad1d786@linux.intel.com>
 <20430731173417.2692-1-xingtong_wu@163.com> <ZNzvMMCUMDrgmTnn@araj-dh-work>
Content-Language: en-US
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <ZNzvMMCUMDrgmTnn@araj-dh-work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDnXhs2ed1kS_P9DA--.9791S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWfCr17Xry8Jr43tF15XFb_yoW8tw1UpF
        s5Wa1qkFWUWry5twsrGay3uFW3Zw45Kr17G3Wqyw15Z3sFvFn7tr17Za1aqFsrAr4UWayr
        JFn3tF9rKayDZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE385UUUUU=
X-Originating-IP: [39.144.139.14]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfgHO0GDcPOA19wAAsD
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/16 23:45, Ashok Raj wrote:
> On Sat, Aug 01, 2043 at 01:34:17AM +0800, xingtong_wu@163.com wrote:
> ^^^^^^^^^^^^^^^^^^^^
> 
> Nice way to keep your mail on top of the sort :-).. You need to fixup your
> system date.

I'm sorry that there are time problem on my local machine which lead to a
wrong time in email, but I just sent an email to remind hdegoede@redhat.com
individually, the time problem was solved by him on his branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=review-hans&id=b01c1e022f7f0c327ecc7544dc44d5f80a2d2bd9
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=review-hans&id=7abf253afa5c72c0c7eb21f67da1d443f036737a

> 
>> From: "xingtong.wu" <xingtong.wu@siemens.com>
>>
>> The variable "priv.devmode" is missing from if statement that leads
>> to a logical error. Add the missing variable to the if condition.
>>
>> Fixes: c56beff20375 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202308010001.BGYCSQrl-lkp@intel.com/
>>
>> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
>> ---
>>  drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
>> index d66b9969234b..e6c12c52843c 100644
>> --- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
>> +++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
>> @@ -194,7 +194,8 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
>>  
>>  	if (table->table[2].key) {
>>  		flags = GPIOD_OUT_HIGH;
>> -		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
>> +		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A ||
>> +		    priv.devmode == SIMATIC_IPC_DEVICE_BX_59A)
>>  			flags = GPIOD_OUT_LOW;
>>  		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
>>  		if (IS_ERR(priv.gpios[2])) {
>> -- 
>> 2.25.1
>>

