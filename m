Return-Path: <linux-kernel+bounces-95324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B3874C37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8793F1C23C38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD685637;
	Thu,  7 Mar 2024 10:20:44 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7B85272;
	Thu,  7 Mar 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806844; cv=none; b=RbzLP2xdifsBmz5F+ZReVC6A//XsRmMiMNk5Pa30rM4UusNiGPNdl4g4vo7vGMFMy9g4C7UseSyz8k3AcTHDMZ/vJHyI1CZ87buRt16V1X8Qj5PqFDBd2eFGdrxVI/odklCxmzptfTtuu49kkd9sXOVtLKhWWIvxb96p8IrDuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806844; c=relaxed/simple;
	bh=IwmwS9iHKoQg6iBFCTR2bwm7V64Cv5p4XcaV5FRO81Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwTEaC+yib3bLRnIy+XR4GaLSthjVvQNNcT+BigrKFgA9D0tfBqhx/w5i2Lb+NJNhqJO/zKmTVpebRNQ0w6heeVhbOhGwXy08AMLKu4KUJ6BIAu7nOdWR8dpXL+H09NmuPX33m44OpZ1l1H8clPU/5S4Skre6ZvYwjbWbMGMDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riASr-00DtMT-Ik; Thu, 07 Mar 2024 09:55:02 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riASn-002dNO-0Z;
	Thu, 07 Mar 2024 09:55:01 +0000
Message-ID: <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
Date: Thu, 7 Mar 2024 09:54:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Content-Language: en-US
To: Waqar Hameed <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@axis.com, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <pndzfvbibgm.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 06/03/2024 16:14, Waqar Hameed wrote:
> On Tue, Mar 05, 2024 at 23:11 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Vincent,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
>> commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
>> date:   6 months ago
>> config: um-randconfig-r111-20240305 (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202403052336.y6DkUd8a-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>>>> pcap-dbus.o:(.text+0x244ff): undefined reference to `dbus_message_demarshal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24515): undefined reference to `dbus_connection_send'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2451e): undefined reference to `dbus_connection_flush'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24526): undefined reference to `dbus_message_unref'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24574): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>>>> pcap-dbus.o:(.text+0x245c0): undefined reference to `dbus_connection_pop_message'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245e2): undefined reference to `dbus_connection_pop_message'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245f8): undefined reference to `dbus_connection_read_write'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24662): undefined reference to `dbus_message_is_signal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2467e): undefined reference to `dbus_message_marshal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x246e6): undefined reference to `dbus_free'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>>>> pcap-dbus.o:(.text+0x2474c): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>>>> pcap-dbus.o:(.text+0x247f6): undefined reference to `dbus_connection_open'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2480e): undefined reference to `dbus_bus_register'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x248fc): undefined reference to `dbus_bus_add_match'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24904): undefined reference to `dbus_error_is_set'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2494b): undefined reference to `dbus_bus_get'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x2497c): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x2498d): undefined reference to `dbus_bus_add_match'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24995): undefined reference to `dbus_error_is_set'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x249ce): undefined reference to `dbus_error_free'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x249da): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a06): undefined reference to `dbus_bus_get'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a42): undefined reference to `dbus_error_free'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a55): undefined reference to `dbus_connection_set_max_received_size'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a66): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24adc): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24b1a): undefined reference to `dbus_error_free'
>>     collect2: error: ld returned 1 exit status
> 
> Hi Ingo!
> 
> This error seems to be unrelated to the reported commit 10f4c9b9a33b
> ("x86/asm: Fix build of UML with KASAN"). The root cause seems to be the
> option `CONFIG_UML_NET_PCAP` (which is deprecated, as stated in
> `arch/um/drivers/Kconfig`), which tries to build `pcap.o`.
> 
> In the Makefile, one can find
> 
>    LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
>    
> and at the top the very old comment
> 
>   # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
>   # in to pcap.o
> 
> `libpcap` is indeed the one referencing these symbols (that can be found
> in `libdbus-1` and `libsystemd`). I'm guessing we should just ignore
> this report, right? (Can it even be disabled somehow?)
> 
> Thank you
> Waqar Hameed
> 
> P.S
> Vincent has left the company and has therefore been removed from
> the CC list.
> D.S
>


PCAP is not feasible to incorporate into the build system at present.
It has grown all kinds of warts over the years and brings a lot of dependencies.
IMHO we should remove it from the tree. It has reached a point where it cannot
be built on a modern system.

The users who need the same functionality can produce a bpf filter using tcpdump
and load it as "firmware" into the vector/raw driver.

I am working on a pure python bpf compiler which takes the same syntax as PCAP.
It is showing signs of life and it can do some of the simpler use cases. Once
that is ready, it should be possible to use that instead of pcap/tcpdump.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

