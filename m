Return-Path: <linux-kernel+bounces-162830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA28B6124
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9345281F00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6112A159;
	Mon, 29 Apr 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="amzwYIlz"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB683CBA;
	Mon, 29 Apr 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415577; cv=none; b=s5TKqHFJh0MoNh2GkNeXPm4qv7saVxUj2RG0/LQHj8TA27/3dzejdj+XaiheW0JLv74xkEDzBuVqvdCQp1yKvTqFs6ZBTRNmklRn5l4nzI+Vp1dVD8HrEbCzGek9IlASfhthLqVWwD2n/SxH3wJHd/dmCT+TGsN2iIj0QyXNEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415577; c=relaxed/simple;
	bh=km++YSXFjLJWolJR5xpxNqeUcqNq1cJFCz/rYworjU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAw0SRRp/lJ/4TsrOkmpbjXMdCBO6UptcWnHrGgmAK53DlB4O2bq7hqdDG+/VmdNK5lyeaWa60YD7biVfcwgXdyqcK7vxQowx4t8j8rbqs8VvarZsHeZOJGdTatACHlHWX4auFS9urTivU3OKQY9362YjtluLyEa4j+AK7saCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=amzwYIlz; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1VmksUnBSiGtU1VmlsQI2r; Mon, 29 Apr 2024 20:31:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714415492;
	bh=2kpOLjd1RsRGoMgjZcS9EsszKwG0ZQhgAo+c26was84=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=amzwYIlzPbcKaAQJXOdD545sUIppqdGaR/8v1JITt97n7KazHFyAzCgHaFyuN7LWe
	 iOxrYE7qhUuW20IWvMWtioSxORH+y48F7Q3yy2cc5F8Ql6FpEHY36vMboQ7ufkO/3L
	 y5wn2hGZUXQFKtjaxzi9v+1LQWJ0BJMiS4rtAlQV0lV+PtY2Y2gC2albLo0NqR9qTL
	 a7xYq7aH5nQyi17j1wkrFAaJM6Ji3qPAjctofHLJqOOn5Nv78NuwmeoEpzOTULElV4
	 lWsBbCy/xzDvcn0ZjBZdOpSXbi3nLsrYiyD4aSiW9unMNxET/z90DHbWfn96WEgGvk
	 IZJdstbFJyloQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Apr 2024 20:31:32 +0200
X-ME-IP: 86.243.17.157
Message-ID: <d526b169-0385-4f23-8806-17bc73c2507b@wanadoo.fr>
Date: Mon, 29 Apr 2024 20:31:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: mt6370: Remove an unused field in struct
 mt6370_priv
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
 <16df315e-8a05-49a4-ac07-d1ed150c9317@collabora.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <16df315e-8a05-49a4-ac07-d1ed150c9317@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/04/2024 à 10:13, AngeloGioacchino Del Regno a écrit :
> Il 28/04/24 20:27, Christophe JAILLET ha scritto:
>> In "struct mt6370_priv", the 'reg_cfgs' field is unused.
>>
>> Moreover the "struct reg_cfg" is defined nowhere. Neither in this 
>> file, nor
>> in a global .h file, so it is completely pointless.
>>
>> Remove it.
> 
> Sure
> 
>>
>> Found with cppcheck, unusedStructMember.
>>
>> So, remove it.
> 
> Again?! :-P

Yes. This way we safe twice the memory space :).

> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 
> Anyway, this commit misses a Fixes tag; please add the relevant one, 
> after which,

Will do, but this patch does not fix anything.
It is just a clean-up.

CJ

> 
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>


