Return-Path: <linux-kernel+bounces-38070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B483BA9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE851C22453
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A011CB1;
	Thu, 25 Jan 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScFGMYM1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB611712;
	Thu, 25 Jan 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167762; cv=none; b=MUNpZiKy3nQp9hA1MxCJ8snbjxI0ZbNnmX+MQsSA3tcX9oho9Rz1Ibad1A7dc8GpgT4dRlOlrgfUdMyk/bFXcc85srCRxMmAuztOpoLnChAe79T6/NV4Y8p/E8mkvd3uB6Mpi3Pua4za9h/Q0YUifqnwS1mWh86MG6SgRrUc6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167762; c=relaxed/simple;
	bh=w/xsvgCqgl8ZlV62QDdJt67bBzlXk6B6Nkily4sOnp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/MhniXIrqDjPXyysrVtyuIOhgcK6UAnLQqa4WOLU2hKrc7pzxcRhApxfR/jXZ0mZlwnzzVtdUD9Veo/ylFQqWpGbTVyTAsq7bQjpIqBPmmy7Af9zUvx/M84EeYQQw0jG+EOEVjr0Yq+psxDcBbHPs4gPZB7GZFOwg90AcpJ/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScFGMYM1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so8165814e87.0;
        Wed, 24 Jan 2024 23:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167759; x=1706772559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SpBWJtN6OzM/roaWnbD+Q5Csju0Dqh0SUBOg2+T/As=;
        b=ScFGMYM1J4OEBiRsDl6g9CwCaVjntROfyPO+TCDK2khMOnTrQGxSpKfmTPiXbq6diz
         t4yIxyBtuDe4/8ECUQvG1nxeXnqjJsIx+6UsL5m6CXOuSC9XQvNw+DGc9SRa9xbHFc2e
         CQrM/862odjC+tZD599RRH6lVJmdHXzvxjBpfNa/DkY6HqxT4PMprwbeGFfncNGQjhmz
         DdSo1sSXeKd4uqXirCaQ/SbxX8AiSS8kD8Nyf1p5LaW6K8g4dKpxL6Dkhxr92S0q8NHC
         A85MWYYb5QsLP8abAyhdu1hz0A6iyQmFcixJ6ZoglUkCX/A1rG+KVkvf+JFQEOQgd6kW
         NfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167759; x=1706772559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SpBWJtN6OzM/roaWnbD+Q5Csju0Dqh0SUBOg2+T/As=;
        b=K8/iIM3KjWbKbNHwy/XwnayHSAb9Nkqu6DJCwu6Rsr7rhXVF4OIFgNGhm3E7R52JsY
         Y7oGRpqHQmJ14Ui2n+qarXEL3H6XcA/87SRyWWLsAxMij0QNM4OvJbP2wcPF7kL1Z9UJ
         R0DLKEq31ia30cCfCA8Os8MuCrZfVCa/RjgkaVFSunLJm7RKw/og1q/WgBgDjw9SORfZ
         srMLoeOEhE5bfQPJ7eU7yhlQCDCNPWqALPZrwioHExskGTTQMaoWWLJxpoKJmKEdZ6TI
         RkM6Zl7UBCQ1fgW+z8uuwpjx0bJO4ghzDORfXcSx8uXV7TFYKw2wMe18Q7HhqlFzWn4g
         pUow==
X-Gm-Message-State: AOJu0Yygu3A58pWdxbOcRVJ3rJ0nLYozqD0EZ/LxWWQsJ5x7MB7mKdd7
	1X6tUsX4nnWMVUvoAVev+TP0r/tKd8zxcJ6Hr8vrjkhxPSXJeOlAMm/iClgLqfTo48ObaIIe0hK
	w+ybfpN2yTvdUGVfsanraFetFQyc=
X-Google-Smtp-Source: AGHT+IFsvWv/w3MZ9ahKnAMtITkSnq56kA8ImWJUFJoX6t+Y96Fl2tPUYWyEeo0Pd7WdV0pF5XbH4bXej5/U5dn29wA=
X-Received: by 2002:ac2:4d1a:0:b0:50e:815f:50d1 with SMTP id
 r26-20020ac24d1a000000b0050e815f50d1mr223636lfi.105.1706167758549; Wed, 24
 Jan 2024 23:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
 <ZbDWSUkT/OjHTe0t@infradead.org> <CAGWkznHAi_U5erM0s8vFWwwucRKPoSzimNr9tdsPvs_sApGxgQ@mail.gmail.com>
 <ZbDaq+iI/8ZQWRxF@infradead.org> <CAGWkznGibmzH8WT9CjC9swWD3pLyCcWnG29eoj=EQk=Qd=kHBg@mail.gmail.com>
 <1879ce4b-d8c0-40f4-98ef-88dea0721974@kernel.dk>
In-Reply-To: <1879ce4b-d8c0-40f4-98ef-88dea0721974@kernel.dk>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Jan 2024 15:29:07 +0800
Message-ID: <CAGWkznGGFxazJvhNF-SHFX559sUTkmQfaHpBb-9iMrgdzLaJAw@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] block: introduce content activity based ioprio
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:38=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 1/24/24 4:58 AM, Zhaoyang Huang wrote:
> > On Wed, Jan 24, 2024 at 5:38?PM Christoph Hellwig <hch@infradead.org> w=
rote:
> >>
> >> The I/O priority can be explicitly set by the submitter, task and
> >> blkcg arre jut fallbacks.
> > Yes. I would like to suggest if it is possible to have this commit
> > work as a hint for promoting the priority since it has been proved in
> > the verification?
>
> We don't add patches that are wrong just because they provide a
> performance benefit for some cases. Down that path lies tech debt to be
> cleaned up later. Rather, the feature should be done right from the
> start.
>
> >> And as said multiple times now bio_add_page must just treat the page
> >> as a physical address container.  It must never look at MM-internal
> >> flags.
> > The alternative way is to iterate the request;s pages in the scheduler
> > which has been refused by Jens in the previous version. Anyway, we can
> > find a solution on this.
>
> That approach, or the current one, both have the same layering violation
> that Christoph keeps telling you is wrong - you are looking at the page
> itself in the IO path. What has been suggested is that the _issuer_ of
> the IO, the one that actually deals with pages, is the one that should
> be submitting IO at the right priority to begin with.
>
> Your approach tries to hack around the fact that this isn't done, and
> hence is introducing a layering violation where the block layer now
> needs to look at the page and adjust the priority. If the IO was
> submitted with the right priority to begin with, you would not have this
> issue at all.
I have issued out v3 which provide new APIs to have submitter set
bio's ioprio out of bio_add_page
>
> --
> Jens Axboe
>

