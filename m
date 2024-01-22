Return-Path: <linux-kernel+bounces-32784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA683600A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C671F22005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1F3A1DE;
	Mon, 22 Jan 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JcARR62G"
Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com [115.236.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB939863;
	Mon, 22 Jan 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920525; cv=none; b=DxWsuncJZzZCy0+ygX5fw2tsnC7PH8AabmL77aLpQqbCSsq3BGQeZm6woLHogNvUu+A6Lz3hLwjrPIAHG++2huhEXVVdGB2KvIZek7plxhjltcyn+tTCjnr1XwzX98xHin/smuVt9PfDcwq5GnRvBPbi0AWtiXrSy8v+cYLBdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920525; c=relaxed/simple;
	bh=2D2Bz6kHSRQ55n//fD6i/rFr8iCWh5oGDoAjdduw0V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Whe4I+WCpWtLFYmWEnVke/rUa74wvg7+IOZEHD2YqvFjI2EFuqLnVUjguvayzjRQabiXtvosQuDm2usoFgkskg2i1zl+GKlP/32LAMqFnkRiHM0zOU8nw0p4AGaIAQSiYGGToHN28V2hP5fxbCy0rmt90MX85o9MmeDqo74RYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JcARR62G; arc=none smtp.client-ip=115.236.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=JcARR62G5KtOTczFX/WYMFJwV/BvIRt2AmOWqsI1F5xn2azbR1xwfIQam//ayqB3aKfspGrMC9fY0tBB9FZzT3sHJBj+EPjveLpBsCzGMyHfQlzypNXyQiP9gFsfBZu93//q/pt3zAbRPddIoN9HshO+YNMClt/SwMbIfbfH+ZI=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=BomGdr3zph+RbyeW62SV+s3dc8I4NnnTpRyEiySaDz8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
	by mail-m12758.qiye.163.com (Hmail) with ESMTPA id E3EF3AE04E2;
	Mon, 22 Jan 2024 18:10:13 +0800 (CST)
Message-ID: <a7e5304a-1cfd-4f38-8708-bfca30f0ef7f@rock-chips.com>
Date: Mon, 22 Jan 2024 18:10:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Johan Jonker <jbx6244@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
 <417281cd-23b1-4948-8c5a-b9820dff65aa@collabora.com>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <417281cd-23b1-4948-8c5a-b9820dff65aa@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxIGlZDSEwdGU1LHkodSxlVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8d30a6318cb225kuuue3ef3ae04e2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6FRw*HTwhEA83TjcdMxAS
	TAFPCTNVSlVKTEtOQkpDSUpOS0pLVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSEpJSjcG

Hi Cristian:

On 1/20/24 07:41, Cristian Ciocaltea wrote:
> On 1/19/24 21:38, Cristian Ciocaltea wrote:
>> Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY
>> found on RK3588 SoC.
>>
>> The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
>> and eDP links.
>>
>> The HDMI link has been tested on Rock 5B and EVB1 boards.
> 
> I missed to highlight there is no eDP support provided by the current
> implementation.  Downstream kernel has a separate driver for that and at
> the moment I don't have the hardware to wire this up.
> 
> Will include this statement in v2.

The PHY is used for HDMI and eDP on rk3588, and should used be exclusively.
so I think should s/DP/eDP/ in  all description.

