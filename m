Return-Path: <linux-kernel+bounces-167645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C68BACA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5677D1F215AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E17153575;
	Fri,  3 May 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KlRzdjie"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC626441F;
	Fri,  3 May 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739993; cv=none; b=rhxV/njR3QYqJtyJ4o+L+bZ/v/rbK7VmWFamvBXV9HD+mb8XYW2EiR5V74ZViURhnnLYBuMpE3IHCAC5MezH49y7cNp73jt94QSxwisZQJaFAw2unCO5Rw1n4fezxxC/UjLx42yOJE7lHN0R99m1LLu4HbCC6k6IxH6GTEdXnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739993; c=relaxed/simple;
	bh=ScKKgtbpHI9WxhSclW1S1wJFGY8HG8UE2nzOV203BLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXrOmTo0qL/gt59En/bWR5aNC1C9TeYV75jehenX1MJwaf0KNGSei0wI2j0acdfgZjdmVYlPo9TelKDodLvzfrBzo5iiIfcupdPeOASIO6SSGD+X8VQGosIZh35zjm0yw2yVpR41tf2UUkXxug+TuyWN0EwHWQCaUzSP7jQ6cUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KlRzdjie; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=2WD2iQ8jgRD+mDGq1Y+2rGeHODhYXr+x0J0Cs7Smfjk=;
	t=1714739990; x=1715171990; b=KlRzdjieQR3Zk+XlixoWz7vxVzRt+ONeaEHQwlNITnqpqar
	pS96avPhn6RclDnsEQwvpbPGfDM8MUHqj/OlsozQmqse13rcabQybWbPhag9E5XmXj6LsTlgjeN5T
	9DlSGRWJUDEh+uTPup+Rx1vn9CObJhUV+e7q9CExUWeoEudzOJ36Lbb7lTvdYLJaFdwAaSy406CGu
	qctTtGX12fNPxfpNY/WA4TTZV4PGkUTiPdPxw3413cDkhlvVD//yXrlfkRGl21iglE6vlN/NGOAfw
	JlztsJXGqqmRdzn+vVGlATC1FF5xhxUY3/5tSS05TDXW7zSpFWJb9CGz+DaKIkDQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s2sCZ-0005cD-0S; Fri, 03 May 2024 14:39:47 +0200
Message-ID: <97e7850f-4a4b-4dd8-bd18-7da6d6401831@leemhuis.info>
Date: Fri, 3 May 2024 14:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Hardik Gajjar <hgajjar@de.adit-jv.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, Ferry Toth <fntoth@gmail.com>,
 s.hauer@pengutronix.de, jonathanh@nvidia.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_linyyuan@quicinc.com,
 paul@crapouillou.net, quic_eserrao@quicinc.com, erosca@de.adit-jv.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20240417151342.GA56989@vmlxhi-118.adit-jv.com>
 <d94f37cf-8140-4f89-aa67-53f9291faff3@gmail.com>
 <5dae4b62-24d4-4942-934a-38c548a2fdbc@gmail.com>
 <20240430153243.GA129136@vmlxhi-118.adit-jv.com>
 <8041106f-0be0-4ed9-990e-1f62902b30e9@gmail.com>
 <9dab0c4f-cfae-4212-9a27-518454314eef@gmail.com>
 <20240502152916.GA7995@vmlxhi-118.adit-jv.com>
 <ZjOx5KZdmBZ0S5CD@smile.fi.intel.com>
 <20240502161652.GA8362@vmlxhi-118.adit-jv.com>
 <be13b434-9110-4333-8bd9-3ad85adfa976@leemhuis.info>
 <20240503091541.GA4478@vmlxhi-118.adit-jv.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240503091541.GA4478@vmlxhi-118.adit-jv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714739990;14cbb81c;
X-HE-SMSGID: 1s2sCZ-0005cD-0S

On 03.05.24 11:15, Hardik Gajjar wrote:
> On Fri, May 03, 2024 at 09:24:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Greg, not totally sure, but this might be something where you might need
>> to make a judgement call. See below:
>>
>> On 02.05.24 18:16, Hardik Gajjar wrote:
>>> On Thu, May 02, 2024 at 06:31:48PM +0300, Andy Shevchenko wrote:
>>>> On Thu, May 02, 2024 at 05:29:16PM +0200, Hardik Gajjar wrote:
>>>>> On Tue, Apr 30, 2024 at 11:12:17PM +0200, Ferry Toth wrote:
>>>>>> Op 30-04-2024 om 21:40 schreef Ferry Toth:
>>>>>>> Op 30-04-2024 om 17:32 schreef Hardik Gajjar:
>>>>>>>> On Sun, Apr 28, 2024 at 11:07:36PM +0200, Ferry Toth wrote:
>>>>>>>>> Op 25-04-2024 om 23:27 schreef Ferry Toth:
>>>>>>>>>> Op 17-04-2024 om 17:13 schreef Hardik Gajjar:
>>>>>>>>>>> On Tue, Apr 16, 2024 at 04:48:32PM +0300, Andy Shevchenko wrote:
>>>>>>>>>>>> On Thu, Apr 11, 2024 at 10:52:36PM +0200, Ferry Toth wrote:
>>>>>>>>>>>>> Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
>>>>>>>>>>>>>> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
>>>>>>>>>>>>>>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>>>>>>>>>>>>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
>>>>
>>
>>>> ...
>>>>
>>>>>>>>>>>>>>>>> Exactly. And this didn't happen before the 2 patches.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> To be precise: /sys/class/net/usb0 is not
>>>>>>>>>>>>>>>>> removed and it is a link, the link
>>>>>>>>>>>>>>>>> target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0
>>>>>>>>>>>>>>>>> no
>>>>>>>>>>>>>>>>> longer exists
>>>>>>>>>>>>>>> So, it means that the /sys/class/net/usb0 is
>>>>>>>>>>>>>>> present, but the symlink is
>>>>>>>>>>>>>>> broken. In that case, the dwc3 driver should
>>>>>>>>>>>>>>> recreate the device, and the
>>>>>>>>>>>>>>> symlink should become active again
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, on first enabling gadget (when device mode is activated):
>>>>>>>>>>>>>
>>>>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>>>>> driver  net  power  sound  subsystem  suspended  uevent
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then switching to host mode:
>>>>>>>>>>>>>
>>>>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>>>>> ls: cannot access
>>>>>>>>>>>>> '/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/':
>>>>>>>>>>>>> No such file
>>>>>>>>>>>>> or directory
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then back to device mode:
>>>>>>>>>>>>>
>>>>>>>>>>>>> root@yuna:~# ls
>>>>>>>>>>>>> /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
>>>>>>>>>>>>> driver  power  sound  subsystem  suspended  uevent
>>>>>>>>>>>>>
>>>>>>>>>>>>> net is missing. But, network functions:
>>>>>>>>>>>>>
>>>>>>>>>>>>> root@yuna:~# ping 10.42.0.1
>>>>>>>>>>>>> PING 10.42.0.1 (10.42.0.1): 56 data bytes
>>>>>>>>>>>>>
>>>>>>>>>>>>> Mass storage device is created and removed each time as expected.
>>>>>>>>>>>>
>>>>>>>>>>>> So, what's the conclusion? Shall we move towards revert of those
>>>>>>>>>>>> two changes?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> As promised, I have the tested the this patch with the dwc3 gadget.
>>>>>>>>>>> I could not reproduce
>>>>>>>>>>> the issue.
>>>>>>>>>>>
>>>>>>>>>>> I can see the usb0 exist all the time and accessible regardless of
>>>>>>>>>>> the role switching of the USB mode (peripheral <-> host)
>>>>>>>>>>>
>>>>>>>>>>> Following are the logs:
>>>>>>>>>>> //Host to device
>>>>>>>>>>>
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "peripheral"
>>>>>>>>>>>> mode
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>>>>>> a800000.dwc3/gadget/net/
>>>>>>>>>>> usb0
>>>>>>>>>>>
>>>>>>>>>>> //device to host
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # echo "host" > mode
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ls
>>>>>>>>>>> a800000.dwc3/gadget/net/
>>>>>>>>>>> usb0
>>>>>>>>>>
>>>>>>>>>> That is weird. When I switch to host mode (using the physical switch),
>>>>>>>>>> the whole gadget directory is removed (now testing 6.9.0-rc5)
>>>>>>>>>>
>>>>>>>>>> Switching back to device mode, that gadget directory is recreated. And
>>>>>>>>>> gadget/sound as well, but not gadget/net.
>>>>>>>>>>
>>>>>>>>>>> s a800000.dwc3/gadget/net/usb0
>>>>>>>>>>> <
>>>>>>>>>>> addr_assign_type    duplex             phys_port_name
>>>>>>>>>>> addr_len            flags              phys_switch_id
>>>>>>>>>>> address             gro_flush_timeout  power
>>>>>>>>>>> broadcast           ifalias            proto_down
>>>>>>>>>>> carrier             ifindex            queues
>>>>>>>>>>> carrier_changes     iflink             speed
>>>>>>>>>>> carrier_down_count  link_mode          statistics
>>>>>>>>>>> carrier_up_count    mtu                subsystem
>>>>>>>>>>> dev_id              name_assign_type   tx_queue_len
>>>>>>>>>>> dev_port            netdev_group       type
>>>>>>>>>>> device              operstate          uevent
>>>>>>>>>>> dormant             phys_port_id       waiting_for_supplier
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb # ifconfig -a usb0
>>>>>>>>>>> usb0      Link encap:Ethernet  HWaddr 3a:8b:63:97:1a:9a
>>>>>>>>>>>             BROADCAST MULTICAST  MTU:1500  Metric:1
>>>>>>>>>>>             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>>>>>>>>>>             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>>>>>>>>>>             collisions:0 txqueuelen:1000
>>>>>>>>>>>             RX bytes:0 TX bytes:0
>>>>>>>>>>>
>>>>>>>>>>> console:/sys/bus/platform/devices/a800000.ssusb #
>>>>>>>>>>>
>>>>>>>>>>> I strongly advise against reverting the patch solely based on the
>>>>>>>>>>> observed issue of removing the /sys/class/net/usb0 directory while
>>>>>>>>>>> the usb0 interface remains available.
>>>>>>>>>>
>>>>>>>>>> There's more to it. I also mentioned that switching the role or
>>>>>>>>>> unplugging the cable leaves the usb0 connection.
>>>>>>>>>>
>>>>>>>>>> I have while in host mode:
>>>>>>>>>> root@yuna:~# ifconfig -a usb0
>>>>>>>>>> usb0: flags=-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
>>>>>>>>>>           inet 10.42.0.221  netmask 255.255.255.0  broadcast
>>>>>>>>>> 10.42.0.255
>>>>>>>>>>           inet6 fe80::a8bb:ccff:fedd:eef1  prefixlen 64 
>>>>>>>>>> scopeid 0x20<link>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> You don't see that because you didn't create a connection at all.
>>>>>>>>>>
>>>>>>>>>>> Instead, I recommend enabling FTRACE to trace the functions involved
>>>>>>>>>>> and identify which faulty call is responsible for removing usb0.
>>>>>>>>>>
>>>>>>>>>> Switching from device -> host -> device:
>>>>>>>>>>
>>>>>>>>>> root@yuna:~# trace-cmd record -p function_graph -l *gether_*
>>>>>>>>>>     plugin 'function_graph'
>>>>>>>>>> Hit Ctrl^C to stop recording
>>>>>>>>>> ^CCPU0 data recorded at offset=0x1c8000
>>>>>>>>>>       188 bytes in size (4096 uncompressed)
>>>>>>>>>> CPU1 data recorded at offset=0x1c9000
>>>>>>>>>>       0 bytes in size (0 uncompressed)
>>>>>>>>>> root@yuna:~# trace-cmd report
>>>>>>>>>> cpus=2
>>>>>>>>>>        irq/68-dwc3-725   [000]   514.575337: funcgraph_entry:      #
>>>>>>>>>> 2079.480 us |  gether_disconnect();
>>>>>>>>>>        irq/68-dwc3-946   [000]   524.263731: funcgraph_entry:      +
>>>>>>>>>> 11.640 us  |  gether_disconnect();
>>>>>>>>>>        irq/68-dwc3-946   [000]   524.263743: funcgraph_entry:      !
>>>>>>>>>> 116.520 us |  gether_connect();
>>>>>>>>>>        irq/68-dwc3-946   [000]   524.268029: funcgraph_entry:      #
>>>>>>>>>> 2057.260 us |  gether_disconnect();
>>>>>>>>>>        irq/68-dwc3-946   [000]   524.270089: funcgraph_entry:      !
>>>>>>>>>> 109.000 us |  gether_connect();
>>>>>>>>>
>>>>>>>>> I tried to get a more useful trace:
>>>>>>>>> root@yuna:/sys/kernel/tracing# echo 'gether_*' > set_ftrace_filter
>>>>>>>>> root@yuna:/sys/kernel/tracing# echo 'eem_*' >> set_ftrace_filter
>>>>>>>>> root@yuna:/sys/kernel/tracing# echo function > current_tracer
>>>>>>>>> root@yuna:/sys/kernel/tracing# echo 'reset_config' >> set_ftrace_filter
>>>>>>>>> -> switch to host mode then back to device
>>>>>>>>> root@yuna:/sys/kernel/tracing# cat trace
>>>>>>>>> # tracer: function
>>>>>>>>> #
>>>>>>>>> # entries-in-buffer/entries-written: 53/53   #P:2
>>>>>>>>> #
>>>>>>>>> #                                _-----=> irqs-off/BH-disabled
>>>>>>>>> #                               / _----=> need-resched
>>>>>>>>> #                              | / _---=> hardirq/softirq
>>>>>>>>> #                              || / _--=> preempt-depth
>>>>>>>>> #                              ||| / _-=> migrate-disable
>>>>>>>>> #                              |||| /     delay
>>>>>>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>>>>>> #              | |         |   |||||     |         |
>>>>>>>>>       irq/68-dwc3-523     [000] D..3.   133.990254: reset_config
>>>>>>>>> <-__composite_disconnect
>>>>>>>>>       irq/68-dwc3-523     [000] D..3.   133.992274: eem_disable
>>>>>>>>> <-reset_config
>>>>>>>>>       irq/68-dwc3-523     [000] D..3.   133.992276: gether_disconnect
>>>>>>>>> <-reset_config
>>>>>>>>>       kworker/1:3-443     [001] ...1.   134.022453: eem_unbind
>>>>>>>>> <-purge_configs_funcs
>>>>>>>>>
>>>>>>>>> -> to device mode
>>>>>>>>>
>>>>>>>>>       kworker/1:3-443     [001] ...1.   148.630773: eem_bind
>>>>>>>>> <-usb_add_function
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.155209: eem_set_alt
>>>>>>>>> <-composite_setup
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.155215: gether_disconnect
>>>>>>>>> <-eem_set_alt
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.155220: gether_connect
>>>>>>>>> <-eem_set_alt
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.157287: eem_set_alt
>>>>>>>>> <-composite_setup
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.157292: gether_disconnect
>>>>>>>>> <-eem_set_alt
>>>>>>>>>       irq/68-dwc3-734     [000] D..3.   149.159338: gether_connect
>>>>>>>>> <-eem_set_alt
>>>>>>>>>       irq/68-dwc3-734     [000] D..2.   149.239625: eem_unwrap
>>>>>>>>> <-rx_complete
>>>>>>>>> ...
>>>>>>>>>
>>>>>>>>> I don't know where to look exactly. Any hints?
>>>>>>>>
>>>>>>>> do you see anything related to gether_cleanup() after eem_unbind() ?
>>>>>>>
>>>>>>> Nope. It's a pitty that the trace formatting got messed up above. But as
>>>>>>> you can see I traced gether_* and eem_*. After eem_unbind no traced
>>>>>>> function is called, until I flip the switch to device mode.
>>>>>>> The ... at the end is where I cut uninteresting eem_unwrap <-rx_complete
>>>>>>> and eem_wrap <-eth_start_xmit lines.
>>>>>>>
>>>>>>>> If not then, you may try to enable tracing of TCP/IP stack and
>>>>>>>> network side to check who deleting the sysfs entry
>>>>>>>
>>>>>>> Yes, that's a vast amount of functions to trace. And I don't see how
>>>>>>> that would be related to the patch we're discussing here. I was hoping
>>>>>>> for a little more targeted hint.
>>>>>>
>>>>>> Now filtering 'gether_*', 'eem_*', '*configfs_*', 'composite_*', 'usb_fun*',
>>>>>> 'reset_config' and 'device_remove_file' leads me to:
>>>>>>
>>>>>> TIMESTAMP  FUNCTION
>>>>>>    |         |
>>>>>>   49.952477: eem_wrap <-eth_start_xmit
>>>>>>   55.072455: eem_wrap <-eth_start_xmit
>>>>>>   55.072621: eem_unwrap <-rx_complete
>>>>>>   59.011540: configfs_composite_reset <-usb_gadget_udc_reset
>>>>>>   59.011545: composite_reset <-configfs_composite_reset
>>>>>>   59.011548: reset_config <-__composite_disconnect
>>>>>>   59.013565: eem_disable <-reset_config
>>>>>>   59.013567: gether_disconnect <-reset_config
>>>>>>   59.049560: device_remove_file <-device_remove
>>>>>>   59.051185: configfs_composite_disconnect <-usb_gadget_disco
>>>>>>   59.051189: composite_disconnect <-configfs_composite_discon
>>>>>>   59.051195: configfs_composite_unbind <-gadget_unbind_driver
>>>>>>   59.052519: eem_unbind <-purge_configs_funcs
>>>>>>   59.052529: composite_dev_cleanup <-configfs_composite_unbin
>>>>>>   59.052537: device_remove_file <-composite_dev_cleanup
>>>>>>
>>>>>> device_remove_file gets called twice, once by device_remove after
>>>>>> gether_disconnect (that the one). The 2nd time by composite_dev_cleanup
>>>>>> (removing the gadget)
>>>>>
>>>>> I believe that the device_remove_file function is only removing
>>>>> suspend-specific attributes, not the complete gadget.  Typically, when you
>>>>> perform the role switch, the Gadget start/stop function in your UDC driver is
>>>>> called. These functions should not delete the gadget
>>>>>
>>>>> To investigate further, could you please enable the DWC3 functions in ftrace
>>>>> and check who is removing the gadget?  I can also enable this on my system
>>>>> and compare the logs with yours, but I will be in PI planning for 1.5 weeks
>>>>> and may not be able to provide immediate support.
>>>>
>>>> Since we are almost at -rc7, I propose to revert and try again next cycle.
>>>
>>> Why? There is no problem with this patch!
>>>
>>> I don't know why you are so excited to revert the patch instead of
>>> investigating the original issue. Even though I have proved that the
>>> problem is caused by usb0 being removed just by role-switching the
>>> port by the UDC driver, this behavior is incorrect.
>>>
>>> There is no behavior in the Linux kernel that keeps the network
>>> interface and removes the related sysfs entry. THIS IS WRONG and has
>>> been FIXED without reverting any mainline patch.
>>>
>>> Please don't encourage reverting any mainstream patches to avoid
>>> investigating a (probably) faulty driver. This is not how the
>>> community should work.
>>
>> I only skimmed the thread and this is not my area of expertise, so
>> correct me if I'm wrong anywhere here:
>>
>> But from what I see I tend to disagree: the patch mentioned in the
>> subject apparently regressed something. This afaics was reported 16
>> weeks ago during the 6.7 cycle[1]. Due to how we apply the "no
>> regressions" rule[2] the change causing this ideally should have been
>> reverted before 6.8 was release -- it does not matter that it just
>> exposed an existing problem rooted somewhere else. That revert did not
>> happen. Then even a few more weeks went by and this is still not fixed.
>> Then I'd guess reverting this might be the right course of action to
>> motivate someone to fix the exposed problem. Unless of course we know or
>> fear that a revert causes regressions for users of 6.8.y -- is that the
>> case?
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_ZaQS5x-2DXK08Jre6I-40smile.fi.intel.com_&d=DwIDaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=QAHqX_KD5JuTUUtqftI9GSmckKDKzRyJ5qu0DT0NdpJ7Gxk6vfsvBPrBvJLM0fzb&s=HBokvujOYQdyCxk3eMV6xtwLLNdCxjsnZ4nTzbhbLXM&e=
>>
>> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.kernel.org_process_handling-2Dregressions.html&d=DwIDaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=QAHqX_KD5JuTUUtqftI9GSmckKDKzRyJ5qu0DT0NdpJ7Gxk6vfsvBPrBvJLM0fzb&s=lOh1a5Vzu2VNEaspoNgEipxRU9UDDPcibRLoOVrGbIU&e=
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__linux-2Dregtracking.leemhuis.info_about_-23tldr&d=DwIDaQ&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=QAHqX_KD5JuTUUtqftI9GSmckKDKzRyJ5qu0DT0NdpJ7Gxk6vfsvBPrBvJLM0fzb&s=MuVuulVZqYAjIqCVpNc01ve8yD6DFt2wOZEH4p9khTc&e=
>> If I did something stupid, please tell me, as explained on that page.
> 
> I understand your perspective. Do you have documentation or
> guidelines available to ensure that the existing problem is resolved
> and the correct patch is reinstated?

The second link I gave (e.g. to a rendered version of
Documentation/process/handling-regressions.rst ) has quite a few quotes
from Linus which iirc should support this. Apart from this there is only
the lore archive and the the git log afaik.

> As far as I know, the issue is currently only reproducible by the
> reporter. I also have a similar setup, but I have not been able to
> reproduce the issue myself (please refer to our previous
> discussions). This discrepancy could be due to some OEM
> modifications.

To the board/machine in question or the kernel used beforehand? If the
former: that does not matter much. In the latter: than of course it's
not a regression.

> If the problem is only reproducible by the reporter, how do we
> motivate others to support and upstream the fix?

The general idea afaics is: there was someone that for some reason was
motivated to bring in the patch that caused the regression (indirectly
in this case); with a bit of luck that someone after the revert wants it
to be included again and thus is motivated to fix it (or search for the
underlying issue and fix that in this case).

Of course that does not always work out. OTOH with a bit of luck the
other developers will help with that, too.

And there are gray areas, but they are not that big. Not sure if this is
one, that in the end is up to Greg or Linus to decide.

> Isn't it
> demotivating to revert the correct patch and retain the wrong
> behavior of the driver?

Sure, but I'd say it's even more demotivating if things break for users
when they update their kernel, as then they won't update the next time
and stay on old versions with bugs and vulnerabilities. As that's afaics
what Linus wants to prevent -- and why he made the rule and established
current practices.

> Additionally, is it possible to determine how many correct patches
> have been reverted in the past to address this particular problem?

git log?

> Please correct me if I am wrong ?

HTH, Ciao, Thorsten

>>> Also, I'm a bit wondering: the patch has been in the mainline for
>>> some time, and we haven't had any issues except this one, which is
>>> due to the wrong behavior of the UDC driver.
>>>>
>>>>> Additionally, please check if you have any customized DWC patches that may be causing this problem.
>>>>>
>>>>>>> You may recall the whole issue did not occur before this patch got applied.
>>>>>>>
>>>>>>>>>>> According to current kernel architecture of u_ether driver, only
>>>>>>>>>>> gether_cleanup should remove the usb0 interface along with its
>>>>>>>>>>> kobject and sysfs interface.
>>>>>>>>>>> I suggest sharing the analysis here to understand why this practice
>>>>>>>>>>> is not followed in your use case or driver ?
>>>>>>>>>>
>>>>>>>>>> Yes, I'll try to trace where that happens.
>>>>>>>>>>
>>>>>>>>>> Nevertheless, the disappearance of the net/usb0 directory seems
>>>>>>>>>> harmless? But the usb: net device remaining after disconnect or role
>>>>>>>>>> switch is not good, as the route remains.
>>>>>>>>>>
>>>>>>>>>> May be they are 2 separate problems. Could you try to reproduce what
>>>>>>>>>> happens if you make eem connection and then unplug?
>>>>>>>>>>
>>>>>>>>>>> I am curious why the driver was developed without adhering to the
>>>>>>>>>>> kernel's gadget architecture.
>>>>>>>>>
>>>>>>>>> I don't know what you mean here. Which driver do you mean?
>>>>>>>>>
>>>>>>>>>>>>>>> I have the dwc3 IP base usb controller, Let me check
>>>>>>>>>>>>>>> with this patch and
>>>>>>>>>>>>>>> share result here.  May be we need some fix in dwc3
>>>>>>>>>>>>> Would have been nice if someone could test on other
>>>>>>>>>>>>> controller as well. But
>>>>>>>>>>>>> another instance of dwc3 is also very welcome.
>>>>>>>>>>>>>> It's quite possible, please test on your side.
>>>>>>>>>>>>>> We are happy to test any fixes if you come up with.
>>>>
>>>> -- 
>>>> With Best Regards,
>>>> Andy Shevchenko
>>>>
>>>>
> 
> 

