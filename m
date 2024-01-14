Return-Path: <linux-kernel+bounces-25393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C699682CF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E09283162
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E111851;
	Sun, 14 Jan 2024 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yqkrz5kD"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FA17E8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204520717b3so5220871fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705204138; x=1705808938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=Yqkrz5kDxiv7/zEltjfmZnF4yjdyjTHO5kBf6lFurdpZoic3jit7KTS9IPzHyeuPHE
         pRSNWfPJcTIsReLo8+e2Y/QNzJZmixySqYa0mISR80xLx0mnoFY34fstVtZ1aJuD9xkg
         B723f0RnZH1aiAru7vUAJfh2D1Q0Twx1ES2fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705204138; x=1705808938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi83qxC7DN9Mrs6Lcn/FzkFtPxyAqAamlzctaT7s4iw=;
        b=gwmC0puSCUm59flxNefuk6sH91PnhRSYnYTQLFBF89cKw78l7yNOjt8naHO4KrWvjp
         ELRIi2X5GQ7uxWVS1IXZwGtH/W4YxSeKLvuvkyg4UYX3/1pywIZ7W+R+2BDzS2orEAzD
         FdzwjaBpyoYZsuwO+OEfZO4QEoAOyoVYDzeK1vK/CCbLknpiYl7lpZ3kfmaffqsK2dKY
         YxdSyHL6A3zCS7J25lGwrMSpnWLOx3AT2POiDZpnO6R6MATPZWY8x+iW3hbPrpLPUezL
         cJq0nzJGOBx1QbZhDNrbWjZYjZa9vQm/xkrElPv9f99Mp/QZ//ST81mDHVQzInTP2zBd
         Eovw==
X-Gm-Message-State: AOJu0YzWGuYAIHx2lElXG7IZ7auQ7EF6h/2LOBEIDnUIiGlCWLXcL8x3
	XUqaOOyIY/ms4hkhMphmY2g/Jwsjkvkz0y5rIcNs1fFjwopJ
X-Google-Smtp-Source: AGHT+IGxcLy79rvnuOyBki0wllFskUd2ajI6nO0d3k/tEM6ToEF/16NmjnxfE/jV0LwfK2aFzd7ESKdMigeTSVY4LKk=
X-Received: by 2002:a05:6870:5cca:b0:202:ffc8:c6bb with SMTP id
 et10-20020a0568705cca00b00202ffc8c6bbmr5841416oab.4.1705204138403; Sat, 13
 Jan 2024 19:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-3-jeffxu@chromium.org>
 <202401131146.F017DB5870@keescook>
In-Reply-To: <202401131146.F017DB5870@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 13 Jan 2024 19:48:46 -0800
Message-ID: <CABi2SkXrUm-oa7bZBxFGHdL6qknAeD0OkLio2vniJw=YgDXQaA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mseal: add mseal syscall
To: Kees Cook <keescook@chromium.org>
Cc: rdunlap@infradead.org, akpm@linux-foundation.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 11:48=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Jan 11, 2024 at 11:41:39PM +0000, jeffxu@chromium.org wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f5a97dec5169..345667583b03 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/kasan.h>
> >  #include <linux/memremap.h>
> >  #include <linux/slab.h>
> > +#include <uapi/linux/mman.h>
>
> I think the arm64 build failure is from this include -- it's happening
> too early and some of the arm defines aren't available yet?
>
good point, I will try fixing it.
Thanks!
-Jeff

> -Kees
>
> --
> Kees Cook

