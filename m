Return-Path: <linux-kernel+bounces-24650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54582BFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D421C23052
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026E6A348;
	Fri, 12 Jan 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yz9XTWyu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE56A01C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705062324;
	bh=hRjI+qBcq3LK53mhCsH1ZnMI8/MllGQaUnnB+z/7wAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yz9XTWyuKTxxpIbiQ9Bl2VKsDxv6MNCz1U6on8jswNBh2+45RHSGy6zL7cirHrW6H
	 KyUgWKlRIxAoLL7Cc3iZBUhH/dhSeJ2d3ZXSnafxAFw1cJA3kh7f7aZUNltM62SxKz
	 SiBscqjLNSwh05WcFg3ahzYKfwlRpUTbEI4dqupP1zDV88S3Vtifrl4D19ba6uIRqC
	 yqT7F2L6jdZ9bTuG/uP3GXbMYVU4wwk0z9GJc/cXNivAXieMNAgYDni8I6/U5G4kZL
	 Dp2gq1FVIlQhyQVj+WgzQ0QJ78wysXIFnGKl1YPOhUhPS1Ki64tFaiBO1+TbQP9Ryj
	 k7POj8rGYTgAQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 437173782017;
	Fri, 12 Jan 2024 12:25:20 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:24:48 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Message-ID: <88a25015-c318-4e17-bf02-382d81310104@notapiano>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-2-nfraprado@collabora.com>
 <ZaCJWfIUHYKHcu4v@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaCJWfIUHYKHcu4v@google.com>

On Thu, Jan 11, 2024 at 04:37:10PM -0800, Brian Norris wrote:
> It would have been nice to get the whole series, or at least direct to
> all the same mailing lists -- specifically, chrome-platform@lists.linux.dev

Yeah, that's an artifact of using patman for patch submission... But I'll make
sure that list gets the whole series for v2.

Thanks,
Nícolas

