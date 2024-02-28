Return-Path: <linux-kernel+bounces-85720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662886B9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81375B28761
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E0A7004E;
	Wed, 28 Feb 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tmT5AqPt"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EC5E090
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155682; cv=none; b=CwilK4UPdYOcwFB1/clvDTzvgHQFKPKbw6nLW2/fZVMehmPer4NRgp66bCEY5UYaHaousjXCP0Aj/3heijJdV6Xtc6d2LUAKE9WcULI3xJZ7C/vfJfxQTN3nq4ASsSapGD0J7xhnHUaAGRMcJAkUM6YPD0x4woHeRB6UdMyiak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155682; c=relaxed/simple;
	bh=qc3IJmVO/3R3A0SFJHCdwm34OBK/Jh388HY6ha8d4zc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=deVoW+T3klsSCIbslbPkjSk/4gZOTqXWloyiR3hZaLEr8sQEjcneZ/GKyoIduRfSOjyCPny2zrG6y6QMBc2yXW9AjOcARnWUHVUAgnOdOr+Tl3PBoKT3b0IlnHeuz9DqPEJ/980Xbh1/9s5hA+708cIHx34IUhuzgciRXvjy860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=tmT5AqPt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42e86f37a0eso1709471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709155679; x=1709760479; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Blc6MtZrUfw0pfNXYBqBV8687KOne6DSCmGwF7E1Oc=;
        b=tmT5AqPtLKQA3SMCNqahR+zqrH8scEXZ/cx72tTHM2/ZslivTFN2t4ZB7eGjRg/y+u
         3JsXQnqUAyj/1O0NygE3isVFTcA8dbHOPAjBrRp0M2JjWUg3GDb0vY1mW2iH2oaf/Gkv
         ItY6FkCHH9EPYl1AeuzvBwjYihZzk+NvwOzv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155679; x=1709760479;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Blc6MtZrUfw0pfNXYBqBV8687KOne6DSCmGwF7E1Oc=;
        b=XRX5ZW9r50/ZRsv+POHTD2fd/u/wrm68Bzo1qjutdGVaEKtCQn0PA+RDt/JetIG2P8
         ewDX3uEa2s7dj9+PX2CJFAxQluAxD8Hum1RB8kk+mZfjIShRaKZJ1IsxUeXYX/x0pWBd
         Fd/2WvssP9DD2dnUdNNaMMSL5l5eFOyMsVDspN8FI9wNUqUDlSrnx4JYGilRQsOUp9uc
         k4JMdJFTJflP0+N3rHVdEexlCqEqp/kE7YlKERypChpXz9Z+i4mn+bXya8rtxwkJoLLe
         lRkX6tM5JywpRzMBSzPlrt7rKscoBfi6LW72miDKBgvM2+UdCQGoM7JrA7WGNCgzWdw8
         f/xw==
X-Forwarded-Encrypted: i=1; AJvYcCWRNl/zfKRsPZRrFsgxrBP6J8kWP59qnL2cBwCouQZbunqL2iqnZkWwskYOHQETP7VS0gmd8GYSwl1NVziT+ImxhYW9G8WSvCid876y
X-Gm-Message-State: AOJu0Yz6JxAHygab4pzXXBmbkJlSHpyGJDv5dGGCE4UQdK1VVYPPJD9v
	9OycoNugKzoiCar+2iZaXk6NE2VrcfY7Mpae2ZjjXo+q9BvD5hY+aTe25j7mXZ0=
X-Google-Smtp-Source: AGHT+IGDQNk6NZQ43wHJ3Dd0O4jJRkuOkedQSDFeACS4W4u7SGJlKnJJwLEhOZq/P68pAYf3qzd8Kw==
X-Received: by 2002:ac8:5ad5:0:b0:42e:7ebf:1d51 with SMTP id d21-20020ac85ad5000000b0042e7ebf1d51mr134002qtd.68.1709155679115;
        Wed, 28 Feb 2024 13:27:59 -0800 (PST)
Received: from smtpclient.apple ([45.88.220.126])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a048c00b0042e7856fbe3sm12820qtx.59.2024.02.28.13.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:27:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Date: Wed, 28 Feb 2024 16:27:47 -0500
Message-Id: <4965F5CD-B33C-4B75-818A-021372020881@joelfernandes.org>
References: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, rostedt@goodmis.org, mark.rutland@arm.com
In-Reply-To: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (21D61)



> On Feb 28, 2024, at 4:13=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:
>>> On Wed, Feb 28, 2024 at 12:18=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>>>=20
>>> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
>>>> On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
>>>>> Also optionally, I wonder if calling rcu_tasks_qs() directly is better=

>>>>> (for documentation if anything) since the issue is Tasks RCU specific.=
 Also
>>>>> code comment above the rcu_softirq_qs() call about cond_resched() not t=
aking
>>>>> care of Tasks RCU would be great!
>>>>>=20
>>>> Yes it's quite surprising to me that cond_resched does not help here,
>>>=20
>>> In theory, it would be possible to make cond_resched() take care of
>>> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
>>> of cond_resched().  But if for some reason cond_resched() needs to stay
>>> around, doing that work might make sense.
>>=20
>> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
>> (to me), because cond_resched() is to inform the scheduler to run
>> something else possibly of higher priority while the current task is
>> still runnable. On the other hand, what's not permitted in a Tasks RCU
>> reader is a voluntary sleep. So IMO even though cond_resched() is a
>> voluntary call, it is still not a sleep but rather a preemption point.
>=20
> =46rom the viewpoint of Task RCU's users, the point is to figure out
> when it is OK to free an already-removed tracing trampoline.  The
> current Task RCU implementation relies on the fact that tracing
> trampolines do not do voluntary context switches.

Yes.

>=20
>> So a Tasks RCU reader should perfectly be able to be scheduled out in
>> the middle of a read-side critical section (in current code) by
>> calling cond_resched(). It is just like involuntary preemption in the
>> middle of a RCU reader, in disguise, Right?
>=20
> You lost me on this one.  This for example is not permitted:
>=20
>    rcu_read_lock();
>    cond_resched();
>    rcu_read_unlock();
>=20
> But in a CONFIG_PREEMPT=3Dy kernel, that RCU reader could be preempted.
>=20
> So cond_resched() looks like a voluntary context switch to me.  Recall
> that vanilla non-preemptible RCU will treat them as quiescent states if
> the grace period extends long enough.
>=20
> What am I missing here?

That we are discussing Tasks-RCU read side section? Sorry I should have been=
 more clear. I thought sleeping was not permitted in Tasks RCU reader, but n=
on-sleep context switches (example involuntarily getting preempted were).

 - Joel



>=20
>                            Thanx, Paul

