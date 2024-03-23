Return-Path: <linux-kernel+bounces-112479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A4887A53
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD6BB214F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A13A29B;
	Sat, 23 Mar 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="VY0sWCru";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="s81GrUQe"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9305CB5;
	Sat, 23 Mar 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226436; cv=none; b=MhYb7pOviimVJ7INgdj0fck5YeFhcM1KHsIG/0RquopL7xc/1KSqIss+W/3aBO4iks7d6trCh6E2Jk6SeJi4ZG95X+HNxkgC5dLah6Y9D9s+/131EETPk8GLO7z4s38TwcHt40OEUFURRySn/JpElvKznIEPkmTJl9DazRjG2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226436; c=relaxed/simple;
	bh=dqT2p+eGF9cV0VVTE3dRZffrvfyZEaeOc2vlasLfqrw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H7wvXYb6JhwlNp7qYN7SpVssn4QZVsmaDrv9kax749h5+j2NGcbFgFyeetOHWtrtSd6KJG9tvpoUVmMrng27uSGL3aNjeZps8U4jBPZ3JxFCpTZSc55iNOdrfITFcwmikizQLkfhQRSMesIhpVZAelKqJiW+m2QcZH3qUc5Qmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=VY0sWCru; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=s81GrUQe; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C463360186;
	Sat, 23 Mar 2024 21:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711226429; bh=dqT2p+eGF9cV0VVTE3dRZffrvfyZEaeOc2vlasLfqrw=;
	h=Date:To:Cc:From:Subject:From;
	b=VY0sWCrupcanqcUIpH/W4OEHWcvCWEGbEK/kawZUO/7brqZ3HKWJU1OEUa4tCl63T
	 1tUy8CUVh+mjbjuj462k1nXzj+hZwFnJVfs2bZk7A20cN0khOEa0p0N1SPHcH0pxiT
	 fTyRIMf88HFogE6JvtFo1bOgRQMJYdDbCGIVAp8ec3XAn9ro5d8zES8Px912gG8EYh
	 lre1jKr6qF4YxMs6E4BKdhLJPDnfQQv29aMY6vOLAN2IJFI8OXqflOemiHdzw5Unq2
	 ZAx5ZpwlsdBJc3dyTzy7O4mQhbtAqFBDG/dcM3DA4ZDbuJYnR4v9nMxteY6LaS82W3
	 HsH+Ixh5t2TfQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kM9Zf_sNdsix; Sat, 23 Mar 2024 21:40:06 +0100 (CET)
Received: from [192.168.178.20] (dh207-43-75.xnet.hr [88.207.43.75])
	by domac.alu.hr (Postfix) with ESMTPSA id 909156017E;
	Sat, 23 Mar 2024 21:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711226405; bh=dqT2p+eGF9cV0VVTE3dRZffrvfyZEaeOc2vlasLfqrw=;
	h=Date:To:Cc:From:Subject:From;
	b=s81GrUQetl+qTXC02rwMKgR+8yujIDwCiaqyypahwjZKetceT4mH+C3elphDaKv/U
	 VyTHEjsfh3TMPN7vYI82djCBkBcE+U7oqDGkZEPqPbwNUsMzOYVjYwjOLyRE5yEUJN
	 Gw47IaWncVaX7YbJBxQwhdmuAHk/rFGVgi/NfJhiE8UsIqnbyuI3ZGl2OyHD1obLLR
	 mQzCZuPouRX/lV5DzXda7JIBUrKSGfkeIAXLHmBXWetlDDUinPgVxSyMAcpGxrcMut
	 Iu8XgrNvzyqR3hi6sd968Dwk06uPd/XkQuXbk8zqbder+G2LurCxighZDggIpq3T7B
	 Qsw5RROpsS8rw==
Message-ID: <391b3407-2093-4040-8bd4-61efa899e4cf@alu.unizg.hr>
Date: Sat, 23 Mar 2024 21:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Colin Ian King <colin.i.king@gmail.com>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG][KMEMLEAK] selftests/net/tcp_ao: unreferenced object (size 128)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On the Ubuntu 22.04 LTS system, with recent iproute2-next toolsvand build 6.8-11743-ga4145ce1e7bc,
kmemleak system reported the following memory leaks:

unreferenced object 0xffff9d998a7a9200 (size 128):
comm "unsigned-md5_ip", pid 884102, jiffies 4297217176
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace (crc 2a283862):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
tcp_ao_alloc_info (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:229)
tcp_ao_info_cmd.constprop.0 (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:1959)
tcp_v4_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:2038)
do_tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3655)
tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3738)
sock_common_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/core/sock.c:3727)
do_sock_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2311)
__sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:34 /home/marvin/linux/kernel/linux_torvalds/net/socket.c:2336)
__x64_sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2340)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9d9a49065b00 (size 128):
comm "unsigned-md5_ip", pid 884438, jiffies 4297233666
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace (crc 2a283862):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
tcp_ao_alloc_info (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:229)
tcp_ao_info_cmd.constprop.0 (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:1959)
tcp_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:2033)
tcp_v6_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv6/tcp_ao.c:146)
do_tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3655)
tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3738)
sock_common_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/core/sock.c:3727)
do_sock_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2311)
__sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:34 /home/marvin/linux/kernel/linux_torvalds/net/socket.c:2336)
__x64_sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2340)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9d9a8c98fb00 (size 128):
comm "unsigned-md5_ip", pid 2063902, jiffies 4321736387
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace (crc 2a283862):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
tcp_ao_alloc_info (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:229)
tcp_ao_info_cmd.constprop.0 (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:1959)
tcp_v4_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:2038)
do_tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3655)
tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3738)
sock_common_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/core/sock.c:3727)
do_sock_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2311)
__sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:34 /home/marvin/linux/kernel/linux_torvalds/net/socket.c:2336)
__x64_sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2340)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)
unreferenced object 0xffff9d9a49efdd00 (size 128):
comm "unsigned-md5_ip", pid 2064231, jiffies 4321752509
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace (crc 2a283862):
kmemleak_alloc (/home/marvin/linux/kernel/linux_torvalds/mm/kmemleak.c:1045)
kmalloc_trace (/home/marvin/linux/kernel/linux_torvalds/./include/linux/kmemleak.h:42 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3802 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3845 /home/marvin/linux/kernel/linux_torvalds/mm/slub.c:3992)
tcp_ao_alloc_info (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:229)
tcp_ao_info_cmd.constprop.0 (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:1959)
tcp_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp_ao.c:2033)
tcp_v6_parse_ao (/home/marvin/linux/kernel/linux_torvalds/net/ipv6/tcp_ao.c:146)
do_tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3655)
tcp_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/ipv4/tcp.c:3738)
sock_common_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/core/sock.c:3727)
do_sock_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2311)
__sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/./include/linux/file.h:34 /home/marvin/linux/kernel/linux_torvalds/net/socket.c:2336)
__x64_sys_setsockopt (/home/marvin/linux/kernel/linux_torvalds/net/socket.c:2340)
do_syscall_64 (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:52 /home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:129)

Hope this helps,

Best regards,
Mirsad Todorovac

