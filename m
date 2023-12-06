Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992348073EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379410AbjLFPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379451AbjLFPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:43:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4E310C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:43:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06819a9cbso31277995ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701877415; x=1702482215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xvIfj9SGIuLtG8/yK9rCiMlAwPjTrlbf5ihyHdEcuo=;
        b=jpqZyi26yQ2SijA3mBThBHlwq0ybDiNQgp+yAoYKuPEgQMKCm/WYMXJdTE81xqBmK3
         d9mvAKxkUQnbyd29o/FO2krgFa3BSi4I1Zx9n8A+ROWUfQNVVzyKgRjveGzEQaeZt4oT
         1wqh+qr0z/EFVhYnTyDqxJ3Ed11qSg2N/wBzZJfm05so0RdHw5qYc0jvxDU94nhU5dFX
         OQ3Baexha5vteO/LYCZccA+I7KnaPMyqkV+D5VDmEGRZgopst7fV2QxsxF1VpQmxeh4l
         agRaC3ecJOCZMBTbUdJ2Q4/hvbeYooXm15Wfq2wIfIR+2ycyXZ5d2olDArjCuVmC84wH
         ijVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701877415; x=1702482215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xvIfj9SGIuLtG8/yK9rCiMlAwPjTrlbf5ihyHdEcuo=;
        b=jFIeYhnFPcMzaoJUq5ogoaC7hUSnyElC2XgKew8FnTbW9msQ0V38rVv0b4i0uAU97h
         is2Tzw2hqq6Qr+TajsoZvdx++nxRg5IOagHxEzg/agOe5aMBK/7dQb4G0jNBlyiQOTOV
         UsWufwD/hZ2BX8SElx4+grADgWZYynHcvP8nbGBeKs636wlCyq3ZRcWvbieKxbrAZzTu
         GVn+sBI9ljSMPTp9ZABt1ASjPGavsVPNPNl+RS7cXD5HFsZ5/7nG5xxJyHTtH+1YrPkz
         vc5GjLG3kMEDcygeJTjbTmIJNwMDaLJ7ABY/O/36Au01PkrB9i8p6uGGjLaW6V1Fh1/J
         AScA==
X-Gm-Message-State: AOJu0YyB44DhpyRYKoyM6wkE4Om+ojyEDJEQkRYKb/QC5ZRjbpbDjiak
        3E7gSkjgKeuwcTn287v4qMY=
X-Google-Smtp-Source: AGHT+IE+wW+TuYhw2of0MY5s1frNHGGnieETflNBbTB/qfTdu0/169V/xcndLMR6j7GtKmdAuhvbZQ==
X-Received: by 2002:a17:902:ced2:b0:1d0:c6fd:3173 with SMTP id d18-20020a170902ced200b001d0c6fd3173mr854900plg.42.1701877414857;
        Wed, 06 Dec 2023 07:43:34 -0800 (PST)
Received: from ?IPV6:2401:4900:1f3e:53bf:50c7:2988:e019:4b97? ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id jh14-20020a170903328e00b001d053ec1992sm10401395plb.83.2023.12.06.07.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:43:34 -0800 (PST)
Message-ID: <7e244edd-0dfc-4363-b41d-579f1685f33e@gmail.com>
Date:   Wed, 6 Dec 2023 21:13:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Greg KH <gregkh@linuxfoundation.org>
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
 <98911f33-6932-46e1-9846-ae3f558b2409@ieee.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <98911f33-6932-46e1-9846-ae3f558b2409@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/23 20:22, Alex Elder wrote:
> On 12/5/23 2:32 PM, Ayush Singh wrote:
>> On 12/6/23 01:15, Greg KH wrote:
>>
>>> I'm confused, what exactly is needed here to be sent that isn't in the
>>> existing message definition.
>>>
>>> And as to your original statement, the protocol definition was not
>>> designed for any specific use case that would make IoT "special" here
>>> that I can see.  It was designed to provide a discoverable way to
>>> describe and control hardware on an unknown transport layer for devices
>>> that are not discoverable by definition (serial, i2c, etc.)
>>>
>>> The fact that we implemented this on both USB and unipro successfully
>>> provided that the transport layer for the data should be working and
>>> agnositic.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> So, the missing information is the AP cport which is sending the 
>> message/for which the message is intended. Each AP cport will be 
>> connected to a cport in some greybus node. For a simple case like 
>> USB, where AP can directly talk to the node, and we do not really 
>> need the cport information outside of kernel driver.
>
> I think I lack some context here, but as Greg said Greybus
> is intended to be a pure transport, and anything using it
> should be able to get all information it needs as a layered
> protocol on top of it.
>
> If the BeaglePlay stuff requires CPort information, it sounds
> like it's not managing the layering of abstractions properly.
Well, I used gbridge as a reference during my GSoC work. So I just 
followed it's lead of using pad bytes for cport information.
>
>> I think under normal circumstances, the kernel driver is supposed to 
>> directly communicate with the node. However, in beagle play, the 
>> subghz transport is only present in CC1352 coprocessor. This means 
>> CC1352 needs to act as the middle man between AP and node (aka 
>> perform the APBridge tasks). So it needs to maintain a way to keep 
>> track of all active greybus connections, and route the messages 
>> between AP and Node cports.
>>
>> I am not quite sure where SVC is supposed to be in Linux kernel 
>> greybus setup. Since SVC needs to be able to detect module 
>> insertion/removal, it needs to be able to access the same transport 
>> as APBridge. Thus, CC1352 (and gbridge in old setup) are responsible 
>> for both SVC and APBridge roles.
>
> It sounds like CC1352 is serving in an SVC role... sort of? Again, I 
> don't have enough context right now to understand.
>
> Greybus was developed for a particular hardware platform, and it
> included an SVC.  The SVC was an independent processor that managed
> the "endo", or the basic hardware "backplane" that held modules).
> The AP bridge was how the AP connected to that, and the GP bridge
> was how a given module interface connected to that.
>
> It seems to me (this is partly from an impression I had a few years
> ago) that the BeaglePlay model doesn't align perfectly with that.
> And if that's the case, we need to figure out how to resolve any
> mismatches.
>
> (I'm not sure this is very helpful, but it's a little background.)
>
>                     -Alex

Yes, the BeaglePlay (and older gbridge) model does deviate from that. 
You can read more about beagle connect technology here [1] and the 
initial presentation [2].

However, to put it simply, it is trying to use greybus over transports 
other than Unipro. This means we do not have a Unipro switch. Instead, 
we use a coprocessor (CC1352) running specialized firmware to handle all 
the things Unipro switch would.

The current focus is 6lowpan (due to it's range). However, CC1352 also 
has a 2.4 and 5 ghz antenna, so in the future, that might also be used 
for transportation.

Since I am not much aware of greybus use outside of beagle connect, I do 
not have much knowledge of how it is supposed to be used in a 
traditional setting.

I have submitted new patches that remove the need for using pad bytes.


Ayush Singh


[1]: https://docs.beagleboard.org/latest/projects/beagleconnect/index.html

[2]: https://www.youtube.com/watch?v=7H50pv-4YXw

