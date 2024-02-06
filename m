Return-Path: <linux-kernel+bounces-54592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9184B14E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414B41F24D75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15D12D169;
	Tue,  6 Feb 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELU5qB9A"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2AF12D146;
	Tue,  6 Feb 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211843; cv=none; b=JQZ4RSzm51YDYVaT665gfKu2RpSfRiSjDSH4BcfZXunnyZxMqNH/pNJT3Uum3h+KvbKMEbkWn+PT/eB0CmpUi9szdIkt47mQeiRLpDsWuTaxO9KQ8Jk8OiTd93VXerpSjp5Q+xqnVHTre4NXb3L7O0wFjZnroifKpAs/9+aYkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211843; c=relaxed/simple;
	bh=jlGj9Uu6Tk9w2AFXs0V9xd4N6n7LGYzGry6z71IofEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBUws/bFDOoIyUL+NcqXPdqkiVL8vC6Uf68xFu3DKe/2Fksw7Wy4uGg8niPNbub0+Dh88liofH/wWEesS45Bhz7ZiU/zPbkXgixEgl29nKNu2ojKiHV02cJWBtlPG4XwjmxX7xyzx4pT5J8bxjPDK4em5u0bSQ3KDvawXuUys7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELU5qB9A; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c035b3203dso552355e0c.2;
        Tue, 06 Feb 2024 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707211840; x=1707816640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJknXdok6CD7ygpMK4/zXVds+SczZy7OrsvIqJVHeK0=;
        b=ELU5qB9A6E1sODf4Ki7DxtqpIGZJF1w+1ZZNOv/NfZQPMvrN75/XAY54/Cducp8H6a
         gcv06i4xqXyTejD/WqikPcu7eQHTZ9W3JA/akCabDh0WYhQty969Q527G8DtiLev+w2L
         20L0VzY/m9YyJ1mizflTJw76lJtpbKzzfLIKzHxFjFab+MA2+ms9+iiB3Lsgk+rSv4aS
         O572VR47K6Gk1AKeVKp/jWwT9wJGnARJ4xfwSqv+H7P0YY/EO1Dr22To1fhBjO5GmMaX
         KZXdyW5W3BeTedvgHTrjqLH+2zQLRFPUHH2dcP6nAlxvwh8RCvwDnI3IsdcJiefPhK6V
         Ov+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211840; x=1707816640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJknXdok6CD7ygpMK4/zXVds+SczZy7OrsvIqJVHeK0=;
        b=TRgeFVpvsx8nZRSoL969A3TgXP1mfrBE1lMthAclFmA8532dBjDHcw5ZMbs9IeHwqI
         yQCaH2rYn31NNzqHlPjdS+MZNxSjjQ44G17ry5j6qphxdDFPR2Y7atv+RRJkdaRsnbS1
         s+4egN8lcD5s/ld0iTOhxYcY30cMay7QP2N5YpgbwkVTIt7TAdgOpYbmpCmmBL90TBPY
         JBMrNrjUI1lmLkcGLdLyAr5FwvvEh0RuTQ6abCsCO7cvbWW3Tiks7zlQFu5Rpvb2Xufx
         LJMg3MUFvKwfJlA1kxyXMkDSol8jh09EutrxZa8lY3DG0vIdtHEtKBHlLu+exyn3WMEs
         y3PA==
X-Gm-Message-State: AOJu0Ywc3wL8SgW/5eYj0j5SgK69KG6zrWffelI9HFk66zp/EC4onx+R
	b2BjSJq51SE2bU26NRDci6fr1oMfDd1DJYXJNbXLTakHuWXOKD6hLnNEHqGC1Q+wkPqjMSULgrW
	gYPu5fcgYKuUX+yCXE3QPEgbepSU=
X-Google-Smtp-Source: AGHT+IFVYZOTJ8IY2wiZ9RnEH3QZhmUHcyF0uhCeBks0nSnQXki0D+Bvb0lyqduFUWzUGGISvlARx6OrildiuBJAsgo=
X-Received: by 2002:a05:6122:201a:b0:4c0:2561:75c2 with SMTP id
 l26-20020a056122201a00b004c0256175c2mr1415596vkd.4.1707211840474; Tue, 06 Feb
 2024 01:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003011.211382-1-v-songbaohua@oppo.com>
 <20240106013021.GA123449@google.com> <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>
 <20240115023457.GA1504420@google.com> <CAGsJ_4x6e7=tWVKfauJaGMRmJ3tz7GymKosYcHrxoxEnAHyX6g@mail.gmail.com>
 <20240206015543.GH69174@google.com>
In-Reply-To: <20240206015543.GH69174@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 6 Feb 2024 17:30:29 +0800
Message-ID: <CAGsJ_4z_de_Tu=q_Y0LxWH1Buva-LT086kfMDL=gdksnMGXVXw@mail.gmail.com>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2 pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:55=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/01/29 10:46), Barry Song wrote:
> > On Mon, Jan 15, 2024 at 10:35=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (24/01/06 15:38), Barry Song wrote:
> > > > On Sat, Jan 6, 2024 at 9:30=E2=80=AFAM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > > >
> > > > > On (24/01/03 13:30), Barry Song wrote:
> > > > > > There is no need to keep zcomp_strm's buffers contiguous physic=
ally.
> > > > > > And rarely, 1-order allocation can fail while buddy is seriousl=
y
> > > > > > fragmented.
> > > > >
> [..]
> > > Okay, makes sense.
> > > Do you see these problems in real life? I don't recall any reports.
> >
> > i don't have problems with the current zram which supports normal pages=
 only.
> >
> > but  in our out-of-tree code, we have enhanced zram/zsmalloc to support=
 large
> > folios compression/decompression, which will make zram work much better
> > with large anon folios/mTHP things on which Ryan Roberts is working on.
> >
> > I mean, a large folio with for example 16 normal pages can be saved as
> > one object in zram.
> > In millions of phones, we have deployed this approach and seen huge imp=
rovement
> > on compression ratio and cpu consumption decrease. in that case, we
> > need a larger
> > per-cpu buffer, and have seen frequent failure on allocation. that
> > inspired me to send
> > this patch in advance.
>
> May I please ask you to resend this patch with updated commit mesasge?
> E.g. mention cpu offlinig/onlining, etc.

I will send v2 to add this information in the commit message. thanks!

>
> [..]
> > > > > I also wonder whether Android uses HW compression, in which case =
we
> > > > > may need to have physically contig pages. Not to mention TLB shoo=
tdowns
> > > > > that virt contig pages add to the picture.
> > > >
> > > > I don't understand how HW compression and TLB shootdown are related=
 as zRAM
> > > > is using a traditional comp API.
> > >
> > > Oh, those are not related. TLB shootdowns are what now will be added =
to
> > > all compressions/decompressions, so it's sort of extra cost.
> >
> > i am sorry i still don't understand where the tlb shootdowns come
> > from. we don't unmap
> > this per-cpu buffers during compression and decompression, do we ?
> >
> > am i missing something?
>
> No, I guess you are right.

Best regards
Barry

