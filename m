Return-Path: <linux-kernel+bounces-19322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D676A826B67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8522B284A33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738213AEC;
	Mon,  8 Jan 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JI2igXEs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D413ADD;
	Mon,  8 Jan 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704708870;
	bh=+6Hlxr0hsvZweqdmUQQAuzfh3fA7eGxoJr8e5qLrLCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JI2igXEsshtxlSPnZLcph1flUi93XgLxZl6t8n9XCWGOHtcarxXXrSzMnrIXsmvIl
	 HSkOIMdhcgvFwd2TmLoWkGQE4jzw7Yod7QKq01FUoxa+EqwOvo8Jy+oOmE4gcbXWTd
	 ukZ4oGNxG80HW+ehP/kTxI/9jEVdKpWVz3/IVK/6fwuhY8y781a9OFzv1JqhJHGhUb
	 9Rc3/EMT0/P4iUKV838AhMBFy9MjWyydR5AMUZ94b1TuQAbhde5iFDVbok6GImtvt7
	 n72YXbcgM8oJJEnkG6+5tYpI8JM0kFPSb3//0s1Gns2BMRKR3JMlK9UNMH21eADWq5
	 LnNgHU6Rs26oA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AB07C3780625;
	Mon,  8 Jan 2024 10:14:29 +0000 (UTC)
Message-ID: <97a1d977-38ad-48f7-bc10-f3973b635585@collabora.com>
Date: Mon, 8 Jan 2024 11:14:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8135: Fix an error handling path in
 clk_mt8135_apmixed_probe()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6cd6af61e5a91598068227f1f68cfcfde1507453.1704615011.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/01/24 09:12, Christophe JAILLET ha scritto:
> If an error occurs after mtk_alloc_clk_data(), mtk_free_clk_data() should
> be called, as already done in the remove function.
> 
> Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



