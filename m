Return-Path: <linux-kernel+bounces-83055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBA868DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B931C21BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3161386AE;
	Tue, 27 Feb 2024 10:41:13 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9A137C42;
	Tue, 27 Feb 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030473; cv=none; b=DKfU4AqXeCpPRzTcf+V8y7Q0zxPWUDMzhrzA3NRpOB1Z/uPJdLvD5GvD1eUN1GOAfH+bdR5qRYMbjh6pazpMKj80cTtG6dvE06lcYBeaSjx5ZnJ0wEwkrJIXFnIxvvoNYLHgxeo0puhc8kq/wpYtaqledr1dbz/Z6Plp0PJAVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030473; c=relaxed/simple;
	bh=J79JXDCFEJwPkXuTgqB8uIX5pHk+fGXFL9Hae8qVtPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvdICkVH2SwfO7sRW2sd7oAgGFiToPj+fwAZfCqeiZVuu8x7YWLlkzQWGtgRj72vOUXCb9Nyzr+pVD1LU2zVPbYFtN61BzJHbRi6NkW1HgcWuu8/rMss9zbcuPnqpwTYiFPQ3PYaOQ0B6NcqfdgZNWQ6iOBRpTuoRbKKl161n4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 01A8E61E5FE01;
	Tue, 27 Feb 2024 11:40:53 +0100 (CET)
Message-ID: <aa8a77b1-58ee-466f-90cb-40190fbb157c@molgen.mpg.de>
Date: Tue, 27 Feb 2024 11:40:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240227102914.8341-1-tiwai@suse.de>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240227102914.8341-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Takashi,


Thank you for the patch.

Am 27.02.24 um 11:29 schrieb Takashi Iwai:
> Since dracut refers to the module info for defining the required
> firmware files and btmtk driver doesn't provide the firmware info for
> MT7922, the generate initrd misses the firmware, resulting in the

generate*d*

> broken Bluetooth.
> 
> This patch simply adds the MODULE_FIRMWARE() for the missing entry
> for covering that.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1214133
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/bluetooth/btmtk.c | 1 +
>   drivers/bluetooth/btmtk.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index aaabb732082c..e5138a207f37 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -420,5 +420,6 @@ MODULE_LICENSE("GPL");
>   MODULE_FIRMWARE(FIRMWARE_MT7622);
>   MODULE_FIRMWARE(FIRMWARE_MT7663);
>   MODULE_FIRMWARE(FIRMWARE_MT7668);
> +MODULE_FIRMWARE(FIRMWARE_MT7922);
>   MODULE_FIRMWARE(FIRMWARE_MT7961);
>   MODULE_FIRMWARE(FIRMWARE_MT7925);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 56f5502baadf..cbcdb99a22e6 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -4,6 +4,7 @@
>   #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
>   #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
>   #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
> +#define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
>   #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
>   #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

