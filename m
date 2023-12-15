Return-Path: <linux-kernel+bounces-681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B5B81446D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D5284397
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54416418;
	Fri, 15 Dec 2023 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV/Gc0uV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50C171BB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702632567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlzH05gePiJDbwDlpysWL7+Cb3sV3fowzqJkjYEHj9E=;
	b=HV/Gc0uV4pWpd0wxpbsA9WuopUZiEbItnH7RqHh2rs9STSbIdCQRhH58oU8m3haxlr82/i
	HTYUPGt9EQzmUSM4YYQjC3NfmZSWfRG5wxUlNXxhxFcZLiwgxd4WXEvbxffcsSXeTJkTZ2
	1REmzm890/kRV+13iA5BMqaODlybJtw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-XnYAyN0TMQacRQWoBteFBg-1; Fri, 15 Dec 2023 04:29:25 -0500
X-MC-Unique: XnYAyN0TMQacRQWoBteFBg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1bd7a5931eso28326766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702632563; x=1703237363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlzH05gePiJDbwDlpysWL7+Cb3sV3fowzqJkjYEHj9E=;
        b=ngdomRkNuVzWakA3MGnxKUkJpQs9zj2lx00hoWnEtL2BbZHShUMyJoc4xQD6cb+rB4
         7EX9WylnSFuO5XpfXCdc3DSb+VOMx5q9sWjpPlHPZz7BaTfVFP5PxkrQXaJhnM3rl+Y5
         S/7zDilHKlU7aKLjEUsrmkWxj/btEBw8URw0jWurIt0iATgDLqyRn+0GnW4ac5pGnpW/
         8Q8UW5eKnR++6fFc1GDt75e/+iDjnzA4BntQul80QYAoQMOui7yOWIXEAFmy947U4KRH
         zHT4114eoOkwCy1Q8zu679b6XaMLGLNmZDwYEIH3iG1mSdDhfcOVTCQelQBogEH3pPbD
         bY9Q==
X-Gm-Message-State: AOJu0YwwmwYVWklcm5BT4RxpeZtbnblWfOCCZVXAoP9O86Pb6fjKV8WE
	xMG3h8oquef8aPPFCnxQ6qPhouA69J9nmQBsQH2uiFP+MvNicZooux1JZIuvbka8lKBDhDuao6A
	QlQ8OFkVw+rjaxhDq4+r8O/TspNlwKxTg
X-Received: by 2002:a17:906:6c81:b0:a19:a19a:eaa7 with SMTP id s1-20020a1709066c8100b00a19a19aeaa7mr5327688ejr.96.1702632562860;
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuUTG6manj1CqrmhK8aaase4KkhFf5qY+v+gbegmurj0X846CD8zybpKetqHCeOybOHfnFtQ==
X-Received: by 2002:a17:906:6c81:b0:a19:a19a:eaa7 with SMTP id s1-20020a1709066c8100b00a19a19aeaa7mr5327686ejr.96.1702632562520;
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a1dbda310f4sm10530551ejc.158.2023.12.15.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:29:22 -0800 (PST)
Date: Fri, 15 Dec 2023 10:29:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Woithe <jwoithe@just42.net>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <20231215102921.587a9857@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
	<20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
	<ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 08:43:27 +1030
Jonathan Woithe <jwoithe@just42.net> wrote:

> On Thu, Dec 14, 2023 at 02:32:05PM +0100, Igor Mammedov wrote:
> > On Thu, 14 Dec 2023 11:58:20 +1030 Jonathan Woithe wrote:  
> > > 
> > > Following an update from 5.15.72 to 5.15.139 on one of my machines, the  
> > 
> > looks like you are running downstream kernel, can you file bug report
> > with distro that you use (with a link posed here as well).  
> 
> I am running Slackware64 15.0.  The kernels supplied by that distribution
> are unmodified kernel.org kernels.
> 
> > For now offending patches are being reverted, so downstream bug will help
> > with tracking it and reverting it there.   
> 
> The patches will be reverted in Slackware as a matter of course when a
> kernel.org "-stable" kernel with the fix is adopted.  Slackware does not
> apply any patches to kernel.org kernels.  Nevertheless, I will raise a post
> in the forum, hopefully later today.
> 
> > > console froze part way through the boot process.  The machine still managed
> > > to boot: it could be reached via the network and a keyboard-initiated
> > > shutdown would do the right thing.  The problem was that the screen remained
> > > static the whole time: the X login did not appear.  Only a reboot would
> > > restore the display's functionality.
> > > 
> > > Comparing boot logs between these two kernels showed that 5.15.139 reported
> > > the following messages not seen with 5.15.72:
> > > 
> > >     thunderbolt 0000:04:00.0: interrupt for TX ring 0 is already enabled
> > >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > > 
> > >     thunderbolt 0000:04:00.0: interrupt for RX ring 0 is already enabled
> > >     WARNING: CPU: 0 PID: 713 at drivers/thunderbolt/nhi.c:139 ring_interrupt_active+0x218/0x270 [thunderbolt]
> > > 
> > >     radeon 0000:4b:00.0: Fatal error during GPU init
> > >     radeon: probe of 0000:4b:00.0 failed with error -12
> > > 
> > > The fatal error during GPU initialisation would be the reason behind the
> > > frozen screen.  I don't know if the thunderbolt warnings are significant.
> > > 
> > > A git bisect resulted in the following report:
> > > 
> > >     d9ce077f8b1f731407e6b612b03bba464fd18d9b is the first bad commit
> > >     commit d9ce077f8b1f731407e6b612b03bba464fd18d9b
> > >     Author: Igor Mammedov <imammedo@redhat.com>
> > >     Date:   Mon Apr 24 21:15:57 2023 +0200
> > > 
> > >         PCI: acpiphp: Reassign resources on bridge if necessary
> > >     
> > >         [ Upstream commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 ]
> > > 
> > > It's taken me a while to work through the bisect process due to limited
> > > access to the machine concerned.  I see that in the last few days there have
> > > been other reports associated with this commit.  The symptoms on my machine
> > > are different to the other reporters.  In particular, I note that I'm
> > > running the Linux kernel on bare metal.
> > > 
> > > For what it's worth, I also experienced the same problem when I tested 6.6.4
> > > last week (the most recent kernel at the time of testing).
> > > 
> > > The output of lspci is given at the end of this post[1].  The CPU is an
> > > "Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz" which is not overclocked.  Please
> > > let me know if you'd like more information about the affected machine.  I
> > > can also perform additional tests if required, although for various reasons
> > > these can only be done on Thursdays at present.

can you provide 'lspci -tv' output as well and machine model for the record?

> > > The kernel configuration file can easily be supplied if that would be
> > > useful.  
> > 
> > full dmesg log and used config might help down the road (preferably with current
> > upstream kernel), as I will be looking into fixing related issues.
> > 
> > Perhaps a better way for taking this issue and collecting logs, will be
> > opening a separate bug at https://bugzilla.kernel.org (pls CC me as well)  
> 
> Sure, will do.  I'll be able to get the dmesg log from my earlier tests and
> config easily enough.  Testing with another kernel will have to wait until
> next Thursday as that is when I'll next have physical access to the machine.
> 
> Which upstream kernel would you like me to test with: the latest "-stable",
> or the most recent release?

current master branch that still has offending patches would do
(or any recent one with specifying commit id)

Also add:

dyndbg="file drivers/pci/access.c +p; file drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p" ignore_loglevel

to kernel command line to get more data from PCI/acpiphp enumeration process
 
> Regards
>   jonathan
> 
> > > [1] lspci output



> > > 
> > > 00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2 (rev 02)
> > > 00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > > 00:01.1 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 1 (rev 02)
> > > 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI Express Root Port 3 (rev 02)
> > > 00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Address Map, VTd_Misc, System Management (rev 02)
> > > 00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Hot Plug (rev 02)
> > > 00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 RAS, Control Status and Global Errors (rev 02)
> > > 00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series chipset SPSR (rev 05)
> > > 00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB xHCI Host Controller (rev 05)
> > > 00:16.0 Communication controller: Intel Corporation C610/X99 series chipset MEI Controller #1 (rev 05)
> > > 00:19.0 Ethernet controller: Intel Corporation Ethernet Connection (2) I218-V (rev 05)
> > > 00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #2 (rev 05)
> > > 00:1b.0 Audio device: Intel Corporation C610/X99 series chipset HD Audio Controller (rev 05)
> > > 00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #1 (rev d5)
> > > 00:1c.3 PCI bridge: Intel Corporation C610/X99 series chipset PCI Express Root Port #4 (rev d5)
> > > 00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB Enhanced Host Controller #1 (rev 05)
> > > 00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC Controller (rev 05)
> > > 00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset 6-Port SATA Controller [AHCI mode] (rev 05)
> > > 00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus Controller (rev 05)
> > > 02:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:00.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:01.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:02.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 03:04.0 PCI bridge: Intel Corporation DSL6540 Thunderbolt 3 Bridge [Alpine Ridge 4C 2015]
> > > 04:00.0 System peripheral: Intel Corporation DSL6540 Thunderbolt 3 NHI [Alpine Ridge 4C 2015]
> > > 49:00.0 USB controller: Intel Corporation DSL6540 USB 3.1 Controller [Alpine Ridge]
> > > 4b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
> > > 4b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
> > > 4d:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> > > ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
> > > ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0c.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Unicast Registers (rev 02)
> > > ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > > ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Buffered Ring Agent (rev 02)
> > > ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 System Address Decoder & Broadcast Registers (rev 02)
> > > ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > > ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCIe Ring Interface (rev 02)
> > > ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
> > > ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > > ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Home Agent 0 (rev 02)
> > > ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:13.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
> > > ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 0/1 Broadcast (rev 02)
> > > ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > > ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
> > > ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
> > > ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
> > > ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
> > > ff:14.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 0 & 1 (rev 02)
> > > ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
> > > ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
> > > ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
> > > ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
> > > ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Target Address, Thermal & RAS Registers (rev 02)
> > > ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Channel 2/3 Broadcast (rev 02)
> > > ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO Global Broadcast (rev 02)
> > > ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
> > > ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DDRIO (VMSE) 2 & 3 (rev 02)
> > > ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 Power Control Unit (rev 02)
> > > ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)
> > > ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 VCU (rev 02)  
> 


