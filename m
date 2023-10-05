Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9E7BA1FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjJEPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjJEPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:08:16 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CDF5B99
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:33:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so14696939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696516435; x=1697121235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXhhPLEbAH2Co1vOCJVLpu3VNCebYxHTaxUBPSL3m/A=;
        b=Fr2fR6/sJIOJCoOuJUi58GJngqPaA/HSFSa0fJhJ0ldiySmGOcjhyPTuaUVI/U5Oz3
         rYl1vLlsXhNp/pZMBiIupFFan+bOh+xkTqM08MXOQBWjFlimRsqPrdAHQUQ22p33Wtbq
         kHoNN8ycuVZA6lpw3qhZdgawSzehMgB8tchYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516435; x=1697121235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXhhPLEbAH2Co1vOCJVLpu3VNCebYxHTaxUBPSL3m/A=;
        b=R/PXzQq47A2E8UFeWWGxDnzTXItO4CfIDxEHoXWoP3yeBQDd7mwNaJF9s7ZSj/w0f0
         AnJXUMn3R2Ufc3L459OLqvYqXCYui/zQeYpoFtJmk3f+pyBAgHUr/hDyB0xF45jxvycx
         +H8e2jPvlBT5P8GF4Upc8xoFssit1UgAqT8VsPhjS06mwIinDoKYe3q3l9tNajEWTmYE
         61fuxGYb1aSGJIW6r7i8qZ+9XL0z+T8kK8fNquBuehpLRV5rXKd9tkCmBw6RqUpOsSOJ
         9ygZa6heaiiuDEWK9iDA7jLLD+DeISUwJxAKtRNzPquWSjzaP6HLi64LwbrOG65I6VPM
         FDQw==
X-Gm-Message-State: AOJu0YzrM9oZpJxZHVGrUhaJOouLRS4hvkF/kQ4xNIfLbeDLeeynoOWB
        TUq1ual7iaBs2IVPo0JzfpW9vYo8MGVzVr5kkBE=
X-Google-Smtp-Source: AGHT+IHO+aFM7ha6XCEPzgrAXCsvNjRwxGCPHmreI2zNmrs7Itj3mlYvL2vecXZPtwUHFZ4V9sHWOw==
X-Received: by 2002:a05:6602:140c:b0:79f:a8c2:290d with SMTP id t12-20020a056602140c00b0079fa8c2290dmr6926134iov.0.1696516435724;
        Thu, 05 Oct 2023 07:33:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y10-20020a02bb0a000000b0043e8735ea85sm461243jan.144.2023.10.05.07.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:33:55 -0700 (PDT)
Message-ID: <e56353b2-a814-4a81-9516-63736d12abba@linuxfoundation.org>
Date:   Thu, 5 Oct 2023 08:33:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: usbip: fix stub_dev hub disconnect
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonas Blixt <jonas.blixt@actia.se>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230615092810.1215490-1-jonas.blixt@actia.se>
 <2023100548-kleenex-deceased-624e@gregkh>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2023100548-kleenex-deceased-624e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 01:22, Greg KH wrote:
> On Thu, Jun 15, 2023 at 11:28:10AM +0200, Jonas Blixt wrote:
>> If a hub is disconnected that has device(s) that's attached to the usbip layer
>> the disconnect function might fail because it tries to release the port
>> on an already disconnected hub.
>>
>> Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
>> Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
>> ---
>> v2:
>>   - Clarify comment
>> v1:
>>   Link to v1: https://lore.kernel.org/linux-usb/20230615092205.GA1212960@W388ANL/T/#m575e37dc404067797eadf4444857366c73ba3420
>> ---
>>   drivers/usb/usbip/stub_dev.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
>> index 2305d425e6c9..2170c95c8dab 100644
>> --- a/drivers/usb/usbip/stub_dev.c
>> +++ b/drivers/usb/usbip/stub_dev.c
>> @@ -427,8 +427,13 @@ static void stub_disconnect(struct usb_device *udev)
>>   	/* release port */
>>   	rc = usb_hub_release_port(udev->parent, udev->portnum,
>>   				  (struct usb_dev_state *) udev);
>> -	if (rc) {
>> -		dev_dbg(&udev->dev, "unable to release port\n");
>> +	/*
>> +	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
>> +	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
>> +	 * that error here.
>> +	 */
>> +	if (rc && (rc != -ENODEV)) {
>> +		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
>>   		return;
>>   	}
>>   
>> -- 
>> 2.25.1
>>
> 
> Shuah, what ever happened to this change, is it correct or was something
> else applied to fix it?
> 

Sorry for the delay. I thought I took care of acking this one. :(

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

