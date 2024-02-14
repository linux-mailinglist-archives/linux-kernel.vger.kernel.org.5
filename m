Return-Path: <linux-kernel+bounces-65470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A90854D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247A31C26865
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96675DF0F;
	Wed, 14 Feb 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ChCecnFt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9B95C8F9;
	Wed, 14 Feb 2024 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926246; cv=none; b=EnU7ZdSDh9rzZ1NDOj4O0V/Bq9VJWm6T+7prpyRcghJdSQnRbHtiba7GyTdoUmiOx5XfVwAXmtLxgXPOqsBPet9lm4Z1pQLd6bntPgc05ZZcjcUM0glOxYKymTbMiMC1BA8ATdbNT7X2lCaN8ggzLUPPRYOtPUP+2aDuYzhFHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926246; c=relaxed/simple;
	bh=9S1I1UJjz/X6ER5LhtT7IGanpvGoyXhIkt7y7jddGRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IezDtq4FgNJ8jUE3NZ5T484QphPubYBkNcWQS7+JkNZkLTvAgw7h/5FUMMkDYAsom3yiQIxqzr+qqKcPjdHIvTKOi/8DIjBp8FoLCInrU1c1FUIT5gN1NytRb85Ov1NGARv/xNsOF1ojz3e3nBtKU6Q/EEJ9idRnoWrdDuF0+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ChCecnFt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707926242;
	bh=9S1I1UJjz/X6ER5LhtT7IGanpvGoyXhIkt7y7jddGRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ChCecnFtsuu89rAx4oQVrab/J7YJwvcBTw7poUim+4V7Jh/s9CaJ7kvywmUU3WCjL
	 duyRWlOvU8VNDpkvnV2nHr+SKCdSvF5fX9GdEDC4MwI0SbL6k2jqK9NfwLd/WxWhbu
	 d+jfED/0i2tVJQHpocJ1Fmtsvuy9vmoHE+rTsqrdloypio1kwatMgjdu1W2EwxoUXC
	 qZlNrwEC05xdXUMQBJV+eAqh4SxbI7eP/+S1s5DiAPyE3rp9mTJKwFPMQxS+qJp3gg
	 RjRZSqC9FP9kIFgiqG+gJP7siRfIbsV+wepS1oeWv6LBMWJF7Xi4IP4zMzVU9WSWOY
	 mvyj/c67OmLJA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6AF93780894;
	Wed, 14 Feb 2024 15:57:21 +0000 (UTC)
Message-ID: <137bc832-80fe-4dec-bbe5-caca2c1c5b97@collabora.com>
Date: Wed, 14 Feb 2024 16:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, John Crispin
 <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240214140454.6438-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240214140454.6438-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/24 15:04, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 has on-SoC controller that can control up to 8 PWM interfaces. It
> differs from blocks on other SoCs (amount of PWMs & registers) so it
> needs its own compatible string.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


