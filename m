Return-Path: <linux-kernel+bounces-18916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFD826515
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFE51C21156
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2213ADE;
	Sun,  7 Jan 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xWzza6Cq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD813ADD;
	Sun,  7 Jan 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=zfknrnCeFYxSjd2vcVFKSzQu+I7SQi+JYtABfxA+FSw=; b=xWzza6Cq/XLZ/FsfTLjcpG5Njo
	cgv6dcceX/MFIKqdl8iHc3Oxgf7xEEW72jo8J9xrnu7bk9zAKaeuOKwL5GxlWgpwajejRvsfei9B3
	MQPdPoXnZswLA0cGHSq3W9a9urUo4LFqQY1NMbUeiFo0f/vCGax1lpfsncZ78eJu3X7oxWiF7iSwg
	NpTvFszsgpmAqOQiQDIKkYlZoKr7Qm2iG22DeqmlVRcq98DZfoWw7BYeZG37wjppGyBPGjpvnpMbY
	O73vr0PnTli3ULMW11/sXB4cghZOFjjAQqz3AjL+Bn/onGnw3cu61yTziS/Gfu2mf7E5PMAr/skjJ
	cgmps7aA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMVya-003GT3-1C;
	Sun, 07 Jan 2024 16:26:16 +0000
Message-ID: <7b840061-83a7-40b1-9220-309841b73c34@infradead.org>
Date: Sun, 7 Jan 2024 08:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mouse wheel resolution with kernel 6.6+
Content-Language: en-US
To: Klaus Ethgen <Klaus+lkml@ethgen.de>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
References: <ZZqwmckYIS1rLEAP@ikki.ethgen.ch>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZZqwmckYIS1rLEAP@ikki.ethgen.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[add linux-input mailing list]

On 1/7/24 06:09, Klaus Ethgen wrote:
> Hi,
> 
> I have another minor issue that I don't know how to fix. (And even don't
> know which subsystem creates that issue.)
> 
> I use a Logitech MX3 via bluetooth, which work fine for kernel 6.5 and
> under. But when using kernel 6.6+, the mouse wheel dropped the
> resolution to not usable slow. Scrolling is not really useful that way.
> It seems to me that only every second scroll event is forwarded to the X
> server.
> 
> Any help to identify the source of this annoying bug is appreciated.
> 
> Regards
>    Klaus
> 
> Ps. Please keep me in Cc as I am not subscribed to the list.

-- 
#Randy

