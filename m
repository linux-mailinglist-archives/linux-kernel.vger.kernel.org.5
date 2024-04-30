Return-Path: <linux-kernel+bounces-164651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710518B80AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AB6B21B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B42199E99;
	Tue, 30 Apr 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brXsXKMl"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261C18E0E;
	Tue, 30 Apr 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506062; cv=none; b=QYZbJgDmqtnJG3rmxt7MaG/eLRBKywOjeQYXE3RyYQohGq0hX9LmEuWG5Fodj+TIsTjEYDu8FWSDkqFgca2AJGI4PjeX0PjaMT1Jpk6E9PLOHBcnUM+ek/mUe4pn7AKLrgNXQfJNWl9xxRGv8X5J/iy9Qr2VRNMZDzRjyge7DPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506062; c=relaxed/simple;
	bh=5n8+ddt8kDAlvCf2BfOsGoKVib5BT3mIktTpwpN5PIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fI/EmlEgJkXsjwYusQVyoezbnEhiYtaq+6Lo7Bi7/MiK8WiTV/Fxvsq2IDRFTrAqdvU8Bba1XvBpJOEi8Ad9NkDFgcZR+2giBIrFoqnBCb1QU49Pg+j+FajonixYF8XCpH8enPgnhs5IT17xTXM0mBzM0qOWB0KRGac3CytcFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brXsXKMl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd041acff1so71323231fa.1;
        Tue, 30 Apr 2024 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714506059; x=1715110859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Rde4xPEFDrCOvsN1azzph/yhNCF6rGbmRXCstGmDpk=;
        b=brXsXKMlftGQK0AIHB1YLpwTX2DugDJfqHcvzmizGZoKP/OUG+ZRSHNROt1cR0iVBr
         03kmWdZ5xYsUZTM3r+qCfXnBu/ctVdJf8qXb+P28uXL2lZ/KxnBo/oOS542pG9Uopykc
         Fq40/HknYyuhQthSMevqASgKDwT0JQrRiKF634QvXnkpcqy4EDTBmmB41AycfPKoDksW
         akcntsfjpbnx3RK2/JgNr1eq/GfxJ3+RC9HVJs7+c1KE2/vohGdeeyHZ8jJ9FLss89bE
         Nc6WK5mS94MUc5IWn+7uzrI1/T5KAjwoS5RpEMmHDSrVqEnWJBgRf5dqdriGkkp+POzK
         4hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506059; x=1715110859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Rde4xPEFDrCOvsN1azzph/yhNCF6rGbmRXCstGmDpk=;
        b=B9H3x8R72YR6draR9qYzKeuIbj3jgyRzexLp340vLrVWla6audpnv9QRvdjd5/lfk8
         Razv9ICOBi0IndcZqQ8mXDs2B7BxQm0G+Pq60PJXZbzC67ppAkjUF17d6F7Blj806rK0
         CB8k6Ye+fF3wo/nE5OpeKzT56JVvwi7ecFG096lUDobs5crlVYAlEcZ2Xyw/HPnYZQ07
         tiIM+JwQPD2fN28rVi9dmNsAm0SVNFA6LMdQ25o85mpkxRYw1XRTUXZrA9RjWUkWRg3y
         aBya8/4tz4IuhIvqNN8rzraKppWSn98ISoYFw6HZ3hEqR/N4C68pSjA5J6jUyXGl5YEO
         UvSg==
X-Forwarded-Encrypted: i=1; AJvYcCUG61hpBCegqu5KM7tFfzDnEw8qrpE5pLfPdT+m/sRVPOtBQ55UgoQCFB3SVxTK8McdMWPOpvz26Iey5706dcfevZZKW8eAkVxZ0/SzLFU6L5m50MDZ4TFV+bpd/91kGO5UyY5fmD/2
X-Gm-Message-State: AOJu0YzXweBEzcbE58k+XAVzO/cd+v+qnsPD2X+PMxQhT4i78GpQOkz/
	tQGNHoM261WKM+tSoqrKAuQqd/BmtWejQjZo9mhbG4TwOII/YqkHe8+pWib4/CY=
X-Google-Smtp-Source: AGHT+IFpe/lui1Iwowmq0wBoFo3p6MvhU50Yd3UjjL1NNlvm3lZvDnx5yxRJ5mjv2daGp7/zfc1Spw==
X-Received: by 2002:a05:6512:12ce:b0:51e:245a:8ed3 with SMTP id p14-20020a05651212ce00b0051e245a8ed3mr284076lfg.28.1714506056374;
        Tue, 30 Apr 2024 12:40:56 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:785f:7673:480b:1453? (2a02-a466-68ed-1-785f-7673-480b-1453.fixed6.kpn.net. [2a02:a466:68ed:1:785f:7673:480b:1453])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm2355226ejb.64.2024.04.30.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:40:55 -0700 (PDT)
Message-ID: <8041106f-0be0-4ed9-990e-1f62902b30e9@gmail.com>
Date: Tue, 30 Apr 2024 21:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
 <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
 <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
 <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
 <d94f37cf-8140-4f89-aa67-53f9291faff3@gmail.com>
 <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
 <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Op 30-04-2024 om 17:32 schreef Hardik Gajjar:
> On Sun, Apr 28, 2024 at 11:07:36PM +0200, Ferry Toth wrote:
>> Hi,
>>
>> Op 25-04-2024 om 23:27 schreef Ferry Toth:
>>> Hi,
>>>
>>> Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
>>>> On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
>>>>> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
>>>>>> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
>>>>>>> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>>>>>>>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
>>>>>>>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>>>>>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
>>>>>
>>>>> ...
>>>>>
>>>>>>>>>> Exactly. And this didn't happen before the 2 patches.
>>>>>>>>>>
>>>>>>>>>> To be precise: /sys/class/net/usb0 is not
>>>>>>>>>> removed and it is a link, the link
>>>>>>>>>> target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0
>>>>>>>>>> no
>>>>>>>>>> longer exists
>>>>>>>> So, it means that the /sys/class/net/usb0 is
>>>>>>>> present, but the symlink is
>>>>>>>> broken. In that case, the dwc3 driver should
>>>>>>>> recreate the device, and the
>>>>>>>> symlink should become active again
>>>>>>
>>>>>> Yes, on first enabling gadget (when device mode is activated):
>>>>>>
>>>>>> root@yuna:~# ls
>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>> driver  net  power  sound  subsystem  suspended  uevent
>>>>>>
>>>>>> Then switching to host mode:
>>>>>>
>>>>>> root@yuna:~# ls
>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>> ls: cannot access
>>>>>> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/':
>>>>>> No such file
>>>>>> or directory
>>>>>>
>>>>>> Then back to device mode:
>>>>>>
>>>>>> root@yuna:~# ls
>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>> driver  power  sound  subsystem  suspended  uevent
>>>>>>
>>>>>> net is missing. But, network functions:
>>>>>>
>>>>>> root@yuna:~# ping 10.42.0.1
>>>>>> PING 10.42.0.1 (10.42.0.1): 56 data bytes
>>>>>>
>>>>>> Mass storage device is created and removed each time as expected.
>>>>>
>>>>> So, what's the conclusion? Shall we move towards revert of those
>>>>> two changes?
>>>>
>>>>
>>>> As promised, I have the tested the this patch with the dwc3 gadget.
>>>> I could not reproduce
>>>> the issue.
>>>>
>>>> I can see the usb0 exist all the time and accessible regardless of
>>>> the role switching of the USB mode (peripheral <-> host)
>>>>
>>>> Following are the logs:
>>>> //Host to device
>>>>
>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral"
>>>>> mode
>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>> a800000.dwc3/gadget/net/
>>>> usb0
>>>>
>>>> //device to host
>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>> a800000.dwc3/gadget/net/
>>>> usb0
>>>
>>> That is weird. When I switch to host mode (using the physical switch),
>>> the whole gadget directory is removed (now testing 6.9.0-rc5)
>>>
>>> Switching back to device mode, that gadget directory is recreated. And
>>> gadget/sound as well, but not gadget/net.
>>>
>>>> s a800000.dwc3/gadget/net/usb0
>>>> <
>>>> addr_assign_type    duplex             phys_port_name
>>>> addr_len            flags              phys_switch_id
>>>> address             gro_flush_timeout  power
>>>> broadcast           ifalias            proto_down
>>>> carrier             ifindex            queues
>>>> carrier_changes     iflink             speed
>>>> carrier_down_count  link_mode          statistics
>>>> carrier_up_count    mtu                subsystem
>>>> dev_id              name_assign_type   tx_queue_len
>>>> dev_port            netdev_group       type
>>>> device              operstate          uevent
>>>> dormant             phys_port_id       waiting_for_supplier
>>>> console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
>>>> usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
>>>>             BROADCAST MULTICAST  MTU:1500  Metric:1
>>>>             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>             collisions:0 txqueuelen:1000
>>>>             RX bytes:0 TX bytes:0
>>>>
>>>> console:/sys/bus/platform/devices/a800000.ssusb #
>>>>
>>>> I strongly advise against reverting the patch solely based on the
>>>> observed issue of removing the /sys/class/net/usb0 directory while
>>>> the usb0 interface remains available.
>>>
>>> There's more to it. I also mentioned that switching the role or
>>> unplugging the cable leaves the usb0 connection.
>>>
>>> I have while in host mode:
>>> root@yuna:~# ifconfig -a usb0
>>> usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
>>>           inet 10.42.0.221  netmask 255.255.255.0  broadcast 10.42.0.255
>>>           inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64  scopeid 0x20<link>
>>>
>>>
>>> You don't see that because you didn't create a connection at all.
>>>
>>>> Instead, I recommend enabling FTRACE to trace the functions involved
>>>> and identify which faulty call is responsible for removing usb0.
>>>
>>> Switching from device -> host -> device:
>>>
>>> root@yuna:~# trace-cmd record -p function_graph -l *gether_*
>>>     plugin 'function_graph'
>>> Hit Ctrl^C to stop recording
>>> ^CCPU0 data recorded at offset=0x1c8000
>>>       188 bytes in size (4096 uncompressed)
>>> CPU1 data recorded at offset=0x1c9000
>>>       0 bytes in size (0 uncompressed)
>>> root@yuna:~# trace-cmd report
>>> cpus=2
>>>        irq/68-dwc3-725   [000]   514.575337: funcgraph_entry:      #
>>> 2079.480 us |  gether_disconnect();
>>>        irq/68-dwc3-946   [000]   524.263731: funcgraph_entry:      +
>>> 11.640 us  |  gether_disconnect();
>>>        irq/68-dwc3-946   [000]   524.263743: funcgraph_entry:      !
>>> 116.520 us |  gether_connect();
>>>        irq/68-dwc3-946   [000]   524.268029: funcgraph_entry:      #
>>> 2057.260 us |  gether_disconnect();
>>>        irq/68-dwc3-946   [000]   524.270089: funcgraph_entry:      !
>>> 109.000 us |  gether_connect();
>>
>> I tried to get a more useful trace:
>> root@yuna:/sys/kernel/tracing# echo 'gether_*' > set_ftrace_filter
>> root@yuna:/sys/kernel/tracing# echo 'eem_*' >> set_ftrace_filter
>> root@yuna:/sys/kernel/tracing# echo function > current_tracer
>> root@yuna:/sys/kernel/tracing# echo 'reset_config' >> set_ftrace_filter
>> -> switch to host mode then back to device
>> root@yuna:/sys/kernel/tracing# cat trace
>> # tracer: function
>> #
>> # entries-in-buffer/entries-written: 53/53   #P:2
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>       irq/68-dwc3-523     [000] D..3.   133.990254: reset_config
>> <-__composite_disconnect
>>       irq/68-dwc3-523     [000] D..3.   133.992274: eem_disable
>> <-reset_config
>>       irq/68-dwc3-523     [000] D..3.   133.992276: gether_disconnect
>> <-reset_config
>>       kworker/1:3-443     [001] ...1.   134.022453: eem_unbind
>> <-purge_configs_funcs
>>
>> -> to device mode
>>
>>       kworker/1:3-443     [001] ...1.   148.630773: eem_bind
>> <-usb_add_function
>>       irq/68-dwc3-734     [000] D..3.   149.155209: eem_set_alt
>> <-composite_setup
>>       irq/68-dwc3-734     [000] D..3.   149.155215: gether_disconnect
>> <-eem_set_alt
>>       irq/68-dwc3-734     [000] D..3.   149.155220: gether_connect
>> <-eem_set_alt
>>       irq/68-dwc3-734     [000] D..3.   149.157287: eem_set_alt
>> <-composite_setup
>>       irq/68-dwc3-734     [000] D..3.   149.157292: gether_disconnect
>> <-eem_set_alt
>>       irq/68-dwc3-734     [000] D..3.   149.159338: gether_connect
>> <-eem_set_alt
>>       irq/68-dwc3-734     [000] D..2.   149.239625: eem_unwrap <-rx_complete
>> ...
>>
>> I don't know where to look exactly. Any hints?
> 
> do you see anything related to gether_cleanup() after eem_unbind() ?

Nope. It's a pitty that the trace formatting got messed up above. But as 
you can see I traced gether_* and eem_*. After eem_unbind no traced 
function is called, until I flip the switch to device mode.
The ... at the end is where I cut uninteresting eem_unwrap <-rx_complete 
and eem_wrap <-eth_start_xmit lines.

> If not then, you may try to enable tracing of TCP/IP stack and network side to check who deleting the sysfs entry

Yes, that's a vast amount of functions to trace. And I don't see how 
that would be related to the patch we're discussing here. I was hoping 
for a little more targeted hint.

You may recall the whole issue did not occur before this patch got applied.

> Hardik
> 
> 
>>
>>>
>>>> According to current kernel architecture of u_ether driver, only
>>>> gether_cleanup should remove the usb0 interface along with its
>>>> kobject and sysfs interface.
>>>> I suggest sharing the analysis here to understand why this practice
>>>> is not followed in your use case or driver ?
>>>
>>> Yes, I'll try to trace where that happens.
>>>
>>> Nevertheless, the disappearance of the net/usb0 directory seems
>>> harmless? But the usb: net device remaining after disconnect or role
>>> switch is not good, as the route remains.
>>>
>>> May be they are 2 separate problems. Could you try to reproduce what
>>> happens if you make eem connection and then unplug?
>>>
>>>> I am curious why the driver was developed without adhering to the
>>>> kernel's gadget architecture.
>>
>> I don't know what you mean here. Which driver do you mean?
>>
>>>>>
>>>>>>>> I have the dwc3 IP base usb controller, Let me check
>>>>>>>> with this patch and
>>>>>>>> share result here.  May be we need some fix in dwc3
>>>>>> Would have been nice if someone could test on other
>>>>>> controller as well. But
>>>>>> another instance of dwc3 is also very welcome.
>>>>>>> It's quite possible, please test on your side.
>>>>>>> We are happy to test any fixes if you come up with.
>>>>>
>>>>> -- 
>>>>> With Best Regards,
>>>>> Andy Shevchenko
>>>>>
>>>>>
>>>


