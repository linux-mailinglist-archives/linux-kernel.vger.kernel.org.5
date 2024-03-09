Return-Path: <linux-kernel+bounces-97963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A54877268
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EE91F21BB2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291A20DF1;
	Sat,  9 Mar 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ji+F6QSu";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="JlVwTETV"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641215B1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004408; cv=none; b=utk1Gz1wSsJIwsd53XIVbJ3V+rV4sp76q4YSMIzqInut6SM/tkL2VK9BBW68tOFEllZjU4SsfmqtnW0tB1VwaGRBM4sQcl0hW9H1OSUuR45IaIVqR91dq34mA3LZgEEzfjRN2/w7px24TVSztUlE02Kv5/zZVNOWZidV+KtEAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004408; c=relaxed/simple;
	bh=SYKTrbp5YRyuf7lExTrvRzV5o1y1fnCPksERdtZah04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEq7jxFv61HVf2tUYeOuMm1LSKCaVf6DMESSCqcq/XojAhLDwM5qAqzS39bv3M9Iw3Hs49yPpFpvRoMwPPCEOmRFXVCDV6JmUO5qHkoSxat7+dMOyEBIgcJUqxbxhTTMSguzWW5ee8uVjMbpos3gNIM8CMDdDMdnZpX/uY41ICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=ji+F6QSu; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=JlVwTETV; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 2763F601A1;
	Sat,  9 Mar 2024 18:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710004400; bh=SYKTrbp5YRyuf7lExTrvRzV5o1y1fnCPksERdtZah04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ji+F6QSuNNLca5J2EYCom2aHMyiHwlI3FVT8NcIY5+AhbuIa9fbW8HUhhUFFRxD2L
	 BVvTDAgKurvBMqL/G6qtlvuFFogmATRlrxoiU+OT6pa2L5sMjY2n3jxT3QprbIc0m9
	 CET9lUYFGi5ErYWuzhXQxOALlv1ROLRslNieGb9ro96IeFxwbx0KgJPSfXCKBgBK2m
	 BhmVlKEjGbMVYwi1Ly5ZwGu5Dtx+VFjZl2gp/nud31piNey2NN1mKMm9lyEaTTNOAf
	 GooBYInKySeQ5A3kGiVF5MQ/smUGtq7xxuCS8bnMgLXmuXymq2UNmyT29Edcja7WtW
	 5uZbUrh143pRg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-LAZso7iMX9; Sat,  9 Mar 2024 18:13:16 +0100 (CET)
Received: from [192.168.178.20] (dh207-40-27.xnet.hr [88.207.40.27])
	by domac.alu.hr (Postfix) with ESMTPSA id 07E0E60189;
	Sat,  9 Mar 2024 18:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710004396; bh=SYKTrbp5YRyuf7lExTrvRzV5o1y1fnCPksERdtZah04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JlVwTETV0UzTkcolsWtQvNoSPbdrCyT6zsHubN/wZMNIxtqkgOIuu9whs6lJxUht6
	 m5nQItu/7LYNWgmmZz2JJBYHcKo3cxrVPFx6uGmkgMaBJ8t3ekZCxR2/5M1CO7bHGO
	 dSvKFo82UqlLXUABY51cwNFKfOWtH4cEsVq6H5JOtNslqO/BdK031HNXUbC+VwR2c2
	 uiH7c66aVz3T8Ix2Ny831Dl3ukSBA1udKmVcPaEGIVwQJlVNF4poONdNMF5GVoucOe
	 mpXL04eUcEHB3leDSHVXTrBIJacgxZxgqshQ44IebsfkufgV9oVtLILe0BmEpWRjq4
	 9gvSVpVJuwxJg==
Message-ID: <da255f4f-5541-4a8a-bed8-1ecc2df5477c@alu.unizg.hr>
Date: Sat, 9 Mar 2024 18:13:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftest: memfd: indefinite hang in ./fuse_mnt ./mnt
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Jeff Xu <jeffxu@google.com>,
 David Rheinsberg <david@readahead.eu>, Kees Cook <keescook@chromium.org>
References: <59114578-724e-48ca-8cb3-1d5f7191f547@alu.unizg.hr>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <59114578-724e-48ca-8cb3-1d5f7191f547@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/24 14:52, Mirsad Todorovac wrote:
> Hi everybody,
> 
> This is an issue already reported in thread:
> 
> Link: https://lore.kernel.org/all/4a5aa618-8fbc-4053-ba38-0809735d864b@alu.unizg.hr/
> 
> around January 7th.
> 
> It is again against the latest vanilla torvalds build on Ubuntu 23.10 and
> an AMD Ryzen 7 box.
> 
> Please find the .config attached.
> 
> Here are some diagnostics and log outputs:
> 
> root@stargazer:/home/marvin/linux/kernel/linux_torvalds# lsof -p 85021
> lsof: WARNING: can't stat() fuse.portal file system /run/user/1000/doc
>        Output information may be incomplete.
> lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/1000/gvfs
>        Output information may be incomplete.
> COMMAND    PID USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
> fuse_mnt 85021 root  cwd    DIR 259,13     4096       2 /
> fuse_mnt 85021 root  rtd    DIR 259,13     4096       2 /
> fuse_mnt 85021 root  txt    REG   0,44    16760 7558526 /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd/fuse_mnt
> fuse_mnt 85021 root  mem    REG   0,40          7558526 /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd/fuse_mnt (path dev=0,44)
> fuse_mnt 85021 root  mem    REG   0,26           481843 /usr/lib/x86_64-linux-gnu/libc.so.6 (path dev=0,27)
> fuse_mnt 85021 root  mem    REG   0,26           434443 /usr/lib/x86_64-linux-gnu/libfuse.so.2.9.9 (path dev=0,27)
> fuse_mnt 85021 root  mem    REG   0,26            22118 /usr/libexec/coreutils/libstdbuf.so (path dev=0,27)
> fuse_mnt 85021 root  mem    REG   0,26           481840 /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 (path dev=0,27)
> fuse_mnt 85021 root    0u   CHR    1,3      0t0       5 /dev/null
> fuse_mnt 85021 root    1u   CHR    1,3      0t0       5 /dev/null
> fuse_mnt 85021 root    2u   CHR    1,3      0t0       5 /dev/null
> fuse_mnt 85021 root    3w  FIFO   0,14      0t0  404306 pipe
> fuse_mnt 85021 root    4w  FIFO   0,14      0t0   19072 pipe
> fuse_mnt 85021 root    5u   CHR 10,229      0t0      88 /dev/fuse
> root@stargazer:/home/marvin/linux/kernel/linux_torvalds# strace -p !$
> strace -p 85021
> strace: Process 85021 attached
> futex(0x7ffc1a7c9ea0, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, NULL, FUTEX_BITSET_MATCH_ANY^Cstrace: Process 85021 detached
>   <detached ...>
> 
> root@stargazer:/home/marvin/linux/kernel/linux_torvalds#
> 
> make[3]: Entering directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd'
> TAP version 13
> 1..3
> # timeout set to 45
> # selftests: memfd: memfd_test
> # memfd: CREATE
> # memfd: BASIC
> # memfd: SEAL-EXEC
> # memfd:        Apply SEAL_EXEC
> # memfd:        Apply ALL_SEALS
> # memfd: EXEC_NO_SEAL
> # memfd: NOEXEC_SEAL
> # memfd: SEAL-WRITE
> # memfd: SEAL-FUTURE-WRITE
> # memfd: SEAL-SHRINK
> # memfd: SEAL-GROW
> # memfd: SEAL-RESIZE
> # memfd: sysctl 0
> # memfd: sysctl 1
> # memfd: sysctl 0
> # memfd: sysctl 2
> # memfd: sysctl 1
> # memfd: sysctl 0
> # memfd: nested sysctl 0
> # memfd: sysctl 0
> # memfd: sysctl 1
> # memfd: sysctl 0
> # memfd: sysctl 2
> # memfd: sysctl 1
> # memfd: sysctl 0
> # memfd: nested sysctl 1
> # memfd: nested sysctl 2
> # memfd: nested sysctl 0 -> 1 after fork
> # memfd: nested sysctl 0 -> 2 after fork
> # memfd: nested sysctl 2 -> 1 after fork
> # memfd: nested sysctl 2 -> 0 after fork
> # memfd: nested sysctl 1 -> 0 after fork
> # memfd: SHARE-DUP
> # memfd: SHARE-MMAP
> # memfd: SHARE-OPEN
> # memfd: SHARE-FORK
> # memfd: SHARE-DUP (shared file-table)
> # memfd: SHARE-MMAP (shared file-table)
> # memfd: SHARE-OPEN (shared file-table)
> # memfd: SHARE-FORK (shared file-table)
> # memfd: DONE
> ok 1 selftests: memfd: memfd_test
> # timeout set to 45
> # selftests: memfd: run_fuse_test.sh
> # opening: ./mnt/memfd
> # fuse: DONE
> ok 2 selftests: memfd: run_fuse_test.sh
> # timeout set to 45
> # selftests: memfd: run_hugetlbfs_test.sh
> # memfd-hugetlb: CREATE
> # memfd-hugetlb: BASIC
> # memfd-hugetlb: SEAL-EXEC
> # memfd-hugetlb:        Apply SEAL_EXEC
> # fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected
> # ./run_hugetlbfs_test.sh: line 60: 85016 Aborted                 (core dumped) ./memfd_test hugetlbfs
> # opening: ./mnt/memfd
> # ADD_SEALS(6, 0 -> 8) failed: Device or resource busy
> # 8 != 0 = GET_SEALS(6)
> # Aborted (core dumped)
> ok 3 selftests: memfd: run_hugetlbfs_test.sh
> make[3]: Leaving directory '/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/memfd'

As this bug report did not receive much attention, I did a little digging myself, so the debug
version of the run is like this:

root@tools/testing/selftests/memfd# gdb ./memfd_test
GNU gdb (Ubuntu 12.1-0ubuntu1~22.04.1) 12.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./memfd_test...
(gdb) run hugetlbfs
Starting program: tools/testing/selftests/memfd/memfd_test hugetlbfs
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-EXEC
memfd-hugetlb:	Apply SEAL_EXEC
fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:44
44	./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737353742144, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff7c42476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff7c287f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x0000555555556de7 in mfd_fail_chmod (fd=3, mode=511) at memfd_test.c:746
#6  0x0000555555557834 in test_exec_seal () at memfd_test.c:1090
#7  0x0000555555558934 in main (argc=2, argv=0x7fffffffe368) at memfd_test.c:1594
(gdb) list memfd_test.c:1594
   1589			}
   1590		}
   1591	
   1592		test_create();
   1593		test_basic();
→ 1594		test_exec_seal();
   1595		test_exec_no_seal();
   1596		test_noexec_seal();
   1597	
   1598		test_seal_write();
(gdb)

##############################
### NOTE!!!
##############################

The memfd file is impossible to remove using the unlink() syscall. I am not certain if this
is an error or deliberate design feature:

unlinkat(AT_FDCWD, "mnt/memfd", 0)      = -1 ENOSYS (Function not implemented)

##############################
### NOTE!!!
##############################

--------------------------------------------------------------------------------------------------

Additionally, debugging memfd F_SEAL_WRITE:

root@defiant:tools/testing/selftests/memfd# gdb ./fuse_test
GNU gdb (Ubuntu 12.1-0ubuntu1~22.04.1) 12.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
     <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./fuse_test...
(gdb) run ./mnt/memfd hugetlbfs
Starting program: tools/testing/selftests/memfd/fuse_test ./mnt/memfd hugetlbfs
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
opening: ./mnt/memfd
[Detaching after fork from child process 1301253]
ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
8 != 0 = GET_SEALS(4)

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:44
44	./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737353742144) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737353742144, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff7c42476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff7c287f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00005555555555a2 in mfd_assert_has_seals (fd=4, seals=8) at fuse_test.c:85
#6  0x0000555555555abd in main (argc=3, argv=0x7fffffffe358) at fuse_test.c:303
(gdb) list fuse_test.c:303
   298		was_sealed = mfd_assert_get_seals(mfd) & F_SEAL_WRITE;
   299	
   300		/* Wait for sealing-thread to finish and verify that it
   301		 * successfully sealed the file after the second try. */
   302		join_sealing_thread(pid);
→ 303		mfd_assert_has_seals(mfd, F_SEAL_WRITE);
   304	
   305		/* *IF* the memfd-object was sealed at the time our read() returned,
   306		 * then the kernel did a page-replacement or canceled the read() (or
   307		 * whatever magic it did..). In that case, the memfd object is still
(gdb)

strace output might give some more light on the issue:

root@tools/testing/selftests/memfd# strace -f ./fuse_test ./mnt/memfd hugetlbfs
execve("./fuse_test", ["./fuse_test", "./mnt/memfd", "hugetlbfs"], 0x7ffedde36ba8 /* 33 vars */) = 0
brk(NULL)                               = 0x5596294a2000
arch_prctl(0x3001 /* ARCH_??? */, 0x7fff07c45f50) = -1 EINVAL (Invalid argument)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7de66999c000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=101071, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 101071, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7de669983000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\237\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
pread64(3, "\4\0\0\0 \0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0"..., 48, 848) = 48
pread64(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\302\211\332Pq\2439\235\350\223\322\257\201\326\243\f"..., 68, 896) = 68
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=2220400, ...}, AT_EMPTY_PATH) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
mmap(NULL, 2264656, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7de669600000
mprotect(0x7de669628000, 2023424, PROT_NONE) = 0
mmap(0x7de669628000, 1658880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x7de669628000
mmap(0x7de6697bd000, 360448, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1bd000) = 0x7de6697bd000
mmap(0x7de669816000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x215000) = 0x7de669816000
mmap(0x7de66981c000, 52816, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7de66981c000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7de669980000
arch_prctl(ARCH_SET_FS, 0x7de669980740) = 0
set_tid_address(0x7de669980a10)         = 1301385
set_robust_list(0x7de669980a20, 24)     = 0
rseq(0x7de6699810e0, 0x20, 0, 0x53053053) = 0
mprotect(0x7de669816000, 16384, PROT_READ) = 0
mprotect(0x559628558000, 4096, PROT_READ) = 0
mprotect(0x7de6699d6000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
munmap(0x7de669983000, 101071)          = 0
getrandom("\x5a\x3b\xfe\xc5\x49\xcb\x6b\xc2", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x5596294a2000
brk(0x5596294c3000)                     = 0x5596294c3000
openat(AT_FDCWD, "/proc/meminfo", O_RDONLY) = 3
newfstatat(3, "", {st_mode=S_IFREG|0444, st_size=0, ...}, AT_EMPTY_PATH) = 0
read(3, "MemTotal:       64906640 kB\nMemF"..., 1024) = 1024
read(3, "     121580 kB\nVmallocChunk:    "..., 1024) = 507
close(3)                                = 0
mmap(NULL, 4198400, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7de669000000
newfstatat(1, "", {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x3), ...}, AT_EMPTY_PATH) = 0
write(1, "opening: ./mnt/memfd\n", 21opening: ./mnt/memfd
)  = 21
openat(AT_FDCWD, "./mnt/memfd", O_RDONLY|O_CLOEXEC) = 3
memfd_create("kern_memfd_fuse", MFD_CLOEXEC|MFD_ALLOW_SEALING|MFD_HUGETLB) = 4
ftruncate(4, 4194304)                   = 0
mmap(NULL, 4194304, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x7de668c00000
clone(child_stack=0x5596294b2900, flags=CLONE_VM|CLONE_FS|CLONE_FILES|SIGCHLDstrace: Process 1301386 attached
) = 1301386
[pid 1301385] read(3,  <unfinished ...>
[pid 1301386] clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=0, tv_nsec=200000000}, NULL) = 0
[pid 1301386] munmap(0x7de668c00000, 4194304) = 0
[pid 1301386] fcntl(4, F_GET_SEALS)     = 0
[pid 1301386] fcntl(4, F_ADD_SEALS, F_SEAL_WRITE) = -1 EBUSY (Device or resource busy)
[pid 1301386] clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0},  <unfinished ...>
[pid 1301385] <... read resumed>0x7de668c00000, 4194304) = 21
[pid 1301385] fcntl(4, F_GET_SEALS)     = 0
[pid 1301385] wait4(1301386,  <unfinished ...>
[pid 1301386] <... clock_nanosleep resumed>0x5596294b28a0) = 0
[pid 1301386] fcntl(4, F_GET_SEALS)     = 0
[pid 1301386] fcntl(4, F_ADD_SEALS, F_SEAL_WRITE) = -1 EBUSY (Device or resource busy)
[pid 1301386] write(1, "ADD_SEALS(4, 0 -> 8) failed: Dev"..., 53ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
) = 53
[pid 1301386] rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
[pid 1301386] gettid()                  = 1301386
[pid 1301386] getpid()                  = 1301386
[pid 1301386] tgkill(1301386, 1301386, SIGABRT) = 0
[pid 1301386] --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=1301386, si_uid=0} ---
[pid 1301386] +++ killed by SIGABRT (core dumped) +++
<... wait4 resumed>NULL, 0, NULL)       = 1301386
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_DUMPED, si_pid=1301386, si_uid=0, si_status=SIGABRT, si_utime=0, si_stime=0} ---
fcntl(4, F_GET_SEALS)                   = 0
write(1, "8 != 0 = GET_SEALS(4)\n", 228 != 0 = GET_SEALS(4)
) = 22
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
gettid()                                = 1301385
getpid()                                = 1301385
tgkill(1301385, 1301385, SIGABRT)       = 0
--- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=1301385, si_uid=0} ---
+++ killed by SIGABRT (core dumped) +++
Aborted (core dumped)
root@tools/testing/selftests/memfd#

----------------------

Without "hugetlbfs" argument, the program finishes with "fuse: DONE":

root@defiant:/home/marvin/linux/kernel/net-next/tools/testing/selftests/memfd# ./fuse_test ./mnt/memfd
opening: ./mnt/memfd
fuse: DONE
root@defiant:/home/marvin/linux/kernel/net-next/tools/testing/selftests/memfd# strace -f ./fuse_test ./mnt/memfd
execve("./fuse_test", ["./fuse_test", "./mnt/memfd"], 0x7ffe52f7eb90 /* 33 vars */) = 0
brk(NULL)                               = 0x63d5e57ff000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffd9ce0ada0) = -1 EINVAL (Invalid argument)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x70cd31796000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
newfstatat(3, "", {st_mode=S_IFREG|0644, st_size=101071, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 101071, PROT_READ, MAP_PRIVATE, 3, 0) = 0x70cd3177d000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\237\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
pread64(3, "\4\0\0\0 \0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0"..., 48, 848) = 48
pread64(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\302\211\332Pq\2439\235\350\223\322\257\201\326\243\f"..., 68, 896) = 68
newfstatat(3, "", {st_mode=S_IFREG|0755, st_size=2220400, ...}, AT_EMPTY_PATH) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
mmap(NULL, 2264656, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x70cd31400000
mprotect(0x70cd31428000, 2023424, PROT_NONE) = 0
mmap(0x70cd31428000, 1658880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x70cd31428000
mmap(0x70cd315bd000, 360448, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1bd000) = 0x70cd315bd000
mmap(0x70cd31616000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x215000) = 0x70cd31616000
mmap(0x70cd3161c000, 52816, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x70cd3161c000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x70cd3177a000
arch_prctl(ARCH_SET_FS, 0x70cd3177a740) = 0
set_tid_address(0x70cd3177aa10)         = 1301750
set_robust_list(0x70cd3177aa20, 24)     = 0
rseq(0x70cd3177b0e0, 0x20, 0, 0x53053053) = 0
mprotect(0x70cd31616000, 16384, PROT_READ) = 0
mprotect(0x63d5e3a98000, 4096, PROT_READ) = 0
mprotect(0x70cd317d0000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
munmap(0x70cd3177d000, 101071)          = 0
getrandom("\x8d\xcf\x51\x91\x51\xe1\xdc\xcb", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x63d5e57ff000
brk(0x63d5e5820000)                     = 0x63d5e5820000
newfstatat(1, "", {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x3), ...}, AT_EMPTY_PATH) = 0
write(1, "opening: ./mnt/memfd\n", 21opening: ./mnt/memfd
)  = 21
openat(AT_FDCWD, "./mnt/memfd", O_RDONLY|O_CLOEXEC) = 3
memfd_create("kern_memfd_fuse", MFD_CLOEXEC|MFD_ALLOW_SEALING) = 4
ftruncate(4, 8192)                      = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x70cd31794000
clone(child_stack=0x63d5e58116b0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|SIGCHLDstrace: Process 1301751 attached
) = 1301751
[pid 1301750] read(3,  <unfinished ...>
[pid 1301751] clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=0, tv_nsec=200000000}, NULL) = 0
[pid 1301751] munmap(0x70cd31794000, 8192) = 0
[pid 1301751] fcntl(4, F_GET_SEALS)     = 0
[pid 1301751] fcntl(4, F_ADD_SEALS, F_SEAL_WRITE) = -1 EBUSY (Device or resource busy)
[pid 1301751] clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0},  <unfinished ...>
[pid 1301750] <... read resumed>0x70cd31794000, 8192) = 21
[pid 1301750] fcntl(4, F_GET_SEALS)     = 0
[pid 1301750] wait4(1301751,  <unfinished ...>
[pid 1301751] <... clock_nanosleep resumed>0x63d5e5811650) = 0
[pid 1301751] fcntl(4, F_GET_SEALS)     = 0
[pid 1301751] fcntl(4, F_ADD_SEALS, F_SEAL_WRITE) = 0
[pid 1301751] exit(0)                   = ?
[pid 1301751] +++ exited with 0 +++
<... wait4 resumed>NULL, 0, NULL)       = 1301751
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=1301751, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
fcntl(4, F_GET_SEALS)                   = 0x8 (seals F_SEAL_WRITE)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE, 4, 0) = 0x70cd31794000
close(4)                                = 0
close(3)                                = 0
write(1, "fuse: DONE\n", 11fuse: DONE
)            = 11
exit_group(0)                           = ?
+++ exited with 0 +++
root@defiant:/home/marvin/linux/kernel/net-next/tools/testing/selftests/memfd#

-------------------------------------

I hope this will attract any attention. Apparently, the bug is connected with hugetlbfs memfd,
and it fails even when I manually allocated 10 hugetlbfs pages due to non-transparent reasons.

My knowledge of memfd interface is insufficient to solve this problem, and the variant
w/o use of hugetlbfs apparently works.

Thank you.

Best regards,
Mirsad Todorovac

