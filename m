Return-Path: <linux-kernel+bounces-22186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F27829A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E512A1C24640
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282F482FE;
	Wed, 10 Jan 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeUMpNzS"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE748CC8;
	Wed, 10 Jan 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbebe6191bso3732058b6e.3;
        Wed, 10 Jan 2024 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704890953; x=1705495753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REhGpdroa6cBxeVt6/ySf42exMJ/bES9CjOdzQq6zdU=;
        b=UeUMpNzSCgb0R+9pBXfgAjxfQHSpKDdXbGSYzWtUZyBZF6ykGUbETzQaMz+wIIJ1F3
         1QVM2cpppQEwoQjC75Iz6PM7gRTUk61AlKfBq2vB0QBoYkUT7e08+W02f8kaAi8BRcv3
         +WWzPeIUM8hg0oYkmzbFto3f8WGhSE6UyDdh93hx1mjmK9fEUAgEB4JADf4XxoTWL4T+
         OhOGRCRySuYtGWqoyDXyBfVllKnkaAHjmaDusbk77pmuQp6iIFYFEVbnbOl23+65h3C1
         utErjhYpwDg/CWFn1WTirUykpTG8F2WcJXEasqX5/9EWE1k7lfjyVF5elUWTqya3C/Xv
         yMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890953; x=1705495753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REhGpdroa6cBxeVt6/ySf42exMJ/bES9CjOdzQq6zdU=;
        b=n9FTWF7JJgZVL4vVphhbVk3F0RSdyGuohH5awL0vxIDd1ru5mTO/uCfKTJkVJ4KA/D
         vV57eTQX4ze851Z70q7xopnLhs87/Fl2sE+z0+85+ERxPfYEMhIz1HybQUzzagSf5gzf
         9h3rznVNLmI8oS74avt7fB53F4ygj8j2hwsDrfwUWIIdoG6lWFX3UBOiZqdmXOQ3yngx
         0Iih8L20sOweKcwnVCTeX3H8oNQo95cTAsrJPSpFz4oiOtWuZIpmc7Hc3ErJOPvu9/MF
         ME/nnYumiuvNwDZcOyY1aMSjyWNRZ+fzqD7OKtWZtGmpYrxEk+1R2YjL5AemC8/YNhQE
         goPQ==
X-Gm-Message-State: AOJu0Yy/Luk5Tky3wj5NrRWkFu72z2/an/ZPo7NyzOpH1HUJoCBKJKOI
	rkUvT8B3jUVaejRuZsdllPRI1gj3Sob812z9WIU=
X-Google-Smtp-Source: AGHT+IHvA530Y3zhfFAw3i/+1nMbsoG6/W9iThS7KUwM8hcmn1LZ4rYFri6JhNWTA+KPK13EjF1bQC0cpqciA99E/tE=
X-Received: by 2002:a05:6808:f91:b0:3bd:38b9:64c3 with SMTP id
 o17-20020a0568080f9100b003bd38b964c3mr1266243oiw.61.1704890953655; Wed, 10
 Jan 2024 04:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de> <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
In-Reply-To: <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Jan 2024 14:49:02 +0200
Message-ID: <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
Subject: Re: [PATCH 0/4] overlayfs: Adjustments for ovl_fill_super()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:25=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Date: Thu, 30 Mar 2023 10:38:23 +0200
> >
> > Some update suggestions were taken into account
> > from static source code analysis.
> >
> > Markus Elfring (4):
> >   Return directly for two checks
> >   Improve two size determinations
> >   Improve exception handling
> >   Move some assignments for the variable =E2=80=9Cerr=E2=80=9D
> >
> >  fs/overlayfs/super.c | 72 ++++++++++++++++++++++++--------------------
> >  1 file changed, 39 insertions(+), 33 deletions(-)
>
> Is this patch series still in review queues?
>

Sorry, this series was not on my radar.

> See also:
> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web.de=
/
> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
>

I will queue cleanup patches 1-2, but I do not like patches 3/4 and 4/4.
I do not think that they make the code better to read or maintain.

Thanks,
Amir.

