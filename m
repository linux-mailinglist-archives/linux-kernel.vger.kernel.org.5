Return-Path: <linux-kernel+bounces-59136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70C84F1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA682830E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10B664C3;
	Fri,  9 Feb 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tOzjRwCT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC37664AC;
	Fri,  9 Feb 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468897; cv=none; b=k8AYCT1OA/2dH8KttWuuPWws13sXjZxAFt1pWGDxcNtQyg6aukukO9n8Hy5/OVGWmFs+O66q8Tjn1MTJ+NGjnBwRVtJYi6VhW1ks01wIX6wPCdBfQsMd+fhhXg4edrt7SD4gtc+mf552x/UdjHThfXweQAEZL2NqVUi/7v61kio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468897; c=relaxed/simple;
	bh=J3H5m350c/j2c/Zrss1AfOjAUuFtB5wq5BaVux2rSjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmBD/enBprRxylNbl9UZAqa/5k2EmsKXRoRm51f2ZVGTqMtcNKs09GsZpb3MOfRqWiHN6SeLihZsZdmpWMrW6mO/cO8n14cFmU6SC0kIGqk9RUOakeK9Zr2sOwBPHZoLHaeIoQCJ2CkidtUvhfLE9BvOAdZzq4Kic/u2BpIlHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tOzjRwCT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707468894;
	bh=J3H5m350c/j2c/Zrss1AfOjAUuFtB5wq5BaVux2rSjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOzjRwCTskl0m39IDIy/L/aNlDlFkIu4falBaJCTSLVxNjbhVBFAfjotBZayI7yAz
	 5FYMpzOaroeI4ItVolGfhqDGRHV1WfBoqstg5R5DuharkhrTTbURPDe9cVMcu1V/U0
	 4OLnF7yC0H7CiauX9PQDfkrX3WS1eMo9fBRB3d/JM0T/BVSYPR+uoSrJetjqF3dZHq
	 Uesux8liqjHnrV3rcLEX5KQnFbubuj4H1oRwmNRDTmElqlDARWlMVxUcW1wPB1v3Lj
	 yF4fcj+cAjqyJ4SjvKaMX36BDWeyLxgdGt1SrWf9F8/Afnj3OIKJyp7qC+9DOpueFh
	 ilrPLanSsSo3Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6107737809D0;
	Fri,  9 Feb 2024 08:54:53 +0000 (UTC)
Message-ID: <90e0e76c-7bc9-4aa3-8d5e-4fe96c2687e4@collabora.com>
Date: Fri, 9 Feb 2024 09:54:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] power: reset: mt6323-poweroff: Use
 devm_register_sys_off_handler(POWER_OFF)
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240208170410.67975-1-afd@ti.com>
 <20240208170410.67975-12-afd@ti.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240208170410.67975-12-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/02/24 18:04, Andrew Davis ha scritto:
> Use device life-cycle managed register function to simplify probe and
> exit paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



