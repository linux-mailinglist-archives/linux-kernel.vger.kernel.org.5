Return-Path: <linux-kernel+bounces-54582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4CE84B117
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EE1282D02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EF12D750;
	Tue,  6 Feb 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4NSspz4x"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1A12C541;
	Tue,  6 Feb 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211446; cv=none; b=ssVLGPJf1jFvH3ZBTUkLLDbSYxp0M4QYiIxXAAAjZ3o8/1FoC7CkQotJXpwA94eoiNmx0Pk2/tScPgmSXVB8TgCNftOBox+xEnaVT2LIIngociWRRnc2KEvjQJ75NI/HXF9qP140tb0Q5FtCzh186iEzcaEBBR+9LdQP8+AXkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211446; c=relaxed/simple;
	bh=5YvgUqR61QNjvLXdS55FaX2N2Q7jHdFaH5GUQL62KZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7BgZJ8kFV4UnzN6+M9Iefoe13/NQPFmv700BudEYtFnOEJmbnQIhcaXeDH6K0ZaLm0FIKC1DtkLB1wpi4NLrIzQlFt9WoY5ygU4ihiMCxcMIW5wao1udFU1giP7BnTkVmkHQhJQkW6zBJaKKgZHFtEK/4UqT7ODniiuS0TwTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4NSspz4x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707211443;
	bh=5YvgUqR61QNjvLXdS55FaX2N2Q7jHdFaH5GUQL62KZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4NSspz4xXg6LEVrBIlDgheuDmBBoXGi39H8gT9MzESdQR4gzeVP2C0PkXzQTgiM1I
	 9CaTnVrim/1ezdaqUNH3EMRlkWA4YWDh9xmVxaU5QgFLZTtwbF96cOg+3Q1aHhZ5Jp
	 qWpDnh5r/3EsiPM7YG5K1oZOrju9bR2gt5B+P+X+Agxncasic+/kN8p1R6ZJrQ+wJd
	 fIWWDU9mzwthw8JODnUjvoP8odQkQnzKVeerBML3eNEpI7kYEFeMjfPvfvFzzdprTF
	 xTvi6M0o9GkKizt/T/4XP7AkMjR5uQtv+7IAtKuVx6yLcpkS4te0R48mUMMajDg6Z4
	 Cwj63bdYjq3EA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7925E3782051;
	Tue,  6 Feb 2024 09:24:02 +0000 (UTC)
Message-ID: <cb85caec-d2e3-460b-a9ab-90ef9aacc2ce@collabora.com>
Date: Tue, 6 Feb 2024 10:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: Use
 devm_platform_get_and_ioremap_resource() in init_scp()
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
 <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/02/24 17:31, Geert Uytterhoeven ha scritto:
> Hi Markus,
> 
> On Mon, Feb 5, 2024 at 3:23 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Mon, 5 Feb 2024 15:08:27 +0100
>>
>> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
>> ("drivers: provide devm_platform_get_and_ioremap_resource()").
>> Thus reuse existing functionality instead of keeping duplicate source code.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
>> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
>> @@ -441,8 +441,7 @@ static struct scp *init_scp(struct platform_device *pdev,
>>
>>          scp->dev = &pdev->dev;
>>
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -       scp->base = devm_ioremap_resource(&pdev->dev, res);
>> +       scp->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> 
> Given res is further unused, please use devm_platform_ioremap_resource()
> instead, and remove the local variable res.
> 

Agreed: res will never be used.

Cheers,
Angelo



