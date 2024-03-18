Return-Path: <linux-kernel+bounces-106407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703787EE37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE51F24F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C854BF6;
	Mon, 18 Mar 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="SqhLcveJ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4B54BDD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781093; cv=none; b=KhFJGTEQ2pXG+0TJa1SMbLzcqCOOVaRZ9uF1Dgz4zxqdfJW/Hf0zgn5c4r0RFpM+E9V6hWwYNw122sHeNbzPC8AS8BC9Vno/AabziTnjIDttqnCLh12YJcVkdXa+MYmR+CSPfwU5YOEWDPv2MinHf8nHBBRuRb726sDmUP1x9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781093; c=relaxed/simple;
	bh=OWCXHiHuWUNcADMrLVJ7yIzfR5xBJK2YzZDVj2+J+s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yr26DBU3DPXY+dYl4hltycWyY9xjWDGispySTupr/Wq+AhCcwvoZAFw4Tp6BR8dabCsNtr/Hlzx+9uS7g/+ryxI5KkDDgx71tcMfuEsJ3FwO2evcX3pFKhN5rR0JkXLoX8RYgogTb1RXVUg+DRfky6HI/9s32+6UtZx8AfqwsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=SqhLcveJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429de32dad9so29354501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710781090; x=1711385890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnlhu+JvaL7929U+6kJvotnI2XXjE1OdgJ5AHBCPlfU=;
        b=SqhLcveJwcY9cv3ZQyiiZwuxG42Yi5QHfZHvx16dk743tBoG9PSD2CDzIYzFMDeQZt
         5d+vHsstMcYLNDvY9WGHMZeVMSVOae1BnXm5+HamBMzeKxUob7ftRv89fLpgMC8cukAd
         7k0fiohrZOQr7f/IFmjX4w+OF3k9fHLmKXFr9oPk/r4eJ1fz4K9nhfCZjJJ0MCgzdbF0
         vcBItivP+zwrlysfvGD+1wOBJSk6h/Sp/Y68bzCEPugghvSuNoohJs/DdTXLcktNNAGr
         tNSFACKB+7QpYojwu6UpTmlai4c0gHT60QjfgriDXs75XSyQt4RcP4aksBy/WqCshXAq
         ywTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781090; x=1711385890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnlhu+JvaL7929U+6kJvotnI2XXjE1OdgJ5AHBCPlfU=;
        b=h6+axL+5fDL2ysajbTHHuvVDed9qy/w6WM3Y4kA1jP8crETaOZVeFgihtL45dkJtJl
         xS/14D9hHLX2SdamMAnwRAp4Bvz8KaOcCLoHiez731MGuDdAjsKpnCgEH8V+M9+VRrV2
         qCZb/3YOa9zLNkWjOHlP3C24iBAyDKM6X/rka+uV5QPjrGAN3z+fzInocsMyhP04Vg8E
         Md539/+tq+OZqdtORwx5AxIIYyHADaC+acGv2oIfqDSzq+kDM2LiOhH5iJZv/y5wuRgO
         L3WDL09xvBYNiFQIxZF7Gqtk0ronn/3VrRZqLOOaXgu43nitG4dHmM9EI2MHUEoAgFLs
         sp+w==
X-Forwarded-Encrypted: i=1; AJvYcCXIKtR9039drk5raKGZTn9raDzPNjiY0c/KY8qKrQqpJkkq4PKx1mGPfPc/cACzbMs1JjytNM4A0NbT9ORX7YcbvzKtJE0XPGJ4XzUN
X-Gm-Message-State: AOJu0YxwOloqpMu6J+P5fYBWb+lezmNrqfNgcDvPp9uUJ6xAxsVsmpTY
	ZK5cWu1DBmxB0gFeFK/Ey42lImrF6LztS0CeW4emb9dmFSDpElBVwaHPkU88M82VIRC99wZh47v
	hJ5Gkj82YpdMtQgfsmc+lbUanouuWq1Qw5SvKug==
X-Google-Smtp-Source: AGHT+IFN7knHo+WpH6x/WvfzPyMhR/l30Eh/1o058/0FIhxj0EolDI7sDDeyw46SFuISEGDiHFfPukOFEai9cDXY7JQ=
X-Received: by 2002:a05:622a:120c:b0:430:d4cd:ebcd with SMTP id
 y12-20020a05622a120c00b00430d4cdebcdmr3619586qtx.35.1710781090457; Mon, 18
 Mar 2024 09:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com> <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com> <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
 <Zfhblk609XJn5clL@casper.infradead.org> <CA+CK2bDFUekHnh=XqLcLJS-VgTMrTRWPm4xgmXHWgFCd9JXYmw@mail.gmail.com>
 <4b542b49b2994c9d8c4c73b9e3b42dde@AcuMS.aculab.com>
In-Reply-To: <4b542b49b2994c9d8c4c73b9e3b42dde@AcuMS.aculab.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Mar 2024 12:57:32 -0400
Message-ID: <CA+CK2bB59NUJ7c9-Akt_QnVujfg0bHukhtLgbMv-fDFwWDkgsA@mail.gmail.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
To: David Laight <David.Laight@aculab.com>
Cc: Matthew Wilcox <willy@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>, 
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com" <bsegall@google.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dianders@chromium.org" <dianders@chromium.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "kinseyho@google.com" <kinseyho@google.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net" <mic@digikod.net>, 
	"michael.christie@oracle.com" <michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>, 
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"pmladek@suse.com" <pmladek@suse.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"surenb@google.com" <surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"urezki@gmail.com" <urezki@gmail.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> I think you'll need to broadcast an invalidate.
> Consider:
> CPU A: task allocates extra pages and adds something to some list.
> CPU B: accesses that data and maybe modifies it.
>         Some page-table walk setup ut the TLB.
> CPU A: task detects the modify, removes the item from the list,
>         collapses back the stack and sleeps.
>         Stack pages freed.
> CPU A: task wakes up (on the same cpu for simplicity).
>         Goes down a deep stack and puts an item on a list.
>         Different physical pages are allocated.
> CPU B: accesses the associated KVA.
>         It better not have a cached TLB.
>
> Doesn't that need an IPI?

Yes, this is annoying. If we share a stack with another CPU, then get
a new stack, and share it again with another CPU we get in trouble.
Yet, IPI during context switch would kill the performance :-\

I wonder if there is a way to optimize this scenario like doing IPI
invalidation only after stack sharing?

Pasha

