Return-Path: <linux-kernel+bounces-105352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576B87DC86
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE941F216CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7FFBEA;
	Sun, 17 Mar 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iFobELxN"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0AFE545;
	Sun, 17 Mar 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710662026; cv=none; b=VfLheAtyAJRjTTKOZ7EB0jTA5hSjA7KczXKQPcYn8dAHGJ71Z0wyZYiXLGeLlAVTajvGMlmGoVfSO6gtK9UYi1Pd6Y6a9bRz9DmhJv9HNy1gNlfGVv4hXFut5KM1M73mhSSc423x4GP5+apncQvSiS1OpxbUV6k4KHQygKyksIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710662026; c=relaxed/simple;
	bh=4GCLP5j+q28ClbsWd7Y5pdV4tERPA8DZhk/va5O/7xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFtoG+06rYo1kizTDJfnt8hnguoErKdDC78nohkMRpHwXwt3eXdP1tD4RNdP3Ks0HcPfkOZTGkNxmFXnk7Il4Mq+M6DmiAS4/1Lger9yrwtsRM8GRtNFP7pLUo8ZliB9bMkoVVypHeFpsv9VQUbJdWBUtWxMeWuRPqk9LcemNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iFobELxN; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id llJjrmy3IRCtVllJjr5s99; Sun, 17 Mar 2024 08:52:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710661950;
	bh=/WCum13Q940uqRaUL47uOKBBWqUF7LZasYb5Blu5PPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iFobELxNiwY0F9sDp0SS8ZegyYMMXhA5CotHsYS3HXvEqf944vqd/AdlbYW0cAFDx
	 sFkPN6Ce4JTKJvVOwcF15evwan8z6XqslVe5eLBjHcwLj8Dc3rzT4QphNY1BbTH2si
	 GNSVGfsSme5mP03mGEX1jeKpfi2hRFEkdshPK7U41dAtWaWRf5+mZ6OKrmwKY6ZkfS
	 FViUI8tMOp1i5mbg8+bBjSMrsHa1n3fsjwy7d4exQaq2LlXW3rZCei5pAq5WGqN9xN
	 7y9Zz0rQczZf27n3bQ0uecVCnurbH8Ny4C85lwQEIRo1CvhHGtXQ+0oKbHMMevNtrL
	 jkHigegJqhDtA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Mar 2024 08:52:30 +0100
X-ME-IP: 92.140.202.140
Message-ID: <a1763e4f-cdf9-49d4-8421-f4cab902e277@wanadoo.fr>
Date: Sun, 17 Mar 2024 08:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: anx7411: Fix possible buffer overflow in
 anx7411_send_msg()
Content-Language: en-MW
To: bazilevich@sicamp.ru
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 lvc-project@linuxtesting.org, xji@analogixsemi.com
References: <20240316203354.81591-1-bazilevich@sicamp.ru>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240316203354.81591-1-bazilevich@sicamp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/03/2024 à 21:33, Grigory Bazilevich a écrit :
> Passing a size argument greater than or equal to MAX_BUF_LEN causes
> a buffer overflow when the checksum is written.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Grigory Bazilevich <bazilevich-vHv2KSI2GGSHXe+LvDLADg@public.gmane.org>
> ---
>   drivers/usb/typec/anx7411.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index b12a07edc71b..70ba56dfb22b 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -733,7 +733,7 @@ static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
>   	u8 crc;
>   	int ret;
>   
> -	size = min_t(u8, size, (u8)MAX_BUF_LEN);
> +	size = min_t(u8, size, (u8)(MAX_BUF_LEN - 1));

Hi,

with "min_t(u8, ...", is the casting needed?

CJ

>   	memcpy(msg->buf, buf, size);
>   	msg->msg_type = type;
>   	/* msg len equals buffer length + msg_type */


