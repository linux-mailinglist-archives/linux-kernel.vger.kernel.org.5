Return-Path: <linux-kernel+bounces-81377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC9867513
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A0E1C250A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD667F475;
	Mon, 26 Feb 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jsmsxXwV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9EA1CFA7;
	Mon, 26 Feb 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950841; cv=none; b=NNJuhDOqClrCVJHW3CHqzMXl6+zORJdIUpUt18dSykJ+5p5lpIKnd6NlHIhSBji/xtESpavAgWjtI4YxBTIzW9EVOGJWPfw6aOvNqSLYfP7T9zO8rVqFo8e9jf05JuUbSURZfU8cTjPOhRQZP9VTi63GoyHYQVe8ShrQPMR1js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950841; c=relaxed/simple;
	bh=yTKK6qTVp/S8l1CYnLD9a4Jr8ZrucjT94QlJdY1OCxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4jwoP3iReEFbsMFISLft/Qi+Mn5ZH5EG8yWCfGC3bMWWS0MScbqS59Do0lVJ2CDXK6Z5lNtiFwhGgHyrA3CeKiGXg+PvQdFXcPVKS/GTEIokuae2UHLQg6PpvVLQ+LfcW0B2C052hReCgjDdkT43TWVgwcMCvwCNyGlmO/UwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jsmsxXwV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708950838;
	bh=yTKK6qTVp/S8l1CYnLD9a4Jr8ZrucjT94QlJdY1OCxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jsmsxXwVeXseXIYn86JQZ679HZED+QL5moQjh1DVj9GbMGu5KYHlE4tY0t1xFylXu
	 OKksilY4tr5zFGMmMaQUyt3yDZGNiqy3vMMcS/Y+HdUoS0C0hYFBIV8cQ3eKUT7hqn
	 xMBHfjl4y+CnUJMvC3dhRFr4vuRGUrWDsMylvifSwcVJNtyEto65c/rc0p58TNFq34
	 rTABcNH/qNCicSUQzUaIZ8+zhxMtGwHzMvIKAhSZksCdTduBs14HdfYdPDfIvs7x7H
	 PotQQlaIrTwAzMPbdLa1mY4wQis4X1G8MRcBmYCZzlVRh0GVadxzIGENsQeRLc8weh
	 hOUDq3V1f69iw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 414BB37803EE;
	Mon, 26 Feb 2024 12:33:57 +0000 (UTC)
Message-ID: <7866fd9b-6f68-402d-abdf-087b1088d28b@collabora.com>
Date: Mon, 26 Feb 2024 13:33:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: clk-mt8173-apmixedsys: Use common error
 handling code in clk_mt8173_apmixed_probe()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <6a64e7b3-b1ce-46c4-9c85-89f731aee592@web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6a64e7b3-b1ce-46c4-9c85-89f731aee592@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 13:26, Markus Elfring ha scritto:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 26 Feb 2024 13:10:37 +0100
> 
> Add a label so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>



