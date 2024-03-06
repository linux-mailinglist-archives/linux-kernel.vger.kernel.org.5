Return-Path: <linux-kernel+bounces-94599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580378741F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E5EB22387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119171B7E4;
	Wed,  6 Mar 2024 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="dktCrTT5"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAA17551;
	Wed,  6 Mar 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760386; cv=none; b=oVHBIR103UlvetRyiLN/DKw4geOzYZMkJi8YFa6iU1mAiIgCsQjWumVDtCxalp+7UNKnc0Vx9IzzJB3q1Z6qst7BwPaS+Kcf8lmmG4djdny9GPfrdYeT7DkGPGFNcCpBQEgh9DC5JPGi5SivyIC4eH9kFi9mfyeClmVnq4zdPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760386; c=relaxed/simple;
	bh=TAf1pRQeio8PGirhTJ/v9sVTyJ2rY4AUL7DL/3h6h6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuOl/LgA2T0koTpN//tGK2hobc56np8f01HoPCOhtd5PWAzRztwnlZNOwRy023cxhAa5jyE8pzCEaVeOTBx64iWCOI4lX3A7xN0tBJDJnaMkbHwni5+yvU8KP4LPWyKEGMj4blrMVCfnRzYQQFBDM0VlSmG5kKeyvAw7SJV6Y10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=dktCrTT5; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090] (unknown [IPv6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C5DA3C0262;
	Wed,  6 Mar 2024 22:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1709759883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6EoaRUYRdAw9zhTwqjWYmGJYJ1LXHupz+LKqXk4uSk=;
	b=dktCrTT5smPivI8dgB0tObyd+QQ/MW+iFMDC7yhW+1WBFrgxvZb3fnQ5h69aoRxmB/2Und
	IjIxObkTotjImETJ8BKbLKzBUWPIwfl1orjJLtHFxDtgK35LBgpsCva3Y6QFrFQvscUkrK
	mC88s7K3nDTitGCetXZU2UiOiY0e/jVKf8F/egmPOuE66DkvyBT/vl14VjjmqnrX3znTCJ
	qcRA3M4gSH2CFSrKOcMXb+AygZBs/skxWRtuiTPKbKrPDF47YehKjKEpukgn1YFgckudsr
	kiufWBrePy6MubUjBJnaEO0CQUrp7BZS/92pcuNDoScMfvEXwHwUFRUoCanhcQ==
Message-ID: <1fecf8b1-68d2-481e-a5cc-1c8f53489906@datenfreihafen.org>
Date: Wed, 6 Mar 2024 22:18:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wpan-next] wifi: cfg802154: make wpan_phy_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240305-class_cleanup-wpan-v1-1-376f751fd481@marliere.net>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240305-class_cleanup-wpan-v1-1-376f751fd481@marliere.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 05.03.24 20:55, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the wpan_phy_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

