Return-Path: <linux-kernel+bounces-103313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB987BDED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2071D1C214A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176B5D8F8;
	Thu, 14 Mar 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VHVHiVvT"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D15A4E0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423764; cv=none; b=X4ie5O1mDqtSnT6NrNOKOOT5UpHThcGT6zPw4drsWraqH2LxDuQBs1bqTV9rG3tsWBOWECmZRwMxAe11qNbQpiVjzXiMQZUyQUryw3ULB8q8QTSdhCWKkcmZ3sajN733rDVvADkL05GFTD57BOAlnKZr4RdkYVvBsaHibfj/Vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423764; c=relaxed/simple;
	bh=NCm6m9p9o5Na54eQfsAR5vVaVANvzo7zu0eVP9gWP8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeKDIp7J+KOtShqEmg/h1czZIfFdgQHQges1NJuYiK7BYQ0VLlcEZdujJfBFyfD2mrqECtYvrxyMNpioBmmEO7zyh3mgsam8bjM6zTyi8h8uGdGGcBKNhx3Wy0USppAJ3ralRpEK3Vy5QOWMg5MGS/QBraE6uZKDEVALB/IQmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VHVHiVvT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609fb19ae76so10794577b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710423762; x=1711028562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFAZU9ltO4/NJyne7uET/FKWCg3e97DY7gCJUzC0+4o=;
        b=VHVHiVvTvbGGhaxtkoT94uoJggv4N18USpAD3NuTVpDVA8NhVVgi8IaxavswqtO2Fz
         llh4S5yCeYFsapxKUWMRuJhfyXDdjHEzUrp5hiv2Nh4bptdH1qIu5xdjRlV8imfDm0dq
         aF70jfV3qvSv8dLmhvmiwdznwognlRi2lcNUPGIIMHoFrNq0K9iGCQ0nEUsuXG+UA+A7
         OMC6NyWsfH5iOIx10RkxBMwsvmfTjVJTCkPUkVJ5QHQ/At4yKvPSsHvrYy6qrMwTqqYD
         eIR850tzNpTiHfNoVjZ0QviX8N2NlgaS3P+9xBRkPbIfGfnfPLuaHKjL8DHDvadNAw8S
         TXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423762; x=1711028562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFAZU9ltO4/NJyne7uET/FKWCg3e97DY7gCJUzC0+4o=;
        b=PQ+Nh2GHfDjfreRxX+AJ8tju/tvZVK2/oWTgPPv8W/3/eNvAYPVvDblZzywpMyTjw5
         HnnznKxMmIUE+PubmRs1YZrdwwfouAPA/WlYiyW1skVL8HH9xpL2Nog19AuheNbpJoK+
         bmUPvrrOllwDaSPs/S1XEzYyYOnaC9DG2xINFYYp+vYy31UIWHdOInastt0uXupg7ips
         Ht5cZVbt7bkYERjOQ6aUSyPdmaOQ4FzuZtSYkDycueLKBlb7F/x1X0vA7XvOUjFSiarJ
         e1+oxLtUvDj3kt1r4uB0u1gK1uC4oNn0fp1XaTyupQjIzlsUt11+c3uf1GuIyia3chuZ
         fuow==
X-Forwarded-Encrypted: i=1; AJvYcCU2lwmEuj/Epfsr49DNEuMSKtcHXUc33uOcr7tIc9j8irJ3dDb0FppawZKU4TIJKb03/wJ8LJlTWm77vZERf/dWOwxfE++K55Rdox50
X-Gm-Message-State: AOJu0Yz45i+XA6cqHVyGJA/LnGXYru4Y4NOBiOE8BT3tAiVR22I/qJpm
	5J8aPUgMIFim4gHLrCfHITdI1P/e5C1/W6+n2oLA7fC+neKfIqve9JeUSSC6K8WVEvwos07VZan
	uBoi1E01ulwtb2irdCxbKnIKt53Ae1vunUuDdTw==
X-Google-Smtp-Source: AGHT+IFzzcSAl90VnCLvZimd3g0bzNXZxRAp/ul8mB1XTM9UGCCCa9yxtndGCwzS1Os/g+Yi59BMDjnUWnLh700inqA=
X-Received: by 2002:a0d:fe01:0:b0:60a:2b18:6637 with SMTP id
 o1-20020a0dfe01000000b0060a2b186637mr724546ywf.34.1710423761902; Thu, 14 Mar
 2024 06:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313033417.447216-1-pasha.tatashin@soleen.com> <7af73776-06f9-42e6-9bfc-fabe8f8b002e@csgroup.eu>
In-Reply-To: <7af73776-06f9-42e6-9bfc-fabe8f8b002e@csgroup.eu>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 09:42:05 -0400
Message-ID: <CA+CK2bBdJ6RcSdqfE+EkmxgnVnzpRvE+Vz3PUbvYHEHbAQs2NQ@mail.gmail.com>
Subject: Re: [PATCH] vmstat: Keep count of the maximum page reached by the
 kernel stack
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, "peterz@infradead.org" <peterz@infradead.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"cerasuolodomenico@gmail.com" <cerasuolodomenico@gmail.com>, "surenb@google.com" <surenb@google.com>, 
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "willy@infradead.org" <willy@infradead.org>, 
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:19=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 13/03/2024 =C3=A0 04:34, Pasha Tatashin a =C3=A9crit :
> > CONFIG_DEBUG_STACK_USAGE provides a mechanism to know the minimum amoun=
t
> > of memory that was left in stack. Every time the new anti-record is
> > reached a message is printed to the console.
> >
> > However, this is not useful to know how much each page within stack was
> > actually used. Provide a mechanism to count the number of time each
> > stack page was reached throughout the live of the stack:
>
> by "this is not useful to know ", you mean "this does not allow us to
> know" ?

Yes, bad wording from my side, I will change it to you suggestion in
the next version.

>
> >
> >       $
> >       kstack_page_1 19974
> >       kstack_page_2 94
> >       kstack_page_3 0
> >       kstack_page_4 0
>
> That's probably only usefull when THREAD_SIZE is larger than PAGE_SIZE.

That is right, if THREAD_SIZE <=3D PAGE_SIZE, only "kstack_page_1" would
be filled.

>
> On powerpc 8xx, THREAD_SIZE is 8k by default and PAGE_SIZE can be either
> 4k or 16k.

With THREAD_SIZE =3D=3D 8K, and  PAGE_SIZE =3D 4K
There will be  two counters in /proc/vmstat, something like this:

kstack_page_1 XXX
kstack_page_2 YYY

With THREAD_SIZE=3D16K, and PAGE_SIZE =3D 16K
There will be two counters, but one will always be zero:

kstack_page_1 XXX
kstack_page_2 0

Thanks,
Pasha

