Return-Path: <linux-kernel+bounces-19950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0419827745
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49731284ADB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079954F86;
	Mon,  8 Jan 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ektZpHHV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05D54BF8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso1982668e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704737965; x=1705342765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qku9fzesSmMIoCPbtRd9UiOBvRdFodDwMjMAkwBQ5jo=;
        b=ektZpHHVZyPrE1iWDKTIAQtHm4PuzfjJmC+tm6vgod7GS9CZ9nZ5TLwxDKYzTkEjx3
         k+LZ1i2rtQZNZeUA4LqwKm2ORvi+AOYnDgvvaupEh8X5oNY3AeTUKkW/9aH0Ie9gJO+1
         qyjrtdZCj84qrkk4pqnJAkI1m6684bq3f6Wfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737965; x=1705342765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qku9fzesSmMIoCPbtRd9UiOBvRdFodDwMjMAkwBQ5jo=;
        b=LVVsc4h7TPFrk9I3B/swWMGrOwqmD4m1eBs2Q456dSPb+LdV1jAnDCo0Ja3ez6bnPI
         fVwVKrHbj4wfMTciWWWSQv9GLoQivUBB5WP6DpGTAcjqE6FcP21hU6aCjVsB94537JVj
         CdDMAiVk0I9rqAeGMxGmuGf2odi/l6FZH9KD7A0op5U3u9SCn5OXyOLTitXDVzhdulCW
         IXFDn8bCaiFsE+i2RWA95/FiYxJjQXgUC3yRqcPfj/JDMN3WUifYez5gkOSAmnV3dtqu
         d1a85MHg29zyIodzYJaMYuCINWXaB3Yv6itVDTka8v7Qu388vyv25Mtb7PohQzv7gzB7
         YajQ==
X-Gm-Message-State: AOJu0YxaXEhP6d/EYrtrGPvHWP3OSCiim6GsZnmOB0JhNFVLuLLIQ39c
	gVM2dC39zA/sOQa7XOF0FBr1IGgGcBgly3gAjbTMt7tyco5JJf8s
X-Google-Smtp-Source: AGHT+IHdXFc4efpqrbsqwpwZy/+Bc0NMQIiAKZLtrNTSPuvixN3RMUppXVP/mz6f9IP19TFkuqLaTA==
X-Received: by 2002:a19:ae0a:0:b0:50e:aa30:5ea1 with SMTP id f10-20020a19ae0a000000b0050eaa305ea1mr1380874lfc.61.1704737964948;
        Mon, 08 Jan 2024 10:19:24 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id h40-20020a0564020ea800b005578b816f20sm96393eda.29.2024.01.08.10.19.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 10:19:24 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e4d64a3d8so569185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:19:24 -0800 (PST)
X-Received: by 2002:a05:600c:3d8e:b0:40e:488c:9cff with SMTP id
 bi14-20020a05600c3d8e00b0040e488c9cffmr638883wmb.77.1704737963949; Mon, 08
 Jan 2024 10:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com> <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
In-Reply-To: <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 10:19:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
Message-ID: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
To: Jiri Slaby <jirislaby@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 03:46, Jiri Slaby <jirislaby@gmail.com> wrote:
>
>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
> real    0m45,002s
>
> $ git revert 867046cc7027703f60a46339ffde91a1970f2901
>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
> real    0m11,132s
>
> $ git revert 4ead534fba42fc4fd41163297528d2aa731cd121
>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
> real    0m3,711s

Ouch. Yeah, that's unfortunate. There's a lot of nested nasty macro
expansion there, but that timing is excessive.

Sparse actually complains about that file:

  drivers/media/pci/solo6x10/solo6x10-p2m.c:309:13: error: too long
token expansion
  drivers/media/pci/solo6x10/solo6x10-p2m.c:310:17: error: too long
token expansion

and while that is a sparse limitation, it's still interesting. Having
that file expand to 122M is not ok.

In this case, I suspect the right thing to do is to simply not use
min()/max() in that header at all, but do something like

  --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
  +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
  @@ -56,2 +56,5 @@

  +#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
  +#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
  +
   #define SOLO_MP4E_EXT_ADDR(__solo) \
  @@ -59,4 +62,4 @@
   #define SOLO_MP4E_EXT_SIZE(__solo) \
  -     max((..),                               \
  -         min(((..) - \
  +     MAX((..),                               \
  +         MIN(((..) - \
                 ..), 0x00ff0000))
  @@ -67,4 +70,4 @@
   #define SOLO_JPEG_EXT_SIZE(__solo) \
  -     max(..,                         \
  -         min(..)
  +     MAX(..,                         \
  +         MIN(..)

and avoid this issue.

That said, I'm sure this thing exists to a smaller degree elsewhere. I
wonder if we could simplify our min/max type tests..

             Linus

