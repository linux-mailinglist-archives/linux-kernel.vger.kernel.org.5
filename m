Return-Path: <linux-kernel+bounces-105437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF1087DDD8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3162813DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B341CAB5;
	Sun, 17 Mar 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="xuBU16pM"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FF1CA87
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688545; cv=none; b=ioZSNpc9Wrp6+9q5XkiwaJAIiIQoPi4djSrv0qwQfiWNJhD80OxQPxJf1OZ6L4a/KcoimH5xKWxnQbJN19NDdYX1N1gGM/henNx2NpmWWe14ofKFu2BbxWDqLTtHYjj0bCljMNNX1nuEC3Oaj2EmfTZ4IjUitkyKUa0pH+ZCGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688545; c=relaxed/simple;
	bh=KLRfnq4eXlBcEGbywcchqO4jgh7J7ZsjRRHuQZtJC5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7p7uwb95RkTgRAsRbxCSMzBqtdW7e39rCYifcNmVWdRZnYiE8nG6jSzBwn1HFDOUrgXKSvkcHSQuV7mTNwhL+I1oyvLdHHuKbrOzaZzyfMCI0GV492aiBFduLTzz8QLl2OyfXuVXyl29ErHYp6u3h6ev//wZEzS7lkzDlHKZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=xuBU16pM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42f2d02fbdeso16633311cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710688542; x=1711293342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAjI9MKRPGbeGXeY7a3YR0okh1E18UlTMq7EcVEnoMY=;
        b=xuBU16pMOJTHoz4IrxJdfi+hB4AQy+2lAk1Mcg9H6U9UM5n5CSn0KZPCsjLzFQ6f8C
         Ytedced10qnuOwJgkdPmdkTo5tixsYWKNobunlf5kGtFJjVvdUoWWBYfKe6vCjXmcfQK
         dt2w7jr+vITtX9N2NxTgbN8D6QlPBkKvbEUgqDp0Nf6b43UNBHFXqZdKdeIfaAdMomSI
         umo/FzLzg5url6nh3G+PPII7LqCSacGC9oitA/HpoVkBtZK8qU0NYtX6BtLuL+ntu5YC
         CuoO5wGrFBreL42BFhg146UgE2f2plEIjFv0BW/CGfWoKpWLJ6AORwKa2inIRISSRhPZ
         OXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688542; x=1711293342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAjI9MKRPGbeGXeY7a3YR0okh1E18UlTMq7EcVEnoMY=;
        b=tV8tvqYgLYAcTEqkLtaw3PPp/SciVEwMaFe1FgDYylL04x3DSQ+qY/PwDSY0C2ihyG
         +1rivoAWbRP/IFHMS9p3yY5a8M8akonduomshcgsBVdSLJ21FxWly7ReHpZBSQOB7HC3
         KwrTEwIpuR4V+rjNDv5/5q/gXMaJnsOEgpeU1cejphaydxseIcIzMMNNHIF9pgDwFmpA
         G7WqSZtFkPK5VuAf4P8z1ZwXlYEOEvKD3QqlNE6pjkvkiy5IHcgVq59Z4lxGtgZfV8fi
         MUarOINmEQtYbbfYQ+KSocNk8uoFPvO75K+eyEEFkttSkHHKcUCFjWcZwfQdp2rCeE34
         hP2Q==
X-Gm-Message-State: AOJu0YwtsE1mryHoQ84gxF00+WBs6Fqwu68kPLX+GlxZeM3s7/fP5pyo
	9rsdZoW74d0QL5x5ulbxV8qqz+dXVoCaFksK9Fl5KIth1g9wekzOEAUyqxnRaqIY5yBWEsxbncO
	nD6kxpSj28A4kbl0TA7ti4PZLezmFeRw1YtVAzA==
X-Google-Smtp-Source: AGHT+IFHEaLZYyw0uAX0ZI/fr0dhZDQyZO1C7osqzysYutn76ux4Euc6Vx5ZcC+58/zciKXeEoXuHWH/QDBBa6btR7w=
X-Received: by 2002:a05:622a:5b97:b0:42e:daf5:1b93 with SMTP id
 ec23-20020a05622a5b9700b0042edaf51b93mr11616575qtb.39.1710688542407; Sun, 17
 Mar 2024 08:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com> <7e5d6e69-5f65-4b70-8220-6d98457ed17a@wanadoo.fr>
In-Reply-To: <7e5d6e69-5f65-4b70-8220-6d98457ed17a@wanadoo.fr>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 17 Mar 2024 11:15:06 -0400
Message-ID: <CA+CK2bCdqMzvFyfOqk1ZMeuZA1a_UaPtsKSeVWVvqE-n=gBkDA@mail.gmail.com>
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of memset()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:48=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 11/03/2024 =C3=A0 17:46, Pasha Tatashin a =C3=A9crit :
> > In preporation for dynamic kernel stacks do not zero the whole span of
>
> Nit: preparation

Thank you,
Pasha

>
> > the stack, but instead only the pages that are part of the vm_area.
> >
> > This is because with dynamic stacks we might have only partially
> > populated stacks.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   kernel/fork.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
>
> ...
>

