Return-Path: <linux-kernel+bounces-19810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F1827495
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563081C22E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154E524A0;
	Mon,  8 Jan 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxDQStCP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE0524BA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-204dfd7a89aso957321fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 08:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704729635; x=1705334435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhaTWMM1J7fnFC4m0/Is2MdvAgnd3Gn355pGFsoQhag=;
        b=QxDQStCP5glLeIpZn44jkXG3qKRpmBNJBKB4/kB3BTYUt/Ui8YnkpF8saGG+7eGe2p
         eOrIh/07sYSts8OmQNcUir6Bl6qjh92CUZ+mXOBNE7QtASo5dlM2pgmN5vUTzjsZ/3kC
         7AGQo/BgT8Q1NCFiB41d7zGVjVNSLSXDRNb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704729635; x=1705334435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhaTWMM1J7fnFC4m0/Is2MdvAgnd3Gn355pGFsoQhag=;
        b=RXSo/ErSMPa+lQX70Xj5EQcVYVzwjJ+xN8auA3ln+QGUGxUcQCURud66HD73jSsY58
         VGvc5chXqDX8iEnxwJ/ZML7on6B8G9azOqTwPRYwDaKyF8ky399zAq8u+rD0Qvu1I+tH
         qkjCy2tjFTILbT8Ls3ZcQ3SUpZy+rvtGin6vgxu1nzSzjYUFEsoPlYc8uWbYrxEvcPGu
         sW0diIQJjzs4gUWeR/V9F4Mle+PfKFfcN7gXZITKDLgueRKTkub7yaou3UrF3b9CUgk6
         Ey44vk6SiFZ71CVh+7hswpmY+Hds+G9Uu/MXitzG0OLjl9TanxYiU5xc4SEy+Kiw8SkI
         4I7g==
X-Gm-Message-State: AOJu0Yye35nAcKfC9FLPinhqwjwcA1TFtdz9zdW2dfdk9xZxGDb/xXWs
	7dWicZk6nMIg/Mv+zPgj2sMF3CbLhTh3zxTmK6SUFIXhvpMC
X-Google-Smtp-Source: AGHT+IFsyr9PipomN50qTzZSjGmht0Y6LotO8i5wTx1ikP902yVEMEd9iRDf0Klegy5vhidUtbKEgst4FKgIVlgOddc=
X-Received: by 2002:a05:6870:1587:b0:206:3c53:65b9 with SMTP id
 j7-20020a056870158700b002063c5365b9mr487892oab.52.1704729635730; Mon, 08 Jan
 2024 08:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104185138.169307-1-jeffxu@chromium.org> <20240104185138.169307-3-jeffxu@chromium.org>
 <CAHk-=wiy0nHG9+3rXzQa=W8gM8F6-MhsHrs_ZqWaHtjmPK4=FA@mail.gmail.com>
In-Reply-To: <CAHk-=wiy0nHG9+3rXzQa=W8gM8F6-MhsHrs_ZqWaHtjmPK4=FA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 8 Jan 2024 08:00:00 -0800
Message-ID: <CABi2SkXx0bWeqMTb1TRwya6_Hx6NGnMEtycQ56g9S5ORpz7u=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/4] mseal: add mseal syscall
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 10:42=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One comment:
>
> On Thu, 4 Jan 2024 at 10:51, <jeffxu@chromium.org> wrote:
> >
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 9a846439b36a..02280199069b 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -193,6 +193,7 @@ COND_SYSCALL(migrate_pages);
> >  COND_SYSCALL(move_pages);
> >  COND_SYSCALL(set_mempolicy_home_node);
> >  COND_SYSCALL(cachestat);
> > +COND_SYSCALL(mseal);
> >
> >  COND_SYSCALL(perf_event_open);
> >  COND_SYSCALL(accept4);
>
> Move this part to PATCH 1/1, so that it all builds cleanly.
>
Sure, thanks!

-Jeff

> Other than that, this seems all reasonable to me now.
>
>                   Linus

