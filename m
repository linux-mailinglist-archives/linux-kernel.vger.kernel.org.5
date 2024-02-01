Return-Path: <linux-kernel+bounces-48789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76AB846168
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A87B2BCEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13285290;
	Thu,  1 Feb 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL3S4Lvd"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41684FC7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816927; cv=none; b=X9IcMIbkXBvzLTj3Qt4o7/6SEMvPlgKRNUQIXFNcgmqAhxMhVgAFxHGnKDoiP+DaJ+DoFv5IIPMwGIQEzD6VHTjVLBFuC2cHzWpJ8cPCVJKN2oa17wUrkdEhqsMHZZjxNpU11T3fM2gG4h2HeVXuc6/BrT3hxjS3pT5oyVo0uME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816927; c=relaxed/simple;
	bh=i/g9Yf7HjuthbjgHhVHT5BFNoXZGF38cy9BD/xnm3Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdbGtnVybAU45kFPWMOPt0BaLDj+wdgH9hNvSZ3jAI7ztlutuXhlxNi+pF8gGSPhdIOLD5MeG/cQipNzWodNU+t+DhK6l6yNlOKFtOj2w9pfJo+sZ0XUFX13H5C4Vez/Eqf/SzLUJReSj20b3dIEG4NSI7rcFhhPJbqZmMUXH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL3S4Lvd; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4c009d2053fso89625e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706816921; x=1707421721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXSig469fCb6eoHtcNsPTS8zBt99yB9tmhGISmE5ccA=;
        b=jL3S4Lvd11VaBDJXaMqIJDVHUqGYVWGQISHIiOyDfI/wrVdBG6/ePY29a3+6KWn+nK
         ikz10cqd25yw+y48lMGyIizPzXWQNKTUjjsHsukXeWXmMW30a6/HJ8z3ilXOFHQpQywE
         uewYp4zCb13ssLwMas5KFogpRcvhTWot9FPijbq10BnsD/zzS4OAn0NngKtcMNDcfcVC
         wMC7IR+mspaO3DdmwTcuF44C/2bLMAOmh9JLNgteNUtD1A/jTzHhHY8Cr71uVbrEADfJ
         vdYAywKpphwTQNRNuSo6j6O+pnVtLwk/uFgTCOyQnD3zG88pvfK3qjZ1HP6MSvIaFZB9
         wsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816921; x=1707421721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXSig469fCb6eoHtcNsPTS8zBt99yB9tmhGISmE5ccA=;
        b=WcEnCiaosVS9rq3jOOo95ax6vgKmwbtgAQNZLAqwJQ3gjj1MBlUD+S7BVTYMV2cDuS
         v242M4krgblfl6XiTGH8fvewZDbqWUwTIV4mnorLYdsVTP688+ilV4K0BASimUsl+yfQ
         uoNx2K5C9GLS7QKVydmo0JRpvAXj+jFyOX5Alq5w3lDKmDuBwV64PTm0DhCnyj6z9RDq
         nLfQ52RKRuF7Ko0RyPZQOoIHAOGDCg1IRb2un9mPwBbKxenCg9x3mjnvrlsQ6svrYKnn
         z1lOYrRd1rXs3wiAIFICAyvQ0HFmBtZaUO3Iq0E86xDKkyZphGgp0xAYmqatmHdlB1MH
         oAqA==
X-Gm-Message-State: AOJu0YzED7flu1BvXCFr3PfIp7RR1K8PGIh1tGFAPSVQHFN3Vlgx4LLI
	XT3nT5rIjBOSuWnwgXRV5hDl6bR9wnkI2DMmABojDv4n9TcW4j2p30NHFs+IusBCK/MIH+I+lKW
	YBMU50FU07qVvfDVE/5cZQx9VjEY=
X-Google-Smtp-Source: AGHT+IEXAUB/p4M3ZacxDXpVRayEFAf3Po35ubYfIIso7+Fer4273WO52XQYkllVH+jGagvZ03n+nTn0gq1IbXdyzuU=
X-Received: by 2002:a05:6122:3981:b0:4b6:d4a0:5841 with SMTP id
 eq1-20020a056122398100b004b6d4a05841mr6214333vkb.6.1706816920967; Thu, 01 Feb
 2024 11:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com> <cc828212-9a90-430e-8719-e6b19bdab600@acm.org>
In-Reply-To: <cc828212-9a90-430e-8719-e6b19bdab600@acm.org>
From: Boqun Feng <boqun.feng@gmail.com>
Date: Thu, 1 Feb 2024 11:48:29 -0800
Message-ID: <CAL0jBu-2jrhBzTo+ZneFMpsTsqUMLVQCYCAQKqd6BHjv3-kxhQ@mail.gmail.com>
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:28=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 1/16/24 23:48, Zhiguo Niu wrote:
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
> > -011|kthread(_create =3D 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
>
> The above call trace shows a graph_lock() call from inside lock_timer_bas=
e().
> How can that happen? In lock_timer_base() I see a raw_spin_lock_irqsave()=
 call.
> Did I perhaps overlook something?
>

(replying from gmail web, please forgive the format)

raw_spin_lock_irqsave():
  lock_acquire():
    __lock_acquire():
      validate_chain():
        lookup_chain_cache_add():
          graph_lock();

Basically, every lock acquisition may lock the lockdep graph because
of dependency checking.

Regards,
Boqun


> Thanks,
>
> Bart.
>

