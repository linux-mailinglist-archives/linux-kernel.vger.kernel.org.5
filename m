Return-Path: <linux-kernel+bounces-121667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C7A88EC11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E5C1C215A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5798614D718;
	Wed, 27 Mar 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7NmMz1a"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128014E2EE;
	Wed, 27 Mar 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559166; cv=none; b=YhA5FC4jlC3m/jMcdR2xshXxDwMbJJgQPvcA1aRqyehnbyU+6iS1IIa2WzVJe2QPvMnLX6EjJ3xXRcFtx4hsacze6eVrfIzDCz45QlVhjBW9WDu39OeLqYfVoMgYVWOqCSc/VNSXYH9FtTPbLh9VdB8PlNjMLEk7ExBsyc0k2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559166; c=relaxed/simple;
	bh=ahZyAforUiq+wNzRyymfSb7gbzaJyiqD41A/VBDCRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjdFiuI7xCaSHLHNFQFcG0fxugKTdjrCCAjBLaaQzEVAT5MB+xWlOa29GaV153bKzAm/U0Q6+u1hArY0jNlG1N9ljkgbPFUPiJyHHsI8ciOotAM5FAcn1maxjawAP+SiptYdg6a84fHq2gcpuFQjcYr63qVfZEFqg8H26oSTqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7NmMz1a; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso3161566b.2;
        Wed, 27 Mar 2024 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711559163; x=1712163963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUi4zEedr7KDhvHU0G0GEp0diV72wfwI5jg0UCvkAig=;
        b=W7NmMz1adzD4xD9ZaD40hpdYRNJeP6pnvs3/osh3Ljz6zNen2HCuMXr0kvLnYE3DxC
         diVIDBB8K0hCpu8l7lyZEnqDkEAXNBO8SLNAJifS4yi7cqiJTi46dxNhfZDqQVJv2ckI
         Wel/BRYMQE5p/fJ+vZmxMkTKJiJlRUSI8K89ov/aVzXeDq52nNM8UsOfd9Gb523Kk9/w
         jD3xeYyj3VjFjsHbUYw/RyWzoOSGbVpmjRo7vzkqT1XjvAuc+e1lguuR1nimrcQKURCS
         55aMtVG5Kbg+st103pDRiDq5+h2y5K7IHgRMcmIy/hIuEkDpxjqxLc6Q5tfTwa8Umz3s
         9gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711559163; x=1712163963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUi4zEedr7KDhvHU0G0GEp0diV72wfwI5jg0UCvkAig=;
        b=kVIRltAugArcPs53SXx2DvGV3nvOz05ID4T+4DpLpDdYkqMb/AkFShP3eyH2h8mDrz
         yq3vqD5EgLDJrT8KJrj65hHIZ8VQUffQobe1+9lQVK0FftVM7vLaj9b3HbbzrnR40IPK
         gGTGRFbq1XFSSC2A0es0W/k2z9okN2NjZqOE424ZncYM/yPjN6Qk4jo3M60uIht5q/Ff
         fn70HmdSZ0UecDQ5qS6Lq99uvyMJvSEg61aCEnMeRsmsr10H2v6qzRwn2/U2U327Xrco
         y3u1bvSxKl7Gm2g7AK5jym5KCXNkLT0a/ZbzJiABmvZ6m8kN1NONrUmoznjJhjmkAFW4
         IRzg==
X-Forwarded-Encrypted: i=1; AJvYcCVlGY06RdSAPg+Vve6/Q+QTxGNfeCbhyJJS1zeO/WrItC5Q1PFftZo3o5LcN4BjV47REFks0tAg8wcehmfQU2glKNigszXv9fH2lEsQ6jU3CltdjQP5k4l0t3YEmg9ntmixYVBfO4RJyxmEScDtLrtYo4RpITQrHhn3r86abFwjMkY046FY51fyCAsFfowfjY6YC/1TGTU4VH5IbTb6SbJsmcWREPrtbw==
X-Gm-Message-State: AOJu0YzgwNLNTaMb5EoskME7IGt2MjUt0CGik99ZDcRbs1w86D75VR6M
	hJKKR71bndpDY+zL+bziv71eJewoSTdQkAGYl8/I5wP/aHXPAabf
X-Google-Smtp-Source: AGHT+IE1PEKoVdAhIynLjkvyagQxfnizdEEGmUrp4CFr48Ozk0XLMxEW+3OrgIWT6Rqhttdhya5atg==
X-Received: by 2002:a17:906:3798:b0:a46:206d:369b with SMTP id n24-20020a170906379800b00a46206d369bmr52979ejc.28.1711559162756;
        Wed, 27 Mar 2024 10:06:02 -0700 (PDT)
Received: from jonhaslam-mbp.dhcp.thefacebook.com ([2620:10d:c092:500::4:b63d])
        by smtp.gmail.com with ESMTPSA id ao18-20020a170907359200b00a46aba003eesm5624401ejc.215.2024.03.27.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:06:02 -0700 (PDT)
Date: Wed, 27 Mar 2024 17:06:01 +0000
From: Jonthan Haslam <jonathan.haslam@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org, rostedt@goodmis.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-ID: <54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <20240325120323.ec3248d330b2755e73a6571e@kernel.org>
 <CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
 <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327084245.a890ae12e579f0be1902ae4a@kernel.org>

> > Masami,
> > 
> > Given the discussion around per-cpu rw semaphore and need for
> > (internal) batched attachment API for uprobes, do you think you can
> > apply this patch as is for now? We can then gain initial improvements
> > in scalability that are also easy to backport, and Jonathan will work
> > on a more complete solution based on per-cpu RW semaphore, as
> > suggested by Ingo.
> 
> Yeah, it is interesting to use per-cpu rw semaphore on uprobe.
> I would like to wait for the next version.

My initial tests show a nice improvement on the over RW spinlocks but
significant regression in acquiring a write lock. I've got a few days
vacation over Easter but I'll aim to get some more formalised results out
to the thread toward the end of next week.

Jon.

> 
> Thank you,
> 
> > 
> > >
> > > BTW, how did you measure the overhead? I think spinlock overhead
> > > will depend on how much lock contention happens.
> > >
> > > Thank you,
> > >
> > > >
> > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > >
> > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > ---
> > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > >   */
> > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > >
> > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > >
> > > >  #define UPROBES_HASH_SZ      13
> > > >  /* serialize uprobe->pending_list */
> > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > >  {
> > > >       struct uprobe *uprobe;
> > > >
> > > > -     spin_lock(&uprobes_treelock);
> > > > +     read_lock(&uprobes_treelock);
> > > >       uprobe = __find_uprobe(inode, offset);
> > > > -     spin_unlock(&uprobes_treelock);
> > > > +     read_unlock(&uprobes_treelock);
> > > >
> > > >       return uprobe;
> > > >  }
> > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > >  {
> > > >       struct uprobe *u;
> > > >
> > > > -     spin_lock(&uprobes_treelock);
> > > > +     write_lock(&uprobes_treelock);
> > > >       u = __insert_uprobe(uprobe);
> > > > -     spin_unlock(&uprobes_treelock);
> > > > +     write_unlock(&uprobes_treelock);
> > > >
> > > >       return u;
> > > >  }
> > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > >               return;
> > > >
> > > > -     spin_lock(&uprobes_treelock);
> > > > +     write_lock(&uprobes_treelock);
> > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > -     spin_unlock(&uprobes_treelock);
> > > > +     write_unlock(&uprobes_treelock);
> > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > >       put_uprobe(uprobe);
> > > >  }
> > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > >       min = vaddr_to_offset(vma, start);
> > > >       max = min + (end - start) - 1;
> > > >
> > > > -     spin_lock(&uprobes_treelock);
> > > > +     read_lock(&uprobes_treelock);
> > > >       n = find_node_in_range(inode, min, max);
> > > >       if (n) {
> > > >               for (t = n; t; t = rb_prev(t)) {
> > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > >                       get_uprobe(u);
> > > >               }
> > > >       }
> > > > -     spin_unlock(&uprobes_treelock);
> > > > +     read_unlock(&uprobes_treelock);
> > > >  }
> > > >
> > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > >       min = vaddr_to_offset(vma, start);
> > > >       max = min + (end - start) - 1;
> > > >
> > > > -     spin_lock(&uprobes_treelock);
> > > > +     read_lock(&uprobes_treelock);
> > > >       n = find_node_in_range(inode, min, max);
> > > > -     spin_unlock(&uprobes_treelock);
> > > > +     read_unlock(&uprobes_treelock);
> > > >
> > > >       return !!n;
> > > >  }
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

