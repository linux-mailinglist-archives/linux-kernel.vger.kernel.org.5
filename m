Return-Path: <linux-kernel+bounces-19123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965A826858
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EFF1C21920
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A468C02;
	Mon,  8 Jan 2024 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz4cbGlW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D18BE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4670af5bd56so271011137.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704697260; x=1705302060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XaSGSt7oo6/seLu3rOawrEq2RYwxc9+YcD3xNECSKxo=;
        b=mz4cbGlWmu2Uu8wFoQHHxihIOv89NYNRw0n3LMop/QOh8jxXpM5a61paBLxr8TcyO/
         PnOiZTvnnRjbR/qU/XOBUSxu+F8lALws2j9UZZAEtNTU1dteAhgRe/xWGXsKjdtmM7yN
         WWlKn70CHA/L/H96Bm6QttmjFvrr7bhuMquACNU1EmYt+vCE0dQATpyqAqCD5x3Rq/Pt
         ApwrvdJ81kHBxb5Jmg3BVcj8pH8dPXDbb6ljQzqMGsvBsP9ti1Fv51gEgTfmGIpP/nnG
         5BLH8Wux8IyPGKO/+KJbAYool8aMVEcyTUkUR6VN933qsjYLJ3OpCBzF+wX4uAqAlyKU
         eCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704697260; x=1705302060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaSGSt7oo6/seLu3rOawrEq2RYwxc9+YcD3xNECSKxo=;
        b=wX3IYc4Xmy0RcXxetcSZMbdMjwctmNJqMkJsLyL2J89eoExT/EVhdzgLHJQbddFsOz
         bKHNVEFpSChsmgiURceb/GBPCyoTCYsYCeJZ1IF7FHk08diOMOiEJMZeqllvQ/U/Rb6K
         tJbrcf2phCvUQI9QpqnrrX9qFhELF20Z6KvafB8uP9L/3nl47EyO5HC5yl7fYhr1Cg3x
         FYAI2yzUSwu7d+ifFyeIY3UX/2Xit5dNQz2sEcDqSfJ1BpFwtMZMkci2EryEx9tyKIHV
         M/w4XcCWZA1Si0mZozSqXY/62Hsdm6+98LnY/Z2Dvl6vP55m1sDvDM1iga9aUhx/iMk+
         smtg==
X-Gm-Message-State: AOJu0YxuBStR4rLMPqR9u73LmGo1NI0GA/LSfBzqi1kxNZqzH6dBcpY5
	QBy3Wez2KQSUH9re4O38jS+AELgdhqe3qGsAvF9BJkaGSymS
X-Google-Smtp-Source: AGHT+IFpUN6pC7xCIbsApGCrJl55CBrGAh6IirKLDVKz3A3mm7X38w82LDyi08a6WKg/Zz3amwxxsgoI1/gJIOwtPq4=
X-Received: by 2002:a05:6102:304b:b0:467:ac41:856d with SMTP id
 w11-20020a056102304b00b00467ac41856dmr1575462vsa.20.1704697260063; Sun, 07
 Jan 2024 23:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104164937.424320-1-pierre.gondois@arm.com> <CANpmjNOwqoEbmuyE_LeMmJ=x9-3CkpXqYsi6m3Gniudyj+RFzw@mail.gmail.com>
In-Reply-To: <CANpmjNOwqoEbmuyE_LeMmJ=x9-3CkpXqYsi6m3Gniudyj+RFzw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 8 Jan 2024 08:00:00 +0100
Message-ID: <CANpmjNMK3hiBPG2UwEV14YZoee08a7ULw4cwcsxfV=E5+FcTTg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] list: Add hlist_count_nodes()
To: Pierre Gondois <pierre.gondois@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Coly Li <colyli@suse.de>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Jani Nikula <jani.nikula@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 18:16, Marco Elver <elver@google.com> wrote:
> On Thu, 4 Jan 2024 at 17:50, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >
> > v2:
> > - Add usages of the function to avoid considering it as dead code.
> > v1:
> > - https://lore.kernel.org/all/20240103090241.164817-1-pierre.gondois@arm.com/
> >
> > Add a generic hlist_count_nodes() function.
> >
> > This function aims to be used in a private module. As suggested by
> > Marco, having it used would avoid to consider it as dead code.
> > Thus, add some usages of the function in two drivers.
>
> Whether or not it's used in a private module is probably irrelevant
> from an upstream perspective.
>
> But this is a reasonable cleanup, and at the same time adds API
> symmetry with the already existing list_count_nodes().
>
> > Pierre Gondois (3):
> >   list: Add hlist_count_nodes()
> >   binder: Use of hlist_count_nodes()
> >   bcache: Use of hlist_count_nodes()
> >
> >  drivers/android/binder.c  |  4 +---
> >  drivers/md/bcache/sysfs.c |  8 +-------
> >  include/linux/list.h      | 15 +++++++++++++++
> >  3 files changed, 17 insertions(+), 10 deletions(-)
>
> For the series:
>
> Acked-by: Marco Elver <elver@google.com>

Btw, there doesn't appear to be a clear maintainer or tree for
include/linux/list.h. Since there have been several Acks/Reviews by
now, did you have a particular tree in mind?
Perhaps Andrew (+Cc) can help.

Thanks,
-- Marco

