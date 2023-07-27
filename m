Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629DE765089
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjG0KGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjG0KGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:06:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB5128;
        Thu, 27 Jul 2023 03:06:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8ad907ba4so4779345ad.0;
        Thu, 27 Jul 2023 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690452395; x=1691057195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FZGCECC5UQyB2oH7t7oPCmzkPOTLbo6iKgyeWpbv7c=;
        b=sR0fpuXlCwcqDAm+RnK7VTaord/oL9OZcsbmgToilTPOq70tGFihy2R+rP6mvmX+XR
         +E2JxyI3NB1Rvm9MFdaUC4cEgC+HAh3cjp/lsdxhia3AoYfag+RQ5IJOV5y5+my261ZY
         cBW2bJCyxixxaBbzCo46GiPShOfWEdPFut+xTM/XMki2MH2txGGKUk2kb0ygmTuZvijJ
         qUHs5yYhvWtl0rmpUiWnFhQ2jRLJyW6g/eGFY9Sk64uLICLO5KVqEDKImnpvFXjuc+bp
         MAfc22wA8SyG0tKWmhCeuIsNZNM/n6GOdBnX5my0+hccEj66VoTfsdzy639wNSewEG8p
         mTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690452395; x=1691057195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FZGCECC5UQyB2oH7t7oPCmzkPOTLbo6iKgyeWpbv7c=;
        b=Uu+rOzgccmENZntRwZ36e09aalgMfO3XYgMHr78jt7FDyn8cBkG4eTjlf0/dZMGc/K
         lAufOlh9Tplikn32jxJtg9xI/5AI6lLGF9nIdYYZxRXng8piyjWfun3ohbIbsCXbW4NU
         qrB3TTO+3udguCkLSw3UOrELccUu7PzjgwXB6+0M2xfZ99W/eruT1BT7ErYW+mo5gRoY
         tUQOmul8Jv04vgo6yFbNiNxDfpjkCdlMbWSOhRyguNcLF2w6GM6yLByxnX2LEnu3WzTg
         omcECyWa9zjohiAGtlaRpI9H02AwjNLmbjvj7rHK5QABD6HTJ32mqyasvJ0dPX4S1iFz
         /AKQ==
X-Gm-Message-State: ABy/qLZeiCW1ldNV/leYVvPh+27sU1+QzBpjq3BY2Rz6Qpyz1tBcDhEs
        xgjwFfGPYEaWup6+2WhiXvQOE/yzDCGhYg==
X-Google-Smtp-Source: APBJJlGcNpa5SEIxTsbL6e1MnleOLiKInLJf+D24pkQZimLlFKc0j4iZnOu/4CNCbxCHmVrBtFrvKg==
X-Received: by 2002:a17:902:7207:b0:1b6:ba60:77f0 with SMTP id ba7-20020a170902720700b001b6ba6077f0mr3867479plb.10.1690452395080;
        Thu, 27 Jul 2023 03:06:35 -0700 (PDT)
Received: from [192.168.1.121] ([65.129.146.152])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b001bba3a4888bsm1212060plo.102.2023.07.27.03.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:06:34 -0700 (PDT)
Message-ID: <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
Date:   Thu, 27 Jul 2023 04:06:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
From:   TW <dalzot@gmail.com>
In-Reply-To: <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I retried on 6.5 rc3 without the Nvidia drivers and still received the 
same error and going to try for the patch next but got a malformed patch 
error on line 6 for the first patch for libata-scsi.c. The other two 
seem to go through just fine however.

Also the bugzilla link is similar to what I have but the disk doesn't 
disappear, comes back but just takes awhile to come back out of sleep mode.

On 7/26/23 17:39, Damien Le Moal wrote:
> On 7/26/23 22:47, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>
>> On 26.07.23 13:54, TW wrote:
>>> I have been having issues with the 6.x series of kernels resuming from
>>> suspend with one of my drives. Far as I can tell it has trouble with the
>>> cache on the drive when coming out of s3 sleep. Tried a few different
>>> distros (Manjaro, OpenMandriva Rome, EndeavourOS) all that give the same
>>> error message. It appears to work fine on the 5.15 kernel just fine
>>> however.
>>>
>>> This is the error or errors that I have been getting and assume has been
>>> holding up the system from resuming from suspend.
>>>
>>> Jul 20 04:13:41 rageworks kernel: ata10.00: device reported invalid CHS sector 0
>>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Start/Stop Unit failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
>>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Sense Key : Illegal Request [current]
>>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Add. Sense: Unaligned write command
> This sense is garbage. This issue was reported already, but it is hard
> to deal with as it seems to be due to drives/adapters not correctly
> reporting status bits. So for now, let's ignore this sense codes.
>
> The start/stop unit failure is weird. On another case, I am suspecting
> that this command is causing a delay on resume, but not an error like this.
>
>>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 returns -5
>>> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: failed to resume async: error -5
>> Thx for your report. I CCed a few people, with a bit of luck they have
>> an idea. But I doubt it. If no one replies you likely will need a
>> bisection to find the root of the problem. But before going down that
>> route you want to check if latest mainline kernel (vanilla!) works better.
>>
>> FWIW, this is not my area of expertise, so the following might be a
>> misleading comment, but the problem looks somewhat similar to this one
>> that iirc was never solved:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216087
>>
>>> Jul 20 04:12:51 rageworks systemd[1]: nvidia-suspend.service: Deactivated successfully.
>>> Jul 20 04:12:51 rageworks systemd[1]: Finished NVIDIA system suspend actions.
>>> Jul 20 04:12:51 rageworks systemd[1]: Starting System Suspend...
>> That sounds like you are using out-of tree drivers which can cause all
>> sorts of issues. Please recheck if the problem happens without those as
>> well and do not use them in all further tests to debug the issue.
> Yes. Please retest with the latest 6.5-rc3.
>
> And can you try this patch to see if it solves your issue ?
>
> commit 29e81d11812ee924d19425343ec69acd34af9d35
> Author: Damien Le Moal <dlemoal@kernel.org>
> Date:   Mon Jul 24 13:23:14 2023 +0900
>
>      ata,scsi: do not issue START STOP UNIT on resume
>
>      Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 370d18aca71e..6184c7bcc16c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1100,7 +1100,13 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct
> ata_device *dev)
>   		}
>   	} else {
>   		sdev->sector_size = ata_id_logical_sector_size(dev->id);
> +		/*
> +		 * Stop the drive on suspend but do not issue START STOP UNIT
> +		 * on resume as this is not necessary: the port is reset on
> +		 * resume, which wakes up the drive.
> +		 */
>   		sdev->manage_start_stop = 1;
> +		sdev->no_start_on_resume = 1;
>   	}
>
>   	/*
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 68b12afa0721..b8584fe3123e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3876,7 +3876,7 @@ static int sd_suspend_runtime(struct device *dev)
>   static int sd_resume(struct device *dev)
>   {
>   	struct scsi_disk *sdkp = dev_get_drvdata(dev);
> -	int ret;
> +	int ret = 0;
>
>   	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
>   		return 0;
> @@ -3885,7 +3885,8 @@ static int sd_resume(struct device *dev)
>   		return 0;
>
>   	sd_printk(KERN_NOTICE, sdkp, "Starting disk\n");
> -	ret = sd_start_stop_device(sdkp, 1);
> +	if (!sdkp->device->no_start_on_resume)
> +		ret = sd_start_stop_device(sdkp, 1);
>   	if (!ret)
>   		opal_unlock_from_suspend(sdkp->opal_dev);
>   	return ret;
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 75b2235b99e2..b9230b6add04 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -194,6 +194,7 @@ struct scsi_device {
>   	unsigned no_start_on_add:1;	/* do not issue start on add */
>   	unsigned allow_restart:1; /* issue START_UNIT in error handler */
>   	unsigned manage_start_stop:1;	/* Let HLD (sd) manage start/stop */
> +	unsigned no_start_on_resume:1; /* Do not issue START_STOP_UNIT on resume */
>   	unsigned start_stop_pwr_cond:1;	/* Set power cond. in START_STOP_UNIT */
>   	unsigned no_uld_attach:1; /* disable connecting to upper level drivers */
>   	unsigned select_no_atn:1;
>
>
