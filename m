Return-Path: <linux-kernel+bounces-62499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB48521B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95881C22489
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D254DA1F;
	Mon, 12 Feb 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WMEzaMb0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3604EB23;
	Mon, 12 Feb 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778111; cv=none; b=J1HUYh2qYjlwsuyU4kkdGH7yDIfm4xFvz20ZPBlV1BBBxnRhsInQhSQY7iY5YQZpzdKohsksun3O6a9wW6b1OESGY9kU9nvlNOtJ/ZaxC/Vfc/7ZlZk7toNUkMZ6M7Pk4WKlqWl8hQeXUNjefUvpYa/rZdV/F9MQZqjErdP1c1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778111; c=relaxed/simple;
	bh=ul5k55UQtWoQXPNcb/0pzT+j7IivOX8sLryDaU7Ct7Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fsHMnuXOm1GiJW94XRWLqSgK7D7ct6WS7sBwSxzKDDnLOP+0p17XLJL2gYIqBR+Rb0CZOb2PxD3JFIFzZHnkseaBS4iKUUo0aOYHGau3n4R5DNTl1hekM0oIUYVNgH7dK7HFJ+k0xANhSCZTwMn0I6tuOFwK4ZPkuBMdf9+3ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WMEzaMb0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707778107;
	bh=ul5k55UQtWoQXPNcb/0pzT+j7IivOX8sLryDaU7Ct7Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=WMEzaMb0jF8d4K8ffKjdIN1T6SfXUyxnsga8j71b2gYgKpEhxOCt3Y89KABX5xqd5
	 fbv9vpbeOCuIE88lN74M4DIGVF7qczX91bFOdYuqUJllh3/RebXKfkalUjcPJk001/
	 H8qWuLfeISqog7kruNsqPXPmtA5X2Z9/iRmOSTyS1PkJ67wdaC9kUuvr0xBFRiZBna
	 Ynz6HJodRV8HLqyLBdP/+4MFIDsEpg0pAbX53t+FPuNza7+oTdUtX3aROyY+K/IdMH
	 ZQlgFA8zm9WCFUY694biMeLRpjUTDyzRnrXUe5rCtYxsZY9xaWXbgVXvmcY4ziLuk7
	 rLkrJlA5lSY0Q==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D75633780C22;
	Mon, 12 Feb 2024 22:48:26 +0000 (UTC)
Message-ID: <ad65ab14-4e23-43ec-aed8-6bfc59dddb51@collabora.com>
Date: Tue, 13 Feb 2024 00:48:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v4 01/19] power: reset: atc260x-poweroff: Use
 devm_register_sys_off_handler(RESTART)
To: Andrew Davis <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240212162831.67838-1-afd@ti.com>
 <20240212162831.67838-2-afd@ti.com>
Content-Language: en-US
In-Reply-To: <20240212162831.67838-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/12, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe and
> exit paths.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

