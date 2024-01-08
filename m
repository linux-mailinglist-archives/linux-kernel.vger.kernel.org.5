Return-Path: <linux-kernel+bounces-19324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25342826B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2021C20621
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0081426D;
	Mon,  8 Jan 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uug89SLG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7914017;
	Mon,  8 Jan 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704708881;
	bh=v3YxdNrdSgkWoqnPochuFDi/fDkCFuaCUTCM/mFHb+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uug89SLGrs671PvYYyqHZyKC4fITITj8cRDPQbcmt7Lxsr89yS001FrIIsSmsCK7l
	 meZoCx2urIhIUNWtLf8mAKJFvrjYoh5S2xadnIslVpRXZ138MfElyhqaUshgqNqKoH
	 0w9xHCfDLUprJS9xXI6+lPg+RQssAGmrFWk+ZxyjHmTq56hg10QlyvlO9qY1k/a0YW
	 4DMX3G4ay5lrfBR1NRvvnqjyUKUZc7CLHLiUIbDbD6GGnbdb9MgVXTLJxzvun9BvuO
	 W2IYrRnP+wFLgCxx4rbJ74mtG/+4xr4jHWItWeJadzP/VtyU2uSYiXdvAbQWRc8BmR
	 999ufQxTpZrqg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 169F93780625;
	Mon,  8 Jan 2024 10:14:41 +0000 (UTC)
Message-ID: <5edf0558-7d31-4ccb-9635-dee64b026cbc@collabora.com>
Date: Mon, 8 Jan 2024 11:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt7622-apmixedsys: Fix an error handling
 path in clk_mt8135_apmixed_probe()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/01/24 09:29, Christophe JAILLET ha scritto:
> 'clk_data' is allocated with mtk_devm_alloc_clk_data(). So calling
> mtk_free_clk_data() explicitly in the remove function would lead to a
> double-free.
> 
> Remove the redundant call.
> 
> Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



