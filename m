Return-Path: <linux-kernel+bounces-126639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB2893AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9D28166A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CE2230C;
	Mon,  1 Apr 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgEVMuqh"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C474210F8;
	Mon,  1 Apr 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972679; cv=none; b=mdv9eSlDgjqXTowWXSuiiLGUYlMvldRlM8TIA96WJ/vLzFBjimZ57ThoZ94ArZySJgobqaFqHqYTVuzNuWJ56KDQneRR3QoGwhG/eByrZF8wPQeXH4jv3fF+fn8klrER1FJrDOQb5Js90a2v3CXZBABhWSNF/Nzp6HPDAEtoZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972679; c=relaxed/simple;
	bh=mi4ERWJ5mQ9smqXixw6WRIR0rmjAkZ8wCu1qA/SAFRw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EfEofpyK8/tz3Uz6y9Mb9geHjReVuTrLnPvahG9SqbrhYKHKf0ILWYko5f7sGYtxX6Q3hBj9yxomwawy8W1XGTG7uszps77mm3PQArbOYMgj2MtTUPDFsB5Y/k5/76GTPhLmJDgx7yZJsDYFKUyYkbDvrYCDyNECmlmwEmKz+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgEVMuqh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29df3333d30so2846940a91.1;
        Mon, 01 Apr 2024 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711972677; x=1712577477; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi4ERWJ5mQ9smqXixw6WRIR0rmjAkZ8wCu1qA/SAFRw=;
        b=ZgEVMuqhiQ7kBnWtgZ9PUIdJfgs7a3jwMrqM8Y1m6/KQSQ9OYkOohyUDO6wri1ce/q
         aog8gOhWWz0gWO7cwbPW3zVyztAmqLwH6ISYAIqftoEXu/LomqimsYkNJOBn/aYEIX7a
         2mInudbBocpBQ5iumwiUDr+h1PeN92XNx+P6iOGj0ohuIh3ZswJ37bSgu2pbQ0PjyTO2
         BLfWy8sfID1OeFobfjGDnH+FdoqHCD5nHrFNnfX2dyQaL1/YWPi+QKEoPid8jEbEn1Fz
         hhghaEUFOXXVsZFh8fNxB6l3SNJ90wyISuCCThTkM8K2xxBrbDlitTINsEBKaJcdpt9v
         ZoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711972677; x=1712577477;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi4ERWJ5mQ9smqXixw6WRIR0rmjAkZ8wCu1qA/SAFRw=;
        b=UCFdoiZ2ABDVlTlmJspY3Lt52QcI3VEeHZWKS4XIeDB0IdydYzc2oR88z1AGRm05PA
         PGX76CDDnmdxi23g0ENXNHCCb1d4YX+1GduHochOeH7nwe/RbHlQRfbduKzzr18PqDOK
         C3zWD6Lw7ewWhJZ1XrI3fu2XEkvi61XjlsL5DlbDwqpg2aFj6WDbU3yebJF1iwMLRN0H
         a5xWGVGFilc9Wuiwn9qOxyXdmOUc6km3aliL9P4LSe7YDauV8Nh/JLiEphXz7U2m4L+D
         cO+5ztMjTE9A6RqV/VssgGyVHWI1D6eMIf9BdmopAmzg0dbmpvmQidwVWwjyK5vnM8w9
         VsdA==
X-Forwarded-Encrypted: i=1; AJvYcCUpUfcv4wpg6yT2n6KttVVyumDbiyWv3fwdVGSYNg9Pjim40SKTlZB0/RRvJ0x8CKQmUsMVQPnH0hmORAYgR7nJtv7ix31fdUS+HjG9v+ybVhiyV+NEB3Gn26zNZTemKlhR
X-Gm-Message-State: AOJu0Yyt+6WqJX7cTQBb8Zc4G/2LWr2w+/63TXTbZtFL6cGWvBO4Cjuh
	96lErTGUBtQhKwPSuUwum7BGTnf8DoWSO+w2f3vbxPzvIJaFATnE
X-Google-Smtp-Source: AGHT+IHWtDFfkWPpfgWPi2RK084dpIArY9pwilbYhwUtopK5VQPVxIowOJREfK8vIyCBUSauGanG7g==
X-Received: by 2002:a17:90a:d149:b0:29d:f1e9:a9d2 with SMTP id t9-20020a17090ad14900b0029df1e9a9d2mr6235728pjw.49.1711972677470;
        Mon, 01 Apr 2024 04:57:57 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id oh3-20020a17090b3a4300b002a20c0dcebbsm3936802pjb.31.2024.04.01.04.57.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 04:57:56 -0700 (PDT)
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
In-Reply-To: <073E72BD-63AF-4D88-95F8-9A002252C554@gmail.com>
Date: Mon, 1 Apr 2024 19:57:40 +0800
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
Message-Id: <60BB1971-38D3-4FE2-BB45-2DE228C6F370@gmail.com>
References: <20240328075318.83039-3-jiangshanlai@gmail.com>
 <769AEAAB-7DEA-4D94-8979-F01EDFD6EE46@joelfernandes.org>
 <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
 <073E72BD-63AF-4D88-95F8-9A002252C554@gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

2024=E5=B9=B44=E6=9C=881=E6=97=A5 19:40=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> wrote=EF=BC=9A
>=20
> 2024=E5=B9=B44=E6=9C=881=E6=97=A5 00:16=EF=BC=8CLai Jiangshan =
<jiangshanlai@gmail.com> wrote=EF=BC=9A
>>=20
>> On Sun, Mar 31, 2024 at 7:10=E2=80=AFPM Joel Fernandes =
<joel@joelfernandes.org> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan =
<jiangshanlai@gmail.com> wrote:
>>>>=20
>>>> =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>>>=20
>>>> Prepare for arch-specific-defined rcu_preempt_depth_set().
>>>>=20
>>>> No functionality change intended, but it has to be defined as a =
macro
>>>> as rcupdate.h is a very low level header included from areas that =
don't
>>>> even know about the task struct "current".
>>>=20
>>> Sorry I did not follow changelog. If some rcupdate.h includers do =
not know
>>> about task_struct, how does adding a macro that uses current help?
>>>=20
>>=20
>> Hello
>>=20
>> This is how macro works and it expands blindly based on tokens on the
>> usage-sites.
>=20
> But =E2=80=98current=E2=80=99 still needs to be expanded at last, it =
seems to me that it only affects=20
> the including order of the header files=EF=BC=9F
>=20
> Or what am I missing?

Get the missing part: if the user don=E2=80=99t need to use =
rcu_preempt_depth()=20
and rcu_preempt_depth_set() but other parts of rcupdate.h, then the two
has to be defined as a macro to avoid including linux/sched.h.

Sorry for the bother.

>=20
>>=20
>> And rcu_preempt_depth() & rcu_preempt_depth_set() are not universally
>> used wrappers, the user can simply also include linux/sched.h to make
>> they work.
>>=20
>> Thanks
>> Lai



