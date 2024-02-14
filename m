Return-Path: <linux-kernel+bounces-65471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3001854D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774181F21D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A85FB85;
	Wed, 14 Feb 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1LScw71g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A95D8EF;
	Wed, 14 Feb 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926246; cv=none; b=KA5Z5w6vPMSTQuiZwxUULmHEtZ4yPmI0EAXFyuKwyMOZPSj8kgg5KaQAVxvOM1uk5zbj8hxTP7JDvuzOvvBR6crZOm0FbbaNarDC42mqUjmqVtXYj9aldNaRgOGVb6TF73AJ0Ec+tPM2vd+KZ8biAnj5yyT4dcU6U8T8lfqZKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926246; c=relaxed/simple;
	bh=Bd5EcXpITfABSAnDz1WzxxXsNxYIHPEqoPgVPDXjEq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LL8KEUDVhTEnv79arRciZkaxOfMgeKn/EOF2ejcdEmgivRYZh4rlaj0Gpwiv25JUXP3CyXxMkeImy7ZQT/ObZpsdaSr3pj8XeinpM9N4oZzaci6a8Bv+HBCs7FsFE8XEptVOhKppbMLC78+eS0isGIu/kmaZjB6NS2coftR1XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1LScw71g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707926243;
	bh=Bd5EcXpITfABSAnDz1WzxxXsNxYIHPEqoPgVPDXjEq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1LScw71gscHusyEbrd4zfM/xFcfo0LDyiCDjfjNLpdlC3vXCIHGOr+OVC9UiG49oe
	 Th3ePND4eiQ+rojPuKJ8Ul9Y+E1FFnccwqYGQF0xHzYC7IMjIq5c9uMuwurenmCKqx
	 sv/hbGpdt9GkC7qTGJ3iaWcX78+sXr4RJdWffHH0J2R8yA6xUMrCeBW1YtQPhNxgBz
	 5fM2NOr0/nOkeQJ1jhxsvBhe9yq8EFM1wtBQlJABI00Rolc0BXToX5rZCe/opBVClS
	 J+sLyrhBZunjmRZj6pb9OUrrsTG/fXVRneMn76dUWdJi6VxrSyQMXaK+HXnOrJB+4H
	 cy526X8mMBR9w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C33673782083;
	Wed, 14 Feb 2024 15:57:22 +0000 (UTC)
Message-ID: <f5998e7c-674b-4ee5-b25f-d280db2f912d@collabora.com>
Date: Wed, 14 Feb 2024 16:57:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] pwm: mediatek: add support for MT7988
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
 <20240214140454.6438-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240214140454.6438-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/24 15:04, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MT7988 uses new registers layout just like MT7981 but it supports 8 PWM
> interfaces.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


