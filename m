Return-Path: <linux-kernel+bounces-17044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E0824781
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2812B21F80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D129286B8;
	Thu,  4 Jan 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JozeXy37"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C5286AD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-428405a0205so289011cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704389569; x=1704994369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqY8OgOdC3d88JsYKWQTFxM4+HiTBGWgetv0NzWf6g8=;
        b=JozeXy37oYwIKcWWaCgMo9e8DJoS3A+AvwboMMvnpsfdODQpIEeeBeTnO5DzmVEkWl
         uNOaRwArkuX3o5OxPkhTUqGjcJkoERqad2bGBCzafOPC12w+HCnazJ87qGM5Sqa2v1U7
         wnb67X0t1p57565tYC3AJLctVt1L9bivxjfAxXgxygAOW7YDKWawS5HKa5Gf1lEckjxg
         ZPF91KvQFf1GlHVsaULQG3s+9fcDfNSKfTdCbE0qg28ozObqdI0mhBHPyk+PEUDrSq7x
         OJhcdmidoLN/7gW9zfg8PRgqZbPVMIAAcGoQbgFs6XmB35DxMTSo5lTKvQF1Vhl6KmVN
         wyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389569; x=1704994369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqY8OgOdC3d88JsYKWQTFxM4+HiTBGWgetv0NzWf6g8=;
        b=kKVu7W++r56d9IzHT3Iw6U3SfCqJAsEdSgpYcRMQNBI9rpBRVpM04Uwj/waBYFNxw7
         V2S8gW8t70wAXS0B8g4KvvtWa0p8JmUMc9pWTC6mxBlhnQz5FP232tYJwDmUNE6LDoEo
         kHGiJ6WxK5K6WQMPdqMHurfqn+FtBlz949C+ldCLfD16DrsgM2PAwB0HFNJP+csakp01
         NOSz+0tCCNC8jGuyyrUqxEtHXdGXQFWkmS1rgrSAhBst/9IIgO4jHlXZA9IJHnIlzbD7
         q8CJCAQrQSHhAStpcQDg0jMNuqIkjQ+bJumao4B2x9YnqLZlXpyR64adXHOLDVUURipQ
         1oCw==
X-Gm-Message-State: AOJu0Yy5/vUsciyWFXvO7T2Deftcw+YnIQh+FZMXkelSkYMY19VP6jrT
	aGCsMJy4ArCXeUd8lTUd//nPm7gYpIBZ6u8DKTfbIpxk7pc8
X-Google-Smtp-Source: AGHT+IGyvqmCqF8cJesbEu56LXfd0VAsNyenEMxT+xOZY2Fven9BKDWbf98GEp+MQNIIsUnmgJj9IlY3RRiaF2oR9U0=
X-Received: by 2002:ac8:7d49:0:b0:425:918b:f18c with SMTP id
 h9-20020ac87d49000000b00425918bf18cmr521300qtb.11.1704389569148; Thu, 04 Jan
 2024 09:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226-binderfs-v1-1-66829e92b523@google.com>
 <eacd168f-22dd-4e11-8907-0c79ee33f595@wanadoo.fr> <ZZboVgcBljOgrJAI@google.com>
In-Reply-To: <ZZboVgcBljOgrJAI@google.com>
From: Tanzir Hasan <tanzirh@google.com>
Date: Thu, 4 Jan 2024 09:32:37 -0800
Message-ID: <CAE-cH4r270umQbs82w=tXAJtK5J5V=Z9zJun_8jYOKJsHWb7qw@mail.gmail.com>
Subject: Re: [PATCH] android: removed asm-generic/errno-base.h
To: Carlos Llamas <cmllamas@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:18=E2=80=AFAM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> On Thu, Jan 04, 2024 at 04:36:00PM +0100, Christophe JAILLET wrote:
> > Le 26/12/2023 =C3=A0 18:09, Tanzir Hasan a =C3=A9crit :
> > > asm-generic/errno-base.h can be replaced by linux/errno.h and the fil=
e
> > > will still build correctly. It is an asm-generic file which should be
> > > avoided if possible.
> > >
> > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> > > ---
> > >   drivers/android/binderfs.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index 1224ab7aa070..d04ff6029480 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -29,7 +29,7 @@
> > >   #include <linux/uaccess.h>
> > >   #include <linux/user_namespace.h>
> > >   #include <linux/xarray.h>
> > > -#include <uapi/asm-generic/errno-base.h>
> > > +#include <linux/errno.h>
> >
> > linux/errno.h is already included a few lines above.
> >
> > CJ
> >
>
> Good catch! Then we should just drop the errno-base.h include.
>
> --
> Carlos Llamas

Thanks for bringing that up. I will correct it and just remove the
asm-generic header instead.

Best,
Tanzir

