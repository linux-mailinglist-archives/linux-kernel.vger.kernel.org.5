Return-Path: <linux-kernel+bounces-7847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD381AE29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D531F249C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D4B677;
	Thu, 21 Dec 2023 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASLsmIA8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07848B642
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so36885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703134437; x=1703739237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k0cAPFS7LLAsUHdO/FR/5DuAwii6esQYDIfaewZ8DQ=;
        b=ASLsmIA8KoIkcPIxn3XSSsmftbrgHnES+JfSrc5c8ND/yzL6NIsfWG5UKWsURenPkE
         Z+qC1xWZRrCaOpalyCiuiuzr7Xw/ZKp+yG9sgYr6URaxBxwpd8WJ8XcvYUjpCXcZRo8M
         CaiQDcC8U/4sjedj0hHSr7IEHsh9Ak6Vc7wXnXUmyLz8Evr9Ai8SiyAboiXhRAsIpc3c
         LSEKjxoEL4G81S6nqOn7O2sP9QSLhj/6gwOSNBe02FCBcb1a/P6hOC+R6pI5HFawQ/IV
         0CZ2grHbb0ogBnNvIPzx8V5ncXrSRAgrroOKw/LZ9pceYLGya7qa1hiKwuKc4XHqOZoq
         eqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134437; x=1703739237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k0cAPFS7LLAsUHdO/FR/5DuAwii6esQYDIfaewZ8DQ=;
        b=LSAimQ6FvEVu7SYJXSv03xoWQZoffjEdmLVHU+cOAADjLH6fYuO8GAJrhEMKbi7oLF
         6Fyk+YhubWvJpparKbb3gw+PL/inI8bSGgjkDS/7dPi0TQeO3ivTb5Dk/GyRR5rbIcX6
         McqV8FwQcrKVkqpTVOqlCw7/35FFqL7aSmCdfLIvQvuaeFJkXL67gkmFSetUPCvkDNxR
         1aUurXRnPIOcbiJKZpwW8vwJdOnnumHN8LLkm9kf55zYyDzn1m9f95pUQBG2xHf3/0lN
         3j+i/Z/+VFapqAhMzt9iBCFUVHXSzjLk6I6daXE7yCJtyYeSAA9FgQI5fhj4lBJri4bi
         +XHg==
X-Gm-Message-State: AOJu0YzyZg9XmP0yE/vGu+4E0+5d3DWKKYHDluaDWeBNv6HACBKOiZLQ
	uZ3fZJ2MwDopymV/BD5d2TmdZrMXz93iOe1L0GA8WDJR6l06
X-Google-Smtp-Source: AGHT+IFe1VETlZKll/MDbpRMTSVMFHC+QIFL9ULnK0v5vAQpf0kjul7d3jojq4fBlBIvOZ83nP3FPrsBrvS+leDx1EQ=
X-Received: by 2002:a05:600c:5487:b0:40c:4ed3:8d1f with SMTP id
 iv7-20020a05600c548700b0040c4ed38d1fmr17340wmb.7.1703134436906; Wed, 20 Dec
 2023 20:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
 <ZYL2rbD5UTz3s8gg@casper.infradead.org> <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
 <ZYO6bLcCRYlo290g@casper.infradead.org>
In-Reply-To: <ZYO6bLcCRYlo290g@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 21:53:19 -0700
Message-ID: <CAOUHufZ-hAAB+9iL3K-YokN4oVJoiC9dVQ+6zLu-M4Ag52TY5g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Matthew Wilcox <willy@infradead.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Inactive mapped folio will be promoted to active only when it is
> > > > scanned in shrink_inactive_list, while the vfs folio will do this
> > > > immidiatly when it is accessed. These will introduce two affections=
:
> > > >
> > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > 2. Low reclaiming efficiency caused by dummy nactive folio which sh=
ould
> > > >    be kept as earlier as shrink_active_list.
> > > >
> > > > I would like to suggest mark the folio be accessed in minor fault t=
o
> > > > solve this situation.
> > >
> > > This isn't going to be as effective as you imagine.  Almost all file
> > > faults are handled through filemap_map_pages().  So I must ask, what
> > > testing have you done with this patch?
> > >
> > > And while you're gathering data, what effect would this patch have on=
 your
> > > workloads?
> > Thanks for heads-up, I am out of date for readahead mechanism. My goal
>
> It's not a terribly new mechanism ... filemap_map_pages() was added nine
> years ago in 2014 by commit f1820361f83d
>
> > is to have mapped file pages behave like other pages which could be
> > promoted immediately when they are accessed. I will update the patch
> > and provide benchmark data in new patch set.
>
> Understood.  I don't know the history of this, so I'm not sure if the
> decision to not mark folios as accessed here was intentional or not.
> I suspect it's entirely unintentional.

It's intentional. For the active/inactive LRU, all folios start
inactive. The first scan of a folio transfers the A-bit (if it's set
during the initial fault) to PG_referenced; the second scan of this
folio, if the A-bit is set again, moves it to the active list. This
way single-use folios, i.e., folios mapped for file streaming, can be
reclaimed quickly, since they are "demoted" rather than "promoted" on
the second scan. This RFC would regress memory streaming workloads.

