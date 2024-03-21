Return-Path: <linux-kernel+bounces-110032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD488591A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B16284949
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA57992D;
	Thu, 21 Mar 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgDiIYH2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0878B41;
	Thu, 21 Mar 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024257; cv=none; b=tPQRDUkvE7OGYKcOjZanRgZG+uIWfSnYr86KWDExsjix/LCSbVZ2z1Lgmfn6FKBlPH91MC6saza2QL3NOf/bggjmzTj/w9HHDPLJLASfVQApJEwb2Xk+JwHQtW1nGL3RV1sMhULIeiFNJALUSGIo5EGgrabJNflmGVXgnyniljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024257; c=relaxed/simple;
	bh=c0G7y4064kWepgY4H9XjLAUB71A1ERH33FepzlttQiw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFwEhEnULvUMyzPWp0LDHouc2hihzNr4bLm8RMCTRnZAlxKWoL5jYDaKjWph/E93hG8TaosepKZhagfpcmRcKi+etcgZtv547doTgJ3bNp3YVFfdHKFInZDsUKbztlACMYNOzQCUVRUvkipI20MQFJONEDt50h4guh9XrNzZMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgDiIYH2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso14976101fa.2;
        Thu, 21 Mar 2024 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711024253; x=1711629053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFNB2YjBMfxGKEHlP6iEiBMA46z7+jm+qO12uAk7rtc=;
        b=XgDiIYH26Q2NKceyVoJkmCgjwfAaZrTX+lTFmsRiMaxgls5wg9dZ7gdduH3mrHx9B1
         PpgkNbqnu99HjpJoW0/L1JByzVaNFZfAZM7602GUcAYMJ9zi8pfzA5f7VDEh+uQTWeLS
         plL+R116ZT4QO7x72nUSK3m0SJDcGu9hnQIbUPYab1UjZ3FyPWZzJFRoQb1Gow2D15ni
         tzpEaL85BpIYTQ0NfocvI4jW8A0mWgRLA5fql8NepxPQ2O+4o66h0gsb83bvdcUqpER+
         CHI2nanBLYWYYAEamhe+rOwTywVxtkCcDzmT4R9n0NaVmQ2hibLCS5w/bBmBs6lurCfo
         U/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024253; x=1711629053;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bFNB2YjBMfxGKEHlP6iEiBMA46z7+jm+qO12uAk7rtc=;
        b=SFPftLeXCX6Dii0IS/eg9uSexwMEP2soxB6AXeK4AwOHDHlOQ8zQfD04TTMY2pATvz
         VNZCdXOQa+YYgh6yIl73rI30zA10gUcMZInbidCKXoCbk1xFOc+H1/nZtPaaoDgIkFxe
         PUA+QtSdAubQ5mboUuwH0hIUJXEJ6igNj0hB/kIcc/pJ6QeNlaY9syn4YTo8nVlTH096
         WXiyJLmtvBDDI8GlA1tlxF/RbYBeJY7Yd1Z8kYI2o38yqb7lWPQ5pfoNDlPXIZKXotu8
         8CMkqkhy9wZ+oys047Zv+FijR6LE3DsU0hkmw4VVnP6FKvSzplXYYMDKOtCajHAALBmo
         LDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVFdbS8EK0pXX4+kEnKWUTrYrxBmltJFS+/6+6CptFO+aWkqwyb6b4e7sf1QcPbyCWLJjNPwNqi/DcjiKDzDCov2iYLs88Vof8xacDcJrAwqL7kydCypmMSEUwaNHJ+X/LhoAXB66DSRBP65Fn/1NoQ7F3t55Prtn+G
X-Gm-Message-State: AOJu0Yxxs/pI/5G9GXsgEoTyVgea5zSk35KK0xmr8UZ0cwVO/ZpNudMy
	wn8gvIXPrQuBoZm1+WQz8dosFsKZ6m0oY/9UXaPgv4/cLvnXYL8k
X-Google-Smtp-Source: AGHT+IHRmxGvDvujXJKy8YCykfAQPUrAoCqJrKq5arIkSLnLCgR+gFQvWK7O6fih7VbEH+809JVDVw==
X-Received: by 2002:a2e:b8cb:0:b0:2d3:f81b:7f9 with SMTP id s11-20020a2eb8cb000000b002d3f81b07f9mr4350662ljp.21.1711024253003;
        Thu, 21 Mar 2024 05:30:53 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00414038b4d64sm5442657wmo.27.2024.03.21.05.30.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 05:30:52 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3] bpf: verifier: prevent userspace memory access
In-Reply-To: <2ef29d6b7ed800631f228ea41f27c0242e96f941.camel@linux.ibm.com>
References: <20240321120842.78983-1-puranjay12@gmail.com>
 <2ef29d6b7ed800631f228ea41f27c0242e96f941.camel@linux.ibm.com>
Date: Thu, 21 Mar 2024 12:30:50 +0000
Message-ID: <mb61p4jczix6t.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Thu, 2024-03-21 at 12:08 +0000, Puranjay Mohan wrote:
>> With BPF_PROBE_MEM, BPF allows de-referencing an untrusted pointer.
>> To
>> thwart invalid memory accesses, the JITs add an exception table entry
>> for all such accesses. But in case the src_reg + offset overflows and
>> turns into a userspace address, the BPF program might read that
>> memory if
>> the user has mapped it.
>>=20
>> There are architectural features that prevent the kernel from
>> accessing
>> userspace memory, like Privileged Access Never (PAN) on ARM64,
>> Supervisor Mode Access Prevention (SMAP) on x86-64, Supervisor User
>> Memory access (SUM) on RISC-V, etc. But BPF should not rely on the
>> existence of these features.
>>=20
>> Make the verifier add guard instructions around such memory accesses
>> and
>> skip the load if the address falls into the userspace region.
>>=20
>> The JITs need to implement bpf_arch_uaddress_limit() to define where
>> the userspace addresses end for that architecture or TASK_SIZE is
>> taken
>> as default.
>>=20
>> The implementation is as follows:
>>=20
>> REG_AX =3D=C2=A0 SRC_REG
>> if(offset)
>> 	REG_AX +=3D offset;
>> REG_AX >>=3D 32;
>> if (REG_AX <=3D (uaddress_limit >> 32))
>> 	DST_REG =3D 0;
>> else
>> 	DST_REG =3D *(size *)(SRC_REG + offset);
>>=20
>> Comparing just the upper 32 bits of the load address with the upper
>> 32 bits of uaddress_limit implies that the values are being aligned
>> down
>> to a 4GB boundary before comparison.
>>=20
>> The above means that all loads with address <=3D uaddress_limit + 4GB
>> are
>> skipped. This is acceptable because there is a large hole (much
>> larger
>> than 4GB) between userspace and kernel space memory, therefore a
>> correctly functioning BPF program should not access this 4GB memory
>> above the userspace.
>>=20
>> Let's analyze what this patch does to the following fentry program
>> dereferencing an untrusted pointer:
>>=20
>> =C2=A0 SEC("fentry/tcp_v4_connect")
>> =C2=A0 int BPF_PROG(fentry_tcp_v4_connect, struct sock *sk)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *(volatile long *)sk;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>=20
>> =C2=A0=C2=A0=C2=A0 BPF Program before=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF Program after
>> =C2=A0=C2=A0=C2=A0 ------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------
>>=20
>> =C2=A0 0: (79) r1 =3D *(u64 *)(r1 +0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0: (79) r1 =3D *(u64 *)(r1 +0)
>> =C2=A0 -----------------------------------------------------------------=
--
>> ----
>> =C2=A0 1: (79) r1 =3D *(u64 *)(r1 +0) --\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
1: (bf) r11 =3D r1
>> =C2=A0 ----------------------------\=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=
=A0 2: (77) r11 >>=3D 32
>> =C2=A0 2: (b7) r0 =3D 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0 3: (=
b5) if r11 <=3D 0x8000 goto
>> pc+2
>> =C2=A0 3: (95) exit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0 \-> 4: (7=
9) r1 =3D *(u64 *)(r1 +0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 5: (05) goto pc+1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=
=A0 6: (b7) r1 =3D 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \----------------=
-----------------
>> -----
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 7: (b7) r0 =3D 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8: (95) exit
>>=20
>> As you can see from above, in the best case (off=3D0), 5 extra
>> instructions
>> are emitted.
>>=20
>> Now, we analyse the same program after it has gone through the JITs
>> of
>> X86-64, ARM64, and RISC-V architectures. We follow the single load
>> instruction that has the untrusted pointer and see what
>> instrumentation
>> has been added around it.
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86-64 JIT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0=C2=A0=C2=A0=C2=A0 JIT's Instrumentation=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Verifier's
>> Instrumentation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (upstream)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (This patch)
>> =C2=A0=C2=A0=C2=A0=C2=A0 ---------------------=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -------------------------
>> -
>>=20
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 nopl=C2=A0=C2=A0 0x0(%rax,%rax,1)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=
=A0 nopl=C2=A0=C2=A0
>> 0x0(%rax,%rax,1)
>> =C2=A0=C2=A0 5:=C2=A0=C2=A0 xchg=C2=A0=C2=A0 %ax,%ax=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5:=C2=A0=C2=A0 xchg=C2=A0=C2=A0 %ax,%ax
>> =C2=A0=C2=A0 7:=C2=A0=C2=A0 push=C2=A0=C2=A0 %rbp=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7:=C2=A0=C2=A0 push=C2=A0=
=C2=A0 %rbp
>> =C2=A0=C2=A0 8:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rsp,%rbp=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rsp,%rbp
>> =C2=A0=C2=A0 b:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x0(%rdi),%rdi=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 b:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0
>> 0x0(%rdi),%rdi
>> =C2=A0 -----------------------------------------------------------------=
--
>> -----
>> =C2=A0=C2=A0 f:=C2=A0=C2=A0 movabs $0x800000000000,%r11=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rdi=
,%r10
>> =C2=A0 19:=C2=A0=C2=A0 cmp=C2=A0=C2=A0=C2=A0 %r11,%rdi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 12:=C2=A0=C2=A0 shr=C2=A0=C2=A0=C2=A0 $0x20,%r10
>> =C2=A0 1c:=C2=A0=C2=A0 jb=C2=A0=C2=A0=C2=A0=C2=A0 0x000000000000002a=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16:=C2=A0=C2=A0 cmp=C2=
=A0=C2=A0=C2=A0 $0x8000,%r10
>> =C2=A0 1e:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rdi,%r11=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1d:=C2=A0=C2=A0 jbe=C2=A0=C2=A0=C2=A0
>> 0x0000000000000025
>> =C2=A0 21:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0 $0x0,%r11=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /--> 1f:=C2=A0=
=C2=A0 mov=C2=A0=C2=A0=C2=A0
>> 0x0(%rdi),%rdi
>> =C2=A0 28:=C2=A0=C2=A0 jae=C2=A0=C2=A0=C2=A0 0x000000000000002e=C2=A0=C2=
=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0 23:=C2=A0=C2=A0 jmp=C2=A0=C2=A0=C2=A0
>> 0x0000000000000027
>> =C2=A0 2a:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %edi,%edi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 25:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %edi,%edi
>> =C2=A0 2c:=C2=A0=C2=A0 jmp=C2=A0=C2=A0=C2=A0 0x0000000000000032=C2=A0 / =
/-------------------------------
>> -----
>> =C2=A0 2e:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x0(%rdi),%rdi=C2=A0 ---/ /=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %eax,%=
eax
>> =C2=A0 ---------------------------------/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 29:=C2=A0=C2=A0 leave
>> =C2=A0 32:=C2=A0=C2=A0 xor=C2=A0=C2=A0=C2=A0 %eax,%eax=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2a:=C2=A0=C2=A0 ret
>> =C2=A0 34:=C2=A0=C2=A0 leave
>> =C2=A0 35:=C2=A0=C2=A0 ret
>>=20
>> The x86-64 JIT already emits some instructions to protect against
>> user
>> memory access. The implementation in this patch leads to a smaller
>> number of instructions being emitted. In the worst case the JIT will
>> emit 9 extra instructions and this patch decreases it to 7.
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM64 JIT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No Intrumentation=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Verifier's
>> Instrumentation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (upstream)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (This patch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---------------------
>> -----
>>=20
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 x9, x30, #0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 x9, x30,
>> #0x0
>> =C2=A0=C2=A0 4:=C2=A0=C2=A0 nop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4:=C2=A0=C2=A0 nop
>> =C2=A0=C2=A0 8:=C2=A0=C2=A0 paciasp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=
=A0 paciasp
>> =C2=A0=C2=A0 c:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=C2=A0 x29, x30, [sp, #=
-16]!=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c:=C2=A0=C2=A0 stp=C2=A0=C2=
=A0=C2=A0=C2=A0 x29, x30,
>> [sp, #-16]!
>> =C2=A0 10:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 x29, sp=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=
=A0 x29, sp
>> =C2=A0 14:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=C2=A0 x19, x20, [sp, #-16]!=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=
=C2=A0 x19, x20,
>> [sp, #-16]!
>> =C2=A0 18:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=C2=A0 x21, x22, [sp, #-16]!=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=
=C2=A0 x21, x22,
>> [sp, #-16]!
>> =C2=A0 1c:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=C2=A0 x25, x26, [sp, #-16]!=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1c:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=
=C2=A0 x25, x26,
>> [sp, #-16]!
>> =C2=A0 20:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=C2=A0 x27, x28, [sp, #-16]!=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20:=C2=A0=C2=A0 stp=C2=A0=C2=A0=C2=A0=
=C2=A0 x27, x28,
>> [sp, #-16]!
>> =C2=A0 24:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 x25, sp=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=
=A0 x25, sp
>> =C2=A0 28:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 x26, #0x0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 28:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 x26, #0x0
>> =C2=A0 2c:=C2=A0=C2=A0 sub=C2=A0=C2=A0=C2=A0=C2=A0 x27, x25, #0x0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2c=
:=C2=A0=C2=A0 sub=C2=A0=C2=A0=C2=A0=C2=A0 x27, x25,
>> #0x0
>> =C2=A0 30:=C2=A0=C2=A0 sub=C2=A0=C2=A0=C2=A0=C2=A0 sp, sp, #0x0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 30:=C2=A0=C2=A0 sub=C2=A0=C2=A0=C2=A0=C2=A0 sp, sp,
>> #0x0
>> =C2=A0 34:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=C2=A0 x0, [x0]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 34:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=C2=A0 x0,=
 [x0]
>> ---------------------------------------------------------------------
>> -----------
>> =C2=A0 38:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=C2=A0 x0, [x0] ----------\=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 38:=C2=A0=C2=A0 add=C2=A0=C2=A0=
=C2=A0=C2=A0 x9, x0,
>> #0x0
>> -----------------------------------\\=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 3c:=C2=A0=C2=A0 lsr=C2=A0=C2=A0=C2=A0=C2=A0 x9, x9, #32
>> =C2=A0 3c:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 x7, #0x0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \\=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 40:=C2=A0=C2=A0 cmp=C2=A0=C2=A0=C2=A0=C2=A0 x9, #0x10,
>> lsl #12
>> =C2=A0 40:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 sp, sp=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \\=C2=
=A0=C2=A0=C2=A0=C2=A0 44:=C2=A0=C2=A0 b.ls=C2=A0=C2=A0=C2=A0
>> 0x0000000000000050
>> =C2=A0 44:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x27, x28, [sp], #16=
=C2=A0=C2=A0 \\--> 48:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=C2=A0 x0, [x0]
>> =C2=A0 48:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x25, x26, [sp], #16=
=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0 4c:=C2=A0=C2=A0 b=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
>> 0x0000000000000054
>> =C2=A0 4c:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x21, x22, [sp], #16=
=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0 50:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=
=A0=C2=A0 x0, #0x0
>> =C2=A0 50:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x19, x20, [sp], #16=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \---------------------------
>> ------------
>> =C2=A0 54:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x29, x30, [sp], #16=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54:=C2=A0=C2=A0 mov=C2=A0=
=C2=A0=C2=A0=C2=A0 x7, #0x0
>> =C2=A0 58:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=C2=A0 x0, x7, #0x0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 58:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=C2=A0 sp, sp
>> =C2=A0 5c:=C2=A0=C2=A0 autiasp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5c:=C2=A0=C2=A0 ldp=C2=
=A0=C2=A0=C2=A0=C2=A0 x27, x28,
>> [sp], #16
>> =C2=A0 60:=C2=A0=C2=A0 ret=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 60=
:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x25, x26,
>> [sp], #16
>> =C2=A0 64:=C2=A0=C2=A0 nop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64=
:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x21, x22,
>> [sp], #16
>> =C2=A0 68:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=C2=A0 x10, 0x00000000000000=
70=C2=A0=C2=A0=C2=A0=C2=A0 68:=C2=A0=C2=A0 ldp=C2=A0=C2=A0=C2=A0=C2=A0 x19,=
 x20,
>> [sp], #16
>> =C2=A0 6c:=C2=A0=C2=A0 br=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x10=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6c:=C2=A0=C2=A0 l=
dp=C2=A0=C2=A0=C2=A0=C2=A0 x29, x30,
>> [sp], #16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 70:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=A0=
=C2=A0 x0, x7,
>> #0x0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 74:=C2=A0=C2=A0 autiasp
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 78:=C2=A0=C2=A0 ret
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7c:=C2=A0=C2=A0 nop
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80:=C2=A0=C2=A0 ldr=C2=A0=C2=A0=C2=A0=
=C2=A0 x10,
>> 0x0000000000000088
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 84:=C2=A0=C2=A0 br=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 x10
>>=20
>> There are 6 extra instructions added in ARM64 in the best case. This
>> will
>> become 7 in the worst case (off !=3D 0).
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 RISC-V JIT (RISCV_ISA_C Disabled)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No Intrumentation=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Verifier's Instrumentation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (upstream)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (This patch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -----------------=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --------------------------
>>=20
>> =C2=A0=C2=A0 0:=C2=A0=C2=A0 nop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0 nop
>> =C2=A0=C2=A0 4:=C2=A0=C2=A0 nop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4:=C2=A0=C2=A0 nop
>> =C2=A0=C2=A0 8:=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a6, 33=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 8:=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a6, 33
>> =C2=A0=C2=A0 c:=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 sp, sp, -16=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c:=C2=A0=C2=A0 ad=
di=C2=A0=C2=A0=C2=A0 sp, sp, -16
>> =C2=A0 10:=C2=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0, 8(sp)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10:=C2=
=A0=C2=A0 sd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0, 8(sp)
>> =C2=A0 14:=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 s0, sp, 16=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14:=C2=A0=C2=A0 addi=C2=
=A0=C2=A0=C2=A0 s0, sp, 16
>> =C2=A0 18:=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, 0(a0)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18:=C2=
=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, 0(a0)
>> ---------------------------------------------------------------
>> =C2=A0 1c:=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, 0(a0) --\=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1c:=C2=A0=C2=A0 mv=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 t0, a0
>> --------------------------\=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 20:=C2=A0=C2=A0 srli=C2=A0=C2=A0=C2=A0 t0, t0, 32
>> =C2=A0 20:=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a5, 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24:=C2=
=A0=C2=A0 lui=C2=A0=C2=A0=C2=A0=C2=A0 t1, 4096
>> =C2=A0 24:=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0, 8(sp)=C2=A0=
=C2=A0 \=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28:=C2=A0=C2=A0 sext.w=C2=A0=
 t1, t1
>> =C2=A0 28:=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 sp, sp, 16=C2=A0=C2=A0 \=
=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0 2c:=C2=A0=C2=A0 bgeu=C2=A0=C2=A0=C2=A0 t1,=
 t0, 12
>> =C2=A0 2c:=C2=A0=C2=A0 sext.w=C2=A0 a0, a5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \=C2=A0 \--> 30:=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
a0, 0(a0)
>> =C2=A0 30:=C2=A0=C2=A0 ret=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 34:=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0 38:=C2=A0=
=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \----------------------------=
--
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3c:=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a5, 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 40:=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0, 8(sp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 44:=C2=A0=C2=A0 addi=C2=A0=C2=A0=C2=A0 sp, sp, 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 48:=C2=A0=C2=A0 sext.w=C2=A0 a0, a5
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 4c:=C2=A0=C2=A0 ret
>>=20
>> There are 7 extra instructions added in RISC-V.
>>=20
>> Fixes: 800834285361 ("bpf, arm64: Add BPF exception tables")
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>> V2:
>> https://lore.kernel.org/bpf/20240321101058.68530-1-puranjay12@gmail.com/
>> Changes in V3:
>> - Return 0 from bpf_arch_uaddress_limit() in disabled case because it
>> =C2=A0 returns u64.
>> - Modify the check in verifier to no do instrumentation when
>> uaddress_limit
>> =C2=A0 is 0.
>>=20
>> V1:
>> https://lore.kernel.org/bpf/20240320105436.4781-1-puranjay12@gmail.com/
>> Changes in V2:
>> - Disable this feature on s390x.
>> ---
>> =C2=A0arch/s390/net/bpf_jit_comp.c |=C2=A0 5 +++
>> =C2=A0arch/x86/net/bpf_jit_comp.c=C2=A0 | 72 ++++-----------------------=
-------
>> --
>> =C2=A0include/linux/filter.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
>> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++
>> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
30 +++++++++++++++
>> =C2=A05 files changed, 53 insertions(+), 64 deletions(-)
>
> [...]
> =C2=A0
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 5aacb1d3c4cc..c131bee33ac3 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2958,6 +2958,15 @@ bool __weak bpf_jit_supports_arena(void)
>> =C2=A0	return false;
>> =C2=A0}
>> =C2=A0
>> +u64 __weak bpf_arch_uaddress_limit(void)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return TASK_SIZE;
>> +#else
>> +	return 0;
>> +#endif
>> +}
>> +
>
> How about the following?
>
> #if defined(CONFIG_64BIT) &&=C2=A0\
>     defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
>
> Then we won't need to do anything for s390x explicitly.`

Thanks for the suggestion, I will use this in v4.

