Return-Path: <linux-kernel+bounces-36913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49E83A899
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4F1F24AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC260DCC;
	Wed, 24 Jan 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPxV8/XE"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC860BBE;
	Wed, 24 Jan 2024 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097539; cv=none; b=shW5RItiUKBI6aXahAtruHucGTYiR1/OP58IAOn3u9rdUqhwxOILLEP2om+3vLaFbLJ+XhERISTamfomYTNR8HT2ZCzxDAieaS5X1M9GQjnh7BRWd3HdGQD7XJT6Fmg/jEvY8FikJcdj+blPC69QPKrabDVLdCMQeWdEtiyjqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097539; c=relaxed/simple;
	bh=/r1vlQtbOdg7AXi0r9wo6pNkMpUiqVJgUeAVo2A4+io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+ml2AAFwX6co8jINcXt9PzVbsFc80fNqRj0xBisvk+MvZjXrMdHSEf+hzARMJyiGDG9yYkVreXdnq2TNymcm1ivVxdPlF4lRzfptZfKxExonLC+NLzb4XF1gu0Z4T8etEkEYnjlyfGGrZMsuhWPJ0Pjo3crt6ptNeB3D9MBBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPxV8/XE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso62817541fa.1;
        Wed, 24 Jan 2024 03:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706097536; x=1706702336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEeYpKeIm+G6+P68Uq7Ll/DOKQPaRL4r9qx1fluK1P0=;
        b=jPxV8/XE6IRZ4qfXrigz5fW80fAx1TFMhZ1Of078PECKip76pmlL1ZtpM2ZoKfcrPa
         52mzo6TBFhD+433QPpGQCXuc+hehxtedkAhQM33YwVPoETgHN9NzZ96N4YgmhpQCbXE6
         81nOsPUZP/jH+zIlUu2+SqlCz2ts2vBif6vvRGqA0K7/H+zf0pkoDgMJYmqliNqZSwzx
         8DgyN8iyVrT6lerREOWfqIqJuvHAcwlScF2v0/XhGAtuJnqX6Zt4VjqA0MpN4PVwj22y
         p3KrtuhfesXt2oJ5pBDfR/hnS1DO2BhuF1ltJgTsm71o3t4tUgGvN3etvgg2WHCNuq2L
         MSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097536; x=1706702336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEeYpKeIm+G6+P68Uq7Ll/DOKQPaRL4r9qx1fluK1P0=;
        b=eduXYOhvHDXfXHq4pxLJrGigS8Q+Kw9WJ55W1EtpN5zrnMZl/u9NX1FxeEVvg3gM8g
         FLbFZuYrjY96mcKf9sViF9xa8gqXtI1ccEz3ydwk2MVWIkCoZC96gPl7YC2FRpu3hV4n
         KxdlMZ6coaDvkGrBSAU8hvNanNpa5Fxy1hnKQga5TwOeIQ9YhHASu7gMgTWXD9ENaB1W
         x8kfjoyiGQENIePwRrXZds5icvScBTwWKgCG+TEJ0atlUMFBhJoLf7S29jQMHcoXdw3p
         UEiJTpZOHUAwMDnhN6mMzaXS2Q7WpA7ZtS3ZyqetvCG+/LwUhWGSvhShS4EPNvw9VhMh
         OKmQ==
X-Gm-Message-State: AOJu0YxnDzWo+nH8dIv8Zc9QWGwM54Ta19zlElroA8zOQof5IBwofv65
	IjVQJoikVIAVWM2VtLZexTwrbahSFzXkxBaC33cVv19RuA6r0XFbKLSSByPza5j0f5sx7hAE3tg
	vCAzK8+syymg9R2mNzYLtGsjHqjA=
X-Google-Smtp-Source: AGHT+IFrKvwsd39rVBOHhtC7JUmJDHJW+i2a2oYxllubJ6caZz2xUhj0E6kTdGY0xu5Jai+KgqwW2AM4maTzREH1j4Y=
X-Received: by 2002:a2e:904d:0:b0:2cd:1aa5:db82 with SMTP id
 n13-20020a2e904d000000b002cd1aa5db82mr585335ljg.21.1706097535852; Wed, 24 Jan
 2024 03:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
 <ZbDWSUkT/OjHTe0t@infradead.org> <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
 <ZbDaq+iI/8ZQWRxF@infradead.org>
In-Reply-To: <ZbDaq+iI/8ZQWRxF@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 24 Jan 2024 19:58:44 +0800
Message-ID: <CAGWkznGibmzH8WT9CjC9swWD3pLyCcWnG29eoj=EQk=Qd=kHBg@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> The I/O priority can be explicitly set by the submitter, task and
> blkcg arre jut fallbacks.
Yes. I would like to suggest if it is possible to have this commit
work as a hint for promoting the priority since it has been proved in
the verification?
>
> And as said multiple times now bio_add_page must just treat the page
> as a physical address container.  It must never look at MM-internal
> flags.
The alternative way is to iterate the request;s pages in the scheduler
which has been refused by Jens in the previous version. Anyway, we can
find a solution on this.
>

