Return-Path: <linux-kernel+bounces-94916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F348746B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B4D1C20946
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA4F125BA;
	Thu,  7 Mar 2024 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ2Wm8Q7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48283E576;
	Thu,  7 Mar 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709781634; cv=none; b=dkf9rtLYuj0ps8GbpyUVG1hxX3BUiyow5AVy4o3Th7HWb2nenbfY466HGyOj4Etn5SPDqJr9xfxhqt3AAX1gkvel0Q23X+fITOl3P6RI1BnUIMvyh0MMp978KJxsRcHzVm02e2b+6mQ3rtw5U2QvN8/kwF6+m8x9Tg8jWIWDNHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709781634; c=relaxed/simple;
	bh=Ti6YAh/NMgGQsnsVPl5LkxAkyP+ZOzDYD3+Aqwls+Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddl7aPBXrA6oKdsulsNHwXqGZZYo8HPkFW1DH6TJuIJOON+aA4RwXOP1BBsStyAX4jlfedTrMeSb7GEArsGQaD/0UI4hoty5pWWwAUGi2GGTRUbeGJRyvGncZB+nI6RHi5oPomaZqGMKs1UJLbI+Wb1JqnfG5lWgtEwBV5a7sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ2Wm8Q7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e122c8598so175362f8f.1;
        Wed, 06 Mar 2024 19:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709781630; x=1710386430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ZvxkU8o27HBaf+3etQV0wPvLqge6KNPGX713iuBK8=;
        b=XZ2Wm8Q7VcruMaGFm5oy5wbv7NBKD3/50G49ys5PEh5dcVBNF2fdtW5C3V8ZU0bJH6
         ZtEHUf2SPqhyZ1tHZzTrHl4HXzMrwNZoM9bJTc9aBZBVrmCsB/iB2fvKb8t4mEv9VIzS
         rmu5Y66a3Lm2O+QX60ARSqdEZ+Hmpe+/RBOoxdVLKYsfoDxT5S0bH8ggU+Uh0cpxSpKx
         S4vWSs7rSZVJOEo//DPd3zJ649oRiIpZE26J4RW89lFQ/cFuKCE9ASp7FTGVJr1gS3no
         NjKNHTUbTk2UMDdPVnmqnbyIxsJ6NGJO+/trLLeufVeV0ugH/sEbRlknBZPPYIUe3EJJ
         dCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709781630; x=1710386430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ZvxkU8o27HBaf+3etQV0wPvLqge6KNPGX713iuBK8=;
        b=WK/EscbNUGyCwdz6ANeBtmrfqlRXHXghXDr4FPntKGjWsjwC12GrqSt0bgnnKKqKK9
         dGylglCetK6zi28AzHpcGejVyzef2gTqt6yyMxWUfV8T2MiyyP9oK4pKyAD1xRsT3mVP
         EtjgkUtW2ci8Tyypx1MP/w0Fb9Bs/YihJMP1UFdRvS4pUnZKnDWRhNCDybtBj/ZSkQmZ
         2Vx0RfpPIOmHNfckLa5gWfwEHasQw49/c+BYuE1NDsF3BwTnC5rhgKkEXvthv/NfGjVC
         4SfGPFMWRxBnY1FgNRFFQQKJ/TAYoOxmefD7NsB6mkCANUJksv3qhNUMkh1w7ZlazWa/
         txeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzAVSrwv1AjpbJYwzuSS1tV65g2rISQPhNppilU2aP6N2V4oy0p8YJpNaRGljiv77fj9lBT3sffyZyp7PikFRKljGvciCImDViU8GhJzDqynDwy/hLSqWAa24PlPUJZJdHzhQWtQHssejAlNi1JJ6kbfFW/jEiYxXXviJInm8kd5pcDlnSeyEVKFg6SeFO1K0QZKGnhw==
X-Gm-Message-State: AOJu0YwRRu+KF5XYOnM64+Svn0cmn0D1Ue/5kUayufVwW2FcJtCBJJQR
	IFAJcjo8BvEaKSNvtKVnlXjO+vfYuydJ4I77WdSZnXaBq4Ruiw6T6NN76MLQb9PSLjGR0S3PNwF
	LadhFMOjuUtNc4K2SV0+i6MzBzB/wvoct
X-Google-Smtp-Source: AGHT+IFjaP2GBdB8DtmUnLCZsfrF61QII3WlzmZDWuRLmnC1wDfvWJwkerifgTREyQcvLifYGD6e/slTjJWDNkjIPMA=
X-Received: by 2002:adf:b643:0:b0:33d:7385:d929 with SMTP id
 i3-20020adfb643000000b0033d7385d929mr14853839wre.0.1709781630370; Wed, 06 Mar
 2024 19:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307123619.159f1c4c@canb.auug.org.au>
In-Reply-To: <20240307123619.159f1c4c@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 19:20:19 -0800
Message-ID: <CAADnVQKy848BOi42kJh5dDpFsVuyktAgFds3byptANGpOkbXZw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm-stable tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   mm/vmalloc.c
>
> between commit:
>
>   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
>
> from the mm-stable tree and commit:
>
>   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages()=
")
>
> from the bpf-next tree.
>
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

..

>
>  -      if (v->flags & VM_USERMAP)
>  -              seq_puts(m, " user");
>  +                      if (v->flags & VM_IOREMAP)
>  +                              seq_puts(m, " ioremap");
>
>  -      if (v->flags & VM_DMA_COHERENT)
>  -              seq_puts(m, " dma-coherent");
> ++                      if (v->flags & VM_SPARSE)
> ++                              seq_puts(m, " sparse");
> +

Indent change across the loop makes the conflict look big,
but it's actually trivial and resolution looks correct.

Thanks!

