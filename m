Return-Path: <linux-kernel+bounces-42289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CD083FF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014081F224FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70A4EB42;
	Mon, 29 Jan 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Yr5YsKEB"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AF2A1C5;
	Mon, 29 Jan 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514131; cv=none; b=KKA5Lg54cF/als36/7N+9Zfy2OwGdZYJHbuO8WsYegibzqaVXk8A+SVAuV8aSF0mKNNeeQzFsa15GFiAhecZNOVY1lv4wftQWmvCmc0imA75vxVQGWONnaszQ/lIWUPgfP6HUjsG/DjYkThYXbWnryYab6gBo2MM3qGfb1wF9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514131; c=relaxed/simple;
	bh=yQQDb/o4l6LtPL8dPnJpuMsw8Xm/OFfGdjAcl1qLjWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+ctfDO+RnDJEv7Fo7Eytr4iHgOL0AeGuLznJZJvVpoN8fxasHvFmb88QSl3Keg6gMT/7xXcQVgMwdshPqXdCtiBG351oHAQbht4YGCppjuyGjb5ph/c821SjF2fl90Xw3pRZGEktzDQw2+9ONKNrbS8YgZ7dpGvY5AobWXWPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Yr5YsKEB; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TNgH926mFz681W;
	Mon, 29 Jan 2024 08:41:57 +0100 (CET)
Received: from [10.10.15.12] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TNgH33mzSz684Y;
	Mon, 29 Jan 2024 08:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1706514117;
	bh=oXiXeQ4VP+sEpye87bHNuGWO3HZKCaSbCgqkPACpIrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yr5YsKEBjPDL+a1wpMe+Qv/yrgcXq4dFIG2g8vbTm3xptBh6GfnKgA63Dh8/gs5Gp
	 F91K4nvg+CLNr03tRC2OLXYnBxL99k8nwC/wlVZSaK72OFv1M3O+UM4647vF3fqXGB
	 1UCVn9IvYUgaryECIPRECSvsDpHkwQ0wVdrxqrwo=
Message-ID: <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>
Date: Mon, 29 Jan 2024 08:41:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: uhci-grlib: Explicitly include
 linux/platform_device.h
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 software@gaisler.com
References: <20240122082225.984523-1-andreas@gaisler.com>
 <2024012740-amaretto-unvarying-465a@gregkh>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <2024012740-amaretto-unvarying-465a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-28 01:31, Greg Kroah-Hartman wrote:
> On Mon, Jan 22, 2024 at 09:22:25AM +0100, Andreas Larsson wrote:
>> This fixes relying upon linux/of_platform.h to include
>> linux/platform_device.h, which it no longer does, thereby fixing
>> compilation problems like:
>>
>> In file included from drivers/usb/host/uhci-hcd.c:850:
>> drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
>> drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
>>    92 |  struct device_node *dn = op->dev.of_node;
>>       |                             ^~
>>
>> Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
> 
> I don't see this commit id in Linus's tree, where is it?

Ah, sorry, it went into Linus's tree with a different commit ID. I
should have referred to ef175b29a242.
Cheers,
Andreas


