Return-Path: <linux-kernel+bounces-120725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C0988DC07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EC81C28237
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D652F7F;
	Wed, 27 Mar 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+4cUP4w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WMFsreSA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF754F93;
	Wed, 27 Mar 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537594; cv=none; b=HJ8PINlkY54QUBMGasPOAYHJeJSkY9/81wbGApA6viz9mz89bXjBZ4oUvjW9k8ZaAdi90+OuNRM9lbv/MMvuJPINYSSqQk8uzm8B5btxD3xHGxoQ3b6xSK/IE0E/kKI4B4ClO1bzuZ9cE0Je1NP6QGDp4mCoLmphsN5noRIkaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537594; c=relaxed/simple;
	bh=4gucVPD3DfynGTKWdQGFWZ/XTgMS02NP6ZxMcGAEjfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1wyUOpavdNvC/wbYTHTLxUW42y4Cm3vhO8do0nrEynVNnwUJ2SNsZcSHLlAGKzOz9+Eq0SV4J5nfzLbOcuLCjiFNGZwyT0hzR/eHPgIJsxUPKDYMP6bdahYv68fPbYxZ/ht8ksygz2m4zG3b5wpk3oVnMJbfcdgPEfJB450H14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+4cUP4w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WMFsreSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711537588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gucVPD3DfynGTKWdQGFWZ/XTgMS02NP6ZxMcGAEjfU=;
	b=g+4cUP4wgA3jnhcXJvy2HjOxDppJB2AisicmLklG4LNzvO5aw+Zsu5LrJdrmg17a837eX1
	9DkFuA7EHzWVH1o6Oyno7+ndFz5Vew0UovvRX/qeuhqUCyt/X4fGQyO9Hm2Cli/sDZrjVg
	4dwl3W9+NVsWo82wn6QMgQXS3cj25Yqd1qITFF1QLeL0oNXNmdJVdh7cB0yFixwNjEntOS
	1lLSE/NsGlBQ4RBZ5d9s6fw2MMxLYRM2JamJBY5uqzIBmMhGDcZg/+RD7ug3XwVXL2wdY9
	01ZCyUt7nntKqHgvI8EGJ5T1ysHHWgK/xyiCzSAS1v4Yagaz//ujLDKDzjsi5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711537588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gucVPD3DfynGTKWdQGFWZ/XTgMS02NP6ZxMcGAEjfU=;
	b=WMFsreSAJVn4jnO2Y1QE5jaY333dr8sccARpr6pLHREPxD4OEL0jQYd7PuLueDWsUsBeJh
	X04++JF9mzwatQAA==
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, John Fastabend
 <john.fastabend@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
In-Reply-To: <CAADnVQJt+aP=Zo4edCu4iQEmdQjiruR1pJn0qyZZboNym+zd0w@mail.gmail.com>
References: <000000000000e40a2906072e9567@google.com>
 <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
 <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
 <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
 <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
 <CAADnVQJt+aP=Zo4edCu4iQEmdQjiruR1pJn0qyZZboNym+zd0w@mail.gmail.com>
Date: Wed, 27 Mar 2024 12:11:31 +0106
Message-ID: <87o7b0szno.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-03-20, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 20, 2024 at 12:30=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2024/03/20 16:12, Alexei Starovoitov wrote:
>> > On Wed, Mar 20, 2024 at 12:05=E2=80=AFAM Tetsuo Handa
>> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> >>
>> >> On 2024/03/20 15:56, Alexei Starovoitov wrote:
>> >>> This has nothing to do with bpf.
>> >>> bpf never calls printk().
>> >>
>> >> Please see the Sample crash report in the dashboard.
>> >> bpf program is hitting printk() via report_bug().
>> >
>> > Exactly. local_bh_neable is simply asking for a splat.
>> > _this_ bug is in printk.
>> > It's a generic issue.
>>
>> I can't catch. printk() is called due to report_bug().
>>
>> If the reason report_bug() is called is that spin_unlock_bh() is bad,
>> this is a bug in sock_map_delete_elem() rather than a bug in printk(), i=
sn't it.
>
> There are two bugs.
> The one you've started the thread about is in printk.

The printk rework (which is not yet fully mainline) will correctly
handle this context.

As to the patch [0] you suggested, it would be more appropriate to
perform deferred_enter/_exit *within* the locked critical section. But
we really only want these whack-a-mole workarounds for cases that can
occur in a non-bug situation. IMHO this is not such a case and falls
into the category of "known problem, the rework will handle it".

John Ogness

[0] https://syzkaller.appspot.com/text?tag=3DPatch&x=3D121c92fe180000

