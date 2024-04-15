Return-Path: <linux-kernel+bounces-145436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518A8A5620
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EA11C2231D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD076C76;
	Mon, 15 Apr 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d3WmJRaL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2076046
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194217; cv=none; b=QvnaRpUvRSAVyHU29SqhXJ1AoK2DAiPEmGUsB5dbHuY5OT0AdI34pTIsj8qGFLV1by34d/79GVpxhaaZeOpA3C0XWhHb0Xfg5RQKsW8wEOAsSbqBxeUMP+RBIlIsfz3O956E9XIIyr59V4laO1csebwUL8bnVJkxxx5htJh/1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194217; c=relaxed/simple;
	bh=V0vSLYdN5+sp0Nj4uvY9rZ4Y5E68p7ZBUFyZvEGFSyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jATl12WnrVUGZNd7QOwu7jkbuVCkSOk/nnDiNsEWpL+M0bIZgMe1XTkbodBgujGYPqYZwLGz/ZKBNbCtwDn/i8z28mJtNhbBhhjFC1cWnUSfBH/Cvw8sj/gIwEw5rx0vy/qKvhkzJaSSly+2SnLEAM5lF5o/xW9yTX3RVUhkaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d3WmJRaL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51beae2f13so385313866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713194214; x=1713799014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEgxyxxNG2YF57j8ToEfZMFeI3YdtTOWHVH2bsdiWdU=;
        b=d3WmJRaL+YnuNKJ4d/UJ7ma+f2oBZwNZvqLR5/UqRKr+gmLX9fchejL5VdBKGeFiDq
         h8v39llb7WVLa9Re6LasD0TTtjE5QaVhBvl8ZJtrGwGgsVkE8yczs2mGbmfRDk7SDUCT
         XYIURDSJn+FS/Ly+ZTyx3InhWxXU37rud16sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194214; x=1713799014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEgxyxxNG2YF57j8ToEfZMFeI3YdtTOWHVH2bsdiWdU=;
        b=slOcMym2/vwfd/uRHt2Cm/ZsdhRHFxPYNDk8oHue58dmNidFeoxVwU8A/V5y43JQOu
         QXK7b5z7cTU3Ev1Iqgt4snKCX+EN4/F9TkrLHuVnCFQ3vLwIP+iQN8S5HRe+hqhH9MmL
         /fK0D/ew+e5OZd87nudzEwAShN4Ixqz8YrnWIVerDn/Qi5X8fSolwHkj+W7cC6Vp/sHb
         dUju9x//R0e2M+yYPKkqgGanFf6JsfWHnkARxqJvOrlAUN6WU8lJQ5uWYtZxbE+/Twg9
         M3k8syqM09wFISpKhdlvD4PsMvjCIwWwsL59ory7RZK1uC93P951kBFI5/Stip28hgDA
         794g==
X-Forwarded-Encrypted: i=1; AJvYcCVmWZXcH239bEpMyrwUGQpkaHkLSa7CtaYP9NH6AiBb8h1oNsXcGkIrT2s/YyNvFispvrRMlcKpIZaI8JuR4YHlnvrDg4j0K9SOGcXW
X-Gm-Message-State: AOJu0Yz02bmeuzQQI0StOhnc4f9fs+GOr6/QFhGCf0d6rI8dbItD7fey
	Sy/uLJpzp0B3qIQjZTbrqJcOvW5+wSn9TwgZEm6oqZh97HjAuPV6LxJOxG8EhjmtmEJxBE5F1uS
	Eqdo=
X-Google-Smtp-Source: AGHT+IE3Ijz3bePDrONWgMRw/E+SEoqFoW4Pfu3FH4pWuxmrYYpbkZ66AP3GLk3mDCxLfi8pa12V2w==
X-Received: by 2002:a17:906:29cb:b0:a52:61b9:be48 with SMTP id y11-20020a17090629cb00b00a5261b9be48mr2490997eje.35.1713194213855;
        Mon, 15 Apr 2024 08:16:53 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id mf10-20020a170906cb8a00b00a4e70ede2b7sm5644010ejb.174.2024.04.15.08.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:16:53 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51addddbd4so390923366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:16:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn3XOYMLmgA8+V7J79EtJJmpGhDoif6hhipNv7ArD7ZRJIYWepoJClGCP7KKp5xonj3GDoD6wvy74mjqVjgxHHnvfsRbLdvJMOBnTQ
X-Received: by 2002:a17:906:f85b:b0:a52:6721:f276 with SMTP id
 ks27-20020a170906f85b00b00a526721f276mr2235966ejb.19.1713194213091; Mon, 15
 Apr 2024 08:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712944776.git.jpoimboe@kernel.org> <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
 <8aee08a9-0d7a-4b5f-aee1-c70bad9433ca@suse.com>
In-Reply-To: <8aee08a9-0d7a-4b5f-aee1-c70bad9433ca@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 08:16:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0QrKuxQQmNsJhn5rE9Qe-Cz_9NsJOcOM1FK+knLeAFw@mail.gmail.com>
Message-ID: <CAHk-=wi0QrKuxQQmNsJhn5rE9Qe-Cz_9NsJOcOM1FK+knLeAFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 00:37, Nikolay Borisov <nik.borisov@suse.com> wrote:
>
> To ask again, what do we gain by having this syscall hardening at the
> same time as the always on BHB scrubbing sequence?

What happens the next time some indirect call problem comes up?

If we had had *one* hardware bug in this area, that would be one
thing. But this has been going on for a decade now.

              Linus

