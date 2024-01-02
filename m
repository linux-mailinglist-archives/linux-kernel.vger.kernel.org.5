Return-Path: <linux-kernel+bounces-14554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55A821E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDC283C55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB614F6B;
	Tue,  2 Jan 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiOporqN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D814F62
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d480c6342dso34030815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704208859; x=1704813659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC8zZpW88JATTyPu75m9EIR8gbeNaY6Wy3+vSQqo4pc=;
        b=CiOporqNLSBQruaI3KZmqTYpEIaUvNJ9i5iL2XXWlpb1oP3eESWhTyFKUDtO+Q0kfB
         4vQ/eG6+7dhUsOjwTFskSaNUlY/QzKR+9euJGDq99cbDxFObxLS+PYLR/lCVA2AVuymc
         i/ueAYb3PnWUi3POTrdpDbiq6dWUxVR6MWKZQyM9Rk6RM5OCh9skgSSTeCK4otU0kb3a
         pohvEEYP6/4bkILCcoMcXMBVhCNn2DBaZFHikn5YElrKYjm0lnPpjkLB381I/Eh4DLVg
         Ob39JJQp+NF2xvLJLFEjXOkV1jQib1ksXrroWOuZZAPZlxEAqNFacLVlB0GH84szcF8F
         UdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208859; x=1704813659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AC8zZpW88JATTyPu75m9EIR8gbeNaY6Wy3+vSQqo4pc=;
        b=up6+o39vauZOerYFJK6HPZm7voPm+BV2dYT5D8YSkhB4v3VXHqokRdYUlYEaIjpSTJ
         vTPZ7U1BFbGIovuNUyFk7ffxovGXm1ialHRBsvvhbeUw3mqxjVbeBuiYrMF6SVd+U/Be
         d/Wp6SVU0y36GpSvb/IVM0FfM4N9BUG3x/djrBS+Us8Xfc/fWlVXwwXVq4hDvEqRzdRG
         FBPcOgsDVyNcN+HAn8i+930NIL+u0r+1fBDLYm+7FJIKLnzGHaB6B+nmaqZ0fcsM7Fht
         AU4XRec0iZJD/pf1wwvIlJZ42DdTulPVxKwpNOlZ81srtTHWgumS/Nd1g8p7n8qp854r
         +F+w==
X-Gm-Message-State: AOJu0YzZMT9lcLD5U7dF3vgm7jZosHcfN/DZ+Sjarp1/2vBSmwLbyKDz
	Lo8RSffRecl8GYyhfwYgD/oChgJ87iDmgw==
X-Google-Smtp-Source: AGHT+IFM4gcGnxZgIt3nx6IqoNlCeiNV7/WpfyDiCmnxC7Me+8kboX3wHN6544VVey8RQv1Hn6uBvQ==
X-Received: by 2002:a17:90a:6fe3:b0:28c:5391:7683 with SMTP id e90-20020a17090a6fe300b0028c53917683mr6307876pjk.65.1704208858728;
        Tue, 02 Jan 2024 07:20:58 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b0028bf79ad453sm22365618pjb.21.2024.01.02.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:20:58 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 23:20:46 +0800
Message-ID: <20240102152046.111961-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
References: <ZY/wtvltzGR0CokV@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 30 Dec 2023 18:28:06 +0800, Baoquan He <bhe@redhat.com> wrote:

> On 12/29/23 at 12:10pm, Andrew Morton wrote:
> > On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > 
> > > Because memory ranges in mem->ranges are stored in ascending order, when we
> > > detect `p_end < start`, we can break the for loop early, as the subsequent
> > > memory ranges must also be outside the range we are looking for.
> > > 
> > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > ---
> > > Hi Andrew,
> > > 
> > > Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> > > crash_exclude_mem_range()" can be ignored, use this patch instead.
> > > 
> > 
> > Some reviewer input on this would be helpful please?
> 
> 
> I suggested this in below discussion thread:
> https://lore.kernel.org/all/ZYEOshALGbDKwSdc@MiWiFi-R3L-srv/T/#u
> 
> So it would be good if squashing this into patch 3 of another patch
> thread you are asking:
> [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
>

Hi all,

I've squashed this patch into the patch:

[PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()

The link to the new patch is:

https://lore.kernel.org/lkml/20240102144905.110047-1-ytcoode@gmail.com/t/#m255d0d26148f2b384f6b7ab77eb38edf3f1bc0df

> And I would suggest withdrawing Yuntao's below patch on your
> mm-nonmm-unstable branch.
> 
> 961c69e9f1bf x86/crash: fix potential cmem->ranges array overflow
> 
> Becase there's better one to fix the potential oob from fuqiang,
> although fuqiang need improve his patch log.
> 
> [PATCH v3] x86/kexec: fix potential cmem->ranges out of bounds
> https://lore.kernel.org/all/20231222121855.148215-1-fuqiang.wang@easystack.cn/T/#u
>

I'm okay with that.

> > 
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >  		p_start = mstart;
> > >  		p_end = mend;
> > >  
> > > -		if (p_start > end || p_end < start)
> > > +		if (p_start > end)
> > >  			continue;
> > >  
> > > +		if (p_end < start)
> > > +			break;
> > > +
> > >  		/* Truncate any area outside of range */
> > >  		if (p_start < start)
> > >  			p_start = start;
> > > -- 
> > > 2.43.0
> > 

