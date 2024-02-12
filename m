Return-Path: <linux-kernel+bounces-61217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87F850F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BD1F22732
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F9F9E5;
	Mon, 12 Feb 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4QO9jfl5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB8F9CC;
	Mon, 12 Feb 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727607; cv=none; b=a9NPrtE+9CtjmW7pZA1TFEoVwhUYC8c+SL89aJvC/sHbFeiOiL8FZbgRbqCoMGqU4+WkAa2C/r6sED/rQZKuSOvWLN/RHPthSZKmUc/psX33mJu3ojeNBAA+ajGQfFPEezC2GFF6hBDkRQGej0QsJbfYRcGF5RmhJ/2btNE/4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727607; c=relaxed/simple;
	bh=MrwKiPYRPkaUYKLWtoU0XksSmS1raWmw/40HvRZXI+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keIFaQT4b/Cv9ApjVjxNVOauGN/HfOGZQF3u7r5fFgJYN5Wclt2lP4FcJD8wxAYpC79RnYcFCag+HjQpoViUHBAoesIfLgwhjS3JVtCmM9YThha5QL/TajGM+3yuamjMr07WQEIQJojoxSHitHxbvJZYCQ+5sRxbVftsgpoNCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4QO9jfl5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707727604;
	bh=MrwKiPYRPkaUYKLWtoU0XksSmS1raWmw/40HvRZXI+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4QO9jfl5nZOSzTHkdnuCtf1s6Pj06nhsiAXE7a2JwM6wG6yLJvyI4oiQb8s5tzzEt
	 uYf54+YYSy52QWb1hrPnh5qw5xnmE8+e5eWchvMXhmjmFnwV+x/E+IhyomZYAUy8Vy
	 r2tlkwNhYhbCeX0WwgTvuyUprxjymuHjEYMSKyI1mxUPvjfxGxeAl+0paFHqi4W4fQ
	 7tx7FkBwzuG+BeJN10J6q5ngB+Y4YKzCckp9BokyqDYhJJvq+FXakWYx10NNAgzHj8
	 P93H/C06gnZz8bzZcZtiok2AXW1gxaDJWZ05tkBOu+4wRw5duVpM8UgdYQMKC5kWw5
	 2qwmFvE/2Uuaw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 78C703782051;
	Mon, 12 Feb 2024 08:46:43 +0000 (UTC)
Message-ID: <d7bbca9f-466a-4595-b02d-703dd22c3386@collabora.com>
Date: Mon, 12 Feb 2024 09:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiko Stuebner <heiko@sntech.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rob Herring <robh@kernel.org>,
 Li Zetao <lizetao1@huawei.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <20240211091633.4545-1-erick.archer@gmx.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240211091633.4545-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/24 10:16, Erick Archer ha scritto:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
> this structure ends in a flexible array:
> 
> struct mtk_nfc_nand_chip {
> 	[...]
> 	u8 sels[] __counted_by(nsels);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> devm_kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Just noticed that there was a v2 already addressing the commit description issue.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



