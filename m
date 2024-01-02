Return-Path: <linux-kernel+bounces-14205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AD7821913
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779E4282B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830479F3;
	Tue,  2 Jan 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r6nhnP0Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56691D2EA;
	Tue,  2 Jan 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704188931;
	bh=lcIOgXE6OIn9Fcsrj3oASGuidAvBxdVMC9raUI1LSV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6nhnP0ZNJC/FtMrd+420G2H6IbzGwqeHXsRSbuhKbhzTzPXcGE8Zcw/ATuLKJAFM
	 //wUCCeNKoanmY/YBdX5Ah7+F1EU1hqtPJXvJU+xWpnXF1qzQPHzXW+nG5q4QP7o2N
	 vASLRXN0txjetnJBhBZSPG5XjdxgxoxIKiFYkVMx7WfBtJQbbAKQ+5iof9P36t/Iso
	 UwBqvxAZ8YSQilta6ADtKYOfoJU2IeH/fT/yeGrPMBlrwtiYEQS2kjIWro8kWZxZeF
	 FsVteTT1rx5Q8XuG2O0FqE7TJdp6ttG2cujiA/RrLBsHZnH/nimUbLJPp5cFSHUTHq
	 gBh8VDEkquhTg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82CCD37813DB;
	Tue,  2 Jan 2024 09:48:50 +0000 (UTC)
Message-ID: <94bbcec7-b587-4c19-8d81-44749885968c@collabora.com>
Date: Tue, 2 Jan 2024 10:48:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvmem: mtk-efuse: Register MediaTek socinfo driver
 from efuse
Content-Language: en-US
To: William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231222080739.21706-1-william-tw.lin@mediatek.com>
 <20231222080739.21706-4-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231222080739.21706-4-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/12/23 09:07, William-tw Lin ha scritto:
> The socinfo driver reads chip information from eFuses and does not need
> any devicetree node. Register it from mtk-efuse.
> 
> While at it, also add the name for this driver's nvmem_config.
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



