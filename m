Return-Path: <linux-kernel+bounces-103732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866D87C3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C84C28337A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F62757FE;
	Thu, 14 Mar 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="NvGrvbtf"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F72E410
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444883; cv=none; b=NMwLuPZuvyBlBU1q82KgcrSYVRrVN8MO5NAeIrnn8Jht+Nd3DzqVtMiIrH/CLJaJJgzpvrWeFgbpDktr3M2vY3Inbs+BP6gU8i3ZzV4B+M54+bH92WbQXuULTnul2vBr9kUyZvpOtmeS9Bie49cJINCGgM/g6b6ssPxRw30ZsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444883; c=relaxed/simple;
	bh=Gu8ndvCosLfR13D/hsYz/cv9ogsH/tqd6hyUv+jcRaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca+CUwEiI5FCnFQDdGkzcpbLz+Q3Cwt2c6tl0r/ZpjN1VMhrMKnFYb1uaQEOFmRkejgqri0Gt8O0sKgei3x9U6qxiS7JMOUEbTobo+c6pVhb0MiLNSvrdkdJWzbSrAUIytFYVKBAm192vO1x4dzEs+ieMnm+msQrvCeP7O1vyy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=NvGrvbtf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a029c8e62so8959001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710444881; x=1711049681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu8ndvCosLfR13D/hsYz/cv9ogsH/tqd6hyUv+jcRaM=;
        b=NvGrvbtf1Kwp25RAZmnTcVC0aF6bpZqbwYjXn4JQm68VaNxi6MbUjWuhmZV0FlPePg
         Mk5/GYaK/3C+o3yF5i0d3d4oXHQJZgyZNCEuw6nLyvCrLjit9bYXUxh2njQz6qQgy4l4
         ldFW7VqZYnXOm01PbXWM9gOX0cz9qU68IwjHfPyju12/n4iAWFU6Fm7PRolbQG2aMqtn
         FhLiOCujBcYpeXtLOeqgLyaLRrjznn1wKnT3UX89ajBzJmcEksbSOPX/ptubvxYlY2CL
         XnQM1IwRvtZ5MBc3TY+7H/5ztD7IN2waqNweb3WhxhQKIZ4pIHATEah4710eTRxDPgI2
         F7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444881; x=1711049681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu8ndvCosLfR13D/hsYz/cv9ogsH/tqd6hyUv+jcRaM=;
        b=P2uabfLyFCpbsF2J/cUnyvY+/WDIRthYHsok4sLbQqYXv9r2FX6thq0xoBt8uIukQr
         fASzMTjIxdmebvoi2/jNnDpGBtOPtXN1dNmZadOkPLBeHzGD6LlfGAR3rGmCAme3mF1w
         2WVH+P+OPswRdhIsfG/cexW+OJcVhu4KjO1kQDrpLOkuvO6AvmoOcBNtPWuJuCZMs4D6
         ouRdIqYMYHVqZGsan/TLT8jjNeELUGwC+5s49xtS9vYprVnLIED6fQFI1EWV7ZQwLh1K
         PV4mrz3ah00XIJu082CCCZG3+AgPLAU6AIiSrZNDYTTisTC3o3gWu+wbFSEDxJZBf8OI
         qdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlE4KxHVwcJQ0Jqkz4bi8Nxu5CmZb4nuPKCMPJKgQMEHqMqzldhitipi/jQJ5lG1+Umnh62KPJbKP+yjAHixe8qUwLAGgy6166isab
X-Gm-Message-State: AOJu0YyfARcZ7i1ihbBTQDy7Lw0obMqRclwxCptNxjXqMq2oj3HMZYwg
	sNpkJ01d7ZtitTwFLCR7UFbdUwozsC8ostSUF8MjE9swIycp0VTWYe7SAG1T2uDOYid8krlLgnO
	ceEBhI5J9mubyhjS1y+0E6yk5xYtU1+Iy6MlKmg==
X-Google-Smtp-Source: AGHT+IFYUmp8vuQtAaVQJsJwK0pf9SP/QzZlup80TTakr/1z6jjrHWw1ZTmVhdIG/sfZHB8mMBDgjcN1TuW0c5bY+6I=
X-Received: by 2002:ac8:5f8e:0:b0:42f:30bd:fc8b with SMTP id
 j14-20020ac85f8e000000b0042f30bdfc8bmr1956069qta.63.1710444880851; Thu, 14
 Mar 2024 12:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
 <f949f712-eacf-49a0-91ea-8062e2d1f5e0@zytor.com> <fp6tyl6laseytepxpyidvwjo4dl357dtqegzumrc5ao6srm6we@afcl57kvjieb>
 <CA+CK2bA+ACXv955KXpP3ZW47n7tiZqzUMz9s09cJMUD7Cz2Log@mail.gmail.com> <mo2z7sfzxntlfbbr5yqyjpe5cn2nn6ecxgi3pr5kcfbzq2dnzn@vvtugr3s5hbf>
In-Reply-To: <mo2z7sfzxntlfbbr5yqyjpe5cn2nn6ecxgi3pr5kcfbzq2dnzn@vvtugr3s5hbf>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 15:34:03 -0400
Message-ID: <CA+CK2bDQu0jh55H=FQtA-5R-5Qy2=nqzcybEuN=RzVR75NBLRA@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 3:29=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Mar 14, 2024 at 03:23:08PM -0400, Pasha Tatashin wrote:
> > > >
> > > > My point is that what matters is total memory use, not just memory =
used in
> > > > the kernel. Amdahl's law.
> > >
> > > If userspace is running a few processes with many threads and the
> > > userspace stacks are small, kernel stacks could end up dominating.
> > >
> > > I'd like to see some numbers though.
> >
> > The unused kernel stack pages occupy petabytes of memory across the fle=
et [1].
>
> Raw number doesn't mean much here (I know how many machines Google has,
> of course it's going to be petabytes ;), percentage of system memory
> would be better.
>
> What I'd _really_ like to see is raw output from memory allocation
> profiling, so we can see how much memory is going to kernel stacks vs.
> other kernel allocations.

I've heard there is memory profiling working that can help with that...

While I do not have the data you are asking for, the other kernel
allocations might be useful, but this particular project is targeted
to help with reducing overhead where the memory is not used, or used
in very extreme rare cases.

> Number of kernel threads vs. number of user threads would also be good
> to know - I've been seeing ps output lately where we've got a lot more
> workqueue workers than we should, perhaps that's something that could be
> addressed.

Yes, doing other optimizations make sense, reducing the total number
kernel threads if possible might help as well. I will look into this
as well to see how many user threads vs kernel threads we have.

