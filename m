Return-Path: <linux-kernel+bounces-73274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A543B85C050
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B71F21BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9701762E5;
	Tue, 20 Feb 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur5pEL28"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12A7603E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444144; cv=none; b=MQMzcSR/drtCTGmsluIqYson/FHJX0Zc7kadljGuEYcZBV4uVgHO7rsyDhE+9AOGhxjb6yvX3bA6i3JRW6jWVgWobQNNcWB4rlmzeOvoZ2ES7NXdFVP+Q+RRBDJLT4U86htX8MI9psEMdAsFf0jbM8I37HwGM2EVlHqJHraYEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444144; c=relaxed/simple;
	bh=w9Qk2axkaAfF+tNTNqJZFb8AUy/zwkV+ozPjqf4dEtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgR2YgWx4PYF+CVr7raMV7xGQ0QTtjd6kg2sTG+eS9TyQZE3Pi7D+BHbn9ySkC5c0YcnZpQaZAgQiKCbS4vRgbxMzQhVMGUFm9iEB5XILBhGpjow9hEfi0FYcsfCPjPtnfsOIiGobBnFFdg/WYwjes8qx3zN9oFkorFi3wUha2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur5pEL28; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4127188dd5cso2893395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708444141; x=1709048941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uMFcSVHz9V9r/oLxZZFJKd2VWyIsZ98dBb86ZS79p2Y=;
        b=Ur5pEL28y60KVoveZSb6ui53Va7+zIuG7M2KLQo5uKLwgYv/Z/G/1b53z4SOA6e4qz
         LmhGYF/6Qfyd56Nvv3qzgxZ8Wr9AHwAeISTLL8EeQvNevqkLMRVun6AJnjWosXKjoVf1
         e+s+gp7PvI9xjiOi2QOf4CZNUDqmbLJ7ptvdPVbvocNNpKKnrwB+QU/pU0V2G/ziDt1U
         8JaUb8ylOAhAGUK1WcJ7vmxi4OH4/L58BHtPYyRvE2qYJNptbM7jJm9pDePhXtM9sAh4
         k8Gvz/VGn3IDHUiYlFaQNTGF6R1Vimipxse0XoeGu8qzNbnFffRFlRrytRs/CtCmqIU9
         0VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444141; x=1709048941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMFcSVHz9V9r/oLxZZFJKd2VWyIsZ98dBb86ZS79p2Y=;
        b=sZhQkMfBhiAYC+ILQeNNazYj9UoP7gWDxXOVx0hYIxd83Brr7DmBSi8fCty0tMkPnF
         nUxpHV3oUuG2DdeVvf6foXGkAtBaZUkogGFcjJjl2RVUp5qLjqTIIa8wrwtnyOWszezL
         8NqALd5CsQr+1rCFwq7hSL1CQxV+7G4DSfRy+75Pepvf26PkPbKOGQCHOKQjdgLMUBra
         uPeeEZEao1PDmC+wpeeF6R3BY5/jDv3npXHn/Xf2CLuRln8ci3+XfBSB4FyP57+Y3Y4o
         ++IQgTpIgelpRh667hxKl5tp1gVZYQTU4PMQ5kv6mUVCqVnqriTAavsNCbF/zw/O4Hgd
         3ouQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJnpGRkzm0bv2GeMb9CXMXK9PdrV0BWypNc95FS54qu5epuiVVgDJs5xD8wrKuEDI5oJ1MmUb8uC7gr1FJlO8SvfH9Y6nkD+ONC6Ka
X-Gm-Message-State: AOJu0YxJKR5NSqRKbc9SPyk29hCfbvaHXr3BxHf8gNmxYlPGGncywXwt
	l26v3g52VslqCKY604LtpT0mfb88MDA65m9FNNRnPF+g8V3DTUVZJo7nvaLB
X-Google-Smtp-Source: AGHT+IGcn/T3IfR/b/9lnTVpStfQx0j2sYtUtQdfPOp2jnNd7ftwdK+zPs40A6zMrCFcmcx7DBWVOA==
X-Received: by 2002:a5d:590e:0:b0:33d:3f2a:63a9 with SMTP id v14-20020a5d590e000000b0033d3f2a63a9mr4782565wrd.22.1708444140409;
        Tue, 20 Feb 2024 07:49:00 -0800 (PST)
Received: from andrea ([31.189.39.37])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d68c8000000b0033b2799815csm13903469wrw.86.2024.02.20.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:48:59 -0800 (PST)
Date: Tue, 20 Feb 2024 16:48:55 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "conrad.r.cole" <conrad.r.cole@proton.me>
Cc: "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
	"me@marcoelver.com" <me@marcoelver.com>,
	"boehm@acm.org" <boehm@acm.org>,
	"fpikus@gmail.com" <fpikus@gmail.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"akiyks@gmail.com" <akiyks@gmail.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org
Subject: Re: LKMM/RCU UNLOCK+LOCK pair Semantics Inquiry
Message-ID: <ZdTJ5808Mn7ehLEo@andrea>
References: <PCmEIB6oZbT2Wa4tScglap6aRpw3PI5sAw8vTAjxFiI33RDyi0i71AGCr0pEtHRWbFcyhv_M1U7L5jVLYBxDQ5Rk2DuplpFpA3BXcQshnnI=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PCmEIB6oZbT2Wa4tScglap6aRpw3PI5sAw8vTAjxFiI33RDyi0i71AGCr0pEtHRWbFcyhv_M1U7L5jVLYBxDQ5Rk2DuplpFpA3BXcQshnnI=@proton.me>

(Dropping my long-dead @AS address and adding the Linux kernel mailing list)

> The example below seems a bit counterintuitive from my perspective. Why does the assert statement below not trigger when the memory barrier in thread 2 is included? How is it possible for Thread 2 to load a value of 0 for y, shouldn't the smp_mb__after_unlock_lock() act as a full memory barrier between the store to y by Thread 1 and the load by Thread 2?

[...]

>     Thread 1              Thread 2                        Thread 3
>     --------              --------                        --------
>     y = 1;                spin_lock(&l);                  x = 1;
>     spin_unlock(&l);      smp_mb__after_unlock_lock();    smp_mb();
>                           r1 = y;                         r3 = y;
>                           r2 = x;
>     
> 
>     assert(r1 == 0 || r2 != 0 || r3 != 0);

This test does not seem to be well-formed, due to the Unmatched lock operation;
you can check that by using the formal (upstream) LKMM:

$ cat conrad0.litmus
C conrad0

{}

P0(int *y, spinlock_t *l)
{
	WRITE_ONCE(*y, 1);
	spin_unlock(l);
}

P1(int *y, int *x, spinlock_t *l)
{
	int r1;
	int r2;

	spin_lock(l);
	smp_mb__after_unlock_lock();
	r1 = READ_ONCE(*y);
	r2 = READ_ONCE(*x);
}

P2(int *x, int *y)
{
	int r3;

	WRITE_ONCE(*x, 1);
	smp_mb();
	r3 = READ_ONCE(*y);
}

forall (1:r1=0 \/ ~1:r2=0 \/ ~2:r3=0)

$ herd7 -conf linux-kernel.cfg conrad0.litmus
Test conrad0 Required
States 8
1:r1=0; 1:r2=0; 2:r3=0;
1:r1=0; 1:r2=0; 2:r3=1;
1:r1=0; 1:r2=1; 2:r3=0;
1:r1=0; 1:r2=1; 2:r3=1;
1:r1=1; 1:r2=0; 2:r3=0;
1:r1=1; 1:r2=0; 2:r3=1;
1:r1=1; 1:r2=1; 2:r3=0;
1:r1=1; 1:r2=1; 2:r3=1;
No
Witnesses
Positive: 7 Negative: 1
Flag unmatched-unlock
Condition forall (1:r1=0 \/ not (1:r2=0) \/ not (2:r3=0))
Observation conrad0 Sometimes 7 1
Time conrad0 0.01
Hash=95ed1bbf05f8df26070ce4a3cc0968a3

(cf. the flag "unmatched-unlock" above).  Here is a well-formed variant of the
previous test together with the corresponding result:

$ cat conrad.litmus
C conrad

{}

P0(int *y, spinlock_t *l)
{
	spin_lock(l);
	WRITE_ONCE(*y, 1);
	spin_unlock(l);
}

P1(int *y, int *x, spinlock_t *l)
{
	int r1;
	int r2;

	spin_lock(l);
	smp_mb__after_unlock_lock();
	r1 = READ_ONCE(*y);
	r2 = READ_ONCE(*x);
	spin_unlock(l);
}

P2(int *x, int *y)
{
	int r3;

	WRITE_ONCE(*x, 1);
	smp_mb();
	r3 = READ_ONCE(*y);
}

forall (1:r1=0 \/ ~1:r2=0 \/ ~2:r3=0)

$ herd7 -conf linux-kernel.cfg conrad.litmus
Test conrad Required
States 7
1:r1=0; 1:r2=0; 2:r3=0;
1:r1=0; 1:r2=0; 2:r3=1;
1:r1=0; 1:r2=1; 2:r3=0;
1:r1=0; 1:r2=1; 2:r3=1;
1:r1=1; 1:r2=0; 2:r3=1;
1:r1=1; 1:r2=1; 2:r3=0;
1:r1=1; 1:r2=1; 2:r3=1;
Ok
Witnesses
Positive: 7 Negative: 0
Condition forall (1:r1=0 \/ not (1:r2=0) \/ not (2:r3=0))
Observation conrad Always 7 0
Time conrad 0.01
Hash=4611aa988bb39b8c0a27e0ed5f43044e

So the "assert" can indeed _not_ trigger (aka, fail) according to the model.  In
other words, the state "not (1:r1=0) /\ 1:r2=0 /\ 2:r3=0" is forbidden; such state
becomes allowed upon removal of the barrier (that "acts as a full barrier").

  Andrea

