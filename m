Return-Path: <linux-kernel+bounces-9232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1D81C2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70057288296
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12510F0;
	Fri, 22 Dec 2023 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="g+Tq8jtD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8565A31
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c31f18274so17109355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703207873; x=1703812673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lk9Vc1mIX7j2zXFqM2XQS4Kz0AH76zHaX+lPmxzhQHQ=;
        b=g+Tq8jtDUR9i+B+bDbX+3ZZW1Q56ZOpeXkIzkVkXsBzyGk7irLaoLUuqTuGcezgo1Y
         pGllN+OcFYJMn32kPT6JNjUN3FATaWZ4WtCeY6cso8smjZcmDDwaDhfA05SXFAhzp3Zb
         9m03xDa1o0fNQsTd+eZJXdO1QaDiuKR/NmGCF7dmh0NWGPWAn+FYhhPP+gXNVQu2jav+
         xai8T85hF0Ax2zCZl0rDRW88hmcidr6oB3dg3QjwFCj/l1ttKQxJAUP89ByjjpbxyMAE
         N2lz0vF73F4mcYOVa6KtoJ+VchFsH4FrZQHOvJwP6mZlKmWyhZg61shjyk1e1tGQSn1D
         kZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207873; x=1703812673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lk9Vc1mIX7j2zXFqM2XQS4Kz0AH76zHaX+lPmxzhQHQ=;
        b=rLZM1IbW19IByrql6uAg/qHCKVeZ0RmbmG3v+RXNDzL6JugvqyEK9hlblcGN8YxQ27
         5mNdL4VWeJluUPnqA+aS0e43t9wPi02gVwV4Ftw2HM6aR0Ydt8LGwQSb3CRfqRYG4bGf
         h2h4Z+NXwlPNDBL95NmgRxaX/eGo8uxW6NLBUe/6d2r9jCMeL8GAkAHuauU0pE9FKIja
         FEGKzpXLbqykEioU5bKLhDbrlyg7RzAAI/Vu46fEdjSXhkb7Dl+U1EF7FzSr5wPmq0gS
         7SdYljCMdeaRrIkSkQuMtkz6ZycmheODMdTpCWmNObn/qNUZX5TE3ahn1TAvBpfpoSwo
         Y2Gw==
X-Gm-Message-State: AOJu0Yxyi2EJrFaSb2wkaCkdzT2ZyGRkB/JMy8k3tJ8DxME9aEBJdp/L
	K2J02nsGOyMjYiW+GyqrPLRdNIRitrFi
X-Google-Smtp-Source: AGHT+IGZwVTodj5gVaeFxy87JYmpFXqpjDmcNC37vMGtpmyoiXSVTCO30ByOyXU1YANWRL760lFBAw==
X-Received: by 2002:a05:600c:b42:b0:40d:3f4b:1c88 with SMTP id k2-20020a05600c0b4200b0040d3f4b1c88mr261316wmr.244.1703207872904;
        Thu, 21 Dec 2023 17:17:52 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b00405c7591b09sm5135414wmb.35.2023.12.21.17.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 17:17:52 -0800 (PST)
Message-ID: <05729f32-44ec-416d-963d-5218ca890fb8@arista.com>
Date: Fri, 22 Dec 2023 01:17:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for
 TCP-AO
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Ard Biesheuvel <ardb@kernel.org>, Bob Gilligan <gilligan@arista.com>,
 Dan Carpenter <error27@gmail.com>, David Laight <David.Laight@aculab.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Donald Cassidy <dcassidy@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>,
 "Gaillardetz, Dominik" <dgaillar@ciena.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ivan Delalande <colona@arista.com>, Leonard Crestez <cdleonard@gmail.com>,
 "Nassiri, Mohammad" <mnassiri@ciena.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
 Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20231023192217.426455-1-dima@arista.com>
 <20231023192217.426455-2-dima@arista.com>
 <CANn89i+Uwg87xAS9m8fm1f1daQj-YyugperN3HnvgbB6g+hOuw@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+Uwg87xAS9m8fm1f1daQj-YyugperN3HnvgbB6g+hOuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 12/21/23 14:31, Eric Dumazet wrote:
> On Mon, Oct 23, 2023 at 9:22 PM Dmitry Safonov <dima@arista.com> wrote:
...
>> +int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
>> +{
>> +       int i, ret;
>> +
>> +       /* slow-path */
>> +       mutex_lock(&cpool_mutex);
>> +       ret = sigpool_reserve_scratch(scratch_size);
>> +       if (ret)
>> +               goto out;
>> +       for (i = 0; i < cpool_populated; i++) {
>> +               if (!cpool[i].alg)
>> +                       continue;
>> +               if (strcmp(cpool[i].alg, alg))
>> +                       continue;
>> +
>> +               if (kref_read(&cpool[i].kref) > 0)
>> +                       kref_get(&cpool[i].kref);
> 
> This sequence is racy.
> 
> You must use kref_get_unless_zero().

Thanks for this report, I've sent a trivial fixup here:
https://lore.kernel.org/all/20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com/T/#u

> 
>> +               else
>> +                       kref_init(&cpool[i].kref);
>> +               ret = i;
>> +               goto out;
>> +       }
>> +
>> +
> 
> syzbot reported:
> 
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 2 PID: 31702 at lib/refcount.c:25
> refcount_warn_saturate+0x1ca/0x210 lib/refcount.c:25
> Modules linked in:
> CPU: 2 PID: 31702 Comm: syz-executor.3 Not tainted
> 6.7.0-rc6-syzkaller-00044-g1a44b0073b92 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x1ca/0x210 lib/refcount.c:25
> Code: ff 89 de e8 58 a3 25 fd 84 db 0f 85 e6 fe ff ff e8 1b a8 25 fd
> c6 05 9a 88 a1 0a 01 90 48 c7 c7 00 9d 2e 8b e8 b7 ec eb fc 90 <0f> 0b
> 90 90 e9 c3 fe ff ff e8 f8 a7 25 fd c6 05 75 88 a1 0a 01 90
> RSP: 0018:ffffc900296df850 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002c40a000
> RDX: 0000000000040000 RSI: ffffffff814db526 RDI: 0000000000000001
> RBP: ffffffff92b5b7b0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000010
> R13: ffffffff92b5b7b0 R14: 0000000000000001 R15: 0000000000000000
> FS: 0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:00000000f7efdb40
> CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00000000f7354000 CR3: 0000000050ee3000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> __refcount_add include/linux/refcount.h:199 [inline]
> __refcount_inc include/linux/refcount.h:250 [inline]
> refcount_inc include/linux/refcount.h:267 [inline]
> kref_get include/linux/kref.h:45 [inline]
> tcp_sigpool_alloc_ahash+0x9cb/0xce0 net/ipv4/tcp_sigpool.c:166
> tcp_md5_alloc_sigpool+0x1b/0x40 net/ipv4/tcp.c:4379
> tcp_md5_do_add+0x192/0x460 net/ipv4/tcp_ipv4.c:1403
> tcp_v6_parse_md5_keys+0x68d/0x860 net/ipv6/tcp_ipv6.c:676
> do_tcp_setsockopt+0x1302/0x2880 net/ipv4/tcp.c:3644
> tcp_setsockopt+0xd4/0x100 net/ipv4/tcp.c:3726
> do_sock_setsockopt+0x222/0x470 net/socket.c:2311
> __sys_setsockopt+0x1a6/0x270 net/socket.c:2334
> __do_sys_setsockopt net/socket.c:2343 [inline]
> __se_sys_setsockopt net/socket.c:2340 [inline]
> __ia32_sys_setsockopt+0xbc/0x150 net/socket.c:2340
> do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
> __do_fast_syscall_32+0x62/0xe0 arch/x86/entry/common.c:321
> do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
> entry_SYSENTER_compat_after_hwframe+0x70/0x7a
> RIP: 0023:0xf7f02579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00
> 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a
> 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f7efd5ac EFLAGS: 00000292 ORIG_RAX: 000000000000016e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000006
> RDX: 000000000000000e RSI: 0000000020000000 RDI: 00000000000000d8
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Thanks,
            Dmitry


