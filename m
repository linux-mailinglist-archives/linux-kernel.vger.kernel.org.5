Return-Path: <linux-kernel+bounces-81365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDF8674E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5411C24607
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DE605BC;
	Mon, 26 Feb 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BdrbsL+f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD645FDC9;
	Mon, 26 Feb 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950504; cv=none; b=OdnScvArGbGDh2l7qrC/bP4wWlcAe69/UJrc9zPgiAinAa/TjfoZ1+EEEvDcccnrqeeqvH5RFjJiBOdw4oi1WmcasdJxbUJ4kcFDmRgIjNarf6w7gz3kYOq0KNjUyhII6xlHzIfehOQUagttsUve7hpTh0r71jbmsT1JYCALjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950504; c=relaxed/simple;
	bh=0Wd0sKNO7tP2RqySG2jQChiUIciUjhQMEGc7f9XIo5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpEmCryoqRdLjdWfdTxFzCtssdJqHHK47V60Z1nOtpiAZ9xR+SjeUuaWgNaGi3njrcPUKl7Nh3bpWXEtmodx74QE/3LQr1VpYgLrz/oJM9+OSfHUPZ1sotM11h/krRX+xNik3kRp83AfWwqXwqVgki1RtHOcfVtWxAeWDF4JWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BdrbsL+f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708950501;
	bh=0Wd0sKNO7tP2RqySG2jQChiUIciUjhQMEGc7f9XIo5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BdrbsL+fURkkEt+RFYfL883Z7DqkhNSW6PazwFDXk8Bcfefd+wUchjmpl05PC0G/z
	 Vl5G9crrnjX1YDTq6xZqg2UiTMpaz6Xcz8ukVDf5/jUtCR+qm953bTjUbOCo4r6Vzr
	 6IKEuDjCvQ/yF4MkHB2oy3P+6i9oJwN3KlIVLfaVhAZIATkSJ1JHzhMvaCOKyw4ySk
	 0w5cbw0dz9Rc8aSr5qwlASm3EnuI3vGlaaTVGm5N6gAdQy53vcnM3Z8arw/inhR6Qq
	 BGzf6JFf6+t76xYCcbSQamVUfliaEd3+3y/jUSgWHLrLKNx2mbnynXV3N59AiiDe5s
	 KaDsUUYpx/TFg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE39C37803EE;
	Mon, 26 Feb 2024 12:28:20 +0000 (UTC)
Message-ID: <3756ad5e-7c05-4502-9a6a-ffb58c76390e@collabora.com>
Date: Mon, 26 Feb 2024 13:28:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for
 Internet access
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240223112223.1368-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240223112223.1368-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 12:22, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> It's common for routers to have LED indicating link on the WAN port.
> 
> Some devices however have an extra LED that's meant to be used if WAN
> connection is actually "online" (there is Internet access available).
> 
> It was suggested to add #define for such use case.

In this case, you can use the Suggested-by tag, but I'm not picky anyway :-)

> 
> Link: https://lore.kernel.org/linux-devicetree/80e92209-5578-44e7-bd4b-603a29053ddf@collabora.com/T/#u
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



