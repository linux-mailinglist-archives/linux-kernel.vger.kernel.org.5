Return-Path: <linux-kernel+bounces-124156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1889132D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E51C22EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD23C467;
	Fri, 29 Mar 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luWyhTZd"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E18494;
	Fri, 29 Mar 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690180; cv=none; b=W01mAHahEKMIpYW+5QcKhBm876bkV/2PhoiSYAh9RXfwLRMWmRtmNt7HFgj5ikoMnB0805Un+BWrdYMGxTZoMcp3q7INP0LcCcQovzGX9MhLNsQ6u9oUbrDMHbYV8acqVXD7Q1Fc3YcEZrjPjt2mRgyDontooltIUOJDNLwHZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690180; c=relaxed/simple;
	bh=ZOl/Bo99tToaWRhqhSoUQflRSQemaKlEpXFd9o9Gttk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PxUuaPOcTIj9QQedzwBnCayX3xC07fzxOegOe7FX8qExgck7x2D/QSA7NjCspJ/V+nQCfLecuFYvU4DVnDdyoqIQBsFvJcu64AB3X3NuoJZausKAKOvp7KaMEeMIQne66ZYlnt7oj3Yh+E0HWOpbG/OIqPSFB7+csQH/ry/g9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luWyhTZd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1378328b3a.2;
        Thu, 28 Mar 2024 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711690178; x=1712294978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k18c6xmm/eyPrEWQ3tkt+ZDWH10CDlh6h0RH3Bi3qC0=;
        b=luWyhTZdloMMQc1OKGWhj73srxsVfkFGXqkmAaACjAXsLbDZUVN9HhCY1WekUnxdW9
         /Qv2gNj4UAJpN7XoC7LqT4d/ihwyrjAFIbMvzSzwxMc1kVdXArjygNqg+DPdIl8f+WC5
         ohxe/as9BS6DnkF4tJFpgqekZpgivQtSej5BMBeqiLoVG58zWUzB25r436Q6K59bG8FL
         GDWF58cOzf2cgKQ9ZHWj0TAe1yd5AX/BJebjD75X7tPhJOFUZr/G7rOFBdK+2flFuxkN
         GIoRbqjB4hoNHPs7D9UKWqqtU9nlUOh9xeTk91+/bRqyL4w5gcfuK78KMHogo46TQlnK
         +7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711690178; x=1712294978;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k18c6xmm/eyPrEWQ3tkt+ZDWH10CDlh6h0RH3Bi3qC0=;
        b=EnQsA1t6rxj67hUKuaAm8kbx8n4lWUSaS9QibY+yh7RROwl4/d7qSfe7dhQeljSS6+
         /4HxN99aBtJn1Lr1NjFL35h4x8OXYDkW4eBBIn4TXGb2j9mttWYGhpW8kgKt3UcQD3LZ
         h1BVi1Y340IqnFhEGOUWswOoNIx1vaJg8McFuJxgWx91hkJEWV88UmPveRK/Rwh6u13B
         zBegLvJnDblwtmh6bH4+ejgLORYRe9bZyRFkhXf7B+9p7W3fO8nGQPtcGmpmG8c8yHdG
         6nNvWDach/EoRjo+qS40MfCrCjqVUfIaCvPd4FR3PW1pGy+dqp9f8NzMzF2g6nuJPnRT
         mMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTJuWcqDMJYkiVM+muIxrLvxRko/vOKry+Ks0f8I19HefSWkme0O/raAnZZkNKtGZZxC4nZ2qfpv1yRbcjUhLVQRAmu21vy1WR4Na51p/rSu3ewfhMHTkpULNoqDKSnZ7zOU0utwHdA2/d4rRvTfYin+uROztQDYS
X-Gm-Message-State: AOJu0Yzqisr0qPAlKgE7/4dbQNS5T+6BWgiF1M9lwZiIPSCe4nCpT5en
	vWCG+w5Vr5aHWQhMLhOTC7YVfnJh3GEzeUzB2dxvcwv2n+i78q/J
X-Google-Smtp-Source: AGHT+IGF0zcDXBCDqaaqa/Kc9ue+cRHKReQB2M9kPl0XrXRl7s+yKAQU7+YMrGsaWmIr628uT6J05g==
X-Received: by 2002:a05:6a21:398b:b0:1a3:e168:4deb with SMTP id ad11-20020a056a21398b00b001a3e1684debmr1460271pzc.32.1711690177987;
        Thu, 28 Mar 2024 22:29:37 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b001e042dc5202sm2603318plf.80.2024.03.28.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 22:29:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 22:29:36 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Edward Adam Davis <eadavis@qq.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com, 
 42.hyeyoo@gmail.com, 
 andrii@kernel.org, 
 ast@kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kafai@fb.com, 
 kpsingh@kernel.org, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 namhyung@kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 peterz@infradead.org, 
 songliubraving@fb.com, 
 syzkaller-bugs@googlegroups.com, 
 yhs@fb.com
Message-ID: <660651c0707f5_22b5520880@john.notmuch>
In-Reply-To: <87ttkuber7.fsf@cloudflare.com>
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
 <87ttkuber7.fsf@cloudflare.com>
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:
> 
> [...]
> 
> > But we also need to cover sock_map_unref->sock_sock_map_del_link called
> > from sock_hash_delete_elem. It also grabs a spin lock.
> 
> On second look, no need to disable interrupts in
> sock_map_unref->sock_sock_map_del_link. Call is enclosed in the critical
> section in sock_hash_delete_elem that has been updated.
> 
> I have a question, though, why are we patching sock_hash_free? It
> doesn't get called unless there are no more existing users of the BPF
> map. So nothing can mutate it from interrupt context.
> 
> [...]

Agree sock_hash_free should be only after all refs are dropped.

Edward, did you want to send a v2 for this? Also if you want fixing the
sockmap case as well would be useful. Also happy to finish up the patches
if you would rather not.

Thanks,
John

