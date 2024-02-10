Return-Path: <linux-kernel+bounces-60502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F858505C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E791C2342E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590015D47C;
	Sat, 10 Feb 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHjcjgRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B041A82;
	Sat, 10 Feb 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587262; cv=none; b=KfnFaFZnCIL7AYZniKVKaYb8wx7kVQhXSuOz7XZNNJ/yvYVgCbyGo9YSNi6WezjNFnixJsbXzrafsW8XjuL9b6NagBg3LP66usQ3ZtmNnMJZUhd29oEZpioHa7DCSrmqIEZYstks2eulLqS1n/Mca+QWOxImIvNbb/G21XUyL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587262; c=relaxed/simple;
	bh=NhWbsww1cnt25l2QD4Fw46or4HLprZvRZL9zG3Ayv1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u22WFWHpMU4anQE/k9MgAM7JzNs8vQbI+ob3EFwy2OQj8a7JJ0M6rrYDaBV+y+5FmUXAjqYoLVe6aOHce3/u2N1nY2EQmwFrwOfpdYxxjFVUxA0lj9Mv+f2jsgobUpOi5DqZtflCYALHYGi3XnzlH5SP5E7kcSLKWupt6dZ8RDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHjcjgRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DFC433C7;
	Sat, 10 Feb 2024 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707587262;
	bh=NhWbsww1cnt25l2QD4Fw46or4HLprZvRZL9zG3Ayv1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHjcjgRYohFKHs2fONtzdonLejGMObC99TKvNsdee5ZTfDhVotMsctS5MIK+uKJZI
	 jDTpt82aO3YW3mnxiDtyx4kYzQcDwy1fGY8+jRRLSuezAEpgSTyiBxw0kHDryKMKuI
	 Phw1N++pguin7ZcdmiY+TmwzFtjrHxr7ZReLWd6V9GvCX+C+iMweiTaBQLBvF0FPVR
	 nZ+gtotrGxQF18QDoJa8GFo7douE2Lu+EhYgvFR7yUjCKOYl5UWjl02HTZ9kt2Km4b
	 noblxvIm9q6MPtWYKm3nravCCrWADwtVGr+1YsILXVeMzvFS6hCqOe3PjYXW2q/5Ry
	 5YoR95aIdw2PQ==
Date: Sat, 10 Feb 2024 17:47:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for
 AD7944/AD7985/AD7986
Message-ID: <20240210174729.7c6cb953@jic23-huawei>
In-Reply-To: <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
	<20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 11:26:00 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> at rates up to 2.5 MSPS.
> 
> The initial driver adds support for sampling at lower rates using the
> usual IIO triggered buffer and can handle all 3 possible reference
> voltage configurations.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>


The one thing in here that will probably bite if this gets much use of
different boards is the use of non multiple of 8 word sizes.

Often we can get away with padding those with trailing clocks.
Any idea if that is safe here?

Jonathan


