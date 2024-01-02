Return-Path: <linux-kernel+bounces-14177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CD8218CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E8F1F2207F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4458746B;
	Tue,  2 Jan 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m6E0Itzo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FD5663;
	Tue,  2 Jan 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186897;
	bh=h1vYuqHfw4Si6zEFGSCOCtG/Sf6p6ZMOenHPLIBQu1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6E0ItzoMYPOvZwdJ9vXEdYJcHQj2X7R7GUh7rEnF6uqjrJAqHNJX3fZ3YU90QkKU
	 F9M5a57t4N/SSBoXdtO4wexHOIXr6JezHTjwTfk/bn5eB6ESJ5brgIpgpJg+0uFUgx
	 eAA3GEsNK8JwORvp5Z92CAXqqHRFDY9eXDPNzy2yH1YEXxjy4xrZYTJ24Eo7ih8RWQ
	 JpVi3bA6HlY9j0bpLSFgcJBnlVEFGRMbToEGWiMU1T5Mt1ssk35v2Rrc2myfLVzreC
	 f3QT+tq67VkSLRWIXHTZoLqX52FD2udi4EGOUle0jz6Oxm8TGKETdtr0iLM3rhXtnq
	 kROLcNG31KPDg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 224FC37804B2;
	Tue,  2 Jan 2024 09:14:56 +0000 (UTC)
Message-ID: <d44ccb77-1bd9-43fe-be2d-cc2c342eae89@collabora.com>
Date: Tue, 2 Jan 2024 10:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm64: dts: mediatek: mt8186: Add venc node
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com, Kyrie Wu <kyrie.wu@mediatek.com>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <20231228113245.174706-7-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231228113245.174706-7-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/12/23 12:32, Eugen Hristev ha scritto:
> From: Kyrie Wu <kyrie.wu@mediatek.com>
> 
> Add video encoder node.
> 
> Signed-off-by: Kyrie Wu <kyrie.wu@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> [eugen.hristev@collabora.com: minor cleanup]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



