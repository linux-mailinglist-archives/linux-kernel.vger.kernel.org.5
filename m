Return-Path: <linux-kernel+bounces-126630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B814893AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CAE1C20E24
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2D219E0;
	Mon,  1 Apr 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igO2lJkD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28720D26D;
	Mon,  1 Apr 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971644; cv=none; b=My3gYEylgKR9id+8dyg4ATE4DTuPJB2UkIGZGmhNpIngubErzzsNlZ/7D5yXSHpy4jskbJ9QEarBX9QVvOy+Lg10gBpzjRAHsDxf9pcB/QHzhyXUnHMeUjrBOPY3SN9z+kMc7V1r0JRds2s96hhdMmrHxR5636CO1s9EEGH5xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971644; c=relaxed/simple;
	bh=k+5Kh43lmEKhaWpzppn28cWTYZoyyV2D1O4QTDXQiU8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bxVNeUs0UiJ7z9wMmEQl9f1JBvJOfCm41eVVOaMQMqvqQlyFGZlpRVcz+FPw6tMgQuiXAaSufTWptPaYtlir62vKoV0O+uoA8B61tW97rE4SquT8E3jEGEBWeyt3Z3KotLvYia6DaX5urubuKjtphJp2jEgmlprxtrb1bRGGFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igO2lJkD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0ae065d24so32167515ad.1;
        Mon, 01 Apr 2024 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711971642; x=1712576442; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+5Kh43lmEKhaWpzppn28cWTYZoyyV2D1O4QTDXQiU8=;
        b=igO2lJkDiB6tocFuBdluipfWqY11n2++A/AMOPBueONJ5Dvl6nXEJainjKq5DDgR2N
         7B5hd99qZJbTSwlfFrTmhAac2xBKtmGJsL2LQLApt0G+VvCPZPiEvpRVTj9P5yIrNyVf
         u9zDQtJGB9jW83Dlszm2OKtk3+N5dw/dFwNtkrAbd5jEuTZhxA4H71kCI3C9bsXPv0I4
         QmEOxILtJbvfa0Q0uRHWR9EUHgTsqm3I9/vgivtSHn0t+Wg5B5zBrym9MeVqOqZ2N8S1
         4igo+vixsWiUR80HnVS+oZvhBLkXh/TcmQuVUHA1jW7D2F+7S4Rjw/O+va4KgvK7CpsA
         CFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711971642; x=1712576442;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+5Kh43lmEKhaWpzppn28cWTYZoyyV2D1O4QTDXQiU8=;
        b=FJ+oxdDanmS5aF+kjTsQSSEIPSrdRMsTPOp52r7QVQgtuJtO3hpJue4Tl7k5c7d0Pm
         55mGs20DZeAWss3km0VgSDau+tpNtUma33YvOXLCmwd4I0KeBNJ70UwaTHXFjY1ruc/t
         mkbeeMgIPC7TJQtklhQXFxjC8EyBxyQW0p8gz+u3hIPUKvnkNkvfu3OtFEBfWnjjGbKF
         HMLaU+qCCjU6fESEA1iP+OMU4Dp5knr7+znwVR9tfe0K7TmsqXoSS/TaPnnVCa+96vEd
         Bkwbt1UAFuRhPUHho8CKs5/Kg1gMIfkkfudFdGF2fwzxQ2Chv4eDulnU1sxxbqhShMRy
         UPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUlZdTtxJ/lNH7cUFLJyZFfzGfcv8shNYESn7Vdw8FGJGhD7BZ52WKwT3Rj/5I7hBw/psK4YZHAcqfsvk38t2rKaswR2/XDpPUy1A9xFYCiyi9Lf62QbQFoBGcYp4AsNA
X-Gm-Message-State: AOJu0YxajryFhkXXZF33a+Gp+2SfLP8hnCRS9QPaQfkpLz1Ui4oi3O2S
	213d5tqWS6MbGx+uYatTCi4XniIAkKiYrg93j6ob3B/bIM8R2/nx
X-Google-Smtp-Source: AGHT+IH1a5pm/+I8WEwCFFnBuN8p5aHG31Skc60qButFtHJsPmi1DJDY7UukKuHigPp5uRRXG6IqVg==
X-Received: by 2002:a17:902:ce91:b0:1e0:2335:8f77 with SMTP id f17-20020a170902ce9100b001e023358f77mr9520945plg.54.1711971642333;
        Mon, 01 Apr 2024 04:40:42 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001d8f81ecea1sm8721569plf.172.2024.04.01.04.40.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 04:40:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
Date: Mon, 1 Apr 2024 19:40:24 +0800
Cc: Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org,
 x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <073E72BD-63AF-4D88-95F8-9A002252C554@gmail.com>
References: <20240328075318.83039-3-jiangshanlai@gmail.com>
 <769AEAAB-7DEA-4D94-8979-F01EDFD6EE46@joelfernandes.org>
 <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

2024=E5=B9=B44=E6=9C=881=E6=97=A5 00:16=EF=BC=8CLai Jiangshan =
<jiangshanlai@gmail.com> wrote=EF=BC=9A
>=20
> On Sun, Mar 31, 2024 at 7:10=E2=80=AFPM Joel Fernandes =
<joel@joelfernandes.org> wrote:
>>=20
>>=20
>>=20
>>> On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan =
<jiangshanlai@gmail.com> wrote:
>>>=20
>>> =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>>=20
>>> Prepare for arch-specific-defined rcu_preempt_depth_set().
>>>=20
>>> No functionality change intended, but it has to be defined as a =
macro
>>> as rcupdate.h is a very low level header included from areas that =
don't
>>> even know about the task struct "current".
>>=20
>> Sorry I did not follow changelog. If some rcupdate.h includers do not =
know
>> about task_struct, how does adding a macro that uses current help?
>>=20
>=20
> Hello
>=20
> This is how macro works and it expands blindly based on tokens on the
> usage-sites.

But =E2=80=98current=E2=80=99 still needs to be expanded at last, it =
seems to me that it only affects=20
the including order of the header files=EF=BC=9F

Or what am I missing?

>=20
> And rcu_preempt_depth() & rcu_preempt_depth_set() are not universally
> used wrappers, the user can simply also include linux/sched.h to make
> they work.
>=20
> Thanks
> Lai
>=20


