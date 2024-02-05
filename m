Return-Path: <linux-kernel+bounces-53254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DE84A2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500C71F2645A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9FC482CC;
	Mon,  5 Feb 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="Cs2mz9tN"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EC481D3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159118; cv=none; b=IDrhQ3ZPx673aZOyPm6tFU1il/g28xEL6tMHUPt7rMeEEqZ9617cb9NCdeH5Pj1KR8gpAERFh8/MsoOdtEyQviuH9k5VwZ16d09QiSEiqdKRfjQ/PfPNrtZZkyguqX84EskPoNHYfovCC9g6EwGYVbvvUw2tXFhLGdX5jgWAkLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159118; c=relaxed/simple;
	bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUJxOe30+iVCFZoYXCmzpsR4MTmo6PRZAWDTXyoxJj1bx/FAcqiK6ZpHW8EKpnHInEN/BwjT2BTt3iYLXUXZrChuzydbZFQh15PMQDNvXrImMd9pplZRsBTzbG5q3Q38tDkDq1UCMg9t4EbWnBXU4Nawc8sbMY2kMPh5GDevvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=Cs2mz9tN reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8900bb93so34956921cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707159116; x=1707763916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
        b=Cs2mz9tNJFCFicdg7ZJYiCt/xazYOO6ofPFmXam6eVLgMsI4Hg1LsU8YfQPG7IKqfp
         sSGmNUN4DBQUWGLTeh+0234f6G5fOV17Xc3obbc8YNEua7uaV2WVCWGMZf3AYPHvkXX5
         xG46/PkGgQr+DTldfflzzX/yxxan2ulG56euxequ4QQOM7T2/orhZZ7lKCgOgImDQfcG
         DHM/jN4ZbewrTAJ8Aaoamnq4MrQjDC5PE7llLqNdKMOgZqFUYg+z4vmw6NoUXfIHtjaL
         GnKSO0qWM+m2pcGLt5sujzdSWdCSJs1SjK7D3CxqWibdzCkt3GzMAIEkY6pHdSFUzCHR
         nDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159116; x=1707763916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VTygx6qb8sYZukMVdB0Zlh8j66lTNxSLNHqv5bFTEc=;
        b=q+H3Jm4NSx8zSbid4+RdcYK3087FTjBK+btvEee6atrwhdv6Rt726tqR+BllBFjVYF
         ftWo4vAHuVH+LUSqOl2unDVNHxgIJbBNGW87gM6qwHH93WdA2SChF6uDwdbp8j0SDPPD
         Kf7nDgeJXjydVaI9Ia1schZC6Vt+K5H7JHKLHOOhU3c4yFDDkV+V0gYUmj666L/+dCeE
         YBQphRcyWM7ERkBZmPM7/Nkj4MQAp2rBaFFaBaD9vvzG1COg8M0nCAkNzHWL9hlmbrmY
         ZBfjB7JIVnhd2gPxkgZNkSi3vy4O2OCJ3S2WtL72VClWWe55o93XOYcwqvtJ21ufcf+T
         6tCg==
X-Gm-Message-State: AOJu0YzAlU1idinXA9BYzrZXz36jRZ8LJO/Ru2/LOvU2cLWN0rNIefTG
	h9Pn60aiMT131DpmR+3DpkSE+gz8sm0kKN3BT2YY4vtiOOJnklqSsTbIvPAoFrKIsNIAma/X0pp
	b7mRmK9PeM6cpI7pVylPtvshDVQ5nJH/ki3EAkg==
X-Google-Smtp-Source: AGHT+IHCtUOUFGkzr8TaBXdeKKOZ0Xp0nyD8dcW0qlThLgsuY3VQrT8RHm+w5NKlMubnehHSEWMT8PuNkDi2wou0sNY=
X-Received: by 2002:ac8:5f12:0:b0:42a:b410:fa47 with SMTP id
 x18-20020ac85f12000000b0042ab410fa47mr18907qta.17.1707159115882; Mon, 05 Feb
 2024 10:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707144953.git.robin.murphy@arm.com> <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
In-Reply-To: <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 5 Feb 2024 13:51:19 -0500
Message-ID: <CA+CK2bBW08=reuD7UfkJfzumVx3ZFYJuD4ptriW4paBiNKV8Hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, 
	yosryahmed@google.com, john.g.garry@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> Failure handling in iova_cache_get() is a little messy, and we'd like
> to add some more to it, so let's tidy up a bit first. By leaving the
> hotplug handler until last we can take advantage of kmem_cache_destroy()
> being NULL-safe to have a single cleanup label. We can also improve the
> error reporting, noting that kmem_cache_create() already screams if it
> fails, so that one is redundant.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha

