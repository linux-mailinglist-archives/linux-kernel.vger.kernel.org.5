Return-Path: <linux-kernel+bounces-17196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83782497F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD824286460
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40252C694;
	Thu,  4 Jan 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K6c63Nyu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9E2C1BC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so965790e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704399504; x=1705004304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pTm7Em9tUNnJ6p2x/DnghnM1+S8bWSmIGMzJGdV0Nc=;
        b=K6c63NyuSN+6uGPUs64yck9sGY+/s5A7O6yZPym3Poq2/cHWbjTHIDgpu1/5729Hqd
         fx4Hw6yiFh3iQAm+lDnRwTlJg3BAnCEVIc4po5ley5Ql58BN0uPCgLUrAhVj+684flJj
         8cxt1g/A0CAj22khp7/q5tAXxpBDQaopMblA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704399504; x=1705004304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pTm7Em9tUNnJ6p2x/DnghnM1+S8bWSmIGMzJGdV0Nc=;
        b=I01jJLh7kpUFHFTP5/TkE90jZZhfSEj8iSQpiB3SMAWkchanMYbHeP1abUspPYy94j
         O8TXOUO2vRomkoR35OqclETCj/tjY+0FX8QFy2Nn6K3w6Wt9wJr1WeBQ8H/vwtRC1JQ4
         XvoHfVlNOCwpqSNdfsMqtom9ecr85geYk80myAMb+ajrQVx7QgNjly8gNTQ+yXzVp9k9
         y8HeCVka9AeZOkjTKOtynaV46qVQTz2oBNYl7oKl/0Ne1dGDRa3zdYOoDIU3z+LJq/uf
         SSwIuIMXrd/A3FBwfEBdJo/TrEhsG/CmZrnon7+yCK7Nlw6WFOPWLuEVu/o9hWl83Qes
         0Ofg==
X-Gm-Message-State: AOJu0YyEsFOPYFvQgOsRdrEZN9LHBgZ628Ay2tTTsuZZ2cHThc0mlAe8
	W2ul+DbWOULL8Kah3negeVhb8rDYtyKQ/TsNS5XPCkyTYclDvzJC
X-Google-Smtp-Source: AGHT+IGJ73MuQ0gPHToWKrkOtNEABZoXQwePF101+LYZTuO1+WmEboTCXOJ8/YiGvHChv2A0YGQ8ZA==
X-Received: by 2002:a05:6512:3054:b0:50e:3e3b:8f39 with SMTP id b20-20020a056512305400b0050e3e3b8f39mr498983lfb.80.1704399504231;
        Thu, 04 Jan 2024 12:18:24 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b00a2699b0fd49sm34173ejc.86.2024.01.04.12.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:18:23 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555936e7018so1083252a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:18:23 -0800 (PST)
X-Received: by 2002:a17:906:1351:b0:a23:31ca:f7 with SMTP id
 x17-20020a170906135100b00a2331ca00f7mr559921ejb.154.1704399502976; Thu, 04
 Jan 2024 12:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104164703.808999991@goodmis.org> <20240104164738.483305222@goodmis.org>
 <CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
 <20240104140246.688a3966@gandalf.local.home> <20240104150500.38b15a62@gandalf.local.home>
In-Reply-To: <20240104150500.38b15a62@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 12:18:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik=OOYCRSzAA7x485GyxH97ioaPziiF4Ms1kRU8VLkHA@mail.gmail.com>
Message-ID: <CAHk-=wik=OOYCRSzAA7x485GyxH97ioaPziiF4Ms1kRU8VLkHA@mail.gmail.com>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 12:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Also, I just realized it breaks if we update the 'c--' before the callback. :-/
>
> I have to put this check *after* the callback check.

What? No.

> Reason being, the callback can say "this event doesn't get this file" and
> return 0, which tells eventfs to skip this file.

So yes, there seems to be a bug there, in that ctx->pos is only
updated for successful callbacks (and not for "ignored entry").

But that just means that you should always update 'ctx->pos' as you
'continue' the loop.

The logical place to do that would be in the for-loop itself, which
actually is very natural for the simple case, ie you should just do

        for (i = 0; i < ei->nr_entries; i++, ctx->pos++) {

but in the list_for_each_entry_srcu() case the 'update' part of the
for-loop isn't actually accessible, so it would have to be at the
'continue' point(s).

Which is admittedly a bit annoying.

Looking at that I'm actually surprised that I don't recall that we'd
have hit that issue with our 'for_each_xyz()' loops before.

The update for our "for_each_xyz()" helpers are all hardcoded to just
do the "next iterator" thing, and there's no nice way to take
advantage of the normal for-loop semantics of "do this at the end of
the loop"

            Linus

