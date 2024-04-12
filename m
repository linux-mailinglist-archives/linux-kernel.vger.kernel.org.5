Return-Path: <linux-kernel+bounces-142692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8CD8A2EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C9C1C20DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311C5FB92;
	Fri, 12 Apr 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoN4/Gwd"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3B5EE67;
	Fri, 12 Apr 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927308; cv=none; b=PJDbLIyRMNIfO75fLttzojg88nWZ2T8YYP8Wrdo+fYI2wFPpWjbbB+YEj6Zak4ExzBysANc4tx70aUo0VONA+Y8Vv/ukLbJth6kZvkEGs9X54hVnjn0VAMHZZTN03AigdbWWjKfQ3dWGUAGf2Sml0KxNRujcJfs3ImXwrakM09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927308; c=relaxed/simple;
	bh=smO65XDZ61emqicPocqbIM9artyu+v5qW43fYAgeCyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdlvD2dLXqDAD2AOZDfIbFZGc6x4j1Dz5XOtcb7ba+ZVAz2ZYVh9Zrykp0nHrHgWPFDGqJ1oyFgYwgC56ecAVoxbpryJgYAHvDl/xltRkl2GmADMgeL/PcowXwSCaqHzLYYFE2Bq9erhKe1yvzugbywytQUTKz17noer4qnXW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoN4/Gwd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso7966741fa.3;
        Fri, 12 Apr 2024 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712927304; x=1713532104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLcGq5zWMeYBBSqql3vIqVo619w1Ke1Wim2kKoEYI4=;
        b=CoN4/GwdQ5wctbCOaSpr7um9fqAmwEi3dLIIPhSagzArGKSUx1bAjpu4PuyrSMjZjI
         DUqomNi1bpLJs7mA6qJoxw7wiKv7Fmieh2ZIaGrzZ5KBIq1/dHdHUVXP3YR2SRXNxzPa
         fpwGlmYzNmF5Oc09z1feHvbjb28MG6hkDOvpq0/34WlJkr2h2snrRd3vZzGKhacYspC6
         JJKQGbutmDqHv+E7Y9sTsq96vMZzbucoiZxWezlu6EB0EsSkjTos/2NNWEwmUWe3SA8I
         wEjVi7OsWmsdnDEUpAGBvn4l28HsUnpOJ7rV0/23oMC/pDOKEeqCSIMuvE0R3XQkeaM6
         S38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927304; x=1713532104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gLcGq5zWMeYBBSqql3vIqVo619w1Ke1Wim2kKoEYI4=;
        b=tw/kdDTBvVpiWKEA0zPUfc8uNQuxXoiuoKOGQ/w9JWIeHv/BXzTWQ1dFi3v5mFe2fu
         ADR8Y6KrMa4hYe3s5J/R2ZBDisdKMhInlBh0ug19e67tdXcziZv6VnBao4sQESW0+3np
         Y5a/3qR62+SgkQwA7wYOBtMqZma+KPILqCYPK4aFhTTI4HzqE9SkaZ70HRsRglNnn55Z
         M7+Rsk0/TYkN119HoDdDV90j5YpmxvQAmlRQNq2Qr1nV98JWiw8bSpeLoXeg4UzT93Nj
         d+44D8XYsXJjZC1VfvQFuWbo3Pbmm90UI8zHdCzF+VQZ4Hk+MZsr7wNSrPrgOw3LhXDH
         WT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfgukvvXICb80wc7uSQJr+xK8Jx04Udgt9A+MJsqIHI9RkdkMiXgdsTb9EY8zs4UqQ7WXhk9i/LsjT2+pNPc0Yc6D3NRRp6Q1t
X-Gm-Message-State: AOJu0Yyo8AlFoHnsWTKEQyjEEsOMbvfxNjZqxoOB0zefGnjafGhhvTtH
	tnw+X/Ms7/UKhKTpf63A03gwyxDkgqZOvwZVgWY0OpE3lg5/Y1debnS7L8QowtQMkfn/ECDDZOg
	z8Cc52i8MgVJKU5B6+pXgPyK7Hgs=
X-Google-Smtp-Source: AGHT+IHbUhyiYY/APoRdVTDCnh2yqac9MzZHZ7FoQ0gwvmXFN4lE18e84XXmBoHMxZH5iDQHmGSgMhAUOZ1bchu1h3U=
X-Received: by 2002:ac2:4142:0:b0:515:9150:ecc1 with SMTP id
 c2-20020ac24142000000b005159150ecc1mr1584483lfi.24.1712927303881; Fri, 12 Apr
 2024 06:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
In-Reply-To: <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Fri, 12 Apr 2024 21:08:12 +0800
Message-ID: <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:24=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Thu, Apr 11, 2024 at 02:52:27PM +0800, Sam Sun wrote:
> > Dear developers and maintainers,
> >
> > We encountered a general protection fault in function disable_store.
> > It is tested against the latest upstream linux (tag 6.9-rc3). C repro
> > and kernel config are attached to this email. Kernel crash log is
> > listed below.
> > ```
> > general protection fault, probably for non-canonical address
> > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 9459 Comm: syz-executor414 Not tainted 6.7.0-rc7 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:disable_store+0xd0/0x3d0 drivers/usb/core/port.c:88
> > Code: 02 00 00 4c 8b 75 40 4d 8d be 58 ff ff ff 4c 89 ff e8 a4 20 fa
> > ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > 02 00 0f 85 b0 02 00 00 48 8b 45 00 48 8d bb 34 05 00 00 48
> > RSP: 0018:ffffc90006e3fc08 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffff88801d4d4008 RCX: ffffffff86706be8
> > RDX: 0000000000000000 RSI: ffffffff86706c4d RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000dc7f85
> > R13: ffff88810f4bfb18 R14: ffff88801d4d10a8 R15: ffff88801d4d1000
> > FS:  00007fa0af71b640(0000) GS:ffff888135c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa0af71a4b8 CR3: 0000000022f5f000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
>
> > ----------------
> > Code disassembly (best guess):
> >    0:    02 00                    add    (%rax),%al
> >    2:    00 4c 8b 75              add    %cl,0x75(%rbx,%rcx,4)
> >    6:    40                       rex
> >    7:    4d 8d be 58 ff ff ff     lea    -0xa8(%r14),%r15
> >    e:    4c 89 ff                 mov    %r15,%rdi
> >   11:    e8 a4 20 fa ff           call   0xfffa20ba
> >   16:    48 89 c2                 mov    %rax,%rdx
> >   19:    48 89 c5                 mov    %rax,%rbp
> >   1c:    48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
> >   23:    fc ff df
> >   26:    48 c1 ea 03              shr    $0x3,%rdx
> > * 2a:    80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1) <--
> > trapping instruction
> >   2e:    0f 85 b0 02 00 00        jne    0x2e4
> >   34:    48 8b 45 00              mov    0x0(%rbp),%rax
> >   38:    48 8d bb 34 05 00 00     lea    0x534(%rbx),%rdi
> >   3f:    48                       rex.W
> > ```
> > We analyzed the root cause of this bug. When calling disable_store()
> > in drivers/usb/core/port.c, if function authorized_store() is calling
> > usb_deauthorized_device() concurrently, the usb_interface will be
> > removed by usb_disable_device. However, in function disable_store,
> > usb_hub_to_struct_hub() would try to deref interface, causing
> > nullptr-deref. We also tested other functions in
> > drivers/usb/core/port.c. So far we haven't found a similar problem.
>
> I don't see how this explanation could be correct.  disable_store() is a
> sysfs attribute file for the port device, so when it is called the port
> device structure must still be registered.  The interface structure
> doesn't get removed until after usb_disable_device() calls device_del(),
> which won't return until hub_disconnect() returns, which won't happen
> until after the port devices are unregistered, which doesn't happen
> until disable_store() calls sysfs_break_active_protection(), which is
> after the call to usb_hub_to_struct_hub().
>
> Can you do a little extra debugging to find out exactly which C
> statement causes the trap?  The disassembly above indicates the trap
> happens during a compare against 0 inside disable_store() -- not inside
> usb_hub_to_struct_hub().  Can you figure out which comparison that is?
>

Sorry for the mistake I made when debugging this bug. Now I have more
information about it. Disassembly of function disable_store() in the
latest upstream kernel is listed below.
```
Dump of assembler code for function disable_store:
   ...
   0xffffffff86e907eb <+187>:   lea    -0x8(%r14),%r12
   0xffffffff86e907ef <+191>:   mov    (%rbx),%rax
   0xffffffff86e907f2 <+194>:   mov    %rax,0x20(%rsp)
   0xffffffff86e907f7 <+199>:   lea    -0xa8(%rax),%rdi
   0xffffffff86e907fe <+206>:   mov    %rdi,0x18(%rsp)
   0xffffffff86e90803 <+211>:   call   0xffffffff86e20220
<usb_hub_to_struct_hub>
   0xffffffff86e90808 <+216>:   mov    %rax,%rbx
   0xffffffff86e9080b <+219>:   shr    $0x3,%rax
   0xffffffff86e9080f <+223>:   movabs $0xdffffc0000000000,%rcx
   0xffffffff86e90819 <+233>:   cmpb   $0x0,(%rax,%rcx,1)
   0xffffffff86e9081d <+237>:   je     0xffffffff86e90827 <disable_store+24=
7>
   0xffffffff86e9081f <+239>:   mov    %rbx,%rdi
   0xffffffff86e90822 <+242>:   call   0xffffffff81eeb0b0
<__asan_report_load8_noabort>
   0xffffffff86e90827 <+247>:   lea    0x60(%rsp),%rsi
   ...
```
The cmpb in disable_store()<+233> is generated by KASAN to check the
shadow memory status. If equals 0, which means the load 8 is valid,
pass the KASAN check. However, this time rax is 0, so it first
triggers general protection fault, since 0xdffffc0000000000 is not a
valid address. rax contains the return address of function
usb_hub_to_struct_hub(), in this case is a NULL.

In function usb_hub_to_struct_hub(), I checked hdev and its sub
domains, and they are not NULL. Is it possible that
usb_deauthorized_device() set
hdev->actconfig->interface[0]->dev.driver_data to NULL? I cannot
confirm that since every time I try to breakpoint the code it crashes
differently.

If there is any other thing I could help, please let me know.

Best,
Yue


> Alan Stern
>
> > If you have any questions, please contact us.
> >
> > Reported by Yue Sun <samsun1006219@gmail.com>
> > Reported by xingwei lee <xrivendell7@gmail.com>
> >
> > Best Regards,
> > Yue

