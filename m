Return-Path: <linux-kernel+bounces-15258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC782294B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27956B2181E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6011B1805E;
	Wed,  3 Jan 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6vMbWdn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3418046
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704269094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYljcyaJYdFZwaWbn+pl2W1uV01ThCIQUmO2ZsphZZA=;
	b=G6vMbWdnqIjJbgWpLcAXIUEs4OVVXeAo8+Vrr/Cm5TlivMe5566ArFlqDLHY0xnwcZUy8M
	g9c/05vwfQh1US0dDkcUHnIOqORK+maUYPVBvkU7mMwoIYpiZc1uxMRwr6hy3udqg0f6jv
	gTF39EhLC6fN3aQdqnCbcMXmUEvAnn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-a4tCcOEQOzGGKtZOAOqk4Q-1; Wed, 03 Jan 2024 03:04:53 -0500
X-MC-Unique: a4tCcOEQOzGGKtZOAOqk4Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d3b0783beso91120445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 00:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704269092; x=1704873892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYljcyaJYdFZwaWbn+pl2W1uV01ThCIQUmO2ZsphZZA=;
        b=j2yleJuUIZTnYYJI6tKILRXXp56H4N4AfuOeWsnMDLV8RO2uhnwWI0tOmSpmQd1wPe
         ca4BR89B9aj6CbS8Xj1cR7Q0Bxn9qJByvtt3r5VyXPkqtbmZlfirf4gwHvrdbhJkH0Ub
         B9Vr6+TAnwvZaZNRuQFkmv2e5W8xoMdjRcQtDQfbDyKPnGhbAIzICXkpQtfQDUG0VM9z
         SClRFgOAFfsAQf/xzRZk3Z8ePyvuw+Cm97KMC96DMrc6D67JPY4UW77TLI/xIOEEfAE3
         Y+09ACpLTVzKbCFxktB6b0Ug3gw07y8jA+EkREqglsgl2BafG15QvprG3rkk4xUtPYbQ
         I3+A==
X-Gm-Message-State: AOJu0Yz5R/+kkW4lzKE78fSzwLWkdlMhamjsJ8vmVU8TqO4SvB7oZ9eG
	J/bHjk1Rx8pSkdVgADKgiEt1IIRz/eUrokIwmttzM7M1+U8cU+QhpGiU795UXKwbMoGW/7SESW2
	OIANKyzLdTOocrsLctJiOhhSgkPlhasZ5reVcRr5RD9My4nn3
X-Received: by 2002:a05:600c:ad0:b0:40c:33be:d187 with SMTP id c16-20020a05600c0ad000b0040c33bed187mr9885590wmr.25.1704269092349;
        Wed, 03 Jan 2024 00:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWYNgEexMUVb2s2vwCsNsuobQ3E/A2kRIlfi4BbZlrb3hn/aaRi6+/bhJ2Wxfbv4ZGXZq5UZfoRErnSdrbW+8=
X-Received: by 2002:a05:600c:ad0:b0:40c:33be:d187 with SMTP id
 c16-20020a05600c0ad000b0040c33bed187mr9885584wmr.25.1704269092036; Wed, 03
 Jan 2024 00:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8KmOw1DzOr-GvQ9E+Y5RCX1GQ1h1Bumk5pB++9=SjMUPHxBg@mail.gmail.com>
 <ZT_HeK7GXdY-6L3t@google.com> <CAE8KmOxKkojqrqWE1RMa4YY3=of1AEFcDth_6b2ZCHJHzb8nng@mail.gmail.com>
 <CAE8KmOxd-Xib+qfiiBepP-ydjSAn32gjOTdLLUqm-i5vgzTv8w@mail.gmail.com>
 <CAE8KmOyffXD4k69vRAFwesaqrBGzFY3i+kefbkHcQf4=jNYzOA@mail.gmail.com> <ZZSVnT0Ovk5QrasA@google.com>
In-Reply-To: <ZZSVnT0Ovk5QrasA@google.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 3 Jan 2024 13:34:35 +0530
Message-ID: <CAE8KmOyrBmUq-38aVig16mEc5h4jwaTYHRY2rRWvMAn6wmKkAg@mail.gmail.com>
Subject: Re: Fwd: About patch bdedff263132 - KVM: x86: Route pending NMIs
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Sean,

On Wed, 3 Jan 2024 at 04:30, Sean Christopherson <seanjc@google.com> wrote:
> Heh, I don't know that I would describe "412 microseconds" as "indefinitely", but
> it's certainly a long time, especially during boot.

* Indefinitely because it does not come out of it. I've left the guest
overnight and still it did not boot.

> Piecing things together, the issue is I was wrong about the -EAGAIN exit being
> benign.
>
> QEMU responds to the spurious exit by bailing from the vCPU's inner runloop, and
> when that happens, the associated task (briefly) acquires a global mutex, the
> so called BQL (Big QEMU Lock).  I assumed that QEMU would eat the -EAGAIN and do
> nothing interesting, but QEMU interprets the -EAGAIN as "there might be a global
> state change the vCPU needs to handle".
>
> As you discovered, having 9 vCPUs constantly acquiring and releasing a single
> mutex makes for slow going when vCPU0 needs to acquire said mutex, e.g. to do
> emulated MMIO.
>
> Ah, and the other wrinkle is that KVM won't actually yield during KVM_RUN for
> UNINITIALIZED vCPUs, i.e. all those vCPU tasks will stay at 100% utilization even
> though there's nothing for them to do.  That may or may not matter in your case,
> but it would be awful behavior in a setup with oversubscribed vCPUs.
...
> Yeah, that's kinda sorta what's happening, although that comment is about requests
> that are never cleared in *any* path, e.g. violation of that rule causes a vCPU
> to be 100% stuck.

* I see, interesting.

> I'm not 100% confident there isn't something else going on, e.g. a 400+ microsecond
> wait time is a little odd,

* It could be vCPU thread's sched priority/policy.

> but this is inarguably a KVM regression and I doubt it's worth anyone's time to dig deeper.
> Can you give me a Signed-off-by for this?  I'll write a changelog and post a proper patch.

* I have sent a formal patch to you. Please feel free to edit the
commit/change log as you see fit. Thanks so much.

Thank you.
---
  - Prasad


