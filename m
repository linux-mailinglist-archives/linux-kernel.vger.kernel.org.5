Return-Path: <linux-kernel+bounces-116615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33D88A115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAE82C68CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B313D63A;
	Mon, 25 Mar 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c1hCJXVT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E917C651;
	Mon, 25 Mar 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350339; cv=none; b=DrXpxwQRYrIInIPqFn2FO2GYKMWyGlPukrBzLa6E3EXuelRZZA71t8p/Nz6RPp1i1wKO4mz9nmV+XRsmp2YniJFoSxXjyoaHpXI6/by9/mhcHhdEkFPUBN+nOyW60mYrAPfZM91mjw2dFnPJkL/BUcY91Wv/bQ7bpTkX2ex1j9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350339; c=relaxed/simple;
	bh=aV94Ji2ZXvUe/v3dnC1nGjcx9RZkSBb/WS70H4w3QRk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YPV0C61FwQ4aegxaZBdDmzD+NxFPJvm6/v+URruiXLhIySToWMwMOLan66g8g6qc1V2SxPsZAoTqwQD5578EyM6GdEFedO9F2K55NQJalGKG0PjExYM3cnu00fs0oy0ilDVXn+ORfhZ0w15JULVqux2oZnKb08+3g/Qji5/zUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c1hCJXVT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711350335;
	bh=aV94Ji2ZXvUe/v3dnC1nGjcx9RZkSBb/WS70H4w3QRk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=c1hCJXVTp75LBY4vdUrg+GI/kT30EH6drgVYeJe9tk2SfwipE4+I2il5a/MUps2L2
	 STlyzxVmSdfN5raHZtPa35Wqm/mzVcYpKIQS43AtZwK9y1P/OP89OiBC1Yt6+7mges
	 PpbmDwjzB1Bm0RndoBjZMP7GGMhhx+kKVeDjllzQfMXmep+LIybMJ0BSa62U3nzS7X
	 sHPokQQOE32DjquR/G3eGOojb6Edm2IzMgDrzDI7/oxlbx1xDufJaDxZYOekbT3cLN
	 zeSFBS3LSwJu3yu3EUEcOD2PGc/k8uJEJpHW90tP17dnN3tndfS0Twrn+Y8pZTkWxw
	 trKOpKKTF9yJg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5BCDE378148F;
	Mon, 25 Mar 2024 07:05:29 +0000 (UTC)
Message-ID: <b8c1b47e-941e-41fc-a3a6-8f68beccae83@collabora.com>
Date: Mon, 25 Mar 2024 12:06:04 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <20240307145013.2721326-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240307145013.2721326-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/7/24 7:50 PM, Muhammad Usama Anjum wrote:
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
> 
> Fixes: e382ab741252 ("mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index 61923a5183693..6099756e59b3c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -87,7 +87,6 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
>  			goto tuning_out;
>  
>  		prev_err = err;
> -		err = 0;
>  	}
>  
>  tuning_out:

-- 
BR,
Muhammad Usama Anjum

