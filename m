Return-Path: <linux-kernel+bounces-166896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482208BA176
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6451A1C21657
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154DE158845;
	Thu,  2 May 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN/fNgeW"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A530180A95;
	Thu,  2 May 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680829; cv=none; b=eXjFe3VDFhoZO78IrIuwF4Vzrb/7sgePMB/9OEDVGwsWpx/zpSuitfcrUYeojPBilT/uz/lE9T4yQ9brBiLjQXFXJBncxgv+x2Tr9O6tOoVwthbug3I7UXuJgzYucmCHO4tDA3uGutA7KZXB3Yo8sICWT/D5lbVzlYprmls+0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680829; c=relaxed/simple;
	bh=V7+c0LXZKUeE/LelLvn4iLLfWFW/t8fnA+VAt9UOnSE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FWphQieOQFi9gsvVXwFS4Z2srI1CnRIMgVADnpueCH0Z0Eh6B/Qnb3Z//tM73sGEDr7TK4gfheutA2jD5WSCSgAyi3IxyPPHM+7owULNavOKg4sdBmzw0mW8+mOcD3LWcok9v1iXANVVKQOtPVM8Emf+hGNi/W127cz3awknuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN/fNgeW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so1061817e87.3;
        Thu, 02 May 2024 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680826; x=1715285626; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56513PreYhiFLirwkfmNlLV6xVMPvJ031TzTJp2IdTE=;
        b=lN/fNgeW2ZM4giteDYqcftPCQKBrcd718xAP2F4C3UdSqa86uEZUHMVOlIc4ENNReS
         A2k1bo+Ik6ENKF41z/unCRbVCRc15NP/eXmQz7rqcFg3pBpeBihVuJj7UrneWJrqEJeO
         Abr+ULC5OkWCMyEuCfym/KWf8sq4naL9C4p1W8vcYgxmIr1PgJHnfsElRY78bjeYp/Ib
         4vZeknDNB8GZJ6Cp4vOX9ys8YJdlbVEVaCYzFNyghkQNfVK6n/4d+e3D8bWJupn6aHS/
         rcWH2R0CCoTWbXQIh8+hqya8MEvLINUNXQVsySoLq0xmpgNOe92Zq4Ovk7TnM3X6II1I
         wS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680826; x=1715285626;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56513PreYhiFLirwkfmNlLV6xVMPvJ031TzTJp2IdTE=;
        b=s6aDxJK1F0pQty6rzB9SstE0SmcR8QDhqyjv41OW5qPiqxIExG0goZqHpCqkd4RY90
         G1NAILI9vBgNmqpNdxjVeqaQpjqlP18lS1n0JQ788+679Z3IFLMMcGMYPhYCZb1yMuR/
         r2Xzxt5Y9BXlOI3y/JGmBpjR3Uyz2NMZErNEKOfGcHzjR0Z/I2F4kQqhvzNmvnovXP2s
         prqlgM6NDlGOADH5jbQZ04XguNIjUQL5Lf6lAVuATA9JXFCSpmqeT30KA+vGa8BE4Fs0
         CYrWt3l8gYI4Crg7fJxzhOYDeyqRDld8SzoJhtVe/WEWfKV/fe1VRAZjMTDdQs9v3ITZ
         bOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEnBP7ZpglW/8v/lMGn8FEMngfTAHk0wAUuxshQvdn7Ehj1uh9xwLiQEl5aPuRguV5WXQYgrfQvk8JiMQI66h6xsSQRJv2wmHYDJ8iZuNTkIps2PrNmi8g7INUQlGghwAuwkd2VhT6
X-Gm-Message-State: AOJu0Yx7A3Y8Z6vZAwhmvzjsRtbosyHS48iEukWxg5hIGdIIvXtjxnK6
	6xPidmjhEqTj+j4D3raR4KloVJel0xw3mNVsgK0SpJFiH3wESeIA
X-Google-Smtp-Source: AGHT+IH4Qx3bCqhzjYhlcw1MO/IiN1QPvjrAZJw8pLTFFMaeoUxn5QI3SQvvgMPKHCV1csPvm2hGsw==
X-Received: by 2002:ac2:559a:0:b0:51d:d78:4952 with SMTP id v26-20020ac2559a000000b0051d0d784952mr542001lfg.65.1714680825109;
        Thu, 02 May 2024 13:13:45 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:c738:8783:c735:785f? (2a02-a466-68ed-1-c738-8783-c735-785f.fixed6.kpn.net. [2a02:a466:68ed:1:c738:8783:c735:785f])
        by smtp.gmail.com with ESMTPSA id gf18-20020a170906e21200b00a587236e646sm904837ejb.174.2024.05.02.13.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 13:13:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wkYj0k3PUv3BCNLWSlSEv53j"
Message-ID: <64ffb6e4-d0c9-4e53-a314-a174097516b1@gmail.com>
Date: Thu, 2 May 2024 22:13:43 +0200
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
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240502152916.GA7995@vmlxhi-118.adit-jv.com>

This is a multi-part message in MIME format.
--------------wkYj0k3PUv3BCNLWSlSEv53j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 02-05-2024 om 17:29 schreef Hardik Gajjar:
> On Tue, Apr 30, 2024 at 11:12:17PM +0200, Ferry Toth wrote:
>> Hi,
>>
>> Op 30-04-2024 om 21:40 schreef Ferry Toth:
>>> Hi,
>>>
>>> Op 30-04-2024 om 17:32 schreef Hardik Gajjar:
>>>> On Sun, Apr 28, 2024 at 11:07:36PM +0200, Ferry Toth wrote:
>>>>> Hi,
>>>>>
>>>>> Op 25-04-2024 om 23:27 schreef Ferry Toth:
>>>>>> Hi,
>>>>>>
>>>>>> Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
>>>>>>> On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
>>>>>>>> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
>>>>>>>>> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
>>>>>>>>>> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>>>>>>>>>>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
>>>>>>>>>>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>>>>>>>>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>>>>>> Exactly. And this didn't happen before the 2 patches.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To be precise: /sys/class/net/usb0 is not
>>>>>>>>>>>>> removed and it is a link, the link
>>>>>>>>>>>>> target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0
>>>>>>>>>>>>> no
>>>>>>>>>>>>> longer exists
>>>>>>>>>>> So, it means that the /sys/class/net/usb0 is
>>>>>>>>>>> present, but the symlink is
>>>>>>>>>>> broken. In that case, the dwc3 driver should
>>>>>>>>>>> recreate the device, and the
>>>>>>>>>>> symlink should become active again
>>>>>>>>>
>>>>>>>>> Yes, on first enabling gadget (when device mode is activated):
>>>>>>>>>
>>>>>>>>> root@yuna:~# ls
>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>> driver  net  power  sound  subsystem  suspended  uevent
>>>>>>>>>
>>>>>>>>> Then switching to host mode:
>>>>>>>>>
>>>>>>>>> root@yuna:~# ls
>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>> ls: cannot access
>>>>>>>>> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/':
>>>>>>>>> No such file
>>>>>>>>> or directory
>>>>>>>>>
>>>>>>>>> Then back to device mode:
>>>>>>>>>
>>>>>>>>> root@yuna:~# ls
>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>> driver  power  sound  subsystem  suspended  uevent
>>>>>>>>>
>>>>>>>>> net is missing. But, network functions:
>>>>>>>>>
>>>>>>>>> root@yuna:~# ping 10.42.0.1
>>>>>>>>> PING 10.42.0.1 (10.42.0.1): 56 data bytes
>>>>>>>>>
>>>>>>>>> Mass storage device is created and removed each time as expected.
>>>>>>>>
>>>>>>>> So, what's the conclusion? Shall we move towards revert of those
>>>>>>>> two changes?
>>>>>>>
>>>>>>>
>>>>>>> As promised, I have the tested the this patch with the dwc3 gadget.
>>>>>>> I could not reproduce
>>>>>>> the issue.
>>>>>>>
>>>>>>> I can see the usb0 exist all the time and accessible regardless of
>>>>>>> the role switching of the USB mode (peripheral <-> host)
>>>>>>>
>>>>>>> Following are the logs:
>>>>>>> //Host to device
>>>>>>>
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral"
>>>>>>>> mode
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>> a800000.dwc3/gadget/net/
>>>>>>> usb0
>>>>>>>
>>>>>>> //device to host
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>> a800000.dwc3/gadget/net/
>>>>>>> usb0
>>>>>>
>>>>>> That is weird. When I switch to host mode (using the physical switch),
>>>>>> the whole gadget directory is removed (now testing 6.9.0-rc5)
>>>>>>
>>>>>> Switching back to device mode, that gadget directory is recreated. And
>>>>>> gadget/sound as well, but not gadget/net.
>>>>>>
>>>>>>> s a800000.dwc3/gadget/net/usb0
>>>>>>> <
>>>>>>> addr_assign_type    duplex             phys_port_name
>>>>>>> addr_len            flags              phys_switch_id
>>>>>>> address             gro_flush_timeout  power
>>>>>>> broadcast           ifalias            proto_down
>>>>>>> carrier             ifindex            queues
>>>>>>> carrier_changes     iflink             speed
>>>>>>> carrier_down_count  link_mode          statistics
>>>>>>> carrier_up_count    mtu                subsystem
>>>>>>> dev_id              name_assign_type   tx_queue_len
>>>>>>> dev_port            netdev_group       type
>>>>>>> device              operstate          uevent
>>>>>>> dormant             phys_port_id       waiting_for_supplier
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
>>>>>>> usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
>>>>>>>              BROADCAST MULTICAST  MTU:1500  Metric:1
>>>>>>>              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>>>>              TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>>>>              collisions:0 txqueuelen:1000
>>>>>>>              RX bytes:0 TX bytes:0
>>>>>>>
>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb #
>>>>>>>
>>>>>>> I strongly advise against reverting the patch solely based on the
>>>>>>> observed issue of removing the /sys/class/net/usb0 directory while
>>>>>>> the usb0 interface remains available.
>>>>>>
>>>>>> There's more to it. I also mentioned that switching the role or
>>>>>> unplugging the cable leaves the usb0 connection.
>>>>>>
>>>>>> I have while in host mode:
>>>>>> root@yuna:~# ifconfig -a usb0
>>>>>> usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
>>>>>>            inet 10.42.0.221  netmask 255.255.255.0  broadcast
>>>>>> 10.42.0.255
>>>>>>            inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64
>>>>>> scopeid 0x20<link>
>>>>>>
>>>>>>
>>>>>> You don't see that because you didn't create a connection at all.
>>>>>>
>>>>>>> Instead, I recommend enabling FTRACE to trace the functions involved
>>>>>>> and identify which faulty call is responsible for removing usb0.
>>>>>>
>>>>>> Switching from device -> host -> device:
>>>>>>
>>>>>> root@yuna:~# trace-cmd record -p function_graph -l *gether_*
>>>>>>      plugin 'function_graph'
>>>>>> Hit Ctrl^C to stop recording
>>>>>> ^CCPU0 data recorded at offset=0x1c8000
>>>>>>        188 bytes in size (4096 uncompressed)
>>>>>> CPU1 data recorded at offset=0x1c9000
>>>>>>        0 bytes in size (0 uncompressed)
>>>>>> root@yuna:~# trace-cmd report
>>>>>> cpus=2
>>>>>>         irq/68-dwc3-725   [000]   514.575337: funcgraph_entry:      #
>>>>>> 2079.480 us |  gether_disconnect();
>>>>>>         irq/68-dwc3-946   [000]   524.263731: funcgraph_entry:      +
>>>>>> 11.640 us  |  gether_disconnect();
>>>>>>         irq/68-dwc3-946   [000]   524.263743: funcgraph_entry:      !
>>>>>> 116.520 us |  gether_connect();
>>>>>>         irq/68-dwc3-946   [000]   524.268029: funcgraph_entry:      #
>>>>>> 2057.260 us |  gether_disconnect();
>>>>>>         irq/68-dwc3-946   [000]   524.270089: funcgraph_entry:      !
>>>>>> 109.000 us |  gether_connect();
>>>>>
>>>>> I tried to get a more useful trace:
>>>>> root@yuna:/sys/kernel/tracing# echo 'gether_*' > set_ftrace_filter
>>>>> root@yuna:/sys/kernel/tracing# echo 'eem_*' >> set_ftrace_filter
>>>>> root@yuna:/sys/kernel/tracing# echo function > current_tracer
>>>>> root@yuna:/sys/kernel/tracing# echo 'reset_config' >> set_ftrace_filter
>>>>> -> switch to host mode then back to device
>>>>> root@yuna:/sys/kernel/tracing# cat trace
>>>>> # tracer: function
>>>>> #
>>>>> # entries-in-buffer/entries-written: 53/53   #P:2
>>>>> #
>>>>> #                                _-----=> irqs-off/BH-disabled
>>>>> #                               / _----=> need-resched
>>>>> #                              | / _---=> hardirq/softirq
>>>>> #                              || / _--=> preempt-depth
>>>>> #                              ||| / _-=> migrate-disable
>>>>> #                              |||| /     delay
>>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>> #              | |         |   |||||     |         |
>>>>>        irq/68-dwc3-523     [000] D..3.   133.990254: reset_config
>>>>> <-__composite_disconnect
>>>>>        irq/68-dwc3-523     [000] D..3.   133.992274: eem_disable
>>>>> <-reset_config
>>>>>        irq/68-dwc3-523     [000] D..3.   133.992276: gether_disconnect
>>>>> <-reset_config
>>>>>        kworker/1:3-443     [001] ...1.   134.022453: eem_unbind
>>>>> <-purge_configs_funcs
>>>>>
>>>>> -> to device mode
>>>>>
>>>>>        kworker/1:3-443     [001] ...1.   148.630773: eem_bind
>>>>> <-usb_add_function
>>>>>        irq/68-dwc3-734     [000] D..3.   149.155209: eem_set_alt
>>>>> <-composite_setup
>>>>>        irq/68-dwc3-734     [000] D..3.   149.155215: gether_disconnect
>>>>> <-eem_set_alt
>>>>>        irq/68-dwc3-734     [000] D..3.   149.155220: gether_connect
>>>>> <-eem_set_alt
>>>>>        irq/68-dwc3-734     [000] D..3.   149.157287: eem_set_alt
>>>>> <-composite_setup
>>>>>        irq/68-dwc3-734     [000] D..3.   149.157292: gether_disconnect
>>>>> <-eem_set_alt
>>>>>        irq/68-dwc3-734     [000] D..3.   149.159338: gether_connect
>>>>> <-eem_set_alt
>>>>>        irq/68-dwc3-734     [000] D..2.   149.239625: eem_unwrap
>>>>> <-rx_complete
>>>>> ...
>>>>>
>>>>> I don't know where to look exactly. Any hints?
>>>>
>>>> do you see anything related to gether_cleanup() after eem_unbind() ?
>>>
>>> Nope. It's a pitty that the trace formatting got messed up above. But as
>>> you can see I traced gether_* and eem_*. After eem_unbind no traced
>>> function is called, until I flip the switch to device mode.
>>> The ... at the end is where I cut uninteresting eem_unwrap <-rx_complete
>>> and eem_wrap <-eth_start_xmit lines.
>>>
>>>> If not then, you may try to enable tracing of TCP/IP stack and
>>>> network side to check who deleting the sysfs entry
>>>
>>> Yes, that's a vast amount of functions to trace. And I don't see how
>>> that would be related to the patch we're discussing here. I was hoping
>>> for a little more targeted hint.
>>
>> Now filtering 'gether_*', 'eem_*', '*configfs_*', 'composite_*', 'usb_fun*',
>> 'reset_config' and 'device_remove_file' leads me to:
>>
>> TIMESTAMP  FUNCTION
>>     |         |
>>    49.952477: eem_wrap <-eth_start_xmit
>>    55.072455: eem_wrap <-eth_start_xmit
>>    55.072621: eem_unwrap <-rx_complete
>>    59.011540: configfs_composite_reset <-usb_gadget_udc_reset
>>    59.011545: composite_reset <-configfs_composite_reset
>>    59.011548: reset_config <-__composite_disconnect
>>    59.013565: eem_disable <-reset_config
>>    59.013567: gether_disconnect <-reset_config
>>    59.049560: device_remove_file <-device_remove
>>    59.051185: configfs_composite_disconnect <-usb_gadget_disco
>>    59.051189: composite_disconnect <-configfs_composite_discon
>>    59.051195: configfs_composite_unbind <-gadget_unbind_driver
>>    59.052519: eem_unbind <-purge_configs_funcs
>>    59.052529: composite_dev_cleanup <-configfs_composite_unbin
>>    59.052537: device_remove_file <-composite_dev_cleanup
>>
>> device_remove_file gets called twice, once by device_remove after
>> gether_disconnect (that the one). The 2nd time by composite_dev_cleanup
>> (removing the gadget)
> 
> I believe that the device_remove_file function is only removing suspend-specific attributes, not the complete gadget.
> Typically, when you perform the role switch, the Gadget start/stop function in your UDC driver is called. These functions should not delete the gadget
> 
> To investigate further, could you please enable the DWC3 functions in ftrace and check who is removing the gadget?
> I can also enable this on my system and compare the logs with yours, but I will be in PI planning for 1.5 weeks and may not be able to provide immediate support.

Yes, but of course adding dwc3_* (and usb_*) also traces host mode, so 
trace is 600kb. I cut uninteresting stuff before 
configfs_composite_reset <-usb_gadget_udc_reset and after 
__dwc3_set_mode, < 300 lines remain. See attached tar.gz for you to compare.

> Additionally, please check if you have any customized DWC patches that may be causing this problem.
> 
>>
>>> You may recall the whole issue did not occur before this patch got applied.
>>>
>>>> Hardik
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>> According to current kernel architecture of u_ether driver, only
>>>>>>> gether_cleanup should remove the usb0 interface along with its
>>>>>>> kobject and sysfs interface.
>>>>>>> I suggest sharing the analysis here to understand why this practice
>>>>>>> is not followed in your use case or driver ?
>>>>>>
>>>>>> Yes, I'll try to trace where that happens.
>>>>>>
>>>>>> Nevertheless, the disappearance of the net/usb0 directory seems
>>>>>> harmless? But the usb: net device remaining after disconnect or role
>>>>>> switch is not good, as the route remains.
>>>>>>
>>>>>> May be they are 2 separate problems. Could you try to reproduce what
>>>>>> happens if you make eem connection and then unplug?
>>>>>>
>>>>>>> I am curious why the driver was developed without adhering to the
>>>>>>> kernel's gadget architecture.
>>>>>
>>>>> I don't know what you mean here. Which driver do you mean?
>>>>>
>>>>>>>>
>>>>>>>>>>> I have the dwc3 IP base usb controller, Let me check
>>>>>>>>>>> with this patch and
>>>>>>>>>>> share result here.  May be we need some fix in dwc3
>>>>>>>>> Would have been nice if someone could test on other
>>>>>>>>> controller as well. But
>>>>>>>>> another instance of dwc3 is also very welcome.
>>>>>>>>>> It's quite possible, please test on your side.
>>>>>>>>>> We are happy to test any fixes if you come up with.
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> With Best Regards,
>>>>>>>> Andy Shevchenko
>>>>>>>>
>>>>>>>>
>>>>>>
>>>

--------------wkYj0k3PUv3BCNLWSlSEv53j
Content-Type: application/gzip; name="trace-u_ether.tar.gz"
Content-Disposition: attachment; filename="trace-u_ether.tar.gz"
Content-Transfer-Encoding: base64

H4sIALDyM2YAA+2Z60/bSBDA+zl/xUp8KFdhZ99rWxQdhd4dKi+1IN3pVEWOvQYLx07tTQGp
ur/9xo8khAaSXPd0OolByPHuzG92Z2YfAVOGkXYmA22udemaO/PKvmCMpeQInkQJ8vBZCxFc
SkS4JJwKeBEIE66IeIXwvzCW72RSmbCEoSS6LO+f0VvV304GzZ7/E9HRdYEw2kP96r7q3+gy
11k/1sPJVd9AaaT57Dko8l4UL+hNNXoN5fVVU0SDN68BV2kzSOp+PUjSzOiy09F61Cg8rREV
o3FRpUav0JtUw0EyyZ9XehMVeZJeJdUKWKnrnlb5OUVwGJm0yGGG0aQsdW4GjVLXTdYNZG/D
uIcGNX56vTdPS69XFoX5+X6Sh8FfW2gzFwumT+V5rrSku/O4ogzWQjxXJesAnk7TWu7XqIZ1
OGtXgwMeblMTXSNToOuiMmhUxHqVjzRpR9jLigAlWXhVvVVs9/J85/js7Pzd/sGHnY+Xp6dH
p7/uITQyEySFYLKHOklzbRChysXwQxCC11FY3SAqRNOEFzQlCgJQGpc6Se8ynYOlh1AVFWOd
xgjfEbxbj3tvZpQVxRghc/dloie6Mah3RbR9XERhho6hdxhGNz/N9D/+jsbQoE2FPI7Q8N7o
Cilf+mhbuQp9SN8t6MJmXJQVVDeKy2I81nH9sfgKzZO8aU7KcKTRfBIXG/AvlvMf4qOwLFNd
Nh+LLEsrKDbo6PVgV8LTbHAim3y8+3i2f3iw/+limpCdk8vji6O6pUsNERg/ygx2OYU0UPoo
N9Nf8DwsizCOwuqBthCP0pZoDwdB6A2HQRQlSZDoOA60ThaSCYfzg1xSvJul+c08l816RmEY
NJCgAQQ14fv0vq9VwfHSxCo5DTzBFBO07bu+1cz6cwdUeRRtE+pye7m9zcJ8llyHelL6i+md
pXXn8I/T/ZOjg2XpbaOZREFEg1gHbBjgYRCGG0cTT+eK0TYsV2QvjM+QfyB8zt58j4v11zTS
6+xya220/+CQWwqbH7Nb7bMMZkdJbwsa4SCBuVVOmjvDSQJXwv605bZMjdF5gATrCwaR2joP
aGOzQgZOLW/3UFp+qZwiSfrvfnPitAqHmY5XmvdbezDPtY4dOLii69Vm3zo7MLsOyxg896si
MfBcadmZgiVsH3o0Nk6sx+Z6tV1rCHaj9KoMjZ7OcQ3L2rSWWGfh/YL+xf6nD8750WHzcnB+
udXqf4Oeo5P3ny72T84R+uXy9ODi6Oz0sadv8DP/PLPs3rr2tvLrCEnPiW8j5gjKmrY/YY1+
Roeuy1x4I4y5vo+p4AF6eH1Au85gML/SwqShPdeR2QxMqQJwfS3qwgbch242pskAdfe0+ZCW
Mm9uixLWSZ8EzOF8xiSfkeu6pGVyF1PKBWtHOMmHaR4DbDwpr3QHq+q7elT16rvOow1gbT/c
cyXDSnV+Oi/194AwjgezhfpdKBTjy0LBfZcIQbHf4uqJh1kdhHm6oG0y3hRIxPLYPnCyKZLi
GdICT1FPWZ2zoj61PGefMe+H50ynPMp8ScW0PG/LcFzX+l2zMDNt9EYsgZlHrbE49eywGOXK
s8ViwpPWWB6bbw1PsabLHwfUET5aZPEZiysmZcvqSFAhg/pPOGZwN0o3KgqhOBe+nUkKTyiP
WGNBxOyxBLfDkj6TwlJRKPgqii2NC4LlWVlEAi67THCpbLGUojY2CmARzD2+sr7WWEQ1i1Dp
KxuLCGCMSd+3FDCmCLWyIIElqM+lpeAL7kG1WmNxbGNxA0vBsaYszVEp4QtLc1TK93wrC5K4
2KNYWIlXzWK+PRbH0hKLwr7KbWyGwBIE2zmIBK1vAYxZqa+aJYmdtU1dTiRWVmJfs2BftTJH
5sK+Kn1rLM+nVuLVsuzUBINaZZxaYUmoCSKZlbOjZa2OfSO7aZzpPQd3r+2XzMPTSkxZvsQS
s+cOyP/6v3Yv8iIv8iI/Ln8Dlbf1tAAiAAA=

--------------wkYj0k3PUv3BCNLWSlSEv53j--

