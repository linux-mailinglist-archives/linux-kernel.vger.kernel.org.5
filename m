Return-Path: <linux-kernel+bounces-164582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F08B7FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284B91F216C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7E1836ED;
	Tue, 30 Apr 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="jVdcxRlL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B2180A65
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501355; cv=none; b=HQTTvhH5nRMl9BGveML6BSXYd+K3tVz9R1N/recFq+OP663k0w+rSd+d30vXnhmHfWkXat63fwa94NmXe7Ig9yFy0yBPt/BmETidRMZ2oQCDwvOT5jZH3mDryg8rxoPkI3w1DhIiIWZ0vX3LqUVG4y+5mthWDiWTnvYBZvpsd6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501355; c=relaxed/simple;
	bh=Tys9Vqu4Np9NrR4Q24ohGiMMf8UxyZr7+N9SeUjltmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nt10hzo5U6/QUGnNR/7KudUF91NcAgQ43BvrcGYMy4bubP5yksHPoDBD4+FPLhb8r4/7L8NJp7oP2E1kqlX8nD45dkcACV4/iE9m+6rJnBJpmFM4fafyi+0aoSwzzIl0C2xjKXwpzdaatd/51upMLKtemYOzDcJWvXH59OXMaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=jVdcxRlL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so454280866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714501352; x=1715106152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eim2qM9dw2NaPc5K3CL5p94YEvS81xT9DDWzSJ6rzVw=;
        b=jVdcxRlL5j4m5yjl+WkqXscbtYgVttxc/4JvOHNJSKoCALCp8m5WMRqqDyNQCmsAA4
         WChmteAaj0mZVrJnCchQERr0n1ieqhyYmztRykfsQJ8lMjLyD4kBUjPTGhhmdCk0MMJ1
         ZqXLxputKkkwMaIlMws1NdafEq2PMpSbXYuqGSfNedb895+iaPrvIzXcuN/4LibEUcjx
         Cx1fTACsnSES/HawFo/TwxuJ7jG6+oACt62OwtYWj8bJN47HBesy6pQd1AASEl63CHSf
         rvj4vjVYZYyRwtANKrfZU7hdxVUMZfbaL5vgQ7EKZZAWENl/MEvXAhZAre7eiM0F7qtW
         +C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501352; x=1715106152;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eim2qM9dw2NaPc5K3CL5p94YEvS81xT9DDWzSJ6rzVw=;
        b=pfMutV5NgYz9UE3Reu987H0GvLhqZJirt2XJ0j51kJTGGzgq/kqLV/jFkK8G6O9ax+
         wZfCgtGbcQFjRpEQo026DBUKZQmI1oFLtxv1pGdNSYQEmsU3RivSJ8xoJXFVFMAm8Bvb
         MpV7CWSKrgeoFvTf+r8f0s+pI0s+Wh8N/4B+XgVm4BYHfCMgz0g90ObHXszkUOhKurw3
         Gz1048nO253piecU5IA0XAyHQ29dZ/lNSD6UmJk8ctRmPXbzNQvVbApOjhTCmCBDqljE
         gNfWYVbCVoYz9mCf+Y4xBNKNbCzQ1wx67FofRWV7lz47TMi6NYqsXqojNUoOlm5QWPHL
         J1yg==
X-Forwarded-Encrypted: i=1; AJvYcCWmFtRz4HrOV7igbmGllGnqskadg7ElPuSbmnFhSyJdoncXcrqrbKmt1m8re/mJ9Vocj4e8ThtEx8qCI7Ec4onllj6xCwJ7GLVORMhv
X-Gm-Message-State: AOJu0Yx3Cb/4zgeDN97HINKMNr/GAWro4w9y7XqI21YZSsCnfxKJhp4k
	aYUavTwouv6uqQNh18KLcqTxghf2IZNxCHUV2UMUglCORegwtg96i7qwMLETA8o=
X-Google-Smtp-Source: AGHT+IE5aiBScuaQ19uargUpEfy39/b85ALLx+hF4lmyoM77hZpnbkfe7n/+rxmBeqSK1orOCqLUdw==
X-Received: by 2002:a17:906:c791:b0:a55:b592:7e0a with SMTP id cw17-20020a170906c79100b00a55b5927e0amr377859ejb.48.1714501352560;
        Tue, 30 Apr 2024 11:22:32 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906474b00b00a58eeb329d8sm3949305ejs.44.2024.04.30.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:22:32 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Anna-Maria Behnsen <anna-maria@linutronix.de>,
  Frederic Weisbecker <frederic@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Andreas Hindborg <a.hindborg@samsung.com>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Alice Ryhl <aliceryhl@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <ZjELgVzzX4oru0gi@Boquns-Mac-mini.home> (Boqun Feng's message of
	"Tue, 30 Apr 2024 08:17:21 -0700")
References: <20240425094634.262674-1-nmi@metaspace.dk>
	<a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
	<87v844lbhm.fsf@metaspace.dk> <Zi_Zb1lBOBBUFJFV@boqun-archlinux>
	<87plu7jahd.fsf@metaspace.dk> <ZjELgVzzX4oru0gi@Boquns-Mac-mini.home>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Tue, 30 Apr 2024 20:22:25 +0200
Message-ID: <87h6fik8wu.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Boqun Feng <boqun.feng@gmail.com> writes:

> On Tue, Apr 30, 2024 at 02:33:50PM +0200, Andreas Hindborg wrote:
> [...]
>> >
>> > Could you see if you can replace this with a `SpinLock<bool>` +
>> > `CondVar`? We shouldn't use Rust atomic in kernel now. I know it's
>> > unfortunate that LKMM atomics are still work in process, but in real
>> > world, you won't do busy waiting for a timer to fire, so a
>> > `CondVar::wait` is better for example purpose.
>>=20
>> Since this is only using the atomic from Rust code, it should be fine
>> right? There is no mixing of memory models on this memory location.
>>=20
>
> It's better compared to mixing accesses on a same location, but it's
> still not allowed (for now, at least) to avoid mixing memory models on
> ordering guarantees, for example:
>
> (assume all memory location is initialized as 0)
>
> 	CPU 0				CPU 1
> 	-----				-----
> 	x.store(1, RELAXED); // Rust native atomic
> 	smp_store_release(&y, 1); // LKMM atomic
> 					let r0 =3D smp_load_acquire(&y);
> 					let r1 =3D x.load(RELAXED);
>
> The smp_store_release() and smp_load_acquire() pairs per LKMM, and
> provide certain rel-acq ordering. But to make it (r0 =3D=3D 1 && r1 =3D=
=3D 0),
> C11 memory model needs to understand this sort of orderings, but
> currently there is no such thing as an "external ordering" to C11 memory
> model.
>
> I admit this is much of a theorical concern for code reasoning, in real
> world, it must "just work", but "if you want to have fun, start with
> one" ;-)

Alright, I will change it to a `CondVar` or a `SpinLock` =F0=9F=91=8D

BR Andreas

