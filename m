Return-Path: <linux-kernel+bounces-139065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A389FE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765BB1C21D54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020E17F376;
	Wed, 10 Apr 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spI0VmGx"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB517BB39
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769297; cv=none; b=pYvTXQySjQpLsG65dBXHk10aRm2K1ULq1v8iNJj6uWA5+pp4Esmr2R3pKZdJxvVI0BdE4X003dr/wDF2NHTRUW+2zPShNPPsAg6vQAqE8TWtxbs2DUde2sftj397d98bZTCPj+67GFfgtOouKnnIv3CZKv5P1gY+I/mzjMiXuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769297; c=relaxed/simple;
	bh=UtE9dpOriBoEHmRNeCf9+mlxv40lB6Ltu8LwxLFa9sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAEVQMZd2YFBtsfT0sYuCb2bR+hKmJJcJaDC9mwO+uEox0yXTt5RXnU6z3Ohe3ZIX/HvP/nr+Y6b7obpHVZK13sLYjugMFWXGsq59BKPBkHXQmOxubrpzGkelmK4odUHHdygfbXkJXVoHpz30OoiX1WitlGTECA1aF7A+n4m9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=spI0VmGx; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e128b1ba75so2426652241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712769294; x=1713374094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S42TdCE7lyYEsoA5SAyNjrW+popWh8S591hBlLsaQzw=;
        b=spI0VmGxZFDU8mApa799wXfd7h0tuvmUOh+Y/it6shLeiqr//SK2/BycaMaR5Fs7Br
         KQbrfEVURfuLyHNEyZThmY/0CPAAUqc2cpr5SZefdcnnIfHK6mME7Y4vH48tJ2Xmf8si
         qX/wFzAWsIQVVk9ZHZ9tE9Gw11Mh9Qb6B3z9VLq9EyuE778/6LXqwXTx8XxcXFkww8NX
         4RybS9SvxB/ZaF9brNwQ2XhJe4lUw4KbsIbIFDrfwqeaXwBUuJyo7hDhhNQD9F1Oi/OW
         lPtGgReTCPLJN9qqTQZsbhevaXRrh7WZ9Q9GvvLXYJmd0eTVYtQDqWLYy36YZIY50fY0
         zuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712769294; x=1713374094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S42TdCE7lyYEsoA5SAyNjrW+popWh8S591hBlLsaQzw=;
        b=dOwhJ+lDisCPaqQJawjixSBxLg/R37YFz7AxdSNTH+1jt3oyN99VrvQuhtyIjgD+G+
         YkVyJMlZbeqFNR5Z2Bm6HrAchf7EszOD6aJdJcrIMGgx2vUBfqPK9qntwLZVlM9jlrA/
         Dvv/I7KQADfRXvPovpCTxBxK5hXnhz6i55wZXNtjII9i0YDB53xKNrcbZBW7aBYuAm2n
         bdcjgx5PWoc3M+tPghsULT1hpOlZNzJRwVju9GrPoGisZHzb3iqbDDCywg13h/mp2V4s
         Qi+yItz3tda6tL73oL11JXLGO6beLJUIh7J0VkpuiyGnYlxNqQMhipxf2ix0LBfAiett
         5+CA==
X-Forwarded-Encrypted: i=1; AJvYcCWlEz3b6PBnDb6fup4P8JTGXR5DPVOHViNh0UdWWpD1zpvxlDXLKNc/t5d1H4MSs22N54yh7KCh/u6CcAp1p0Y8HgPm6riE+gJKyClv
X-Gm-Message-State: AOJu0YzRiEn3xIwTNpu44Sx95kty1ma1yxIdUnQfCf5WNlFKW099njpg
	3OKGAzcpcaqbH9RDXBz2AwksI8RfAl45B6/Y1wjG5nXS59HfN1QjFHl79dbevxBllAyHSsecCm3
	0S5tULzPHPkXcQQyLEGCDuHSN90CExstODQm6oA==
X-Google-Smtp-Source: AGHT+IE/JjiRZWco5SrOaxiLN+PoH0vmK3GBwG7qjHqCSHU0YKK96d/70vo/wrGt2DAYCAIS2rlP+k0iAlCWTB3snVI=
X-Received: by 2002:a1f:e684:0:b0:4c9:c252:6afb with SMTP id
 d126-20020a1fe684000000b004c9c2526afbmr3913032vkh.10.1712769293799; Wed, 10
 Apr 2024 10:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org> <20240410152307.GA25111@willie-the-truck>
In-Reply-To: <20240410152307.GA25111@willie-the-truck>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 22:44:42 +0530
Message-ID: <CA+G9fYv2szPTjixaM-QT_cfZWwGSx1Huk2pUtUWP-A9PTMTLOQ@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: Will Deacon <will@kernel.org>
Cc: mic@digikod.net, keescook@chromium.org, davidgow@google.com, 
	rmoar@google.com, lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/mixed; boundary="00000000000057046d0615c12d20"

--00000000000057046d0615c12d20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 20:53, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed on Linux next-20240410 tag while running
> > kunit testing on qemu-arm64 and qemu-x86_64.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Crash log on qemu-arm64:
> > ----------------
> > <3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (inclu=
de/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 =
include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/li=
nux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)

> It's a shame that you have trimmed the register dump here.

My apologies for that, the detailed crash log is attached and
the links provided in the tail of this email.

>
> > <4>[   30.511022] Call trace:
> > <4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h=
:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:=
169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/a=
tomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 =
include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/li=
nux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.c:=
84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched=
/completion.c:167)
> > <4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > <4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > <4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635)
>
> Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was added
> recently, so adding Micka=C3=ABl to cc.
>
> Will

Thank you.

- Naresh

--00000000000057046d0615c12d20
Content-Type: text/plain; charset="US-ASCII"; name="output-kasan-kernel-crash.txt"
Content-Disposition: attachment; filename="output-kasan-kernel-crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_luu2h7i80>
X-Attachment-Id: f_luu2h7i80

U3ViamVjdDogQlVHOiBLQVNBTjogbnVsbC1wdHItZGVyZWYgaW4gX3Jhd19zcGluX2xvY2tfaXJx
IG5leHQtMjAyNDA0MTAKCkZvbGxvd2luZyBrZXJuZWwgY3Jhc2ggbm90aWNlZCBvbiBMaW51eCBu
ZXh0LTIwMjQwNDEwIHRhZyB3aGlsZSBydW5uaW5nCmt1bml0IHRlc3Rpbmcgb24gcWVtdS1hcm02
NCBhbmQgcWVtdS14ODZfNjQuCgpSZXBvcnRlZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwg
VGVzdGluZyA8bGtmdEBsaW5hcm8ub3JnPgoKQ3Jhc2ggbG9nIG9uIHFlbXUtYXJtNjQ6Ci0tLS0t
LS0tLS0tLS0tLS0KPDM+WyAzMC40NjU3MTZdIEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGlu
IF9yYXdfc3Bpbl9sb2NrX2lycSAoaW5jbHVkZS9saW51eC9pbnN0cnVtZW50ZWQuaDo5NiBpbmNs
dWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmg6MTMwMSBpbmNsdWRlL2FzbS1n
ZW5lcmljL3FzcGlubG9jay5oOjExMSBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6MTg3IGluY2x1
ZGUvbGludXgvc3BpbmxvY2tfYXBpX3NtcC5oOjEyMCBrZXJuZWwvbG9ja2luZy9zcGlubG9jay5j
OjE3MCkgCjwzPlsgICAzMC40NjcwOTddIFdyaXRlIG9mIHNpemUgNCBhdCBhZGRyIDAwMDAwMDAw
MDAwMDAwMDggYnkgdGFzayBzd2FwcGVyLzAvMQo8Mz5bICAgMzAuNDY4MDU5XQo8Mz5bICAgMzAu
NDY4MzkzXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHICAgIEIgICAg
ICAgICAgICBOIDYuOS4wLXJjMy1uZXh0LTIwMjQwNDEwICMxCjwzPlsgICAzMC40NjkyMDldIEhh
cmR3YXJlIG5hbWU6IGxpbnV4LGR1bW15LXZpcnQgKERUKQo8Mz5bICAgMzAuNDY5NjQ1XSBDYWxs
IHRyYWNlOgo8Mz5bIDMwLjQ2OTkxOV0gZHVtcF9iYWNrdHJhY2UgKGFyY2gvYXJtNjQva2VybmVs
L3N0YWNrdHJhY2UuYzozMTkpIAo8Mz5bIDMwLjQ3MTYyMl0gc2hvd19zdGFjayAoYXJjaC9hcm02
NC9rZXJuZWwvc3RhY2t0cmFjZS5jOjMyNikgCjwzPlsgMzAuNDcyMTI0XSBkdW1wX3N0YWNrX2x2
bCAobGliL2R1bXBfc3RhY2suYzoxMTcpIAo8Mz5bIDMwLjQ3Mjk0N10gcHJpbnRfcmVwb3J0ICht
bS9rYXNhbi9yZXBvcnQuYzo0OTMpIAo8Mz5bIDMwLjQ3Mzc1NV0ga2FzYW5fcmVwb3J0IChtbS9r
YXNhbi9yZXBvcnQuYzo2MDMpIAo8Mz5bIDMwLjQ3NDUyNF0ga2FzYW5fY2hlY2tfcmFuZ2UgKG1t
L2thc2FuL2dlbmVyaWMuYzoxNzUgbW0va2FzYW4vZ2VuZXJpYy5jOjE4OSkgCjwzPlsgMzAuNDc1
MDk0XSBfX2thc2FuX2NoZWNrX3dyaXRlIChtbS9rYXNhbi9zaGFkb3cuYzozOCkgCjwzPlsgMzAu
NDc1NjgzXSBfcmF3X3NwaW5fbG9ja19pcnEgKGluY2x1ZGUvbGludXgvaW5zdHJ1bWVudGVkLmg6
OTYgaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjEzMDEgaW5jbHVk
ZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2suaDoxMTEgaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjE4
NyBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrX2FwaV9zbXAuaDoxMjAga2VybmVsL2xvY2tpbmcvc3Bp
bmxvY2suYzoxNzApIAo8Mz5bIDMwLjQ3NjI1N10gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0
IChrZXJuZWwvc2NoZWQvY29tcGxldGlvbi5jOjg0IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6
MTE2IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6MTI3IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9u
LmM6MTY3KSAKPDM+WyAzMC40NzY5MDldIGt1bml0X3RyeV9jYXRjaF9ydW4gKGxpYi9rdW5pdC90
cnktY2F0Y2guYzo4NikgCjwzPlsgMzAuNDc3NjI4XSBrdW5pdF9ydW5fY2FzZV9jYXRjaF9lcnJv
cnMgKGxpYi9rdW5pdC90ZXN0LmM6NTQ0KSAKPDM+WyAzMC40NzgzMTFdIGt1bml0X3J1bl90ZXN0
cyAobGliL2t1bml0L3Rlc3QuYzo2MzUpIAo8Mz5bIDMwLjQ3ODg2NV0gX19rdW5pdF90ZXN0X3N1
aXRlc19pbml0IChsaWIva3VuaXQvdGVzdC5jOjcyOSAoZGlzY3JpbWluYXRvciAxKSkgCjwzPlsg
MzAuNDc5NDgyXSBrdW5pdF9ydW5fYWxsX3Rlc3RzIChsaWIva3VuaXQvZXhlY3V0b3IuYzoyNzYg
bGliL2t1bml0L2V4ZWN1dG9yLmM6MzkyKSAKPDM+WyAzMC40ODAwNzldIGtlcm5lbF9pbml0X2Zy
ZWVhYmxlIChpbml0L21haW4uYzoxNTc4KSAKPDM+WyAzMC40ODA3NDddIGtlcm5lbF9pbml0IChp
bml0L21haW4uYzoxNDY1KSAKPDM+WyAzMC40ODE0NzRdIHJldF9mcm9tX2ZvcmsgKGFyY2gvYXJt
NjQva2VybmVsL2VudHJ5LlM6ODYxKSAKPDM+WyAgIDMwLjQ4MjA4MF0gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CjwxPlsg
ICAzMC40ODQ1MDNdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAwOAo8MT5bICAgMzAuNDg1MzY5
XSBNZW0gYWJvcnQgaW5mbzoKPDE+WyAgIDMwLjQ4NTkyM10gICBFU1IgPSAweDAwMDAwMDAwOTYw
MDAwNmIKPDE+WyAgIDMwLjQ4Njk0M10gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJ
TCA9IDMyIGJpdHMKPDE+WyAgIDMwLjQ4NzU0MF0gICBTRVQgPSAwLCBGblYgPSAwCjwxPlsgICAz
MC40ODgwMDddICAgRUEgPSAwLCBTMVBUVyA9IDAKPDE+WyAgIDMwLjQ4ODUwOV0gICBGU0MgPSAw
eDJiOiBsZXZlbCAtMSB0cmFuc2xhdGlvbiBmYXVsdAo8MT5bICAgMzAuNDg5MTUwXSBEYXRhIGFi
b3J0IGluZm86CjwxPlsgICAzMC40ODk2MTBdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA2Yiwg
SVNTMiA9IDB4MDAwMDAwMDAKPDE+WyAgIDMwLjQ5MDM2MF0gICBDTSA9IDAsIFduUiA9IDEsIFRu
RCA9IDAsIFRhZ0FjY2VzcyA9IDAKPDE+WyAgIDMwLjQ5MTA1N10gICBHQ1MgPSAwLCBPdmVybGF5
ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDAKPDE+WyAgIDMwLjQ5MTgyMl0gWzAwMDAwMDAwMDAw
MDAwMDhdIHVzZXIgYWRkcmVzcyBidXQgYWN0aXZlX21tIGlzIHN3YXBwZXIKPDA+WyAgIDMwLjQ5
MzAwOF0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwNmIgWyMxXSBQUkVFTVBU
IFNNUAo8ND5bICAgMzAuNDk0MTA1XSBNb2R1bGVzIGxpbmtlZCBpbjoKPDQ+WyAgIDMwLjQ5NjI0
NF0gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgVGFpbnRlZDogRyAgICBCICAgICAgICAg
ICAgTiA2LjkuMC1yYzMtbmV4dC0yMDI0MDQxMCAjMQo8ND5bICAgMzAuNDk3MTcxXSBIYXJkd2Fy
ZSBuYW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkKPDQ+WyAgIDMwLjQ5NzkwNV0gcHN0YXRlOiAy
MjQwMDBjOSAobnpDdiBkYUlGICtQQU4gLVVBTyArVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pCjw0
PlsgMzAuNDk4ODk1XSBwYyA6IF9yYXdfc3Bpbl9sb2NrX2lycSAoYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9hdG9taWNfbHNlLmg6MjcxIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY21weGNoZy5oOjEy
MCBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NtcHhjaGcuaDoxNjkgaW5jbHVkZS9saW51eC9hdG9t
aWMvYXRvbWljLWFyY2gtZmFsbGJhY2suaDoyMDU1IGluY2x1ZGUvbGludXgvYXRvbWljL2F0b21p
Yy1hcmNoLWZhbGxiYWNrLmg6MjE3MyBpbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1
bWVudGVkLmg6MTMwMiBpbmNsdWRlL2FzbS1nZW5lcmljL3FzcGlubG9jay5oOjExMSBpbmNsdWRl
L2xpbnV4L3NwaW5sb2NrLmg6MTg3IGluY2x1ZGUvbGludXgvc3BpbmxvY2tfYXBpX3NtcC5oOjEy
MCBrZXJuZWwvbG9ja2luZy9zcGlubG9jay5jOjE3MCkgCjw0PlsgMzAuNDk5NTQyXSBsciA6IF9y
YXdfc3Bpbl9sb2NrX2lycSAoaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWFyY2gtZmFsbGJh
Y2suaDoyMTcyIChkaXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1p
bnN0cnVtZW50ZWQuaDoxMzAyIChkaXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvYXNtLWdlbmVyaWMv
cXNwaW5sb2NrLmg6MTExIChkaXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvbGludXgvc3BpbmxvY2su
aDoxODcgKGRpc2NyaW1pbmF0b3IgMSkgaW5jbHVkZS9saW51eC9zcGlubG9ja19hcGlfc21wLmg6
MTIwIChkaXNjcmltaW5hdG9yIDEpIGtlcm5lbC9sb2NraW5nL3NwaW5sb2NrLmM6MTcwIChkaXNj
cmltaW5hdG9yIDEpKSAKCjx0cmltPgoKPDQ+WyAgIDMwLjUxMTAyMl0gQ2FsbCB0cmFjZToKPDQ+
WyAzMC41MTE0MzddIF9yYXdfc3Bpbl9sb2NrX2lycSAoYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9h
dG9taWNfbHNlLmg6MjcxIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY21weGNoZy5oOjEyMCBhcmNo
L2FybTY0L2luY2x1ZGUvYXNtL2NtcHhjaGcuaDoxNjkgaW5jbHVkZS9saW51eC9hdG9taWMvYXRv
bWljLWFyY2gtZmFsbGJhY2suaDoyMDU1IGluY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1hcmNo
LWZhbGxiYWNrLmg6MjE3MyBpbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVk
Lmg6MTMwMiBpbmNsdWRlL2FzbS1nZW5lcmljL3FzcGlubG9jay5oOjExMSBpbmNsdWRlL2xpbnV4
L3NwaW5sb2NrLmg6MTg3IGluY2x1ZGUvbGludXgvc3BpbmxvY2tfYXBpX3NtcC5oOjEyMCBrZXJu
ZWwvbG9ja2luZy9zcGlubG9jay5jOjE3MCkgCjw0PlsgMzAuNTEyMDEzXSB3YWl0X2Zvcl9jb21w
bGV0aW9uX3RpbWVvdXQgKGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6ODQga2VybmVsL3NjaGVk
L2NvbXBsZXRpb24uYzoxMTYga2VybmVsL3NjaGVkL2NvbXBsZXRpb24uYzoxMjcga2VybmVsL3Nj
aGVkL2NvbXBsZXRpb24uYzoxNjcpIAo8ND5bIDMwLjUxMjYyN10ga3VuaXRfdHJ5X2NhdGNoX3J1
biAobGliL2t1bml0L3RyeS1jYXRjaC5jOjg2KSAKPDQ+WyAzMC41MTMxODhdIGt1bml0X3J1bl9j
YXNlX2NhdGNoX2Vycm9ycyAobGliL2t1bml0L3Rlc3QuYzo1NDQpIAo8ND5bIDMwLjUxMzgwMV0g
a3VuaXRfcnVuX3Rlc3RzIChsaWIva3VuaXQvdGVzdC5jOjYzNSkgCjw0PlsgMzAuNTE0Njc0XSBf
X2t1bml0X3Rlc3Rfc3VpdGVzX2luaXQgKGxpYi9rdW5pdC90ZXN0LmM6NzI5IChkaXNjcmltaW5h
dG9yIDEpKSAKPDQ+WyAzMC41MTUyNTldIGt1bml0X3J1bl9hbGxfdGVzdHMgKGxpYi9rdW5pdC9l
eGVjdXRvci5jOjI3NiBsaWIva3VuaXQvZXhlY3V0b3IuYzozOTIpIAo8ND5bIDMwLjUxNTgzMV0g
a2VybmVsX2luaXRfZnJlZWFibGUgKGluaXQvbWFpbi5jOjE1NzgpIAo8ND5bIDMwLjUxNjM4NF0g
a2VybmVsX2luaXQgKGluaXQvbWFpbi5jOjE0NjUpIAo8ND5bIDMwLjUxNjkwMF0gcmV0X2Zyb21f
Zm9yayAoYXJjaC9hcm02NC9rZXJuZWwvZW50cnkuUzo4NjEpIAo8MD5bIDMwLjUxODE1MV0gQ29k
ZTogOTM0MDdjMDIgZDUwMzIwMWYgMmEwMDAzZTEgNTI4MDAwMjIgKDg4ZTE3ZTYyKQpBbGwgY29k
ZQo9PT09PT09PQogICAwOgk5MzQwN2MwMiAJc3h0dwl4MiwgdzAKICAgNDoJZDUwMzIwMWYgCW5v
cAogICA4OgkyYTAwMDNlMSAJbW92CXcxLCB3MAogICBjOgk1MjgwMDAyMiAJbW92CXcyLCAjMHgx
ICAgICAgICAgICAgICAgICAgIAkvLyAjMQogIDEwOioJODhlMTdlNjIgCWNhc2EJdzEsIHcyLCBb
eDE5XQkJPC0tIHRyYXBwaW5nIGluc3RydWN0aW9uCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZh
dWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KICAgMDoJODhlMTdlNjIgCWNhc2EJdzEsIHcyLCBbeDE5XQo8ND5bICAgMzAuNTE5NTAx
XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPDY+WyAgIDMwLjUyMDMxN10g
bm90ZTogc3dhcHBlci8wWzFdIGV4aXRlZCB3aXRoIGlycXMgZGlzYWJsZWQKPDY+WyAgIDMwLjUy
MTM1NV0gbm90ZTogc3dhcHBlci8wWzFdIGV4aXRlZCB3aXRoIHByZWVtcHRfY291bnQgMQo8MD5b
ICAgMzAuNTIzMTI5XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtp
bGwgaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAwYgo8Mj5bICAgMzAuNTI0Mzk3XSBTTVA6IHN0b3Bw
aW5nIHNlY29uZGFyeSBDUFVzCjwwPlsgICAzMC41MjU1NTNdIEtlcm5lbCBPZmZzZXQ6IDB4MjUx
NDhkNDAwMDAwIGZyb20gMHhmZmZmODAwMDgwMDAwMDAwCjwwPlsgICAzMC41MjgzNDFdIFBIWVNf
T0ZGU0VUOiAweDQwMDAwMDAwCjwwPlsgICAzMC41MjkwMDNdIENQVSBmZWF0dXJlczogMHgwLDAw
MDAwMDA2LDhmMTdiZDdjLDY3NjY3NzNmCjwwPlsgICAzMC41MzAzMTNdIE1lbW9yeSBMaW1pdDog
bm9uZQo8MD5bICAgMzAuNTMxMzE5XSAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2lu
ZzogQXR0ZW1wdGVkIHRvIGtpbGwgaW5pdCEgZXhpdGNvZGU9MHgwMDAwMDAwYiBdLS0tCgpTdGVw
cyB0byByZXByb2R1Y2U6Ci0tLQpodHRwczovL3R1eGFwaS50dXhzdWl0ZS5jb20vdjEvZ3JvdXBz
L2xpbmFyby9wcm9qZWN0cy9sa2Z0L3Rlc3RzLzJldGRDejYzMUdVNlBJTEp6czhyZXRlYmE4aS9y
ZXByb2R1Y2VyCgpMaW5rczoKIC0gaHR0cHM6Ly9xYS1yZXBvcnRzLmxpbmFyby5vcmcvbGtmdC9s
aW51eC1uZXh0LW1hc3Rlci9idWlsZC9uZXh0LTIwMjQwNDEwL3Rlc3RydW4vMjMzODE4ODEvc3Vp
dGUvbG9nLXBhcnNlci10ZXN0L3Rlc3RzLwogLSBodHRwczovL3R1eGFwaS50dXhzdWl0ZS5jb20v
djEvZ3JvdXBzL2xpbmFyby9wcm9qZWN0cy9sa2Z0L3Rlc3RzLzJldGRDejYzMUdVNlBJTEp6czhy
ZXRlYmE4aQogLSBodHRwczovL3R1eGFwaS50dXhzdWl0ZS5jb20vdjEvZ3JvdXBzL2xpbmFyby9w
cm9qZWN0cy9sa2Z0L3Rlc3RzLzJldGREamx4M2VSRmhoSzljeTJVc0VIQVhUcgoKLS0KTGluYXJv
IExLRlQKaHR0cHM6Ly9sa2Z0LmxpbmFyby5vcmcK
--00000000000057046d0615c12d20--

