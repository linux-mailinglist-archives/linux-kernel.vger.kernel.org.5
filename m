Return-Path: <linux-kernel+bounces-95529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7ED874EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5D72855C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268B12AAFD;
	Thu,  7 Mar 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GSVwWOHm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BA85295;
	Thu,  7 Mar 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814294; cv=none; b=eJnnnAWuHf6W5QHq+AwVXlZ+trX1y74YPvRaajiVX1T9nmxEgby9qyASySXQ36B0pAe1zdEZ7M/K3c5CocUg9B78GnHy3po2iMWhuiunRYQJYXHIDIHH3lmspJk3/or4Aa9sgWc3cOZx9k+IoJHfwjdgnQlNPDyFNYO41HhM3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814294; c=relaxed/simple;
	bh=GeDCv05FUk6VAu26Fny7eeNMfK1OboweY8V19O6PpB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMmnoXFcsLNkCiC/SgzX74GOfV9a5xHFQ1jFg9p2VVodyzmYkbnFkS1slOt4LcebBfPm5t9LxuoKilhGS/ejydPVQw5E8zOzVphfkl8f69Jjqxz0aPI+yR1G/S95t3aCvlapXNYK3Ad+zEB2DvByli7jW1wsOfijM/ZvPYk0lGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GSVwWOHm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709814290;
	bh=GeDCv05FUk6VAu26Fny7eeNMfK1OboweY8V19O6PpB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSVwWOHm1IqBMye0E00ZbYyzFuL0x15cxeZJrv4iV43R3f965Wct9hDsk4aZj7zDO
	 q5UuPnHeUfW7ebTAGrGrxVvPeNyU3i8Fprj+qJz0y84epD2ChxdzE9pIB3QE/FbPF1
	 pNtLgt8WHCFaDkpGfp6DV7is7ZTUX0llyH/0qYrAeKonxxSK8kju4axz7vcDuVioPf
	 LvKAg5VFe9zQY4b1aqCA45o9qUVybpHGnMj2/9ytOTfTXSDBFWVw9rAj5PolElFXHg
	 hMc4dyrwnNho6vJ2iX1wXRm26pA0qiXEUcuOBI4nxi9nXsGS7bH87DLJ6q0GdxLj/o
	 2/ltSSof8dbcA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 34F5837810CD;
	Thu,  7 Mar 2024 12:24:50 +0000 (UTC)
Message-ID: <b5bbfeba-1da7-4a27-a793-fb8170fca6bd@collabora.com>
Date: Thu, 7 Mar 2024 13:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240307122129.2359553-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/24 13:21, Muhammad Usama Anjum ha scritto:
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
> 
> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



