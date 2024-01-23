Return-Path: <linux-kernel+bounces-34973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B38838A15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13B6288213
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBE59B4B;
	Tue, 23 Jan 2024 09:17:08 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966159142
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001428; cv=none; b=b4vZyhf8sOBeKE7XMFeWtvEwkkwyKHqzjr4Mlq6bZCGycHBLWFhkO0sMQJY6hk3ANTzUyFEKisp2kLmzho2mfHrrQPyaYLdxo1tpURVKuXO9IB5Jr8Qg7X2XmTk7ArX0CCKCrVViT0jxgTwWLRuJWNcQFOmu2mPct/hQrjdOFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001428; c=relaxed/simple;
	bh=Q8wcX3ewcLwhq0jcEWgW7pUlZgM++UHSxIizDOzcYgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKizYt9Q/8R4CiU5FcsGWyp0fM6dY6zkOkJCdClBcbNU8JA3q+43KJwp+rnAds9pWY9AVYwKr8odSlhxsZxDhBRiuek0bnr3URXeZBPus4dQOHxIu05I/qHsShNuAO4H9AMVkc70ZkO6WT7M9kIV3IeQUdyCq2KEVd908wqLXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3674093276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001423; x=1706606223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eysYTxOjocPq4rrc3DGhszQZAjKDk9f7dYLgf8xIR74=;
        b=mT7oHhFpWggs01Kjz8talNkE40quPV+lAp1w2ew9KkmvfRg4wkbBPcAYzgU2TJ17vd
         waDpvr4lis0Bf311XyLooGFA9rc9xh1n7rmzFGrVYpQLiuunT3B9wf34xheYRTH2qKI1
         zU+5Qq2zfKV5pJgCqfb7lPB0hCFsCyESMBJ8InxDMx22XlGeCwl+FHiPhYjsoKxFw+aD
         yzqlDp5wgE9rFMbY+MJHLXPmdRVtuLTT/AHdF5uFiysrtUH3frqnZx7BA85ezrfxVl/L
         XA0d6OsWjhe7f/Y8/nDaxNvrbjF2Kq36GBz5UwKC9gRpWDgYdSsL3RfNaZzsWck3hsSO
         7IyQ==
X-Gm-Message-State: AOJu0YyqUnswZvRq6IYq6dwHDugo6+h9vaQlGa1ue37r0cAEKFjiGlIt
	IqzhpRq8kDCqeDQh0uVmnXnv+iLPUJqZ9fxHbNL8Kl5DLKAryeQVx26/BYhly/Y=
X-Google-Smtp-Source: AGHT+IHGE1boWNykZN8AxkdlvWdZuLyzWgWJBZ43TydhIrVaPbB7YFe0zqUn6G7tuTclzzLWNxozWw==
X-Received: by 2002:a0d:c643:0:b0:5ff:86b9:e24a with SMTP id i64-20020a0dc643000000b005ff86b9e24amr4756062ywd.25.1706001423606;
        Tue, 23 Jan 2024 01:17:03 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o81-20020a817354000000b005ff9fb43406sm2201931ywc.37.2024.01.23.01.17.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:17:02 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc24ead4428so2680196276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:17:01 -0800 (PST)
X-Received: by 2002:a25:68cf:0:b0:dc2:28e6:9cac with SMTP id
 d198-20020a2568cf000000b00dc228e69cacmr3261930ybc.76.1706001421756; Tue, 23
 Jan 2024 01:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123030826.619242906@goodmis.org> <20240123031452.830697973@goodmis.org>
In-Reply-To: <20240123031452.830697973@goodmis.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jan 2024 10:16:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4sfj09jAPJ1Rc4B_ikSVNLaPUcK0xUX0O3N5uaZeJ+A@mail.gmail.com>
Message-ID: <CAMuHMdV4sfj09jAPJ1Rc4B_ikSVNLaPUcK0xUX0O3N5uaZeJ+A@mail.gmail.com>
Subject: Re: [for-linus][PATCH 2/2] eventfs: Save directory inodes in the
 eventfs_inode structure
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 4:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The eventfs inodes and directories are allocated when referenced. But thi=
s
> leaves the issue of keeping consistent inode numbers and the number is
> only saved in the inode structure itself. When the inode is no longer
> referenced, it can be freed. When the file that the inode was representin=
g
> is referenced again, the inode is once again created, but the inode numbe=
r
> needs to be the same as it was before.
>
> Just making the inode numbers the same for all files is fine, but that
> does not work with directories. The find command will check for loops via
> the inode number and having the same inode number for directories trigger=
s:
>
>   # find /sys/kernel/tracing
> find: File system loop detected;
> '/sys/kernel/debug/tracing/events/initcall/initcall_finish' is part of th=
e same file system loop as
> '/sys/kernel/debug/tracing/events/initcall'.
> [..]
>
> Linus pointed out that the eventfs_inode structure ends with a single
> 32bit int, and on 64 bit machines, there's likely a 4 byte hole due to
> alignment. We can use this hole to store the inode number for the
> eventfs_inode. All directories in eventfs are represented by an
> eventfs_inode and that data structure can hold its inode number.
>
> That last int was also purposely placed at the end of the structure to
> prevent holes from within. Now that there's a 4 byte number to hold the
> inode, both the inode number and the last integer can be moved up in the
> structure for better cache locality, where the llist and rcu fields can b=
e
> moved to the end as they are only used when the eventfs_inode is being
> deleted.
>
> Link: https://lore.kernel.org/all/CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=3DX+c=
7x0Eewxn-YRdCA@mail.gmail.com/
> Link: https://lore.kernel.org/linux-trace-kernel/20240122152748.46897388@=
gandalf.local.home
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 53c41052ba31 ("eventfs: Have the inodes all for files and director=
ies all be the same")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

