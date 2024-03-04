Return-Path: <linux-kernel+bounces-90425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6286FEF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A8A1C2088E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8425764;
	Mon,  4 Mar 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hmxqRTZH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224224B26;
	Mon,  4 Mar 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547705; cv=none; b=tjllv7+B+Y9lH+2mTIRFbLllQBJQHxMKxPHpKK8LYsIsgAuJQDhN/d8Iz8szUc6G5GFayV4zZROloCYo4oPGAkEaqnWvk0Sdqfp/J6CH5Z457GMyLstCMceLbBgHNi/5ZcGuNe05cxEzq/z97AMy6Oz0skztmj3vv602YEKbxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547705; c=relaxed/simple;
	bh=CdqsZgMWba5+4/38tOJ0rHa2CTmblAVjgPmyX2jcBAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKJp0UnV2AQsQf48Hw0VMntiaqtfb10+Lg05cJshNnd2Lf/j5+3r0anySpmV+85XGj/9PTYdjhJMyluuCi4DQ1BwjvUSuyrO3DLn93Sl04mbYOSyuuR8zzrRsMvKpk/WrRWetObWkh0k+FD3+iMczSYEiVvwuHyYxzshB9nk9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hmxqRTZH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547702;
	bh=CdqsZgMWba5+4/38tOJ0rHa2CTmblAVjgPmyX2jcBAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hmxqRTZHaFH0EmwDUqjKD9B2YwFeSsIN/Sv9G9R8MUAarAtX2CpV6WXAVo3j03DJZ
	 6vtWlYiV9WgPT41PzE6h8UvM67wx+aYuxtN5FD6Z5ySrC0TSYmZWVDzObsJNaEEq19
	 2F5mvVJ+sQerOh7Oec65NMyNutREUl9jXMX76RXUcTYj+60Jola5sSeKiapp7c3csh
	 DrnyU2GY34R8J3dVvpY3sTjr9zMAhT+l4KSSlIpa2KFcJtnKaqdo5tN6OKykJmv9wh
	 GlRMMxNol9Qj3uXcyXs/AHzksKgEVfi4mYlgmPapw+/Iel+AITOCchRhf27ktJFVQB
	 DDXKQJZ5gzz6A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C77137813CB;
	Mon,  4 Mar 2024 10:21:41 +0000 (UTC)
Message-ID: <02738700-6328-460b-8a5f-fb531756dd55@collabora.com>
Date: Mon, 4 Mar 2024 11:21:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: core: correct type of i to be signed
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240301144517.2811370-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240301144517.2811370-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 15:45, Muhammad Usama Anjum ha scritto:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


