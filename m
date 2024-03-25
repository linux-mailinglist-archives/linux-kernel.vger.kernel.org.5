Return-Path: <linux-kernel+bounces-116612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FE88ACA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E99BC6CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52469171648;
	Mon, 25 Mar 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L1XJVgXc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC417CF43;
	Mon, 25 Mar 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350379; cv=none; b=sG/CjJJTUmpMf/YuA1och0dqluAlEXIq3PQazRvp3b27ExVBHAh5cfsm96Lr3de/YtOFUWWv5UiDVLTwEdOmY0QDCwJ6XHBbRnAYz1x5AUUbyihjbD5uYIcVSBlRueLN3QbpYT6dptgeOKwgh8l/GaWQQqyaNpwq/k2iJfK4GY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350379; c=relaxed/simple;
	bh=UnJmAUKiIFvvVzhuuUMdBwmvWI6nUYnN1WCwaHaXsA4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SZOiItpRFNUvU0xIS3F1HTgrE9JrR7LeGWjw8lKXWXpxyGaapzfOFKrqTQ/kO+g1BVdTTySeAmTgz6bLMQ7pKHTvM5BUK2XTSKYwUnVqNyU0mEBLgubdL4buWbZwUS3pqXTG5LlVuMwWgKmpRBzIMcSk/elrcgwd1PJm+Vi/bPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L1XJVgXc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711350376;
	bh=UnJmAUKiIFvvVzhuuUMdBwmvWI6nUYnN1WCwaHaXsA4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=L1XJVgXcQwyzjXISr825txTYD/1dy/5wMMxehWso27qqqzC/sJfbNuR56ImLLRS99
	 bpIlhWyI8g7udgyzfyIWfj3IrujDQgzxVweZnxMz1L3+QTkYC9x3KoWzshAwmpfZzf
	 kFWH560IRrMxuG4qxMy5mdHRC3urdhNOP9nHkW/0eiEQX0r89lrAwLJ7wOwm65EnZG
	 AYnsB96Ay1kRZN/GAiWi25GEOvm8hJpgFvLrHJColMm6dn/aHJUcsU/5kqk0IhPPWH
	 3PBJP9KETwdoh3lTlmA3BfQ+ZtP3+EVEg8HVfICSbtpFkSwQL2Q0wMl7s0zQVBCXDk
	 H+Quzt4Z9deAw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A4A2378148F;
	Mon, 25 Mar 2024 07:06:12 +0000 (UTC)
Message-ID: <dad3dad2-11ab-4bca-8bc6-1b23d97cc887@collabora.com>
Date: Mon, 25 Mar 2024 12:06:47 +0500
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
 Ulf Hansson <ulf.hansson@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240307122129.2359553-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/7/24 5:21 PM, Muhammad Usama Anjum wrote:
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
> 
> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> index 989ae8dda7228..96af693e3e37c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -133,7 +133,6 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
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

