Return-Path: <linux-kernel+bounces-161437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC08B4BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B255DB21147
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3476D1BA;
	Sun, 28 Apr 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOdaHkiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6343A1DA;
	Sun, 28 Apr 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310852; cv=none; b=dHyUajlAoJGW5KCUPD+BN2DDGR4Lwfl/SiOZaBDQp9EB83hiifnRYX8wNlmQ9n4gfrPgak6nkpa0adEB31TRW/tHhLEwEU1lBBO6Yj0a09LaISAjC6Q3b43nGWQMra8qGbhHdGSiaSvpIOjUtOsZfZk76EqUSmlXgq5dfwdmRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310852; c=relaxed/simple;
	bh=UeRn/pJ41orv6XOdXZFOuoyklETajUXkK7V1tSlZmtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pc61QZzC5IQ/NwqZ3dxPEIjjFUwmDtUIsv4CDPtkjID8FzQVmnLnizDH5IiURgzDuJMtum5OyNig8PkhGH7/c9tGELykwskLl6v7rI4Ghl9ca/o3VZGnW+94Qoq4i+qR06XLxshDk978TggxnIo/BKo+BRu1Nje0xaMA0yAfI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOdaHkiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51406C113CC;
	Sun, 28 Apr 2024 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714310852;
	bh=UeRn/pJ41orv6XOdXZFOuoyklETajUXkK7V1tSlZmtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DOdaHkiq5iRVyOlk8mzyS4b31++a8Qy3V/BEBddxXEsZU4VwDJJYUgdIhGLqVA8Md
	 rURcRHUfDtkgoNE+Sj/kjFsxJf0uKspDKYH2zhGzDiMcfkkz3F9oip8lhIvM1M737p
	 xIj54kxkTmwu9y3V86LWA2tt8qE/nuKs7qL7ROrY/BSLuKaDkmWU0LvSyJjdVXt+wC
	 RwAR/qGoUeFEkHr1igNYkn5uV7XqDs0W49PQ90/0HMZBgzPR8AYQsnf3gyjGb4YVsw
	 hxcbod8LDoz0ESX9eyT+ommuZk0SRwXDPb/yanpglS6nzWrwHSN/3Gyw1hLK/G6uVV
	 ZAXCcC7Vx7oQw==
Date: Sun, 28 Apr 2024 14:27:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] iio: cleanup masklength usage
Message-ID: <20240428142719.08363889@jic23-huawei>
In-Reply-To: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 10:03:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> While working on other patches I noticed that a few drivers are setting
> the masklength field of struct iio_dev even though it is marked as
> [INTERN]. It looks like maybe this was not always the case, but we can
> safely clean it up now without breaking anything.
> 
> ---
> David Lechner (3):
>       iio: adc: ad7266: don't set masklength
>       iio: adc: mxs-lradc-adc: don't set masklength
>       iio: buffer: initialize masklength accumulator to 0
> 
>  drivers/iio/adc/ad7266.c          | 1 -
>  drivers/iio/adc/mxs-lradc-adc.c   | 1 -
>  drivers/iio/industrialio-buffer.c | 2 +-
>  3 files changed, 1 insertion(+), 3 deletions(-)
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it.

I can't remember that ever being set by drivers so this is rather weird.
Mind you our docs used to be less clear on what drivers should set so
maybe that was the issue.

Jonathan

> ---
> base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901
> 


