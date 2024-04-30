Return-Path: <linux-kernel+bounces-163508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029F8B6C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015FF283E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F34086B;
	Tue, 30 Apr 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1toP7IcX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64683FE37;
	Tue, 30 Apr 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463776; cv=none; b=OLoi4HEzFxhVm5k4jLCHuBmcqqq0mF3S7QOK0wzmwy0KpoOahfynFXSBwBr8DVhxw2cczwca9AaAhd1sfpEGdu6Wx/f3/Fpzyt6hl//BYtwkUz7Xxn7HI+4XleGnSGMNLR3Zt/8SUbjPmDE5DCcM9sAo+Li01Ys0wFvUpyDqp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463776; c=relaxed/simple;
	bh=GeswxmYT4bGFOK2AR1iOj85iEdpchJiz/hwjIyiKyeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZfJuDXVc8iILxQh2EfwwDom9kDIDjsQnTXRhVANAtlaAoErtqOkzWmfbe2wQwW8o37lnqS31fwUbbeSY6apqdWiUh+6BtNj2Le9P9+iELx/F2uDjynEgNBBtKGcx9IvchEHIeubf+vGNpK3rvjT8chSz+52lNn+cHLwLqXSMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1toP7IcX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714463773;
	bh=GeswxmYT4bGFOK2AR1iOj85iEdpchJiz/hwjIyiKyeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1toP7IcX3n2JvpjsyDkchdN1CczXhxVUlN8SskxrFLfuEfNhs9cCFHLj44Ib9sBJ9
	 DaWmnuRs5DzJov4hx2XLarT/dT5vNTH37o3dt5ebbb/1AzXuzcDl4a0FOtV4EwpJEu
	 2qa/8SEwbCAZ0o1faIRMFE79UxwtqVtxa5VIU+NtKHPlS27PwFbEH5+Jj4eqbYNH9U
	 99NtMtMupkIzwMaXPMMUUv1VwROj7isL4MrlBlAErC9hspOQyRqtOoVQ03GnutZRnG
	 3zKXhPoub+DDlj5S7zh2LKv6azNbUu5/10szukkx2R/A55GhLc7+d54vhpsoUI9ZUR
	 p8vKB0Fs1rs1g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 016123781F9A;
	Tue, 30 Apr 2024 07:56:11 +0000 (UTC)
Message-ID: <f104a34a-a1d2-4eb9-8127-cfdb8560872d@collabora.com>
Date: Tue, 30 Apr 2024 09:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] remoteproc: mediatek: Add IMGSYS IPI command
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240430011534.9587-1-olivia.wen@mediatek.com>
 <20240430011534.9587-5-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240430011534.9587-5-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/04/24 03:15, Olivia Wen ha scritto:
> Add an IPI command definition for communication with IMGSYS through
> SCP mailbox.
> 
> Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



