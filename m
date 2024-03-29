Return-Path: <linux-kernel+bounces-124180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6589137D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9EB22648
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BD3D97A;
	Fri, 29 Mar 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYbT11+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C41381AC;
	Fri, 29 Mar 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692830; cv=none; b=jTXFtlegCCeR9Davn/ACAK/W69Lm8TZGjliQ2X+dpFF/0Tj1GMR96agnURaMH8OPwW059mTFcH67aQjk614UUqrWerWuvJqqIqK9xu7mZSWU5xQcfV8F+2UvhGkJrVkhbmrw2dkHySwCOAd4hxjcbqBz79bqg0bufuzbv/eajDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692830; c=relaxed/simple;
	bh=Eyqmgs0L855SMwNwIOawyklVAqR/hQwgGL5v1KsRj+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt8DRVyOyzYWJ+cRwjATqsyyzeucrXy2qjsw6Dpm6tFcfurPHVWo2Ue2CCArBgbZ44jFJZVV+F8luZuVMobUtK/69IJmdCYC+uYNOYc66dQ5tuezNePq8HXAQ9knmXEI3RK2kGyTMO1Gc9PEJC9gOHINVyCtR1R0XvP7gVtYdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYbT11+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B78C433F1;
	Fri, 29 Mar 2024 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711692829;
	bh=Eyqmgs0L855SMwNwIOawyklVAqR/hQwgGL5v1KsRj+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sYbT11+6KsBU3CfSavzG1Hme5dCL3k4hGFP+5vgKz14ngS733fQwYx5ItBenUhNzE
	 GBPy//J2BwvdvfhB6MLO2Lxc9juLkGl+b+yeEbc8wSUe+9QRSiVXv4+I60kDhUcBkL
	 KlYjoL2tVQsE07bPhrGGAaC1NdwIOR84+TLGfIPS8CoaWqnrh3H8J8V/oygZKYWgMw
	 9SNDD1itBf55FqitdmQRokex6tJhcgy3NSZ2rn4zXz0KJBqqnkIhi3VvUfvyd45D5N
	 JoW71YCfv2lJaYWHNq9UKbBLUP1ftfTTElCaxm85Bn4AesY/x93J1wQKumgdf84uuC
	 Sd6aQIJ5IVoGA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5101cd91017so2060843e87.2;
        Thu, 28 Mar 2024 23:13:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7t2VbW/HD0bOxdKE1jOxM2TiXvUSs1AuZiOV8Me5P6yCRg99ZsJlMEbMehng5pbKHte3Vg+bgILVOfYnn1grOAowOT8pWbos4Mwif
X-Gm-Message-State: AOJu0YxBPy2agfdfea0HbFYKvTx7lG2i9U0ao4msD36tRqLxnquUK9MB
	ioRN4zaZC/ZOigggwsegFcgYMt7UNpbFFal/jf2e1kMa4VMnaO+7ptC9obJ2D99wL20BauhkQ+U
	/6bM5eqAyTTVh86vPXMMaztxb+AQ=
X-Google-Smtp-Source: AGHT+IG8vnQPuO8jVKTSVA+Kop8DosO4HvW3nHJgrGyMrYG/+b6uOy4/3wWjA0Ff2fOKuRFGKB+lnA9tFEwUPOX/0gg=
X-Received: by 2002:a05:6512:2212:b0:515:d323:dcdc with SMTP id
 h18-20020a056512221200b00515d323dcdcmr37026lfu.13.1711692827835; Thu, 28 Mar
 2024 23:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120643.2824712-1-sashal@kernel.org> <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
In-Reply-To: <CAMj1kXH8n4-8VHSVygUyEc4Zne-4gE0uijAkDe-Ufu6hUnFU+g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 08:13:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG5bywFpNpMRTXsnaQ6gr4aOBTO7PZ9Op-JV37JT9StKw@mail.gmail.com>
Message-ID: <CAMj1kXG5bywFpNpMRTXsnaQ6gr4aOBTO7PZ9Op-JV37JT9StKw@mail.gmail.com>
Subject: Re: FAILED: Patch "x86/efistub: Call mixed mode boot services on the
 firmware's stack" failed to apply to 6.8-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 15:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 27 Mar 2024 at 14:06, Sasha Levin <sashal@kernel.org> wrote:
> >
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
>
> This applies fine on top of 6.8.2, 6.7.11 and 6.6.23.
>
> On 6.1.83, it gave me a warning
>
>   Auto-merging arch/x86/boot/compressed/efi_mixed.S
>
> but the change still applied without problems.
>
> Not sure what is going on here .....
>

Ping?

