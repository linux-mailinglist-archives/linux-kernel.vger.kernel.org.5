Return-Path: <linux-kernel+bounces-42538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA58402C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46321F23148
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ADC57874;
	Mon, 29 Jan 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x0PVYpGv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AE56454;
	Mon, 29 Jan 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524067; cv=none; b=PRjxZWqx6cgM2+csbu06dMq4mdFvASg16JEX6uC0x83xz3fqK/kSYVH9/Cte2XqfHwV7xqHb85fNFDFnJqmwKYECElNue+7E8fbKe+QZ+Of4gkVQf/xwFHQ3THOynPWb7yKZ6uJ/1DTGDwBQBjsU49fE67DIq26uyOPZ0cEG84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524067; c=relaxed/simple;
	bh=ajpfWU56N4RiwDnamz+uZJp8PwvIobXur3OZBlUPeCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqrDoZvTJZResEy5s9Jlewu32Jjb75rZDlWZv4i13WzwP90uy8fECOj7W1XcFa2HHBivn4HZGGovm9bb6QSyBt4Xv5k0FwgHsDr5T3yzx8zhBpMlaUzGsP1MG1xxosi6jcl1wsvmjVLze4mY2B4UMLSly1YTE6Sy8Tq7g1cvXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x0PVYpGv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706524063;
	bh=ajpfWU56N4RiwDnamz+uZJp8PwvIobXur3OZBlUPeCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x0PVYpGv8qE8Ji2aqHvfglZO6ogSUhFasmuKtiPZu9dHFW/yKofiFIyqpvnbJnryk
	 ZWyvEwzfBBD+La0u0vIRkeANJWjaNvYKn8SoS0O64ek9xwpRS+h9iXdJirCRyO3cWI
	 AOA95AH5TSIz5A7xKTHr/DOtDaML4KagP0KnWHD1TbLPfbr2FkZvVIwjiLMRinn3yD
	 Z5jK680MEjzcJvNm1+DlejpJ5yBpVr5Oxz35BLAOwSM8HQQXSqOY1ilAbmKn26Hchl
	 Hfcl/OC891mvthb4HihMFNm+5elBm/ca1iA3hqxnbylN+5ta2IX5SWO4ryNN47XXk+
	 7Q/FMSg8lcyLw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F9DC3781FCF;
	Mon, 29 Jan 2024 10:27:43 +0000 (UTC)
Message-ID: <861b9921-1869-4341-8299-f25215cfebbb@collabora.com>
Date: Mon, 29 Jan 2024 11:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
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
 <20231222080739.21706-3-william-tw.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231222080739.21706-3-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/12/23 09:07, William-tw Lin ha scritto:
> Add driver for socinfo retrieval. This patch includes the following:
> 1. mtk-socinfo driver for chip info retrieval
> 2. Related changes to Makefile and Kconfig
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>

Applied to v6.4-next/soc

Thanks!
Angelo



