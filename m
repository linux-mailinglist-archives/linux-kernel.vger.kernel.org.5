Return-Path: <linux-kernel+bounces-129865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54467897169
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2945283456
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793421487F3;
	Wed,  3 Apr 2024 13:43:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF114830F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151825; cv=none; b=ThggTGGoqnOgGGHp4VveTbOVqJa30CMnuGMRoq2KiUH/F4Y57AHp1BWQLQEkAjhHaGXYvVs0LIwneqNTq35NWSU5jSZGlIL948Jb3HBMNLa+rJcRnxlugqkcoTq5+cZddKEH6B9RLTyanNC0l2/ROVM9DlBWISKyKeslQM8GEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151825; c=relaxed/simple;
	bh=pmjTyGe0FsdT8oYkfLE7cOWfangICUybcbS8VHpZY/c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9FhJMcyhajOachIY7yXnoY+z9TRPFxo3yN7FZP2uL6t/p1JfJAbKEF9Aaz4PznpShE+p4ZRqCmjUhfjFwD9OYuiKHpUVAhegPoQa5YOAjDznqS62F0E9adFFsTiJKiGYzVqOzSwzhAm/zIc+qQ7+/AlP997OATsRHNv6PWiQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8mC20zpGz67N4y;
	Wed,  3 Apr 2024 21:42:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 99097140CB9;
	Wed,  3 Apr 2024 21:43:38 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 14:43:38 +0100
Date: Wed, 3 Apr 2024 14:43:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Alexey Dobriyan <adobriyan@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <20240403144337.00005060@huawei.com>
In-Reply-To: <7c5dd81f-46ee-43a7-8359-f713a027386d@roeck-us.net>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
	<11d7a34f-909b-4923-a15f-d32015463c35@p183>
	<20240327181053.0000481d@Huawei.com>
	<7c5dd81f-46ee-43a7-8359-f713a027386d@roeck-us.net>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 27 Mar 2024 11:36:28 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Mar 27, 2024 at 06:10:53PM +0000, Jonathan Cameron wrote:
> > On Thu, 22 Feb 2024 14:19:35 +0300
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >   
> > > cpu_possible_mask is by definition "cpus which could be hotplugged without
> > > reboot". It's a property which is fixed after kernel enumerates hardware
> > > configuration.
> > > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>  
> > 
> > Causes a crash in this path (via CPU HP testing on qemu)
> > Pretending to be an AMD Genoa, but I doubt that matters.
> >   
> 
> Can you send me the configuration, qemu command line, and commands
> executed ? I'd like to add that to my test setup if possible.
> 
> Thanks,
> Guenter

Hi Guenter,

Great to get some regular tests running on this.

I haven't minimized this that much, so probably don't need most of this
setup.

qemu-system-x86_64 -M q35,cxl=on,sata=off,smbus=off
 -m 12g -cpu EPYC-Genoa -smp 2,maxcpus=4,sockets=2 \
 -kernel bzImage \
 -drive if=none,file=/mnt/d/images-x86/full2.qcow2,format=qcow2,id=hd \
 -device ioh3420,id=root_port1 \
 -device nvme,serial=deadbeef,drive=hd \
 -nographic -no-reboot -append 'earlycon console=ttyS0 root=/dev/nvme0n1p3 fsck.mode=skip tp_printk maxcpus=4' \
 -monitor telnet:127.0.0.1:1235,server,nowait \
 -object memory-backend-ram,size=12G,id=mem0 \
 -numa node,nodeid=0,memdev=mem0 \
 -numa node,nodeid=1 \
 -numa cpu,node-id=0,socket-id=0 \
 -numa cpu,node-id=0,socket-id=0 \
 -numa cpu,node-id=1,socket-id=1 \
 -numa cpu,node-id=1,socket-id=1

telnet 1235
(qemu) device_add EPYC-Genoa-x86_64-cpu,node-id=1,socket-id=1,core-id=0,thread-id=0 

Jonathan

