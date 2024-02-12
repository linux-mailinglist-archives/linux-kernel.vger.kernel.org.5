Return-Path: <linux-kernel+bounces-62506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07998521D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907CD1F22DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677314EB51;
	Mon, 12 Feb 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yB1EVfzh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320654E1D4;
	Mon, 12 Feb 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778495; cv=none; b=kwFlWKokrI4oJtWSSLFX28301y0UThqwvRgHKBaspKBk/PHxxNIY7KIfZXJ3/wGVw0aTGPB9mqM8W8AZbsV1sPUA53/0bMr/VmK/MqzR4fPVvag9+H9vqwMUPTivZPfyt3VW15svySy4EtF82qvw2epnUz4ydC//dMwPIwpw0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778495; c=relaxed/simple;
	bh=ul5k55UQtWoQXPNcb/0pzT+j7IivOX8sLryDaU7Ct7Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q9ekgBSDsL7ahLXl5CZJaSv/dX3HbTYA7PKvPq/IZhk45uRH5xhPKWeuLd0If9Q6txcbBX/2E14h8aptcm9OOMcDWdcL80hRFRNF/jrgQkXRr3qTARzb8ZAeUtUV/yk5IozFUVwOuw2D9MPEmclTZcjmg9oXg60NK6NDXyhuWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yB1EVfzh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707778492;
	bh=ul5k55UQtWoQXPNcb/0pzT+j7IivOX8sLryDaU7Ct7Q=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=yB1EVfzhAXAG+w8ega+dSZ/swCbr2gPUETml6Hex/vwR5/C7CK1G6sWoB/LnAPMA2
	 q9cQYwIbYH8MAOIJ6fuqH1PTz4iKmpY3lcFeVynIBLGwJ1r4bFiaSTjmQqlEKl/YZN
	 RKAcC2RMZauWn8f6J6h1Lkmk5q5shIRogie2/NalnQ6DppWXa3Tio9UADKvDzbDwe7
	 dI6p+Nnj6ngDjxgBNbvlsC4ErC5LvmVYBov+/DO0yNk4mwP30qcThg+h6e2d6xfvsa
	 eulyaETtXwnXJWxgUNHqrWsO4c8O/tQHkkKkIRw7582s7Te+EJYhow3fUfpdThhjCT
	 j9xEaqlEFAmGQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3DA073782059;
	Mon, 12 Feb 2024 22:54:51 +0000 (UTC)
Message-ID: <088b7b48-075f-4e68-9675-38c0e1f4a560@collabora.com>
Date: Tue, 13 Feb 2024 00:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v4 02/19] power: reset: atc260x-poweroff: Use
 devm_register_sys_off_handler(POWER_OFF)
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
 <20240212162831.67838-3-afd@ti.com>
Content-Language: en-US
In-Reply-To: <20240212162831.67838-3-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/12, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe and
> exit paths.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

