Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5E802172
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 08:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjLCHRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 02:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 02:17:16 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D3F3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 23:17:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cb55001124so3492892b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 23:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701587842; x=1702192642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfTKmTcoIZjeKZQASJtJ+cTwOxU9NGJjwL6rBXc5GsQ=;
        b=VV/lyInbaICwK/c8gSoCB1vZQZ5DTWmztw+2p7nqw7SAp/IBZvxnPMe2u4CXwTfovA
         8FlcfOkF7hxaMmTgl422em+i3xliXO7SYO2Kfj49Fvs7VvitkQlvbpj2pvrdc9jSYYkz
         YeFCvfTemJMhEDlejFKys/T8EzRG2Ja5VmaxwqlBJ01kQ7O58wAYRyuFpjBZPygIk7SL
         zrnZj3yI0As8DY+bZUdmPDHZ6YgyZKsAMsFkDMatOqRttJYq4hv0ygtmMHo7NRo7urF6
         XB7KkkS7K6tcDBSlKpfNjT3Rt3XsZqOjhDHzXPgl3BSEvQnjmceRxdci0Qif9swg5cn4
         zqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701587842; x=1702192642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfTKmTcoIZjeKZQASJtJ+cTwOxU9NGJjwL6rBXc5GsQ=;
        b=CS/OafLvQI8+9uhGPuLUGBJ7vWHb6991Xs4S2jSjClobWsmMlFJ4JvCkihoY620v9M
         cM2gIe5kPWuan0WFmxj8rdY/8JzA8kRp1w7Yoc94B7DYxfF7ql5zwGlcy2hcT/nUoVBA
         hcP0KB1zUVGX0zkUj2rQDFSftBalnm+mA9jBkjK3gXk3IjHBTRRzhYpb8635ZWQXdSBo
         S3MznPKGPpJqspppjw29kpqbCACDsck93ZXeLus9ae75FXDdz8SJeUPVSDYal+udpOhV
         0VSq9UL8TDpvlAy5/vxZcRw4/icTYJs2ca4DI7ud+UbnVVL2/ATSFnvNUBQrb1K0smlB
         99Pg==
X-Gm-Message-State: AOJu0Yy6o7vWZxelu1SRx6L8WKlmgtXyVZ9AgnL2uUwbcA+MrXVZt3Kd
        erOXlHubbT5Ro5gxU77xUSCUPzwiBQA=
X-Google-Smtp-Source: AGHT+IGGUI4OufP5G1eDvjfBKvHdT4e4o5GBFj7MhGryxLC59egOc/jgBZQaoKdM9qCBOyOj4GvcRg==
X-Received: by 2002:a05:6a20:b79f:b0:18f:97c:3865 with SMTP id fh31-20020a056a20b79f00b0018f097c3865mr1564954pzb.63.1701587841948;
        Sat, 02 Dec 2023 23:17:21 -0800 (PST)
Received: from ?IPV6:2401:4900:1f3e:53bf:50c7:2988:e019:4b97? ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006c988fda657sm6003574pfg.177.2023.12.02.23.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 23:17:21 -0800 (PST)
Message-ID: <32cf0a82-23b0-437e-b466-c05ceeb87da6@gmail.com>
Date:   Sun, 3 Dec 2023 12:47:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: gb-beagleplay: fix restricted __le16 degrades to
 integer warning
To:     Alex Elder <elder@ieee.org>, greybus-dev@lists.linaro.org
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <20231114140103.784484-1-ayushdevel1325@gmail.com>
 <fea9d86b-54c7-493b-a7bd-8320bc2e8ced@ieee.org>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <fea9d86b-54c7-493b-a7bd-8320bc2e8ced@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for the late response (college exams were going on).

I will go through the driver to find if any other endianness fixes are 
needed.

As for `hdlc_payload->len`, the whole `hdlc_payload` is an abstraction 
to store array length with the actual pointer. The len is never actually 
sent over HDLC, so it should be fine.


Ayush Singh

On 11/14/23 20:27, Alex Elder wrote:
> On 11/14/23 8:01 AM, Ayush Singh wrote:
>> greybus message header->size are of type __le16, so to fix this warnings
>> we are using le16_to_cpu() macros.
>
> This is more than a warning, it's a bug (though it has no
> effect with a little-endian native CPU).
>
> I suggest you add:
>
> Fixes: ec558bbfea671 ("greybus: Add BeaglePlay Linux Driver")
>
> Should your hdlc_payload->len field be defined as little-endian?
> I've only scanned through this file at this point but I'm thinking
> there might be other endianness fixes needed as well.
>
>                     -Alex
>
>
>
>>
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   drivers/greybus/gb-beagleplay.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/greybus/gb-beagleplay.c 
>> b/drivers/greybus/gb-beagleplay.c
>> index 43318c1993ba..b3f47b5cbbfa 100644
>> --- a/drivers/greybus/gb-beagleplay.c
>> +++ b/drivers/greybus/gb-beagleplay.c
>> @@ -344,7 +344,7 @@ static int gb_message_send(struct gb_host_device 
>> *hd, u16 cport, struct gb_messa
>>       dev_dbg(&hd->dev, "Sending greybus message with Operation %u, 
>> Type: %X on Cport %u",
>>           msg->header->operation_id, msg->header->type, cport);
>>   -    if (msg->header->size > RX_HDLC_PAYLOAD)
>> +    if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
>>           return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too 
>> big");
>>         memcpy(msg->header->pad, &cport, sizeof(cport));
>
