Return-Path: <linux-kernel+bounces-112837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D7887EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996931F21119
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50147199BC;
	Sun, 24 Mar 2024 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDJ0xsgi"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158533EE;
	Sun, 24 Mar 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313001; cv=none; b=R/IBHrI/VhKZq+dV4jnxpO2Rx8zuRBwnSWq3foQPfUFZptbUDQmDMOkxn17jZFG/D/l16LanZNBpX3/+DWvLzQY3u3RpH25BjZRO8mgkych8fqFzMlnNK8ju+QGIZ5BQJ8l9IE24qalLcVzPVFQZzEatrrHCYhBAHOvyeOGcMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313001; c=relaxed/simple;
	bh=BWpC5Sb75blq1j1DSHb+BAr/ABqvga9SnLzwpTWDWFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shj20MJaYo7s64SW66Y7AhlwIMwm4c9KTkUaoTYBtscNQazW/x5hUbESrXkVsm6idHkX3tpFEBzB410PjD2b6Xb9tcNSUbmnPPChcYOV2AakbA4IUcSMyE2q//RgpSTsBHBEJDmcUw70LY6F/N7cJNpwipS0f2yvuxEQro0jeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDJ0xsgi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33edbc5932bso2648483f8f.3;
        Sun, 24 Mar 2024 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711312998; x=1711917798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHiCJgwsQKJHisSLfnjluPrewQvoA1WkSLlpjUnXjuI=;
        b=XDJ0xsgiI8AOcofSHtqtsCE5otWVjKmG/9aXCmPEE4u6UWK3KXt4CFmbB7pylujag3
         /nBmNg28by+xvb7biAVogYa5T4ZlziHP6bwLnBJubjIu5hDLENaz2nZ2J55LlfyUda2J
         mgV4/F4sIBhEQKPnwdr0dIPO0DGMm20Kcgs5v80Gi4mB7M90K0yPhFcCNdhF7tCxRELi
         x0Y5vZ/ImURYI7iNRbXE8hoOkTbdTCaI8GeANJO4jMSLxt71XD/2zJhs2BWNiMRIltMi
         7YSWE+dSwQJZ7EVXSJHdS77tYpErvHnrtnqYZANzkXoLbABJxBsWBZQhAZlK7BrB9HcI
         gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711312998; x=1711917798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHiCJgwsQKJHisSLfnjluPrewQvoA1WkSLlpjUnXjuI=;
        b=KNbzxr9EDmF7c7Ed9r8Hc/jybhFi5riafYL2DKq4SSkLWg+pB69Do8lZAI1ZEyxiS+
         5PU1wpZ2MLjqcC8kqTO+SNfxmicBZwMmAeYqqX1fw6DI4fGMumQkvCwf0RWge6UWycsB
         I7szsbE3B9t2mLP/iQZCqIZZucJQyrtjao+gy+Gt2WqyESUnXa9MganoGSHfHwbSolc4
         vFuxJ3uPmYWUIu3qkkGxaBR3eaF+3LJOp/BWdXVE9mOhpKHFhhyCV5pkobFwYkAtz9tk
         SkHKNo361uyI4Wws6oOoMwWRW7IIfXFigWSsnz78KFEO/lenO+CXHx2CH/+ATBkdFZdC
         gP6w==
X-Forwarded-Encrypted: i=1; AJvYcCW8c+LF2Zhl9Du90G0DMeR5EAVPHebab9ftgx1pdzZKQ+SDedUNrKhjno16rCiNqHk/tREiuSoWGwB4G6bmLMJU79nN39B9FQM0dkJJSh1oQQdPqiVeCZNxeQtmqko/ZfhuNrlD84/Lp7coU65ionEwJq4UP0STV5yC
X-Gm-Message-State: AOJu0YxyMoCmBPeO0ytU4mWKJwXP3XN/9vjqXP96Er+XdU2WHqi3B9et
	xP50PLmyyuBzKhipRVH8Oi/xJh7PlM0SsQB3oSlL8i0qk9tacYa5nFMvMt01/KluAZ8ooql4YEt
	grzSm10LztB9eQaowR3Cke1hHSCo=
X-Google-Smtp-Source: AGHT+IFoiwVmSJXpx+u8eZwRD+8Ldre0v1Olns54nZKxRx8/MslmrdcRAB9ZhVFcHGzG8mgvOd4r/s/Ohlf+su+loBc=
X-Received: by 2002:a5d:69d0:0:b0:341:bf1e:45a5 with SMTP id
 s16-20020a5d69d0000000b00341bf1e45a5mr3460066wrw.46.1711312997972; Sun, 24
 Mar 2024 13:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320105436.4781-1-puranjay12@gmail.com> <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
 <1686adb401b34adaa3b703ec1a8ffe49@AcuMS.aculab.com>
In-Reply-To: <1686adb401b34adaa3b703ec1a8ffe49@AcuMS.aculab.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 13:43:06 -0700
Message-ID: <CAADnVQJzfnK0Mv6HVKZ38VDuAemzbmSMeYscf77YoEy0SgWw+A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: verifier: prevent userspace memory access
To: David Laight <David.Laight@aculab.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 1:05=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Alexei Starovoitov
> > Sent: 21 March 2024 06:08
> >
> > On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > The JITs need to implement bpf_arch_uaddress_limit() to define where
> > > the userspace addresses end for that architecture or TASK_SIZE is tak=
en
> > > as default.
> > >
> > > The implementation is as follows:
> > >
> > > REG_AX =3D  SRC_REG
> > > if(offset)
> > >         REG_AX +=3D offset;
> > > REG_AX >>=3D 32;
> > > if (REG_AX <=3D (uaddress_limit >> 32))
> > >         DST_REG =3D 0;
> > > else
> > >         DST_REG =3D *(size *)(SRC_REG + offset);
> >
> > The patch looks good, but it seems to be causing s390 CI failures.
>
> I'm confused by the need for this check (and, IIRC, some other bpf
> code that does kernel copies that can fault - and return an error).
>
> I though that the entire point of bpf was that is sanitised and
> verified everything to limit what the 'program' could do in order
> to stop it overwriting (or even reading) kernel structures that
> is wasn't supposed to access.
>
> So it just shouldn't have a address that might be (in any way)
> invalid.

bpf tracing progs can call bpf_probe_read_kernel() which
can read any kernel memory.
This is nothing but an inlined version of it.

> The only possible address verify is access_ok() to ensure that
> a uses address really is a user address.

access_ok() considerations don't apply.
We're not dealing with user memory access.

