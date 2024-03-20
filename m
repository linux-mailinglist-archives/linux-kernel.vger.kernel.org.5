Return-Path: <linux-kernel+bounces-108512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50B880B87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20321F23A11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989111DA52;
	Wed, 20 Mar 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSnPMyf2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCD23D2;
	Wed, 20 Mar 2024 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917805; cv=none; b=SgOEB9G/5szQ2qdSyMzpbWpeM36I4+FS79Ax0kMCMt3OeneYtykEvX9J4yuT7vrSfOn0vq7haSgQcBSxxpMlZLRAtDE4LbwpbpFL2F2LUTj4Ps96ElYqkqOqO4LdSzttP5NM4uTrl+bYnlIKzW3TYmEC/ivlJq3eMj0tkA19X90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917805; c=relaxed/simple;
	bh=/6LpJu5Gelv+Xu8dnK0HmbPpEvk3ncmJRD3iWejc39Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUUA1dvYd53uQoGqXQNXvSW1x4gWPYLgcVxxs2g7TrMY8N57dDJZb7iFPcBIec69/8ZCBrG0O7zAsQObuooZcVcKjHHhng1tF8cMz6y0Vn/9pzuHZsn9dL/r4cO6pAP6VzxTHduTrXb2nu+zPdsELAIqiIQy+JQBRPpsLcwdWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSnPMyf2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3272549f8f.2;
        Tue, 19 Mar 2024 23:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710917802; x=1711522602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CeMrvzRfncq322yxK0GgyYXBvm9ru4HKsKaxloqamU=;
        b=PSnPMyf2U+EeW7COhkYj2vhhiffCZHqsN3iRV6LWOPIq2PJ8pitirRID1qWvpZnVIk
         zGfStxhVISG2UtDuytl63sizwDmScJAeU64XoHEOuD+eQql+SW31YhOcXXWQ2Bv4Lgq+
         80fm9gAlENhfQqVqAM3x2ZYxQ+WjuQ2IvFTstKLqRxoD3sEXvAI7rbLm3bLtjIc0dTTP
         qDkFuBr95cTsj4qKHYjaAmn6JxaOIOdMoAGUhi5KI/RqubjpbN3gx03AgDDoVAvz8drS
         /1OIoCcMzMyQ7eEzqkSCL2jWLhvw0i1PIYjmgh4pGNYORzVSJf1xhIeV+dOIE8vRk7NS
         F4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710917802; x=1711522602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CeMrvzRfncq322yxK0GgyYXBvm9ru4HKsKaxloqamU=;
        b=ZPgcGGYIfI2jzQPXAq4t/9lGCnp5Mitjz9ymGUAj2zbhDn+em77+xeM2o4ZZ0slA0h
         gl2mqAAYaVJFY15fDryVPJrOUhlBlHl+0rhCbyXD4eILfTi3u52SXemaO/oKJwDuyHGE
         aG/9VAPk/bPwA7qaFXTD7P6slMgC02/tgKeww12oTt8WDQfYWCx1OV0Rz6czMOwcQrTX
         gcmuMDeIDsmC+KZl3+gGVLzBDtuOpW/YKabR6k5oIVW7gqfosND3aKLlLAgdvW77SPKo
         S63olWETDSoSkoqbQeuQBhn+9vBrpkcB6Vk7QOXcBk89fX0oih+GPqbN7Ap+fTI4qx7z
         cEVg==
X-Forwarded-Encrypted: i=1; AJvYcCVChjVwk+VQE7UO2If1S+MnpdU0uFi5xll5zz10DUWEzJF3aBrMuNRjBZcP6ov6ZtE8+HbF/69gw2mY2qRFTKUER3Y2P96FIpHfN/zT5nAN3I165BwC7K/eifK8LjnuKml6
X-Gm-Message-State: AOJu0YxY6mShuC6SRhXh0Kq8fpnrFNRwKVsRLGYgxz1d4qTteMIt5O1u
	5X6U18oRg0MampSmzwS7aOVNNTHaG3QUe3AUVsXP79OUWIFmTKn+GrVh6rCvN6QzRO3Gyapt5Rf
	H2v+yJf2xK8bxccMDwj4YxBD+i/U=
X-Google-Smtp-Source: AGHT+IERhb89ttNSXo55oFH3XMXHyjyhY9IU4/HbF76LHPa9DEiFbTvmD30AMZ9ayHAZQ0E+nzx0Wt5C8LJ14FPfN1o=
X-Received: by 2002:a5d:4b86:0:b0:33e:737f:9363 with SMTP id
 b6-20020a5d4b86000000b0033e737f9363mr10314545wrt.70.1710917802252; Tue, 19
 Mar 2024 23:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e40a2906072e9567@google.com> <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
In-Reply-To: <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 23:56:31 -0700
Message-ID: <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:50=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello, bpf developers.
>
> syzbot is reporting circular locking dependency because bpf program is hi=
tting
> printk() path. To avoid this dependency, something like
> https://syzkaller.appspot.com/text?tag=3DPatch&x=3D121c92fe180000 is need=
ed.
>
> Is it possible to call printk_deferred_{enter,exit}() from the bpf side (=
e.g.
> bpf_prog_run()) so that we don't need to add overhead on the scheduler si=
de
> when bpf programs are not registered?
>
> printk_deferred_{enter,exit}() requires that printk_deferred_exit() is ca=
lled
> on a CPU which printk_deferred_enter() was called, for percpu counter is =
used.
> Is migrate_{disable,enable}() also needed around printk_deferred_{enter,e=
xit}() ?
>
> On 2023/10/08 15:28, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D172d36e9680=
000

This has nothing to do with bpf.
bpf never calls printk().

