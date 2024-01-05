Return-Path: <linux-kernel+bounces-17750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737D8251FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08251C22EB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1828E17;
	Fri,  5 Jan 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OochwseZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A1EA87
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d2c6903dso26109417b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704450615; x=1705055415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4knP6o1aCl9riuIYIM0pnFGjq6uG5QVyaDPUgYq26SI=;
        b=OochwseZmTninHLPunU6uLRP9lzNDB8zI4SwrEhAv/QcUTZnAUsNsBaKoH912NF7oN
         hemix9V49n9HPHPJaFIYamV5q5ad1StIryUs3cOS3ICUSj3IHsmuiuaCeRNA0LA+WHs/
         LbuAVkmI8NIqYiHYLNxpHceAEz7LSHb3tJo1tzdb2Op7hc1goVXt3vyGqXNxXGih21rI
         pKi5cfxN5gSzzOwMl8SpL3iYkb4v1mfl+bjvzpeG9h1s6+DFIHeKwVgotyDxQ8acNosu
         3raK4eefboSSCDS8DLaBbnnbukrqDNtCUqK/bSZn/W0c0I4nx3mzjQ6bxeN9oIVONthV
         RWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450615; x=1705055415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4knP6o1aCl9riuIYIM0pnFGjq6uG5QVyaDPUgYq26SI=;
        b=pGvdj2UXiIx5lhXgvwLZr487vTXDF9l+NGdh23ZBOn8xVQzVi0yQjUAMdBDbtTf7o/
         xxnNg2/PanxLB5HkjhMVZr7M3iZPJxvvEL+G5+dydPWDuNJlCv2j60lj8WjM02Bi0lpH
         VGDzShDyib91HnxojHIWcJx/M44thYl5LUNWvWvfU5mMLc0Eo2BbGkTj4kuljrMkRopN
         rbLAGiBRp9OqmNB0DXN76NS6PGLgz9ONaC914kbASZ7SVZ+cdWNahgfwqJSyhdIoJ/fs
         RaUd5GiKd8x6i2cLPXcdF+VRDZcBh3yb6j0xGI3A88hzT0KQGlhwhAPF22f4XeNA97Eq
         /KCw==
X-Gm-Message-State: AOJu0YysmydJYYJjbDzkasrRi1LE88ocYpHZP9nVgCxl27Xp0O2lE1OX
	BU22HwZrbm8f8MBPk8prML+s5KUzih2Jkx7nSFzGTw==
X-Google-Smtp-Source: AGHT+IGASg0K+ZKJt5KzU3N4qfZaN/24Bl5MEEElQCIawp/m/shThUPTU1ckbWJQp380yaW0BXcKBfWWSIKwP8M=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1372:b0:db4:6936:48b7 with SMTP
 id bt18-20020a056902137200b00db4693648b7mr704689ybb.2.1704450614950; Fri, 05
 Jan 2024 02:30:14 -0800 (PST)
Date: Fri,  5 Jan 2024 10:30:11 +0000
In-Reply-To: <ZZcuwkBsvSs6bzXF@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZZcuwkBsvSs6bzXF@boqun-archlinux>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240105103011.1241629-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 3/4] rust: sync: add `CondVar::wait_timeout`
From: Alice Ryhl <aliceryhl@google.com>
To: boqun.feng@gmail.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com, 
	ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	tglx@linutronix.de, tiagolam@gmail.com, wedsonaf@gmail.com, will@kernel.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"

Boqun Feng <boqun.feng@gmail.com> writes:
> On Thu, Jan 04, 2024 at 02:02:43PM +0000, Alice Ryhl wrote:
>> Sleep on a condition variable with a timeout.
>> 
>> This is used by Rust Binder for process freezing. There, we want to
>> sleep until the freeze operation completes, but we want to be able to
>> abort the process freezing if it doesn't complete within some timeout.
>> 
>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>> Reviewed-by: Tiago Lam <tiagolam@gmail.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> That said, I want to hear from Thomas on the usage of jiffies, see
> below:
> 
>> -    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
>> +    fn wait_internal<T: ?Sized, B: Backend>(
>> +        &self,
>> +        wait_state: u32,
>> +        guard: &mut Guard<'_, T, B>,
>> +        timeout_in_jiffies: c_long,
> 
> This is an internal function, and it makes sense we use the same type
> for durations as the C function we rely on.
>
>> +    /// Releases the lock and waits for a notification in interruptible mode.
>> +    ///
>> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
>> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
>> +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
>> +    #[must_use = "wait_interruptible_timeout returns if a signal is pending, so the caller must check the return value"]
>> +    pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>> +        &self,
>> +        guard: &mut Guard<'_, T, B>,
>> +        jiffies: Jiffies,
> 
> This is a public interface, so it may make sense use a HZ-independent
> type for durations, e.g. core::time::Duration:
> 
> 	https://doc.rust-lang.org/core/time/struct.Duration.html	
> 
> but we don't have enough users to see whether there would be a need for
> HZ-dependent durations, so I think it's fine that we stick with a simple
> solution in Alice's patchset to get the ball rolling, we can always
> remove a public interface with HZ-dependent durations whenever we want.
> 
> Thoughts?

I tried to justify why I did not do that in the commit message for patch
2. Let me include it here:

	Note that we need to convert to jiffies in Binder. It is not enough to
	introduce a variant of `CondVar::wait_timeout` that takes the timeout in
	msecs because we need to be able to restart the sleep with the remaining
	sleep duration if it is interrupted, and if the API takes msecs rather
	than jiffies, then that would require a conversion roundtrip jiffies->
	msecs->jiffies that is best avoided.

Alice

