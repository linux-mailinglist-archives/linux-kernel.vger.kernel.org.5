Return-Path: <linux-kernel+bounces-80993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F7866EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987DA285C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E136A349;
	Mon, 26 Feb 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aA8uGwp8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E36A01D;
	Mon, 26 Feb 2024 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937936; cv=none; b=ZuDIehA4W97Kl/RxBM0vH5YkM/NxMd9TdGha4bOX9lwxEMqg4mGYK+E65cz6jL+sjmSQnWB254t5mp2ZMNxH9qRMiTihzK/G21FNIPyknGcEmBCJhlrKOtQeJiWrIq5j5E+BkbahXZVhmUtfKnZi1wEXVSRqPfZOlewOz8IXZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937936; c=relaxed/simple;
	bh=zA+oV5eE+DmShaJT1CXXXguSc4DEhYwAp7s4CFKkF0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhOE0hFE+6BFSAqAzn6ZGSBtgMnPug5C5tmWVevGjRfJBIMc6T5j5iJ2iwCb0Cq8isCcFrASPGs1gAxvidFSGFhUtVhWyblynKfx/vngPilHG6mKLaXkQywjHxqmJCiuKG+QHmWbAJj7KyL3SvvsbFcC4ajSpneyMoV3oAYtPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aA8uGwp8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708937932;
	bh=zA+oV5eE+DmShaJT1CXXXguSc4DEhYwAp7s4CFKkF0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aA8uGwp869N8HPs53Dbrhv5TAOQyPWeletOZpIgGJej5mp2Z/Rac/vS0W3UADwGUY
	 xM2sRbgvAqkOQATrLpIY3jmEdc7/lpMXhzBojYi18xxS/O1KrxA5EcXipyVs0iMXA/
	 4j5reS+ZPazRQL3Ae/mCUGNz/DWkCGQSJdxaypTUNL0wTMXCiNhpOoZpLdCbYB8b6N
	 EEPh0CoSBf5LX52E5torJD9FdTfPwZaqTpxP9yZeLXeG2GYevQfku14TcJb4mj66pi
	 w9dB4CWHMGlPRXh30bOgI8HNrI3gf/MCugUZ2NSpPoaY/asafk2JC+DYs5aV8/ZjX/
	 cL3vrJRP4DsbQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7BBF6378207B;
	Mon, 26 Feb 2024 08:58:51 +0000 (UTC)
Message-ID: <9c114a61-ad19-4852-96c8-dbcbe8d8e38c@collabora.com>
Date: Mon, 26 Feb 2024 09:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240223101709.30072-1-zajec5@gmail.com>
 <20240223101709.30072-5-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240223101709.30072-5-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/02/24 11:17, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router. It
> has 256 MiB of RAM, some LEDs & buttons and (not described yet) 4
> Ethernet ports.
> 
> There is one slightly uncommon LED with a label of globe icon described
> in the Quick Installation Guide as having 2 meanings:
> 1. "Not connected to the Internet"
> 2. "Connected to the Internet"
> 
> Vendor designed it to light up when some Internet-accessible IP can be
> reached. This change will be follow by an attempt to define some
> predefined FUNCTION for it.

Can we please try to add that predefined function before adding this devicetree
which would anyway be modified again to use that new definition?

That just makes more sense...

..if you can't get the new definition picked, I will take this one as is, but
please try that first.

Cheers,
Angelo


