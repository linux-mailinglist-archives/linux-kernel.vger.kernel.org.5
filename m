Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA754803A47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbjLDQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjLDQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:28:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1BA4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:29:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d048d38881so17011045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701707341; x=1702312141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dna9IRTvJmD8ExOInd9+w4ObVdAr/u4RKwVkYvL9yHY=;
        b=bjFpM03CPAVIxq0q9w+DK/hrF7Tx4xpRITd3ybiqdiaka5P7Nrm0HauSicbGy/FCR1
         t4tz+LdDNRgtAXLLsQceuMeoU6DnbNbGcB3TJOwGaVPKsjLPgLQQ48vd8YgvoM0Bo0Gq
         5+jzjd6IPuYQmXOCPcEEQkpDc1cDYcPsTdUZio99KMj2aP2aODuMDXaHgPTzjp9hzSgG
         7ffPvYdaopxc/B/XV9McGWmrk9zmlMOVMVkvNHgqKoCEyN1oGtApTJb/YLyQr6t5A6o0
         Wea5x4GQQKf8XWouFRZ2vHoVPslzX9eeqvxPbfxxoVFYZd9s9gXWDqKXdMBQAk+H4O0E
         kdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707341; x=1702312141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dna9IRTvJmD8ExOInd9+w4ObVdAr/u4RKwVkYvL9yHY=;
        b=dXfqA/rHBOAFVVCFCqXpo62CH3iTSaik7nDz86FvgfYsV3+5LMa3PZx9qwPZ3Iy2z7
         LqmJTRfHJY9knd5IzmeB2rLtfYCuwKeRSNPdorp4EeRFfb3+ja07cBCFTIq8mq+lbZ4L
         8HshOhZYbVVmNFBi62XaVCVTlIoVHhSeG0wnB8UWKvMee5mLY8FT5408gaxXY6NbffZX
         L/iL3aMEid8KUzQv4KhvF2myq3xSvAoxu2lreqBcpWjCTKy9RScB6b4pgqOw5/vePkaH
         STaZH5visA+DdfNfDzIxHPLC+cKUjyR/ydSruerbXcrVHTAwU7BZdDyijpaZdVLPG90f
         vQJA==
X-Gm-Message-State: AOJu0YxxO9ZTRqzqrG5ERpkE++nZ04aoSjNJFUH6qKlZQov3GLTXs/UV
        kblziLkZ44YOkqKvwSaizkIzSjeM4bU=
X-Google-Smtp-Source: AGHT+IG5K3i8a2a+1KXgVnHwtc2SefenxymyOCDG3NeLGydXF6V2t+WuJa/YBa3tPD/Jjd6A2oF5cA==
X-Received: by 2002:a17:903:11c8:b0:1cf:5760:43f9 with SMTP id q8-20020a17090311c800b001cf576043f9mr2277719plh.64.1701707340915;
        Mon, 04 Dec 2023 08:29:00 -0800 (PST)
Received: from ?IPV6:2401:4900:1f3e:53bf:50c7:2988:e019:4b97? ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001cf5d0e7e05sm3720816plr.109.2023.12.04.08.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:29:00 -0800 (PST)
Message-ID: <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
Date:   Mon, 4 Dec 2023 21:58:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
To:     Johan Hovold <johan@kernel.org>
Cc:     greybus-dev@lists.linaro.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/23 19:42, Johan Hovold wrote:
> On Mon, Dec 04, 2023 at 06:40:06PM +0530, Ayush Singh wrote:
>> Ensure that the following values are little-endian:
>> - header->pad (which is used for cport_id)
>> - header->size
>>
>> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>> V3:
>> - Fix endiness while sending.
>> V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
>> - Ensure endianess for header->pad
>> V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/
>>
>>   drivers/greybus/gb-beagleplay.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
>> index 43318c1993ba..8b21c3e1e612 100644
>> --- a/drivers/greybus/gb-beagleplay.c
>> +++ b/drivers/greybus/gb-beagleplay.c
>> @@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>>   	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
>>   
>>   	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
>> -		hdr->operation_id, hdr->type, cport_id, hdr->result);
>> +		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
>>   
>> -	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
>> +	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> This looks broken; a quick against mainline (and linux-next) check shows
> cport_id to be u16.
>
> I think you want get_unaligned_le16() or something instead of that
> memcpy() above.
Thanks, will do.
>
> But that just begs the question: why has this driver repurposed the pad
> bytes like this? The header still says that these shall be set to zero.

So, the reason is multiplexing. The original gbridge setup used to do 
this, so I followed it when I moved gbridge to the coprocessor (during 
GSoC).

Using the padding for storing cport information allows not having to 
wrap the message in some other format at the two transport layers (UART 
and TCP sockets) beagle connect is using.This also seems better than 
trying to do something bespoke, especially since the padding bytes are 
not being used for anything else.

The initial spec was for project Ara (modular smartphone), so the 
current use for IoT is significantly different from the initial goals of 
the protocol. Maybe a future version of the spec can be more focused on 
IoT, but that will probably only happen once it has proven somewhat 
useful in this space.

Ayush Singh

