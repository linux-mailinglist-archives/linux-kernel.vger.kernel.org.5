Return-Path: <linux-kernel+bounces-166900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC7C8BA194
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A941F2197A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3AB173333;
	Thu,  2 May 2024 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkjSSwvS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC61E890;
	Thu,  2 May 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681942; cv=none; b=b1/K0KtEiii9rZKuA8N6RjJsRM0AMlCAXhZnOBeuS6FroinBBfoXnHfSHmc2i1nhfZTWhUlJb4kEzYsKQCaeoqISvXYdZnk8wsmjcTVGBcS3+dWHSfYf5nXr+gmcFitsZtUKZjuye4Jj9cF2Ra/pibwyg6SUnw/kaGsbV86+r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681942; c=relaxed/simple;
	bh=zDwMCapyQrCXeJvgqiXSqhqOY/a3+se5ssGQp9zZZQc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=iizeVFj7i2EqglCuFVV4xtAQuNZYSsZEmSNHORKkRpXlV+1pWrmR8Zlx5VbCZyLPDhZOX30YHJlNPaYFKxPCDFpWHyqA33DC+oo5s10hQIME79kSol9Tvi620mpfKnfTG7orf5ddAdcwU+ValGCCHH9sgVGhZMtBsWuNQvduaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkjSSwvS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55b3d57277so1110373066b.2;
        Thu, 02 May 2024 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714681939; x=1715286739; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIi7nG6JJg1hSaa58Cs/LDrFEekl3rqiNmHzMf0E4vs=;
        b=UkjSSwvSRHJIbjrTyGk/XzAqh7szmLYHvbMVoqndag7LDbsNCF8uvE0s9kkoKutgPB
         hH7cVQepbn9NQTdzEYj5ZCUyt8OD2soaRiNe1C1IY1vE9QQvYvg/4Er2IFyRp+FKMkxK
         h2nKaSHA+HtQmrp1ZqTQX8zhmT9qiHKVOjnp6tL7gDKW9eN3s091J/E4tMcAc6L5qTg1
         pXEgPdYOoutqfr1GmZtMYLtcEkRdyPhXTCBNmumgR6RLcI1wo6s4ewbhe1Sm9p+577wj
         iT1e7PrJ2HSTmWdRgH78pe5c1y1Mwow7I+DDIjY0KzKkznYDzlTrQxOrY/LhPu8ksx6a
         B5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714681939; x=1715286739;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bIi7nG6JJg1hSaa58Cs/LDrFEekl3rqiNmHzMf0E4vs=;
        b=S63JuWDw0TAoaPdhRs0AHXwmPHmfLB7hgGPbimm2PP7vdHqwRIhUcGZ+sB+pT6JMkN
         1toKlTVYRmLptrIQExJNLCoPzTPZTf1N7OsUYi50Xd0rTri5x6sn0ZkkfGTrEQuHe+eg
         KJRLxbVJ6u8cDryS51tx6V+kxfgtXyq/bx45TJZz6X0eQdpGKxoB0AyRp472NgBDzySg
         uW7FxNFid4kMxt4/uXEsSsrqik7s1KJ+VQDazigiMjgOqEyh0LTFa86LK428N4IvgrRd
         92R05Oo+DbShOwp3PLIRbgh0tF9KBC3x96FY/437QYT8tmhc4xWYOSMhYGv0FFY3hNW+
         Pr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtpFeN/LxG94u65fIcVk+kysRrUlsQ1ejeYS00LQpMy5ezsb61EbkDh/X8SdZZn09yYfhCJ0kK3f5iHn00MJvF5ThhMqH/wY5PS7Yaj91PU7vjCV2Sjo3XkzAl3M02nDKrj8ZUgazQ
X-Gm-Message-State: AOJu0Yy43zUoqNPIuXgY0zzxEU7Ktqn5yR5NC23th9V2wFYSJRJSImIp
	gb0dAeOmg18uOZmrie6a3RNioxadJ2OZ2DxDaEk6Hz8rCkK+ZDY8
X-Google-Smtp-Source: AGHT+IFUSpFm8gzl+bdtUaz2c+Hh5v0/xR4FeVOzEX5LjDQA+JG9rG3eszN5OopgI4Wyc5+VusxdjQ==
X-Received: by 2002:a17:906:168e:b0:a56:8e7c:9eb8 with SMTP id s14-20020a170906168e00b00a568e7c9eb8mr323974ejd.9.1714681938080;
        Thu, 02 May 2024 13:32:18 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:c738:8783:c735:785f? (2a02-a466-68ed-1-c738-8783-c735-785f.fixed6.kpn.net. [2a02:a466:68ed:1:c738:8783:c735:785f])
        by smtp.gmail.com with ESMTPSA id oz6-20020a170906cd0600b00a55a57712b0sm918380ejb.178.2024.05.02.13.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:32:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------o0nBF9rPCWdydhz2Plgl823S"
Message-ID: <7013cad9-7331-45be-b115-e9e1f253bcea@gmail.com>
Date: Thu, 2 May 2024 22:32:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
From: Ferry Toth <fntoth@gmail.com>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
 <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
 <Zh6BsK8F3gCzGJfE@smile.fi.intel.com>
 <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
 <d94f37cf-8140-4f89-aa67-53f9291faff3@gmail.com>
 <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
 <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
 <8041106f-0be0-4ed9-990e-1f62902b30e9@gmail.com>
 <9dab0c4f-cfae-4212-9a27-518454314eef@gmail.com>
 <20240502152916.GA7995@vmlxhi-118.adit-jv.com>
 <64ffb6e4-d0c9-4e53-a314-a174097516b1@gmail.com>
Content-Language: en-US
In-Reply-To: <64ffb6e4-d0c9-4e53-a314-a174097516b1@gmail.com>

This is a multi-part message in MIME format.
--------------o0nBF9rPCWdydhz2Plgl823S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Oops, sorry, wrong file attached . Now correct one.

Op 02-05-2024 om 22:13 schreef Ferry Toth:
> Op 02-05-2024 om 17:29 schreef Hardik Gajjar:
>> On Tue, Apr 30, 2024 at 11:12:17PM +0200, Ferry Toth wrote:
>>> Hi,
>>>
>>> Op 30-04-2024 om 21:40 schreef Ferry Toth:
>>>> Hi,
>>>>
>>>> Op 30-04-2024 om 17:32 schreef Hardik Gajjar:
>>>>> On Sun, Apr 28, 2024 at 11:07:36PM +0200, Ferry Toth wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Op 25-04-2024 om 23:27 schreef Ferry Toth:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
>>>>>>>> On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
>>>>>>>>> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
>>>>>>>>>> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
>>>>>>>>>>> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>>>>>>>>>>>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko 
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>>>>>>>>>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>>>>>>> Exactly. And this didn't happen before the 2 patches.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> To be precise: /sys/class/net/usb0 is not
>>>>>>>>>>>>>> removed and it is a link, the link
>>>>>>>>>>>>>> target 
>>>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0
>>>>>>>>>>>>>> no
>>>>>>>>>>>>>> longer exists
>>>>>>>>>>>> So, it means that the /sys/class/net/usb0 is
>>>>>>>>>>>> present, but the symlink is
>>>>>>>>>>>> broken. In that case, the dwc3 driver should
>>>>>>>>>>>> recreate the device, and the
>>>>>>>>>>>> symlink should become active again
>>>>>>>>>>
>>>>>>>>>> Yes, on first enabling gadget (when device mode is activated):
>>>>>>>>>>
>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>> driver  net  power  sound  subsystem  suspended  uevent
>>>>>>>>>>
>>>>>>>>>> Then switching to host mode:
>>>>>>>>>>
>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>> ls: cannot access
>>>>>>>>>> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/':
>>>>>>>>>> No such file
>>>>>>>>>> or directory
>>>>>>>>>>
>>>>>>>>>> Then back to device mode:
>>>>>>>>>>
>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>> driver  power  sound  subsystem  suspended  uevent
>>>>>>>>>>
>>>>>>>>>> net is missing. But, network functions:
>>>>>>>>>>
>>>>>>>>>> root@yuna:~# ping 10.42.0.1
>>>>>>>>>> PING 10.42.0.1 (10.42.0.1): 56 data bytes
>>>>>>>>>>
>>>>>>>>>> Mass storage device is created and removed each time as expected.
>>>>>>>>>
>>>>>>>>> So, what's the conclusion? Shall we move towards revert of those
>>>>>>>>> two changes?
>>>>>>>>
>>>>>>>>
>>>>>>>> As promised, I have the tested the this patch with the dwc3 gadget.
>>>>>>>> I could not reproduce
>>>>>>>> the issue.
>>>>>>>>
>>>>>>>> I can see the usb0 exist all the time and accessible regardless of
>>>>>>>> the role switching of the USB mode (peripheral <-> host)
>>>>>>>>
>>>>>>>> Following are the logs:
>>>>>>>> //Host to device
>>>>>>>>
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral"
>>>>>>>>> mode
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>>> a800000.dwc3/gadget/net/
>>>>>>>> usb0
>>>>>>>>
>>>>>>>> //device to host
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > 
>>>>>>>> mode
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>>> a800000.dwc3/gadget/net/
>>>>>>>> usb0
>>>>>>>
>>>>>>> That is weird. When I switch to host mode (using the physical 
>>>>>>> switch),
>>>>>>> the whole gadget directory is removed (now testing 6.9.0-rc5)
>>>>>>>
>>>>>>> Switching back to device mode, that gadget directory is 
>>>>>>> recreated. And
>>>>>>> gadget/sound as well, but not gadget/net.
>>>>>>>
>>>>>>>> s a800000.dwc3/gadget/net/usb0
>>>>>>>> <
>>>>>>>> addr_assign_type    duplex             phys_port_name
>>>>>>>> addr_len            flags              phys_switch_id
>>>>>>>> address             gro_flush_timeout  power
>>>>>>>> broadcast           ifalias            proto_down
>>>>>>>> carrier             ifindex            queues
>>>>>>>> carrier_changes     iflink             speed
>>>>>>>> carrier_down_count  link_mode          statistics
>>>>>>>> carrier_up_count    mtu                subsystem
>>>>>>>> dev_id              name_assign_type   tx_queue_len
>>>>>>>> dev_port            netdev_group       type
>>>>>>>> device              operstate          uevent
>>>>>>>> dormant             phys_port_id       waiting_for_supplier
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
>>>>>>>> usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
>>>>>>>>              BROADCAST MULTICAST  MTU:1500  Metric:1
>>>>>>>>              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>>>>>              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>>>>>              collisions:0 txqueuelen:1000
>>>>>>>>              RX bytes:0 TX bytes:0
>>>>>>>>
>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb #
>>>>>>>>
>>>>>>>> I strongly advise against reverting the patch solely based on the
>>>>>>>> observed issue of removing the /sys/class/net/usb0 directory while
>>>>>>>> the usb0 interface remains available.
>>>>>>>
>>>>>>> There's more to it. I also mentioned that switching the role or
>>>>>>> unplugging the cable leaves the usb0 connection.
>>>>>>>
>>>>>>> I have while in host mode:
>>>>>>> root@yuna:~# ifconfig -a usb0
>>>>>>> usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
>>>>>>>            inet 10.42.0.221  netmask 255.255.255.0  broadcast
>>>>>>> 10.42.0.255
>>>>>>>            inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64
>>>>>>> scopeid 0x20<link>
>>>>>>>
>>>>>>>
>>>>>>> You don't see that because you didn't create a connection at all.
>>>>>>>
>>>>>>>> Instead, I recommend enabling FTRACE to trace the functions 
>>>>>>>> involved
>>>>>>>> and identify which faulty call is responsible for removing usb0.
>>>>>>>
>>>>>>> Switching from device -> host -> device:
>>>>>>>
>>>>>>> root@yuna:~# trace-cmd record -p function_graph -l *gether_*
>>>>>>>      plugin 'function_graph'
>>>>>>> Hit Ctrl^C to stop recording
>>>>>>> ^CCPU0 data recorded at offset=0x1c8000
>>>>>>>        188 bytes in size (4096 uncompressed)
>>>>>>> CPU1 data recorded at offset=0x1c9000
>>>>>>>        0 bytes in size (0 uncompressed)
>>>>>>> root@yuna:~# trace-cmd report
>>>>>>> cpus=2
>>>>>>>         irq/68-dwc3-725   [000]   514.575337: 
>>>>>>> funcgraph_entry:      #
>>>>>>> 2079.480 us |  gether_disconnect();
>>>>>>>         irq/68-dwc3-946   [000]   524.263731: 
>>>>>>> funcgraph_entry:      +
>>>>>>> 11.640 us  |  gether_disconnect();
>>>>>>>         irq/68-dwc3-946   [000]   524.263743: 
>>>>>>> funcgraph_entry:      !
>>>>>>> 116.520 us |  gether_connect();
>>>>>>>         irq/68-dwc3-946   [000]   524.268029: 
>>>>>>> funcgraph_entry:      #
>>>>>>> 2057.260 us |  gether_disconnect();
>>>>>>>         irq/68-dwc3-946   [000]   524.270089: 
>>>>>>> funcgraph_entry:      !
>>>>>>> 109.000 us |  gether_connect();
>>>>>>
>>>>>> I tried to get a more useful trace:
>>>>>> root@yuna:/sys/kernel/tracing# echo 'gether_*' > set_ftrace_filter
>>>>>> root@yuna:/sys/kernel/tracing# echo 'eem_*' >> set_ftrace_filter
>>>>>> root@yuna:/sys/kernel/tracing# echo function > current_tracer
>>>>>> root@yuna:/sys/kernel/tracing# echo 'reset_config' >> 
>>>>>> set_ftrace_filter
>>>>>> -> switch to host mode then back to device
>>>>>> root@yuna:/sys/kernel/tracing# cat trace
>>>>>> # tracer: function
>>>>>> #
>>>>>> # entries-in-buffer/entries-written: 53/53   #P:2
>>>>>> #
>>>>>> #                                _-----=> irqs-off/BH-disabled
>>>>>> #                               / _----=> need-resched
>>>>>> #                              | / _---=> hardirq/softirq
>>>>>> #                              || / _--=> preempt-depth
>>>>>> #                              ||| / _-=> migrate-disable
>>>>>> #                              |||| /     delay
>>>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>>> #              | |         |   |||||     |         |
>>>>>>        irq/68-dwc3-523     [000] D..3.   133.990254: reset_config
>>>>>> <-__composite_disconnect
>>>>>>        irq/68-dwc3-523     [000] D..3.   133.992274: eem_disable
>>>>>> <-reset_config
>>>>>>        irq/68-dwc3-523     [000] D..3.   133.992276: 
>>>>>> gether_disconnect
>>>>>> <-reset_config
>>>>>>        kworker/1:3-443     [001] ...1.   134.022453: eem_unbind
>>>>>> <-purge_configs_funcs
>>>>>>
>>>>>> -> to device mode
>>>>>>
>>>>>>        kworker/1:3-443     [001] ...1.   148.630773: eem_bind
>>>>>> <-usb_add_function
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.155209: eem_set_alt
>>>>>> <-composite_setup
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.155215: 
>>>>>> gether_disconnect
>>>>>> <-eem_set_alt
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.155220: gether_connect
>>>>>> <-eem_set_alt
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.157287: eem_set_alt
>>>>>> <-composite_setup
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.157292: 
>>>>>> gether_disconnect
>>>>>> <-eem_set_alt
>>>>>>        irq/68-dwc3-734     [000] D..3.   149.159338: gether_connect
>>>>>> <-eem_set_alt
>>>>>>        irq/68-dwc3-734     [000] D..2.   149.239625: eem_unwrap
>>>>>> <-rx_complete
>>>>>> ...
>>>>>>
>>>>>> I don't know where to look exactly. Any hints?
>>>>>
>>>>> do you see anything related to gether_cleanup() after eem_unbind() ?
>>>>
>>>> Nope. It's a pitty that the trace formatting got messed up above. 
>>>> But as
>>>> you can see I traced gether_* and eem_*. After eem_unbind no traced
>>>> function is called, until I flip the switch to device mode.
>>>> The ... at the end is where I cut uninteresting eem_unwrap 
>>>> <-rx_complete
>>>> and eem_wrap <-eth_start_xmit lines.
>>>>
>>>>> If not then, you may try to enable tracing of TCP/IP stack and
>>>>> network side to check who deleting the sysfs entry
>>>>
>>>> Yes, that's a vast amount of functions to trace. And I don't see how
>>>> that would be related to the patch we're discussing here. I was hoping
>>>> for a little more targeted hint.
>>>
>>> Now filtering 'gether_*', 'eem_*', '*configfs_*', 'composite_*', 
>>> 'usb_fun*',
>>> 'reset_config' and 'device_remove_file' leads me to:
>>>
>>> TIMESTAMP  FUNCTION
>>>     |         |
>>>    49.952477: eem_wrap <-eth_start_xmit
>>>    55.072455: eem_wrap <-eth_start_xmit
>>>    55.072621: eem_unwrap <-rx_complete
>>>    59.011540: configfs_composite_reset <-usb_gadget_udc_reset
>>>    59.011545: composite_reset <-configfs_composite_reset
>>>    59.011548: reset_config <-__composite_disconnect
>>>    59.013565: eem_disable <-reset_config
>>>    59.013567: gether_disconnect <-reset_config
>>>    59.049560: device_remove_file <-device_remove
>>>    59.051185: configfs_composite_disconnect <-usb_gadget_disco
>>>    59.051189: composite_disconnect <-configfs_composite_discon
>>>    59.051195: configfs_composite_unbind <-gadget_unbind_driver
>>>    59.052519: eem_unbind <-purge_configs_funcs
>>>    59.052529: composite_dev_cleanup <-configfs_composite_unbin
>>>    59.052537: device_remove_file <-composite_dev_cleanup
>>>
>>> device_remove_file gets called twice, once by device_remove after
>>> gether_disconnect (that the one). The 2nd time by composite_dev_cleanup
>>> (removing the gadget)
>>
>> I believe that the device_remove_file function is only removing 
>> suspend-specific attributes, not the complete gadget.
>> Typically, when you perform the role switch, the Gadget start/stop 
>> function in your UDC driver is called. These functions should not 
>> delete the gadget
>>
>> To investigate further, could you please enable the DWC3 functions in 
>> ftrace and check who is removing the gadget?
>> I can also enable this on my system and compare the logs with yours, 
>> but I will be in PI planning for 1.5 weeks and may not be able to 
>> provide immediate support.
> 
> Yes, but of course adding dwc3_* (and usb_*) also traces host mode, so 
> trace is 600kb. I cut uninteresting stuff before 
> configfs_composite_reset <-usb_gadget_udc_reset and after 
> __dwc3_set_mode, < 300 lines remain. See attached tar.gz for you to 
> compare.
> 
>> Additionally, please check if you have any customized DWC patches that 
>> may be causing this problem.
>>
>>>
>>>> You may recall the whole issue did not occur before this patch got 
>>>> applied.
>>>>
>>>>> Hardik
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> According to current kernel architecture of u_ether driver, only
>>>>>>>> gether_cleanup should remove the usb0 interface along with its
>>>>>>>> kobject and sysfs interface.
>>>>>>>> I suggest sharing the analysis here to understand why this practice
>>>>>>>> is not followed in your use case or driver ?
>>>>>>>
>>>>>>> Yes, I'll try to trace where that happens.
>>>>>>>
>>>>>>> Nevertheless, the disappearance of the net/usb0 directory seems
>>>>>>> harmless? But the usb: net device remaining after disconnect or role
>>>>>>> switch is not good, as the route remains.
>>>>>>>
>>>>>>> May be they are 2 separate problems. Could you try to reproduce what
>>>>>>> happens if you make eem connection and then unplug?
>>>>>>>
>>>>>>>> I am curious why the driver was developed without adhering to the
>>>>>>>> kernel's gadget architecture.
>>>>>>
>>>>>> I don't know what you mean here. Which driver do you mean?
>>>>>>
>>>>>>>>>
>>>>>>>>>>>> I have the dwc3 IP base usb controller, Let me check
>>>>>>>>>>>> with this patch and
>>>>>>>>>>>> share result here.  May be we need some fix in dwc3
>>>>>>>>>> Would have been nice if someone could test on other
>>>>>>>>>> controller as well. But
>>>>>>>>>> another instance of dwc3 is also very welcome.
>>>>>>>>>>> It's quite possible, please test on your side.
>>>>>>>>>>> We are happy to test any fixes if you come up with.
>>>>>>>>>
>>>>>>>>> -- 
>>>>>>>>> With Best Regards,
>>>>>>>>> Andy Shevchenko
>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>
--------------o0nBF9rPCWdydhz2Plgl823S
Content-Type: application/gzip; name="trace_u_ether.tar.gz"
Content-Disposition: attachment; filename="trace_u_ether.tar.gz"
Content-Transfer-Encoding: base64

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
vh/fj+/H5fFfk9VPkwB0AAA=

--------------o0nBF9rPCWdydhz2Plgl823S--

