Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3778A03A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjH0QqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjH0QqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:46:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8FF115;
        Sun, 27 Aug 2023 09:45:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a1de3417acso730489766b.0;
        Sun, 27 Aug 2023 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693154757; x=1693759557;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uiO2Fn8gY3Kwe/9TGq4oT/QQCNm5lMOfz3tU3wQO21A=;
        b=OSi2ueNeV/5ok1T0v3a5piFYfVutcoWm5EEI0WkVqPY3lak6LQDhG9JjU1JUKUVuWB
         r0GlR1bItRcA4m2VXsA2y1zGABJ7OD0HdUye8x72CKIeXjlMXj0Sb1PwYjqoZjlzq05l
         OgmqWlDr55NtG0B86dBwplJtZx9NgNl9OHDTLoYlmSzFiR2SniulxEVoLlRiizTfhebu
         WJxKwOojRUacAv8k8qfDqe/GjK2YOC9C44J2zk8RIMY9BRWPJL4aMmx601Sc+n23viZ2
         l5KeSOMwzm1ryOZqefm5UFahj2swbKyK2sPp3+q3q4YxFm1jRQ+KELmuhmZ2wHAYg/5C
         SYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693154757; x=1693759557;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiO2Fn8gY3Kwe/9TGq4oT/QQCNm5lMOfz3tU3wQO21A=;
        b=EJBA9egdvu9pXc2uSSIsCvuLMfWH8/DU9+YpbWQH9G9XCNWNUOF4f2jubEqw6r9nzK
         OMiYDIuXRlbWDw+Fdawz3lw0lOmbuw3K54TGgzpdnEZ4wt7iYd75y7B4d38pm4Q9MZTN
         OZyvsC3yVb/6e1zwBpNrnaigpgLsIAY4d4NRo4MFhh7LllXSdszStLtnmIQI/3SiMmWB
         QJVks+9wnSYM8BqP5IpVKHow1MJ9/qgP2pAAjq1SscNV6Rgw4SViQQgR8DJK23VKON88
         YKGE0Srj6TrPY10uYfQtC6nW6luTOzOrOgjh+tre6vfkwUVDpRwnlad0P5qhNlxWDK78
         isag==
X-Gm-Message-State: AOJu0YzqSh/zYt2k8bRH07iN5PbsXI7OwCLIQ4iomXHPiF7ABfVXhCFg
        keTtPRFDYLTHpbC471UPgeQ=
X-Google-Smtp-Source: AGHT+IF2pjc/BUI2I9+TJ1wbjyqrh57wMmPsXJgKUR82XNdVrZOYkqL+ugbSfBumToE25jPbVU3zDg==
X-Received: by 2002:a17:907:7ea8:b0:9a5:83f0:9bc5 with SMTP id qb40-20020a1709077ea800b009a583f09bc5mr6015704ejc.18.1693154757303;
        Sun, 27 Aug 2023 09:45:57 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906951400b00993470682e5sm3601527ejx.32.2023.08.27.09.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 09:45:56 -0700 (PDT)
Message-ID: <34aa2eea-5417-4e46-91a0-aac1a46a84cf@gmail.com>
Date:   Sun, 27 Aug 2023 18:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb-storage: how to extend quirks flags to 64bit?
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
 <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
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

On 8/27/23 17:50, Alan Stern wrote:
> On Sun, Aug 27, 2023 at 11:32:05AM +0200, Milan Broz wrote:
>> Hello,
>>
>> I tried to extend USB storage for the passthrough of Opal
>> security commands,
> 
> What sort of changes are needed?  Where is this passthrough mechanism
> documented?

We are currently adding support for optional OPAL hw encryption to
cryptsetup/LUKS2 (that uses kernel OPAL ioctl interface) and I tried
to make USB adapters to work with it too.

I'll send RFC patchset (it is quite simple) where I explain it in detail.
The patch for USB storage is actually one liner, the rest is in SCSI driver :)

Basically, USB adapters (not supporting UAS) cannot work as
required SCSI SECURITY IN/OUT SCSI commands do not work here.

But we can use ATA12 pass-thru (as used with original sedutils
and some other tools we used in research; it is a documented feature).
It works once ATA12 wrapper is added to block layer and USB storage enables
the "security_supported" bit.

> 
>>   and some adapters are clearly "not perfect".
> 
> Which ones?

Namely Realtek 9210 family (NVME to USB bridge). Everything OPAL related
works, but the adapter always set write-protected bit for the whole
drive (even if OPAL locking range is just covering part of the disk).

I spent quite a lot time trying new firmware versions - this issue is
still there.

On the other side, many other USB to SATA bridges works nicely.
I think this is the exact situation where we should set a new quirks flag
to disable it. (The nasty thing is that for unbricking it you need PSID reset
- PSID is a number written on the label of the drive - followed by physical
disconnect for recovery.)


Anyway, I intentionally sent this 32bit flags question separately as it
is actually a generic issue - we are just out of flag space now...

Even if the patches mentioned above are rejected, someone will need
a new flag for something else later.

>> I would need to introduce a new quirks flag to turn it off.
>>
>> Seems that we are already out of quirks flags on 32bit
>> for usb storage - in usb_usual.h the last entry in mainline is
>>    US_FLAG(SENSE_AFTER_SYNC, 0x80000000)
>>
>> Adding a new flag will work for 64-bit systems but not
>> for platforms with 32-bit unsigned long like i686.
>>
>> How do we allow new flag definitions?
>>
>> Struct us_data fflags can be made 64bit (defined in
>> drivers/usb/storage/usb.h), but the major problem is that these
>> are transferred through the generic driver_info field
>> defined in linux/mod_devicetable.h as unsigned long).
>> Making this 64bit is IMO an extensive API change (if even possible).
>> I guess this is not the way to go.
>>
>> Could USB maintainers please help to advise what is the correct
>> solution? I am not familiar with the USB driver model here
>> and I see no easy way how it can be solved by a trivial static
>> allocation inside the USB storage driver.
>>
>> Someone will need a new quirks flag in the future anyway... :)
> 
> I can think of only one way to accomplish this on 32-bit systems: Change
> the driver_info field from a bit array to an index into a static table
> of 64-bit flags values.  Each unusual_devs structure would have its own
> entry in this table.  As far as I can tell, the other unusual_*.h tables
> could retain their current driver_info interpretations, since no new
> quirk bits are likely to be relevant to them.
> 
> Making this change would be an awkward nuisance, but it should be
> doable.

Hm, yes, thanks for the idea,that is a possible solution.
It will need to modify all unusual macros, though. Just I am not sure I want
to spent time patching all the drivers as I have not way how to test it.

Thanks,
Milan
