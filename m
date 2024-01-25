Return-Path: <linux-kernel+bounces-38105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3483BB00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C840828A53B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24711759C;
	Thu, 25 Jan 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/mBNtk8"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5E17588;
	Thu, 25 Jan 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169151; cv=none; b=giYei2EYXNN8irI5rz80q9d6w4+DYbY6CGfAAIQC7hKURvHLhLiGb3ervmSVtokPNQSvUgXOq3BeKy3PtFoDUfL0avh12pMIShDFztY0emYdpaJyTVNdPXTAcInOK5m65tOfbKyXMPXQN9RM9Z+lPCTQheD6l87XkDPaxFR1zqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169151; c=relaxed/simple;
	bh=5uK2qKsb1JHnaulezlSEoy6gr4tqLbF94nnEz1jH0Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeSwixdZ7vc1bDCSyqJr7u/Pau7Lz7ooZKWOpbHaKN8jWVzXuMkvmpPfPv84LI5ohi6GfBhBmafbv6f/HCK0Qq1ayQhlF+NBim+4vKZPn6YdFUqo1bCkzJbMEUkGMLi+vinTpH28GMLp91PjUkE9xY1iBbYUtHeP06WsefBgDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/mBNtk8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so8002478e87.0;
        Wed, 24 Jan 2024 23:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706169147; x=1706773947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uK2qKsb1JHnaulezlSEoy6gr4tqLbF94nnEz1jH0Oo=;
        b=j/mBNtk8r7Nq57AfaqqQT6tHPoIWImYllejG8VYTEYgmjTr6oBPK8Z/e+Xx4sRZiZp
         VlmRtTKwTQOs1hBpnZ1bYapZYch8NiVF12gDMOogaJ6gPOez9I7q8GdyNRbt7ejjR7kg
         /YRjvy+hd2nWBBjLRFznHVWpVTBgDv1h5uqXCogdsmyeUU2OekqD8ST16MHBF3FUFmsq
         EW1dAQwwEafrExIYYrBYcTacyKZZojlsOiy5/YXza1Uc5weqM7+gJ+haA+wnvfU1WoY3
         0PAJq8K4dnFAn/T21RJtO6CGquwppSFQBysH69lfbYumsEukFFgBqp4sObBheWz+mB2X
         QBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169147; x=1706773947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uK2qKsb1JHnaulezlSEoy6gr4tqLbF94nnEz1jH0Oo=;
        b=XOUFziYLE98sgYGY5/ZBVseJ+0DkHMT1VuV0vA8wZ7MlISLrjkGhZm5K1RF8BRNAnT
         R8K1bBTrFpO9uGI9pLW5r793H7++sr8gfnwtQWuzSadUCVtVvp9DH20kPVsdvsUqQfwK
         thbfKH6y0WWRQqrUk1jsqFl/aZmVJ252grQzu+D0H6QGibRI5tfb9j8JTHVfaissZCKr
         /cApR5BdefaPsdsiBAjhKUabAa8oqsfG4xXVpxyJCYedAdh04D+E2klA5XcoerOa+R4j
         xwBKG+fN8naZ0Q5IP76LK0N+oF4FKi7RbpuPogQmPT4b66FFAnOHyTdAjQ3cuOAPhAZo
         n7kg==
X-Gm-Message-State: AOJu0Yyrz2ynpwa8ayKQ5oG5WD1fb8wbaqDOSQCV9icLo1tZGLWQjQVo
	qpzwyxXbmsV16s76MXcRaRGbD5mkH//wG+1SG9FZMUau82VBpPOo/F5EzyVJa/aVcOYv6SC1XiL
	CS8cBGzPxMBFsCmlCZJijCBN/XBs=
X-Google-Smtp-Source: AGHT+IHc5UO3q54Qrbj7KL7mYwjWK6D70f7fzJAn72OzNVdUkSQgBVntcy5ppmoUPTdhI3q7nrnPVGxIMuyQorJy7S0=
X-Received: by 2002:a05:6512:3ba1:b0:510:d29:cf57 with SMTP id
 g33-20020a0565123ba100b005100d29cf57mr311022lfv.33.1706169147484; Wed, 24 Jan
 2024 23:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com> <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org>
In-Reply-To: <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Jan 2024 15:52:16 +0800
Message-ID: <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:40=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 1/25/24 16:19, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Currently, request's ioprio are set via task's schedule priority(when n=
o
> > blkcg configured), which has high priority tasks possess the privilege =
on
> > both of CPU and IO scheduling.
> > This commit works as a hint of original policy by promoting the request=
 ioprio
> > based on the page/folio's activity. The original idea comes from LRU_GE=
N
> > which provides more precised folio activity than before. This commit tr=
y
> > to adjust the request's ioprio when certain part of its folios are hot,
> > which indicate that this request carry important contents and need be
> > scheduled ealier.
> >
> > This commit is verified on a v6.6 6GB RAM android14 system via 4 test c=
ases
> > by changing the bio_add_page/folio API in ext4 and f2fs.
>
> And as mentioned already by Chrisoph and Jens, why don't you just simply =
set
> bio->bi_ioprio to the value you want before calling submit_bio() in these=
 file
> systems ? Why all the hacking of the priority code for that ? That is not
> justified at all.
>
> Furthermore, the activity things reduces the ioprio hint bits to the bare
> minimum 3 bits necessary for command duration limits. Not great. But if y=
ou
> simply set the prio class based on your activity algorithm, you do not ne=
ed to
> change all that.
That is because bio->io_prio changes during bio grows with adding
different activity pages in. I have to wrap these into an API which
has both of fs and block be transparent to the process.
>
> Note: Your patch is full of whitespace changes.
Sorry, I double checked the source code and the patch with
checkpatch.pl again, no whitespace found, don't know why
>
> --
> Damien Le Moal
> Western Digital Research
>

