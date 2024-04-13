Return-Path: <linux-kernel+bounces-143509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08028A3A54
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4F428334B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FA113ADA;
	Sat, 13 Apr 2024 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhXvchdx"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7410A19
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973702; cv=none; b=Jv3hsGRFIFNZlVfVM01ONVV/fyt81ZwIsKyeln39WshhgtjhhOJrVkIH7GpWk6JVTwtIqjxeLGCx79x8jgFu8hJWv3x3rPmeNA82rwSWlsgWqxBzP0axugNYIhYU7wK9fRtr3IlxmOqPnPGCPJJC8NSimvZ6p9YfMgOIeYzY+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973702; c=relaxed/simple;
	bh=p/2hydVnnlEbKTZWwG+nen+utD/CQpvcPpWEmaZG1X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUiSPGLK9UxZutnZdw43wpwBdbZZ4nZywpfVaYKzGNvB7FmylSxS6ARV9cmzgggQFzLYWEavpRIGugabt8TY75DJnO67pjX1GWeq99B0zPeOSgiGbZBW25J0HJXiVlwJtPfzVYLapgIrz7ZKU9Xt6wXWFAUDAoG5hVrl8wPL5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhXvchdx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so15018711fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712973699; x=1713578499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/2hydVnnlEbKTZWwG+nen+utD/CQpvcPpWEmaZG1X0=;
        b=YhXvchdxwSpqIsMYezQXre5h2uWHe9pmytB9uSv7F1q86v1ZKOZe2Bj6QWXPPT6BC9
         3HYvJBG4ePfdX1kTzxOoSJIptg+w43h8lS3X0tgsX41+EUFaz5phVQCKu7fnRIdwUev0
         QpANy7EBoeb+pfeseO8REUWnJjITLBAqKytXM2sZ63Gvv5r23ErtCcy1w0EON33h6kiu
         k8GBLlBViAjA2806YpvON28eTz5wOGSahQ8krOkxJcdSECs1RWr1rLV99WdJNa1oHMPk
         wWR7/SJDDLiCZmXXiX7S+LebD6mxKsVplVN8rIK9Xs09xccju7EmfvC+pPRVDxdgwnqs
         aiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712973699; x=1713578499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/2hydVnnlEbKTZWwG+nen+utD/CQpvcPpWEmaZG1X0=;
        b=Fq5+LVGPSDWi7qdV13czXb76yI3GDvoHcDfOZjf9a7DK3DLaG8DzEH/PMRBF8mr7wv
         Or60pr6r7OYnanQlgmJl5wu36OtI1jfHSWoRfL8F9oXmbHO2ZWjunvC4VHFJqoQAB6Pf
         x/2EQWJ0TtOxfIuD9pR+MlfaMU8YnQmAP/2z3p1WzTa1dwDzIzm5C8FYm9SpL9d9X8VG
         2RkJvXjkDmchOHXqCmR69PvvyX4xcsgx6BFr7a5yTdHzIj+o21W505OCBVYPDyUfZ/Yi
         Z2FfQIWjSMP/OKLlUkJiO087hn2Hq//nkLQKjlTJMEKCNLB0LeYhg3JtVKLF0qBUiTji
         ssUw==
X-Forwarded-Encrypted: i=1; AJvYcCVHXGdrsnNPfk4HCpdk8AYBFtipbnvrA6i2XMaqa2LKkUFtvRZGeMG1kwZwVKkdySzQSJAqRMRlWWcotXkkeQGOXc/mFRNVbD2DO0np
X-Gm-Message-State: AOJu0YwZMUGSyP2RF0QliThmrGvvAIBy+86wGObgmmgys699vNrHWy5W
	KDCVowZAbKs6aOfhevAspITgww3h3Ykp6Kc9MgjrVJY4jZC+vXgz+LwmuxuN3cV0OZqSq22sWZw
	bN1wrnbmjSGHArejhupIrOa5B3Is=
X-Google-Smtp-Source: AGHT+IERcfQivnwk0kUV3dGOcGKRjqKT2qQKRpEgfdFliRAGDubcGJS45zyMOCaW4aZWeQQrMNpkomEOqYyFw/nbCGs=
X-Received: by 2002:a2e:9f49:0:b0:2d8:3b49:f831 with SMTP id
 v9-20020a2e9f49000000b002d83b49f831mr2677746ljk.2.1712973698752; Fri, 12 Apr
 2024 19:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com> <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
In-Reply-To: <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sat, 13 Apr 2024 10:01:27 +0800
Message-ID: <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop Dave, since he has ever helped set up an reproducer in
https://lore.kernel.org/linux-mm/20221101071721.GV2703033@dread.disaster.ar=
ea/
@Dave Chinner , I would like to ask for your kindly help on if you can
verify this patch on your environment if convenient. Thanks a lot.


On Sat, Apr 13, 2024 at 5:34=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 12 Apr 2024 14:43:53 +0800 "zhaoyang.huang" <zhaoyang.huang@uniso=
c.com> wrote:
>
> > Livelock in [1] is reported multitimes since v515,
>
> Are you able to provide us with a means by which others can reproduce thi=
s?
>
> Thanks.

