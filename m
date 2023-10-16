Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B407CA84E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjJPMqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjJPMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:46:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6219B;
        Mon, 16 Oct 2023 05:46:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo7583367a12.3;
        Mon, 16 Oct 2023 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697460364; x=1698065164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FOmIupFfwbmtqNKkRyVeoiyqw11JCFa3LHyfh4EX3o=;
        b=YWuaIFdkHf/BRXn+WkmQFTV8g1NLu2k2TC2SZApQfGIGQLCbf1BJdV7LJQZFsNlp28
         KqI06yyK+nsFPQdeNKTfhmgmgNeIH0xFjppSMBBempKYXqIgfM3n55fNCOo8n7O20Kc4
         UcjUqXgORS4O2TVkdtRhlxLq6GG+6fh96EO7WwVXyACgfl9jDzz8PyEytGYxOXYM15oT
         0fbHqlkEBr4czmDUGGBIdxdQQq9CqnC7ihi8T0vRjHxDNsSrOyYcyrPltCRP5Zwjs1+S
         Sl8leiR3mDe71gRgOzKHwtonglMtqlTunufxOagECCbmyU+QDhj3cJU5Bkzibpznjljy
         Xy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460364; x=1698065164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FOmIupFfwbmtqNKkRyVeoiyqw11JCFa3LHyfh4EX3o=;
        b=ENoC7GkOU34hl3dDJnDpKTjY24+V1/oZtlp8toEKi6ZJlutxwa0z7Su57C14EAJhrx
         K7lHuJBBdAju0kwFZvwoMqZZLQi59UTfxcKX5EIiNXHZf+CXBZ9pPXPEpukLVVsd/BKK
         0p+oFAknqKYqT0AQIl+tpG1JlOVJfzvBRQ6/psof0/4dmO3VoXUs+/kh5pEEBd3wM0MC
         ycbQi3OPzfNYCRB8i4Ozpwna3hjxKrcU+BPqwOImt9lOP4G6vpANkXcmJQlqDWQT8mXd
         19yL4XsUDlQ8Naou2uoVTaQBuAATRce8ygutB6aW0F+IeopbWRnVtxR7kSNsfLiuVg5K
         G8+w==
X-Gm-Message-State: AOJu0YwJr8a+y6ms4MfJha2gabKEUBcY/s4qmuXXSXXy4MVsIYTB/JJw
        r6IMHRs+cPKjJWxnMWtBFA0=
X-Google-Smtp-Source: AGHT+IGr6fTCSurpOKTNR5eZ3/jB5EvYMqg1w2aK8FLVc4auFOPyCDc9rtGL0UQPDrUeRNKXyUzmQQ==
X-Received: by 2002:a05:6402:4415:b0:53d:ff0e:df0 with SMTP id y21-20020a056402441500b0053dff0e0df0mr15676856eda.5.1697460364555;
        Mon, 16 Oct 2023 05:46:04 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id f18-20020a50a6d2000000b0053e5f67d637sm4408988edc.9.2023.10.16.05.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:46:04 -0700 (PDT)
Message-ID: <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
Date:   Mon, 16 Oct 2023 14:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org
References: <20231016070211.39502-1-gmazyland@gmail.com>
 <20231016070531.GA28537@lst.de>
 <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
 <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org>
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 13:54, Damien Le Moal wrote:
> On 10/16/23 16:24, Milan Broz wrote:
>> On 10/16/23 09:05, Christoph Hellwig wrote:
>>> On Mon, Oct 16, 2023 at 09:02:11AM +0200, Milan Broz wrote:
>>>> All common USB/SATA or USB/NVMe adapters I tested need this patch.
>>>>
>>>> In short, these steps are run for OPAL support check:
>>>>     1) Storage driver enables security driver flag (security_supported).
>>>>        USB-attached storage drivers will enable it in a separate patchset.
>>>>        SCSI and NNVMe drivers do it already. If the flag is not enabled,
>>>>        no following steps are run, and OPAL remains disabled.
>>>>     2) SCSI device enumerates SECURITY IN/OUT command support. If detected,
>>>>        SECURITY ON/OUT wrapper is used (as in the current code).
>>>>        If not, new ATA-12 pass-thru wrapper is used instead.
>>>>     3) SED OPAL code tries OPAL discovery command for the device.
>>>>        If it receives a correct reply, OPAL is enabled for the device.
>>>>        If SCSI SECURITY or ATA-12 command with discovery command is rejected,
>>>>        OPAL remains disabled.
>>>>
>>>> Note, USB attached storage needs an additional patchset sent separately
>>>> as requested by USB driver maintainers (it contains required changes
>>>> related to USB quirk processing).
>>>
>>> This just feels wrong.  These adapters are broken if they can't
>>> translated, and we should not put ATA command submission into
>>> sd.c.
>>
>> I think it is blocked in USB layer as not running command enumeration,
>> SCSI SECURITY will be never sent to the adapter through USB.
>>
>> I understand the problem, but if you configure OPAL from userspace, ATA-12 is sent
>> to these devices already - so why kernel cannot use it too?
>>
>>>
>>>> +	cdb[0] = ATA_12;
>>>> +	cdb[1] = (send ? 5 /* ATA_PROTOCOL_PIO_DATA_IN */ : 4 /* ATA_PROTOCOL_PIO_DATA_OUT */) << 1;
>>>> +	cdb[2] = 2 /* t_length */ | (1 << 2) /* byt_blok */ | ((send ?  0 : 1) << 3) /* t_dir */;
>>>> +	cdb[3] = secp;
>>>> +	put_unaligned_le16(len / 512, &cdb[4]);
>>>> +	put_unaligned_le16(spsp, &cdb[6]);
>>>> +	cdb[9] = send ? 0x5e /* ATA_CMD_TRUSTED_SND */: 0x5c /* ATA_CMD_TRUSTED_RCV */;
>>>
>>>
>>> Also avoid all these crazy long lines, and please use the actual
>>> constants.  Using a good old if/else is actually a very good way to
>>> structure the code in a somewhat readable way.
>>
>> Sure, I was trying to no add additional includes that will mess this up, I'll reformat it if needed.
>>
>> Otherwise, this wrapper is exactly what is used is sedutils and also in our test utility
>> that tries to work with OPAL commands directly
>> https://github.com/mbroz/opal-toolset
>>
>>>
>>>> +		if (sdkp->security)
>>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
>>>> +		else
>>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_ata12_submit);
>>>
>>> Messed up indentation here.
>>
>> sorry, my bad, I hate such formatting myself and missed it here :-)
>>    
>>> besides the fact that the statement is fundamentally wrong and you'll
>>> start sending ATA command to random devices.
>>
>> So what do you suggest? As I said, this exactly happen if you configure it from userspace.
>>
>> Can this be somehow limited? I did not find and way how to do it.
> The translation of SECURITY IN/OUT commands should go into usb uas.c, at the
> very least. And even having it there is not great in my opinion. If the adapter
> does not support Opal, don't use that feature, or use it only to lock/unlock the
> drive from user space with passthrough.

I was resisting to support OPAL hw for long time, but once we decided to add it as
an additional (and optional) layer for LUKS, I would like it to be supported also
for external drives (if technically possible).

The problem is that we (for simplicity) decided to use kernel SED-ioctl interface that
internally wraps OPAL command to SCSI SECURITY command only. It means, that all devices
that can use ATA-12 just cannot work with this kernel interface (unlike userspace which
can decide which wrapper to use).

And IMO it is not correct - if it was designed only for some servers with directly connected
devices, then it is really not generic OPAL support. It should work for any hw that supports it.

For USB, it actually works quite nice with the patch (ignoring usual bugs in firmware).

> 
> Note that nowhere in your patch do you test if you are talking to an ATA device.

Yes, I know. I expected the command to be rejected if not supported.

> This can be done by testing for the existence of VPD page 89h. See
> scsi_cdl_enable() in drivers/scsi/scsi.c for an example where we had to check
> for that. But also note that we do not issue ATA commands based on that test. We
> keep issuing SCSI commands and libata takes care of the translation. uas does
> not use libata though, so if translation is needed, do it there.

So, you mean translate SCSI SECURITY to ATA-12 inside USB storage drivers?

(There are actually two places, UAS driver and then SCSI glue for mass-storage -
unfortunately, we need both.)
  
> But I have the same opinion as Christoph: working around USB adapters lack of
> support for a feature with passthrough commands issued from the kernel is really
> not ideal.

Well, I have several adapters and many OPAL drives, none works with SCSI commands
if connected through USB. Partially it is missing support in USB layer, but the rest
is mess in hw. I know it is **** but that's how it is; people have these and want
to use it (including myself).

IMO it is quite similar to discard/TRIM support...

Thanks,
Milan
