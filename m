Return-Path: <linux-kernel+bounces-105818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B903487E4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495DEB2155A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A22577A;
	Mon, 18 Mar 2024 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bit42.se header.i=@bit42.se header.b="BIPBhtVi"
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E208DA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750761; cv=none; b=Ks7QQYhNYBY04+Txr1lUkqo4HPjubS+A4r+9Wsi3Ml17ih/hQkpun1RN9XfNOBJ8gCTKc25q6mT7ZybwPCpiOU1TmRcrbqE8G01aF4oqcKpGWm8v/ZD4l5VM+V+N7JMNeFNs7qHYLXxmiudZ9YD7vzb7b9cn2TMHuaS5U9jsmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750761; c=relaxed/simple;
	bh=ZLLRwKv52FwS71Q9TRUs3pSjcDZEBliufyAc0LAPBEM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MFi7ed/eU8/griinvUUeTjW27HxhHxY3oSuxrpif83AGR6hGD73b9pEWfMdC9SqPrNWybN/s+lGNMpUxe3ym5JgfxiJVe8pgU0+xSrT28oYxJAVpUbDwoF6hQUaVf2mkkIW1COhmUg8cqInqU+Yn+IOjPj4bk9pyEKq3TPkLhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bit42.se; spf=pass smtp.mailfrom=bit42.se; dkim=pass (2048-bit key) header.d=bit42.se header.i=@bit42.se header.b=BIPBhtVi; arc=none smtp.client-ip=93.188.3.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bit42.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit42.se
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 6FF8F2FFDEC9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:32:36 +0100 (CET)
Received: from s979.loopia.se (unknown [172.22.191.5])
	by s807.loopia.se (Postfix) with ESMTP id 5F8482E286A0;
	Mon, 18 Mar 2024 09:32:36 +0100 (CET)
Received: from s470.loopia.se (unknown [172.22.191.6])
	by s979.loopia.se (Postfix) with ESMTP id 59E2710BC3B2;
	Mon, 18 Mar 2024 09:32:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.21
X-Spam-Level:
Authentication-Results: s470.loopia.se (amavisd-new); dkim=pass (2048-bit key)
	header.d=bit42.se
Received: from s981.loopia.se ([172.22.191.6])
	by s470.loopia.se (s470.loopia.se [172.22.190.34]) (amavisd-new, port 10024)
	with UTF8LMTP id o87pN2BTdgsU; Mon, 18 Mar 2024 09:32:36 +0100 (CET)
X-Loopia-Auth: webmail
X-Loopia-User: richard@bit42.se
Received: from webmail.loopia.se (unknown [172.22.212.9])
	(Authenticated sender: richard@bit42.se)
	by s981.loopia.se (Postfix) with ESMTPA id D152422B1705;
	Mon, 18 Mar 2024 09:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bit42.se;
	s=loopiadkim1707482520; t=1710750755;
	bh=sCBjdIljVl7n3SHU3VSHSE5xRH6DxbvTSqyd6NrP4Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BIPBhtViO6u+7532rWxsm4A8kN5iHpcMJQmKUmm4T0DbSTbrmOsOAXxvEEUM8mWBA
	 uS673T4dsOoJhy/0PBA8vGhacriKPT56XkxhWjtrB+y1s5iQyaOQkzMGCYGm52biKK
	 MBOV5pIaqqdoIdLdtrsBv+Plr9fFYE9M3EGxPNdBimxFY0RGwVOvPSoEVJXHdV7Shu
	 H8ZQGvXbNpWTnuiCNppfi4sbyGTulykrRaVr7GErKLWVAyBnFhsWBpWSC67Eo4HaGp
	 WOe3LMo+PwZOlR2IYfveUEQb3dDq7s+uDrZYzIux13/07cHMZRlz8dwOJZ4W+l3VNd
	 lpqUpTcl1Gmkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Mar 2024 09:32:35 +0100
From: richard@bit42.se
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund@ragnatech.se>, Michael Walle <michael@walle.cc>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] nvmem: Remove qoriq-efuse in favor of layerscape-sfp
In-Reply-To: <20240316002026.1808336-2-sean.anderson@linux.dev>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240316002026.1808336-2-sean.anderson@linux.dev>
User-Agent: Loopia Webmail/1.6.3
Message-ID: <6f5636e65df5616395cc8e24f63b09ef@bit42.se>
X-Sender: richard@bit42.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-16 01:20, Sean Anderson wrote:
> The qoriq-efuse driver is a duplicate of layerscape-sfp.c. The T-series
> uses TA 2.0, while Layerscape uses TA 2.1 or 3.0 (depending on the
> chip). Add appropriate compatibles to the layerscape-sfp driver and
> remove the qoriq-efuse driver. I did not add support for P-series SoCs,
> since they use TA 1.0 which doesn't share a major version with either 
> of
> the existing implementations.
> 
> The qoriq-efuse driver does not properly abstract the location/offset 
> of
> the fuses properly, instead exposing the device's whole address range 
> to
> userspace. This is not appropriate, as the fuses only occupy a small
> portion of this range. The layerscape-sfp module correctly constrains
> the nvmem size to the fuses size. This represents a (necessary)
> compatibility break. The qoriq-efuse driver has been in-tree for around
> six months. Hopefully this will limit the fallout.
> 
> I would appreciate if someone with access to trust architecture 2.0 
> user
> guide could confirm the number of fuses.
> 
> Fixes: 0861110bb421 ("nvmem: add new NXP QorIQ eFuse driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
I don't think Fixes is appropriate here. Apart from that:

Acked-by: Richard Alpe <richard@bit42.se>

