Return-Path: <linux-kernel+bounces-46542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932C84411F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E840D1F2B387
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333C80C06;
	Wed, 31 Jan 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb3Ivi5f"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6A82864
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709411; cv=none; b=LEZSCKHaeKXiRv3QIul2/2ItnZyPHWxUBotFfJhPktr2pr9jusZ8SOfQqbVIq0IyGQ0ro9xXwgyWnFVTo47qsq2EvPJm22ATVo/DL/PbY8vCB3YwGc2cfJJ49Zm/KavkTuo2Tbyi9hK7Rml1Gwo9eWLMPaW7BnS4YY1DS5PDd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709411; c=relaxed/simple;
	bh=rGSvB5/8qxA64jtWN9ZfyRNxz1iktfkomOYpwJsrEU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li/v+FTVZgjjM/r198lwGhL45UJHmyU6Jl2vsm74R86lTFlrrLvIJMXB0+EXm1K2g9yj6LdX3PGx2T97xnRL0clqrYsqGTXZRVmdXeIkXnQBroe8H6Om1IRsgGuC+GN/1Zi9laL1DVT6aZr4hR8vyvoBCcpuPc8AQHZlNmG1Nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb3Ivi5f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d057b6ddfdso24613751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706709408; x=1707314208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGSvB5/8qxA64jtWN9ZfyRNxz1iktfkomOYpwJsrEU8=;
        b=Nb3Ivi5fzBXJa7q9Kl7AOMGtiRU6JhK+evIEifxG2Pdz43ii8k5w8kBob2JHs1EnRZ
         A86V8O3OX1E8ILZ+1A9Xrnvi8hxjSmSwakhfLyWZKZOovAjoaW+S/ibKsUn/Mzoxm9Qo
         hTehEJqs2Mp3fNY+Kx46u+AZObw62Sm/vRiErbi6It13XZfQEq9yg8ZhuXdNIfdHCqIA
         5xYBlUub4uxFQboZuecWBtoXNY5gp8OnvNW3orKfpbYMumCPEPsTyKCckKrjxjspvanL
         15rMfoDwYkghO7sBWJSZYTJXfK8qlqKwkAS5d/sU4lux64vDThwa+59oRwVM7MW2jSX7
         UW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709408; x=1707314208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGSvB5/8qxA64jtWN9ZfyRNxz1iktfkomOYpwJsrEU8=;
        b=S3sxJ2ngkc/dJUbluqhLhdAU3gnhs322FURDmdGFUjiaTXJM/sqQxjstKI3jX606Xa
         ProlT/cFgPIUjYecGq+gcAQeAG+h6xfr2fXPRs9Y5zZHz6n5sM7X6vF8r0h5Vbd4g7E9
         So/eO6kss6Aa6mspSbTCTzY2+anXADgxW9OKzxM0WxVe5Qdse+ySBxnCs9GQkdpcoHAw
         oeJ6hXSoCgXEG+oiP6suFr4GmTgSIyKuhZJMxk8UqMN3Anlbc3ccDyOGa6YTJgbzLTNa
         9V0ak+srIUA36WZg7qYbQ9A/q+x9VXIzwH/UhehmJOKSg5aHP5XWpJphUGNhVpxM5gB6
         6kDw==
X-Gm-Message-State: AOJu0YwJ02f+pgtyMSs8KQsbmXSH3awz/uZMQctvE6k/h6j/TI5TumX/
	DHJQJ+RVgnNfjFRCGPi4LP0NOSCNpthEvyws9eCy9H6RzsOHr8DLvLXujzKBoT/ACXBU5L0JS6x
	H5dHX3aoHWuleINC8rmRx8z3P8dg=
X-Google-Smtp-Source: AGHT+IHlkF3I7FEjP8gwzU2CmWK1s44YfAt24aenmwRx9jOqw+OUQ0fdI/ODDaa5RcZa8ZtqtM/krkro9JbWDWuAwqk=
X-Received: by 2002:a2e:8906:0:b0:2d0:6396:ba91 with SMTP id
 d6-20020a2e8906000000b002d06396ba91mr1189479lji.44.1706709407473; Wed, 31 Jan
 2024 05:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Wed, 31 Jan 2024 14:56:35 +0100
Message-ID: <CAK4VdL3Bg70ycz5vd4RfwNYa3KcYU8rdPX==i7znzQFw_EgTjA@mail.gmail.com>
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, ionela.voinescu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 8:06=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.

I bisected an issue of cpufreq no longer working on v6.8-rc on a TI
SK-AM62 board and it pointed me to b3edde44e5d4 ("cpufreq/schedutil:
Use a fixed reference frequency").
This commit does fix the issue but doesn't appear to be merged
anywhere yet. It would be good to have this fixed before 6.8 release.

Tested-by: Erico Nunes <nunes.erico@gmail.com>

