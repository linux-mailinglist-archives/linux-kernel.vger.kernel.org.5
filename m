Return-Path: <linux-kernel+bounces-77315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882F8603A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9110C1C23F40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC26E600;
	Thu, 22 Feb 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/IIdSZy"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA786AF9C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633609; cv=none; b=tSMy2aBbfTN+fIrDmlOYVd70HoGTTRA0ZnquFw45aBUaelJCE2ljMYLi4yfwo+m3SVqSjKcr8Yo+VPX37xwitV8fmmqYsK16JFDPe3pe1ir6phzkQkTXADMy9+xHQ/f+Xf/LldZEo+RQfjv+Y/gjhCipfBSh5IYleqvADygfsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633609; c=relaxed/simple;
	bh=PUyXXnprP/ph5buEaDWG0UadiEy06sC3+5Wzt2ivEoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMte4YIEhoXAXIYXuhGdxi23SrN5h3bf2BeJ7PLHbuVFc4yDp2aaudrgPWq5V9Jh5gcauDrQNLvqA71wqi60/qdGAFT+65Dv51LDk3sjIPfwVMKO9YFz/dHTmGj0vb+dtevSlgKcFnVFxDqkEtnclE6ycWGKjvyeeqczBBCOYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/IIdSZy; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so27608241.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633607; x=1709238407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XG6DbkHapiM35lgKhxzUx9wc9Dmk7y4EG80uVYXtd54=;
        b=W/IIdSZyB0hRlPGb21ej+6H3K8sYgvya/C4zOMAfN+VBIznla3jSnpbN47CsdDFA3i
         tl/1TrudPOkEVsy3USmdnRicsZHF6HK1Dl+Ktnbfu5Tj9fxH8fcm4cGMG5yN/5Ypo0te
         dzM1bNgobnChoTuDB5yhNTZXA/yBfpAZ12bxaXiFfD/5VJlMX90nboPUKw9jcYDqAKpX
         K5ZZsGFAKyzvUPRrfRB+sKGDDn61bVbfvFzM95Xp2e/d9AIANqtBApvZPcDFDkI9Xlae
         FE5+k1mlF57WrSkU6BtUsbkdfRUXwMrwY5jz4ZW8QJg34N3q1G78lxiad/ThKGmxyB9i
         QDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633607; x=1709238407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XG6DbkHapiM35lgKhxzUx9wc9Dmk7y4EG80uVYXtd54=;
        b=ZGobMDKFh4j1dZLXDlElLhUIPyBaiEndY8WwlTNbQTin6NYhvojhSgV8TV1aYbi+sh
         voWgsK3cepIPFbXIrVvnnkDOzM2QnebbXmcbvYuUYXj3z2i4bYELLud9MRiMl5tgoqhy
         F50z0R66UBeqRylUAc2uNFQwPkA2Q5iBNbi3AxVQvG22/2S7jGYH/BBCGrEHM1f4W+lz
         UnB9cCNrpr8rCgMETh3yr9otbK7JXndySfpPQVx48gXuiGh4j6JHgMZhJ3j0pDkOP/5a
         wR7S+bpjDSSnP7nsVJn0OYLlOr8WvadB1vxUnHn/M8x7knUGgMhHJed3luWM1VanrfuH
         a+3g==
X-Forwarded-Encrypted: i=1; AJvYcCUaG0enKI4yH1CoV6U4FjQ0JAZ9qF3hOZPar3EfzZ5W5+xIXd+U58qS5AUHHn2pMkiDXnqFm44lPuydRYRa8MX+Myjhsbk7jQShEcOB
X-Gm-Message-State: AOJu0YwxbpCR5ahW5SR4WXzKs2ZZvt4GwmJD9zlP2zKLVP8UDD9mDHdC
	zGfd6jvP6fhdrKpIrlUxbPtlMW3jxYHSqw/cZ7Whz/IEBPzLHtgZdzDgXxnNtTnIxORG5usdnq6
	MTNBDew4o7R/ySQ0uqfPC6ioq13s=
X-Google-Smtp-Source: AGHT+IEuA4ykU1LrAi9/8rSTHUuKXByhd1TgE3HhFWzoBXntZH+1spAr+uQDm+aOFNycj/sZ550NDzRXQtJep0OqIBU=
X-Received: by 2002:a05:6102:411:b0:471:c545:d8ab with SMTP id
 d17-20020a056102041100b00471c545d8abmr1367vsq.28.1708633607159; Thu, 22 Feb
 2024 12:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAOMdWSKrcRFUsFc3a0+2Js5hOA92xeQSkS06oL9VgSyZpDrO8g@mail.gmail.com>
In-Reply-To: <CAOMdWSKrcRFUsFc3a0+2Js5hOA92xeQSkS06oL9VgSyZpDrO8g@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 22 Feb 2024 12:26:35 -0800
Message-ID: <CAOMdWSLjk8pZUgM6QHdeJ3C8Q-Y07GM4QuaSyAyP2jZcAMLOhA@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Tejun,


> > Lai, would you mind reviewing patches 0001-00010? If you're okay, I'll apply
> > them to wq/for-6.9 and then post the v2 patchset with the rest of the
> > patches updated to reflect your reviews.
> >
>
>  In addition to the above features, would it make sense to introduce a "count"
> variable in struct work_struct?(I am not an expert with workqueue
> internals). Or perhaps
> we could use the existing "data" variable.
>
> struct tasklet_struct has a variable count, which is referenced in
> several drivers, Ex:
>
> from drivers/gpu/drm/i915/i915_tasklet.h
>  28 static inline bool __tasklet_is_enabled(const struct tasklet_struct *t)
>  29 {
>  30         return !atomic_read(&t->count);
>  31 }
>
> Also, there are several helper functions that use the "state"
> variable, tasklet_lock() which calls tasklet_trylock().
> I was thinking of adding/introducing these helper functions. Do let me
> know if it makes sense.

 Ignore my above question. I quite frankly had not read enough about workqueues
or did look into the code. I do understand more than what I did after
looking at the
sources.

 I do understand the work bits, but I don't fully understand the
concept of colors
(work_color, flush_color). A swift overview of it would be highly appreciated.

Thanks.


-- 
       - Allen

