Return-Path: <linux-kernel+bounces-74837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED085DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412C31F2298D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE87D414;
	Wed, 21 Feb 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNqbJGxB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F078B4B;
	Wed, 21 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523988; cv=none; b=laRj59f55wcW8p/dPlx2w1ZJXYkZ1xjhXBsY5GCShfORwPVRecvBQrRAoGVr1YnVRdhDnbO7wvW36OcexmwhUjiGH/jf4NaZmRGry6UrpFmC4gJZeqlsXudgGaYiVAm20688CV30mE08Tz27n7djSKC/1FThRdAzakIeOuxlLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523988; c=relaxed/simple;
	bh=SnPLHbpo/441VAamU2FvPSSpEtFvKMwOMzEK2EmKY1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hF/sIxbthoSxv5YuAamVz3SklWZPfhhJco/2AcPl7pyj6hI9OW3xdyBf1Q+V/hltQFThyMUXpH0ZxzlQSxKqDHCRHN5oStBaJKH3gXhXl2fNkWgaQ4O/D4cadu5eMRPfxDHzDi0JXIYpeB0HspMtoy0zgYztiAYqAaeYWQ/yvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNqbJGxB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d934c8f8f7so62499855ad.2;
        Wed, 21 Feb 2024 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708523986; x=1709128786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aaHNU3TsVz9YPg3zJxPm9tj9UZPGWWuZNDbw2aB5JJI=;
        b=bNqbJGxBBjZN1lfkbB55cKKnmGFeuFnPwUjnThjb/c0lTPe51WFxGma4f83JONlSoi
         GutNnwNb88Uirh0lx7yhwI/p92mpJpaZM49fuaqLcpwe3aUTybiM7ZIRWSCipCLRRJYt
         W6AmdYBQTKhqIfyFP78YeOWT3J1F93yCVB4gQOXej3x70ZUVWL2vxlZ2lpAQZ/hn5Bp9
         IEleDim6hCJWpp0+PzAI/fzccmtdc4aK+Q5I5a0kBhz6JgcYwe3Y3BSe1qOaqXONZcNJ
         4j2IYGSW86FXIHjM3GiJP4MMRVkBnd38WmkAPoDLuBQrgp8d2NUEXgNvsZLyn/qWTRSa
         armA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708523986; x=1709128786;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaHNU3TsVz9YPg3zJxPm9tj9UZPGWWuZNDbw2aB5JJI=;
        b=LLjj+MUNTajSvS0W6l3t2QrQwJ7P73LBnMoMhAfWV/TmBzI4NxRPUCTF1nxJRQk5Cj
         NGqMcVTv6Xn08qfVSeV2rsU3Kq9wlFe2eB9+1o2HUyBiZ4sKi9/x4fKaHoaRMnIpn92X
         ipAhmuaOAr9U7NcPqz8BpiWLNisUHKaLjJspRfciMhDJ3GJmBBxiKqUVT1/3/u0mZLI6
         kOW0qJVKQujm1R8kHMJXolwYqWS2fVFUpIBY7urjGx0X8Yb8YzVymk5xNDRU0DpUG6rf
         I2iP1C/Hi9xFT2OxzfW7+W+8BDYgPJB69ggo++YDyKJGILHHfNTtfFmb3a65MUDLh7X4
         tWsw==
X-Forwarded-Encrypted: i=1; AJvYcCXFj4QGccxMfGMHWR+0x3nLdyKbioNZb4sBrPKzVi2p/UpQTRdrV6MkgJ/w28Q+WKEsQmkLeNP6yJZimjhQz0hXI0iJunng9+yRTYrGvW1yOU257+OqRaScsWPem/GUmFa9X7DDaVDbqw5JXv+WvXqIBAT//70AwCdLyokYx2CtZysTGEyl
X-Gm-Message-State: AOJu0Ywn+Wv/LueSDv47i3tQ9k9NrcSJxrIK4/QftgpUoydnlVo8fsuy
	RackIcFhamTej88llNmjNudRWxmzz9cBsHjAvy2A9R2cDxzSiUc7Su58r65L9x525Y1ehdh3beq
	LEhwD1SQd69OgZKao5e3NilrBa/1z09xA
X-Google-Smtp-Source: AGHT+IGA7OlFHoL29A1Ks5gKGBoCCdoRecUcAoF52pJ9S32niGcrcIP8xX/JRmbCOc1hnGaycyULN1xJHu503jPkYSQ=
X-Received: by 2002:a17:903:32cc:b0:1dc:157e:456a with SMTP id
 i12-20020a17090332cc00b001dc157e456amr5645861plr.49.1708523986187; Wed, 21
 Feb 2024 05:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Wed, 21 Feb 2024 21:59:35 +0800
Message-ID: <CABOYnLzFYHSnvTyS6zGa-udNX55+izqkOt2sB9WDqUcEGW6n8w@mail.gmail.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in __nla_validate_parse (3)
To: syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com
Cc: coreteam@netfilter.org, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug in the syzbot dashboard and upstream linux.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

I use the same config with syzbot dashboard.
kernel version: c1ca10ceffbb289ed02feaf005bc9ee6095b4507
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e3dd779fba027968
with KMSAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

[  254.423842][ T8047] =====================================================
[  254.430576][ T8047] BUG: KMSAN: uninit-value in
__nla_validate_parse+0x3d62/0x4f90
[  254.434357][ T8047]  __nla_validate_parse+0x3d62/0x4f90
[  254.437054][ T8047]  __nla_parse+0x6a/0x80
[  254.439556][ T8047]  nfnetlink_rcv_msg+0x74c/0xed0
[  254.444928][ T8047]  netlink_rcv_skb+0x58f/0x6d0
[  254.447359][ T8047]  nfnetlink_rcv+0x3e8/0x4d10
[  254.449893][ T8047]  netlink_unicast+0x107c/0x13e0
[  254.452371][ T8047]  netlink_sendmsg+0x132c/0x1540
[  254.454791][ T8047]  ____sys_sendmsg+0xa5b/0xe70
[  254.456975][ T8047]  ___sys_sendmsg+0x2a7/0x3f0
[  254.459423][ T8047]  __x64_sys_sendmsg+0x342/0x510
[  254.461514][ T8047]  do_syscall_64+0xcf/0x1e0
[  254.463345][ T8047]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  254.465643][ T8047]
[  254.466539][ T8047] Uninit was created at:
[  254.468194][ T8047]  kmem_cache_alloc_node+0x5cb/0xbc0
[  254.470272][ T8047]  kmalloc_reserve+0x14d/0x500
[  254.471882][ T8047]  __alloc_skb+0x385/0x820
[  254.473385][ T8047]  netlink_sendmsg+0xbd6/0x1540
[  254.475011][ T8047]  ____sys_sendmsg+0xa5b/0xe70
[  254.476534][ T8047]  ___sys_sendmsg+0x2a7/0x3f0
[  254.478039][ T8047]  __x64_sys_sendmsg+0x342/0x510
[  254.479628][ T8047]  do_syscall_64+0xcf/0x1e0
[  254.480995][ T8047]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  254.482719][ T8047]


=* repro.c =*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms) {
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)     \
  *(type*)(addr) =                                                   \
      htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
            (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void) {
  intptr_t res = 0;
  res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0xc);
  if (res != -1)
    r[0] = res;
  *(uint64_t*)0x20000080 = 0;
  *(uint32_t*)0x20000088 = 0;
  *(uint64_t*)0x20000090 = 0x20000040;
  *(uint64_t*)0x20000040 = 0x20000100;
  *(uint32_t*)0x20000100 = 0x18;
  *(uint8_t*)0x20000104 = 0;
  *(uint8_t*)0x20000105 = 0xb;
  *(uint16_t*)0x20000106 = 0x401;
  *(uint32_t*)0x20000108 = 0;
  *(uint32_t*)0x2000010c = 0;
  *(uint8_t*)0x20000110 = 0;
  *(uint8_t*)0x20000111 = 0;
  *(uint16_t*)0x20000112 = htobe16(0);
  *(uint16_t*)0x20000114 = 4;
  STORE_BY_BITMASK(uint16_t, , 0x20000116, 2, 0, 14);
  STORE_BY_BITMASK(uint16_t, , 0x20000117, 0, 6, 1);
  STORE_BY_BITMASK(uint16_t, , 0x20000117, 1, 7, 1);
  *(uint64_t*)0x20000048 = 0x18;
  *(uint64_t*)0x20000098 = 1;
  *(uint64_t*)0x200000a0 = 0;
  *(uint64_t*)0x200000a8 = 0;
  *(uint32_t*)0x200000b0 = 0;
  syscall(__NR_sendmsg, /*fd=*/r[0], /*msg=*/0x20000080ul, /*f=*/0ul);
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  loop();
  return 0;
}

=* repro.txt =*
r0 = socket$nl_netfilter(0x10, 0x3, 0xc)
sendmsg$IPCTNL_MSG_CT_NEW(r0, &(0x7f0000000080)={0x0, 0x0,
&(0x7f0000000040)={&(0x7f0000000100)={0x18, 0x0, 0xb, 0x401, 0x0, 0x0,
{}, [@CTA_TUPLE_REPLY={0x4}]}, 0x18}}, 0x0)


and see also in
https://gist.github.com/xrivendell7/fe97316e8a66f8d81109a158a3225bc0

I hope it helps.
Best regards!
xingwei Lee

