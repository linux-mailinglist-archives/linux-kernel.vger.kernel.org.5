Return-Path: <linux-kernel+bounces-26420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526A82E05E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EEF1F228DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36718C05;
	Mon, 15 Jan 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAK/VnFs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BF018AEA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705344913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GthAXNtsk/z7gO/RnYZ5f/Z0hY8DxVn6/8xfaoTAglE=;
	b=hAK/VnFsiM9KXLcvb4UF4W7zf27CVpSlIHLedgytb0SZSOv22D8Xui3aYBMuiC3LLvbjX8
	cHJ7Go4XWmlqdaRYJi7XvfLmumz+dZIVdZqw6wFpx7uCrhwsymZhxfF8/lEM7NgTyUDVEA
	27FbqMUoN1EgMmdblznCftk/RDwzDpM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-j2YBg1i-N-SSv73Mdl_FFw-1; Mon, 15 Jan 2024 13:55:11 -0500
X-MC-Unique: j2YBg1i-N-SSv73Mdl_FFw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dbea2ea8363so7222632276.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705344911; x=1705949711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GthAXNtsk/z7gO/RnYZ5f/Z0hY8DxVn6/8xfaoTAglE=;
        b=C43EGgdFm8AqQ8yZdfJnQnIuMMBU5dDOUpRkod7Arbaa5rLkj1kmueW33No0+O7tNS
         Rs8KrfDDetBilKE83hgMtI/GICvzrZwSdS2a+pBG8bT20m0dXEpexh8EBmL8LlCJEMO+
         rNY/6r5C0EQOuZ5NNcZlpAAAcofMBusKB6eD1MHsth4zC1Tj8jNz3++hddUXsweUB2tC
         pyoO1OSYQHTVJUV9YtJvPHT/N+GsF+W0fffjDMuleYc4pIV/SDQu4TVTvl8qbH9jdHbP
         8PXUsilKWrXwNHHWbnxZwPg6J0HZUme1XZ7C98/gqp7c62kam9eA9DyWTQprLqnvL6li
         a4Ow==
X-Gm-Message-State: AOJu0Yyl1aIiubqTdkLRIH7wrZmXHkPC+OvwZ2ZGGFbu5wBqG6Xru3j0
	PUsEZJwrhFzbJ5cERdDIx18Z2ptQt/T9TbpAo+cBUPc2shx9InvszjI6rhqdRN/zdJFtvQUghJE
	CtXhFL8Hiuv3XwcK6xTrOS/80Qe3lHMEGrcBko+/swmLgUPZX
X-Received: by 2002:a25:d287:0:b0:dbe:ab15:2ffc with SMTP id j129-20020a25d287000000b00dbeab152ffcmr2223276ybg.108.1705344910980;
        Mon, 15 Jan 2024 10:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8/Pr+RHGkHS1w1pJSo1nV+YfK7/PsArpNSUrdCY6hNsPiQe4QgkfgzOOzYdHkj/WNdw6IrZQaM29w1oXEqfY=
X-Received: by 2002:a25:d287:0:b0:dbe:ab15:2ffc with SMTP id
 j129-20020a25d287000000b00dbeab152ffcmr2223261ybg.108.1705344910694; Mon, 15
 Jan 2024 10:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115102202.1321115-1-pbonzini@redhat.com> <2024011502-shoptalk-gurgling-61f5@gregkh>
In-Reply-To: <2024011502-shoptalk-gurgling-61f5@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jan 2024 19:54:59 +0100
Message-ID: <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 7:35=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
>
> This really isn't this commit id, sorry.

True, that's the point of the mainline kernel where the logic most
closely resembles the patch. stable-kernel-rules.rst does not quite
say what to do in this case.

> > Builtin/initrd microcode will not be used the ucode loader is disabled.
> > But currently, save_microcode_in_initrd is always performed and it
> > accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
> > particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does n=
ot
> > implement the MSR and the result is a call trace at boot for TDX guests=
.
> >
> > Mainline Linux fixed this as part of a more complex rework of microcode
> > caching that went into 6.7 (see in particular commits dd5e3e3ca6,
> > "x86/microcode/intel: Simplify early loading"; and a7939f0167203,
> > "x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bar=
e
> > minimum in stable kernels, setting initrd_gone just like mainline Linux
> > does in mark_initrd_gone().
>
> Why can't we take the changes in 6.7?  Doing a one-off almost always
> causes problems :(

The series is
https://lore.kernel.org/all/20231002115506.217091296@linutronix.de/

+ fixes at
https://lore.kernel.org/lkml/20231010150702.495139089@linutronix.de/T/

for a total of 35 patches and 800 lines changed.

There is no individual patch that fixes the bug, because it wasn't
really intentional in those patches; it just came out naturally as a
consequence of cleaning up unnecessary code. It is fixed as of patch
7, so one possibility would be to apply patches 1-7 in the series
above but, especially for older kernels, that would be way more scary
than this three line patch. It literally says "if microcode won't be
loaded in the processor don't keep it in memory either".

Paolo

> What exact commits are needed?
>
> thanks,
>
> greg
>


