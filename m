Return-Path: <linux-kernel+bounces-31632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7E8331A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92738B22AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA015916D;
	Fri, 19 Jan 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fAIBFn/K"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA259461;
	Fri, 19 Jan 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707712; cv=none; b=I8kyJ5E1vQXG7bPbmgKumjpWqHc7jP3CQmqLggWGf2aw9Z+U8FZxi2rN6JnLb7nIW89F++1FrhNMObl29tiVRzLI2bw2N5vH/qM64DFTnvLLDU+I+W9e+OZ8MIqA6VzQCvnCfJocnS8gvHhy4u1d8Q8HlcEmZYQk8ym2YdyDpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707712; c=relaxed/simple;
	bh=ftKWeC6U9mzF1f0nXgLSRHkw3HDVdEK9xa/ts4/b2a8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mig9AmCTHY6HhFkI1SLlmrq7PJKqbX5bJfjISmieK1yVsC59gQNY9Q5uZIlcSUy6zdHofP8bsyB2F1uLU4PiML29FzT50583uKeVF5NS0/8F5CbHvacED/cDlzJ/gJhrZ1HNAj1GCQ/4dgldYpcozxWzxc0jTK2iVAyfMf46JTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fAIBFn/K; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705707708;
	bh=ftKWeC6U9mzF1f0nXgLSRHkw3HDVdEK9xa/ts4/b2a8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fAIBFn/KL8w35tVinmyADRLk4ZjK+GQMugMRZu4hA4eDNll7kti+U8LA7IAMOM9E/
	 Xnj425A36TCWh4TAW2nepY2GYzL5Jv2g86ekrG2l1yeHjBnJc6wOYfxgThb2lehhxK
	 R5d2WBcfPDTQI1gEgmH+8dr30wmOgVw2zSgPdHglYt3Qm9nXRGepWXxbPKNJ9NJoFw
	 Lb6UGQRNtx+D/x0zLALK3Y4X0Mgr/l7N/yTmxQX2743tSTYtiQiqwtBoypkLnDAjws
	 d13e2BV2qwLPpLZeKwjYtCuZs9gh7PJJZv5oX2u4B3FuZvAoWMeXfU8BnjuJ7f2nqi
	 UK/Z7ChrS0qhA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEFB4378143B;
	Fri, 19 Jan 2024 23:41:47 +0000 (UTC)
Message-ID: <417281cd-23b1-4948-8c5a-b9820dff65aa@collabora.com>
Date: Sat, 20 Jan 2024 01:41:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 21:38, Cristian Ciocaltea wrote:
> Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY 
> found on RK3588 SoC.
> 
> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
> and eDP links.
> 
> The HDMI link has been tested on Rock 5B and EVB1 boards.

I missed to highlight there is no eDP support provided by the current
implementation.  Downstream kernel has a separate driver for that and at
the moment I don't have the hardware to wire this up.

Will include this statement in v2.

