Return-Path: <linux-kernel+bounces-60952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEB850B80
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3A3B2223F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1725E3D8;
	Sun, 11 Feb 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="SQXWkKNz"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB01E887;
	Sun, 11 Feb 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684646; cv=none; b=GHNctjZrEQK3/UKX0lhzs3KgroGU7agtnMmORlyhSHA6kGjUZ3I1w2S5EoNYJpffxKDO9X7k9E18eGjiq4uX9gw0WUvk2R++Pys06YS5w7W5/GYS4M5s5vhFVdj6rLokv2GQx39yflSpPuoMoyXLXFjPHcnhivxiSGFYXThXihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684646; c=relaxed/simple;
	bh=/TVt/WXLbFLMhyemN6XrxxKty2GPdqWLsNom6iJb7nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Suu0v7pWy2JP568cwbOghGk6L/jOJR092p/9+Lnw96XT6bNLxUNKiBHdxl9UzN9bZ+QYRy7ozSUAbDL9RM5/BVSuVXHia+KcT+UqiVstzEv0dmMqWAwjJZ2gRTFWtuG9S0k83Dw+K1mgZUdAhNAi0qreAuJ9hxdow/2lVGxytnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=SQXWkKNz; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 5310460D2B;
	Sun, 11 Feb 2024 23:45:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5jsT2eIDX8c0-J19H6vkO;
	Sun, 11 Feb 2024 23:45:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1707684309; bh=f5rRJR6KNn/eOO0vS9ImbNMvdI5OX8OfzGV14/X6mbA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=SQXWkKNz3llZC3eFqKDPg9fqHM3R23uhtyqwJutAGYubmH2pQpkRSHqigAgGcu4qe
	 sCDOLTytsMsRIgoxeOG11Pr3x2GBRH0d6sGybO9YuXjB/4UIus89bfGVNkMq9vvEeb
	 Qpytfo+H88tyz5U2QjP2emKwvGZQXsH5vS8U/bRk=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <bdb92ba5-5ac7-4ae7-ab63-8a7545053988@yandex.com>
Date: Sun, 11 Feb 2024 21:45:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] phy: rockchip: add usbdp combo phy driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Zhang Yubing <yubing.zhang@rock-chips.com>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-5-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <20240209181831.104687-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 19:17, Sebastian Reichel wrote:
> This adds a new USBDP combo PHY with Samsung IP block driver.
> 
> The driver get lane mux and mapping info in 2 ways, supporting
> DisplayPort alternate mode or parsing from DT. When parsing from DT,
> the property "rockchip,dp-lane-mux" provide the DP mux and mapping
> info. This is needed when the PHY is not used with TypeC Alt-Mode.
> For example if the USB3 interface of the PHY is connected to a USB
> Type A connector and the DP interface is connected to a DisplayPort
> connector.
> 
> When do DP link training, need to set lane number, link rate, swing,
> and pre-emphasis via PHY configure interface.
> 
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Co-developed-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Signed-off-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

For Linux FTRACE filters it is needed that all functions in a driver start with the same function prefix.
Currently there's a mix of udphy_* and rockchip_*
Maybe use rk_udphy_* ??? similar to for example rk_nfc_* in rockchip-nand-controller.c

Johan

