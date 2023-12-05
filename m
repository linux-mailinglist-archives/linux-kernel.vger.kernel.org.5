Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3730805344
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbjLELpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345199AbjLELpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:45:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E580C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:45:39 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0c94397c0so1996785ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776738; x=1702381538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifjZic9V2+iDg+N0MCNpQXnm6i6pbqN+fLGdm8ADAvI=;
        b=jp1j7YNbJ2K0Q2+WKaqBcNrxLlw+1Xu9arwcfKdJoFxiPxj41DM58ahngWy7c0VHOv
         UaV411e4/8wO4kBS1QYT+c2CCH7yEEC7gGC9jsHdp/vdRXGeNics8g0bFd9l7Km6HEWU
         OBN6RCkYpw/5ehn30BIcZORuAu0pHbwss8KO1nz2AWeup/izLXdJTjPfMy8XYrm6df2D
         Xgy3ZwgKCnwfrQlWwlfCp7kYTof9K9ktPZoSGwEWr/92nlDP1WuiHXTsLKyRXUezEJE0
         Y3Od/SKMnlYq/Ek6DVq3iYXopbO3htZxs4sp9nMQd2kjjvXrghgJCD+fFMOZJucHu5SN
         RluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776738; x=1702381538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifjZic9V2+iDg+N0MCNpQXnm6i6pbqN+fLGdm8ADAvI=;
        b=O4ckIOyMkmh43j9tGiOnZHPLa5Wbx/X/5nhDQY4I4wF9FFxb9NPqNEz4DhtRf+NOB8
         Rut4aThyfgnsr4lNiIwoLWj4uvVvV/4TOcwaSuskxg9ArOCTMlgdbZEhaRqZuRk7R0qT
         /UqSqC4zLDEPBz6IZJ6mkuIB6rTOGqOyet70IQghLToTsGcWBRZmsIoXAkBOuB9+wHhz
         uHUNFc//Vz2UgBIjdbq25+ckL/vP6vy7xAWImoBSrn80XbGMiHQ8UbWdWjLmaqf5i5Lf
         1wO5Lg6ev5TbA+UKkNIJOSb4Q84d+UhsUdyH79hh5U40HETae70mnY29mhA1t9wsAUBG
         6FaQ==
X-Gm-Message-State: AOJu0Yz515Cfm6hDtWxs4bGX402MMzgviwo4kn9tGTIwFskNHLvvBINV
        QB/ZmXTsazWg+wm0OJiZX6I=
X-Google-Smtp-Source: AGHT+IFKTerv0BHVyBYqJWcQX6206WE3geXyFHnM1ck+LASjK9ZVLI5oV7n5Gcg5NXT0js6mgFchqQ==
X-Received: by 2002:a17:902:ecc7:b0:1d0:c6fd:3173 with SMTP id a7-20020a170902ecc700b001d0c6fd3173mr355177plh.42.1701776738436;
        Tue, 05 Dec 2023 03:45:38 -0800 (PST)
Received: from ?IPV6:2401:4900:1f3e:53bf:50c7:2988:e019:4b97? ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001d0cd9e4248sm316501plg.196.2023.12.05.03.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 03:45:38 -0800 (PST)
Message-ID: <4cafbb5a-8ecd-407e-81a0-76d6505d013b@gmail.com>
Date:   Tue, 5 Dec 2023 17:15:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        elder@kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
 <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
 <2023120515-mongrel-undertook-6e5a@gregkh>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023120515-mongrel-undertook-6e5a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/23 05:44, Greg KH wrote:
> On Mon, Dec 04, 2023 at 09:58:55PM +0530, Ayush Singh wrote:
>> On 12/4/23 19:42, Johan Hovold wrote:
>>> On Mon, Dec 04, 2023 at 06:40:06PM +0530, Ayush Singh wrote:
>>>> Ensure that the following values are little-endian:
>>>> - header->pad (which is used for cport_id)
>>>> - header->size
>>>>
>>>> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
>>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>>> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
>>>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>>>> ---
>>>> V3:
>>>> - Fix endiness while sending.
>>>> V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/L53UN5ROSG4M6OE7CU5Y3L5F44T6ZPCC/
>>>> - Ensure endianess for header->pad
>>>> V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/message/K7UJ6PEAWBLNDMHLT2IO6OP5LQISHRUO/
>>>>
>>>>    drivers/greybus/gb-beagleplay.c | 9 +++++----
>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
>>>> index 43318c1993ba..8b21c3e1e612 100644
>>>> --- a/drivers/greybus/gb-beagleplay.c
>>>> +++ b/drivers/greybus/gb-beagleplay.c
>>>> @@ -93,9 +93,9 @@ static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>>>>    	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
>>>>    	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
>>>> -		hdr->operation_id, hdr->type, cport_id, hdr->result);
>>>> +		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
>>>> -	greybus_data_rcvd(bg->gb_hd, cport_id, buf, len);
>>>> +	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
>>> This looks broken; a quick against mainline (and linux-next) check shows
>>> cport_id to be u16.
>>>
>>> I think you want get_unaligned_le16() or something instead of that
>>> memcpy() above.
>> Thanks, will do.
>>> But that just begs the question: why has this driver repurposed the pad
>>> bytes like this? The header still says that these shall be set to zero.
>> So, the reason is multiplexing. The original gbridge setup used to do this,
>> so I followed it when I moved gbridge to the coprocessor (during GSoC).
>>
>> Using the padding for storing cport information allows not having to wrap
>> the message in some other format at the two transport layers (UART and TCP
>> sockets) beagle connect is using.This also seems better than trying to do
>> something bespoke, especially since the padding bytes are not being used for
>> anything else.
>>
>> The initial spec was for project Ara (modular smartphone), so the current
>> use for IoT is significantly different from the initial goals of the
>> protocol. Maybe a future version of the spec can be more focused on IoT, but
>> that will probably only happen once it has proven somewhat useful in this
>> space.
> Please don't violate the spec today this way, I missed that previously,
> that's not ok.  We can change the spec for new things if you need it,
> but to not follow it, and still say it is "greybus" isn't going to work
> and will cause problems in the long-run.
>
> Should I just disable the driver for now until this is fixed up?
>
> thanks,
>
> greg k-h

Well, I will look into some ways to pass along the cport information 
(maybe using a wrapper over greybus message) for now. However, I would 
prefer having some bytes in greybus messages reserved for passing around 
this information in a transport agnostic way.

Ayush Singh

