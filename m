Return-Path: <linux-kernel+bounces-58003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3984E027
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69AA1F2B2F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019879925;
	Thu,  8 Feb 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="03bYqfjH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1378674;
	Thu,  8 Feb 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393396; cv=none; b=q2rCIApm1tuogYeg5dC2pyORUtynOYJSptz9FMEcFh+ns1Ce6PrkM1w/Brg7CnCWVDCdYNlm7n2ZEv/hc/gi/qy61NzCeNgMrI6ye5iE1LS1EezZCAPxs7SQFnamaIeNBlWzg0AjhMOL3cxbDUYxkfWrt1N3sOz+72t33uT+qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393396; c=relaxed/simple;
	bh=GvOQavqKQ73W+MRNGucTZ0Ho0rG1YvGyfH/usYCQVX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYFx1ZU2k8K/mFagoSXiF/cmH7oXbfTlzQ+/+T8CA69LhmsinaQjqZ3mEc+YrR8z8Xk20vbP74+fXAzma3R5Qozl4pItzsYVC36rEPG52Zbah5OPAlgGln494SVNRyp6H1vAhROx0ZLZAzmmMHF+jCWjlzOMC+jkRnhBHZykVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=03bYqfjH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707393392;
	bh=GvOQavqKQ73W+MRNGucTZ0Ho0rG1YvGyfH/usYCQVX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=03bYqfjHn9J1jg29DH4aCJDmoCpd7W4TAdaMyzB/z8MgQh+qNWMERjJhFHyMI9thQ
	 8UctKNuQvwiz1cb9JGulU41IocHuZsXgQFD19dQs3PO3h1fgKP+fuKu33wIsqjj06n
	 IY+sSce3jWOsqAZR5BXB+skcQ6xbaNOTVuzcozpuOYn4jkxBGbuQ4TZ2txGnbSgOZb
	 zRPTPrVIm4QkJRwWevsLtTMrVlL03t7EoMOXuqgVe857S6SptQkkbP6qfOuoo+qGU+
	 +nPe7I6lKvMKgwji5HiDcyajlCWGv+NGxl3RMtq6RGx2FJcTKPrpXrenBOR8muZTxT
	 GOaRMNnRtpKdQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 769863781F7D;
	Thu,  8 Feb 2024 11:56:31 +0000 (UTC)
Message-ID: <a15ce51b-5778-4978-946a-4b8350205c08@collabora.com>
Date: Thu, 8 Feb 2024 13:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: rockchip: Add Samsung HDMI/eDP Combo PHY
 driver
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, kernel@collabora.com
References: <20240205-phy-hdptx-v2-0-a7150814c047@collabora.com>
 <20240205-phy-hdptx-v2-2-a7150814c047@collabora.com>
 <2670318.X9hSmTKtgW@diego>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2670318.X9hSmTKtgW@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/24 10:00, Heiko Stübner wrote:
> Am Montag, 5. Februar 2024, 12:24:25 CET schrieb Cristian Ciocaltea:
>> Add driver for the HDMI/eDP TX Combo PHY found on Rockchip RK3588 SoC.
>>
>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>> and eDP links.  The maximum data rate is 12Gbps (FRL), while the minimum
>> is 250Mbps (TMDS).
>>
>> Only the TMDS link is currently supported.
>>
>> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> on a rk3588-jaguar
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks for testing this!  Will send v3 soon.

Regards,
Cristian

