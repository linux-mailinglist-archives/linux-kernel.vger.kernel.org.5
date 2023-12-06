Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB61880730B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442288AbjLFOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442127AbjLFOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:52:27 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C69A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:52:33 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d67aa6951so2528405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1701874352; x=1702479152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Zd8/otGoTQ3r1gBBM13rIbCqCW6QvPmqUsDijzL9f4=;
        b=OGOKvvh7bgWhR6NIlYkKrTItLA3Z2l9jfDH3y50/s5HD06vB9I/wwc21YcBe30/L7i
         bB6Dohfu++ffdd6Cb+AgH9Y56YNesh9bgBdTRWepdQulWNsHydYcAy5SZOjIlr+dNXC5
         e6JdUao47imN668pNFBtDMcXn5Jz0fMEffK60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874352; x=1702479152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zd8/otGoTQ3r1gBBM13rIbCqCW6QvPmqUsDijzL9f4=;
        b=awiQLXhx8axqfHYJc3H/UpocZe6+Gm65KEhwxX+zbdIYoap/u8o4sRlUkOvw6NdqxV
         9DUBEQW/ea9OrSMktR+/tkYtYqqqeA/wXvQULbfd0Vx7obqyE+L8KfojSLy8sek4RNHJ
         BXTBa8kRaepY6MmFok4HZVtueaB2Hfrj3mVOxotGeDlo+MJYeYBooB3QfLEbAWBIk+pc
         xQKsdRhGlkpN1PMRlJVq+ZSKkFkFP3gxbf53o8K6D2hHTLnfMmoKsyva3y/efo4UAt6F
         YFLut4J0sZ/K66beZAMxQsxxeENtuhClD8XQuOl1Y2IyI2tSVnzzPcjkF4zhcJJpmK75
         DLpQ==
X-Gm-Message-State: AOJu0YwNnFgPTMDOpMpGuuDVLWnEH0zi/8zvjx8BZQfm8CwFQ8viapl6
        Azd4TyLjSUKpVLLGv+FOlCybJQ==
X-Google-Smtp-Source: AGHT+IFlEeWIngig8stWD0/dIYF5M3Lzyrw4iUqkxVvqIX3CTNfVb8+GekL6nXTjjVvAyni+3gR15Q==
X-Received: by 2002:a92:d689:0:b0:35d:701a:bc5d with SMTP id p9-20020a92d689000000b0035d701abc5dmr692074iln.28.1701874352625;
        Wed, 06 Dec 2023 06:52:32 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id bn11-20020a056e02338b00b0035d79f5d8acsm18508ilb.79.2023.12.06.06.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:52:32 -0800 (PST)
Message-ID: <98911f33-6932-46e1-9846-ae3f558b2409@ieee.org>
Date:   Wed, 6 Dec 2023 08:52:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        elder@kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
 <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
 <2023120515-mongrel-undertook-6e5a@gregkh>
 <4cafbb5a-8ecd-407e-81a0-76d6505d013b@gmail.com>
 <2023120616-rely-naturist-01db@gregkh>
 <3cd7fc7d-075f-4945-b84d-7326e3c99553@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <3cd7fc7d-075f-4945-b84d-7326e3c99553@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 2:32 PM, Ayush Singh wrote:
> On 12/6/23 01:15, Greg KH wrote:
> 
>> I'm confused, what exactly is needed here to be sent that isn't in the
>> existing message definition.
>>
>> And as to your original statement, the protocol definition was not
>> designed for any specific use case that would make IoT "special" here
>> that I can see.  It was designed to provide a discoverable way to
>> describe and control hardware on an unknown transport layer for devices
>> that are not discoverable by definition (serial, i2c, etc.)
>>
>> The fact that we implemented this on both USB and unipro successfully
>> provided that the transport layer for the data should be working and
>> agnositic.
>>
>> thanks,
>>
>> greg k-h
> 
> So, the missing information is the AP cport which is sending the 
> message/for which the message is intended. Each AP cport will be 
> connected to a cport in some greybus node. For a simple case like USB, 
> where AP can directly talk to the node, and we do not really need the 
> cport information outside of kernel driver.

I think I lack some context here, but as Greg said Greybus
is intended to be a pure transport, and anything using it
should be able to get all information it needs as a layered
protocol on top of it.

If the BeaglePlay stuff requires CPort information, it sounds
like it's not managing the layering of abstractions properly.

> I think under normal circumstances, the kernel driver is supposed to 
> directly communicate with the node. However, in beagle play, the subghz 
> transport is only present in CC1352 coprocessor. This means CC1352 needs 
> to act as the middle man between AP and node (aka perform the APBridge 
> tasks). So it needs to maintain a way to keep track of all active 
> greybus connections, and route the messages between AP and Node cports.
> 
> I am not quite sure where SVC is supposed to be in Linux kernel greybus 
> setup. Since SVC needs to be able to detect module insertion/removal, it 
> needs to be able to access the same transport as APBridge. Thus, CC1352 
> (and gbridge in old setup) are responsible for both SVC and APBridge roles.

It sounds like CC1352 is serving in an SVC role... sort of?  Again, I 
don't have enough context right now to understand.

Greybus was developed for a particular hardware platform, and it
included an SVC.  The SVC was an independent processor that managed
the "endo", or the basic hardware "backplane" that held modules).
The AP bridge was how the AP connected to that, and the GP bridge
was how a given module interface connected to that.

It seems to me (this is partly from an impression I had a few years
ago) that the BeaglePlay model doesn't align perfectly with that.
And if that's the case, we need to figure out how to resolve any
mismatches.

(I'm not sure this is very helpful, but it's a little background.)

					-Alex

> Simply put, if the kernel driver cannot directly connect to the node, 
> the processor / network entity handling APBridge tasks will need to 
> cport information. And it probably is good to make it possible to 
> separate APBridge from AP in complex networks.
> 
> Feel free to ask questions if I was unclear regarding something. Also 
> feel free to correct me if I got something wrong since I only started 
> working on greybus this summer.
> 
> Ayush Singh
> 

