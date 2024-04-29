Return-Path: <linux-kernel+bounces-161838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2BC8B520B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F41C20DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90C13FEA;
	Mon, 29 Apr 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XOChPBrA"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880F1171A;
	Mon, 29 Apr 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374780; cv=none; b=BjPFES2KicmC9R98Th/jWsMXIk68NRdEZQ1Kd+J1K3wMMR1CZrJUgk1chY/30XTLzr2VsYYYpyEo+tbt9q3vq6dKh+abun/cCz8jBYAhskLgIrO54ZlCGFrv5rEOIGUl+6T/asUXZQz1BPGRYsQRbwASzxIsU27ZB5M4+QRFlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374780; c=relaxed/simple;
	bh=cKHaXt/I8WPuopNGGK37DV9Mh3drbMUoA92wfwM4SNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EUdzEk6wwWjJRznvDhgacnYceVFgKpTV1TUqwjPczqKEyg1nTd0tO1iUw4hr+5N9IMNC7xIOGOUxtUovgmcH/Cxf3ZvZMXn99cIFdVzWVzHQMdvpvaivOyL0pmR3YZRKBDVCFCShD60IJqbUrWU6rLsXFSTgnTFLQ1rsoLWTqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XOChPBrA; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714374735; x=1714979535; i=markus.elfring@web.de;
	bh=cKHaXt/I8WPuopNGGK37DV9Mh3drbMUoA92wfwM4SNA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XOChPBrANaJvzlQiToMYqVWv6qNpwgignwvtIKGVUMKhfqguMh5MrvFUVRzqDvlw
	 KqoDcOzszQisixUQG+5ZnB/tWuztzYVe4xfg4TBe9MDzD5FTRP8dDUanqA23duAcr
	 mcCQObUZftTpfxLBLXU0Ja97krz1qup5q+t+IyuD9Phq8QMTH0SPeta037iZQLT3A
	 gr4rexBDVHi76BovifIZxEH+SB/we1E7AO2QQ+prNpU63C2OUqrVCjYRH1zO+ky8o
	 uymInGv8rBMTSssBgz8GqXO3UQmiGVYi4DmX/c/FCys8hU3cQYMiryKoqQj/CtAwo
	 NVwYqnsu0wH6jVAyag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Ij-1stapZ3dt5-00yCGV; Mon, 29
 Apr 2024 09:12:14 +0200
Message-ID: <a7db79ae-71a4-4d73-a7a3-7bd19f8e57ba@web.de>
Date: Mon, 29 Apr 2024 09:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangkaiyuan@inspur.com, kernel-janitors@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240429024547.27724-1-wangkaiyuan@inspur.com>
Subject: Re: [PATCH] mfd: axp20x: convert to use maple tree register cache
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429024547.27724-1-wangkaiyuan@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+ex+6mR/cmisVHjn8CZ7fbSTvZxd+aUYo9nwceQUXzdy5MSYEFT
 W03K7xXgx/QInLXQTbToUWUtyplK8/l1y7ye2DxEryr17BDQgJYsv75l4Ojp1IR/slT0Fza
 /2mVTVyHTcRdtjl0o+p4EKR2+qo7mUt1U/YnDERPiKN6Lp5KrocreJGSs1GJTQgwrwqUnAb
 bQ1fh5C2kjfXy9gDLRn3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IOWEFONViw0=;skTsCsuHzNzLV0ykAw7JqW+9vrM
 RthpdFBIl7VRw54gmL2DnxATPU/UEzT1bApXvK2zn1+mP6ddtVQB6PzA5EpYTUznD4raK9yTw
 /1nnIMR1lTkxuLeNKU8k2q2IzCnseDwlfZbk8z4CYAZXlTRHSUKiDDFrQcPLhldnTlSnYkWCP
 mEZWr0DDMt1tlWeItw+6mslaIRoru0H5gP/0XPPQ8G1hbD6RDsZq8ChuJGrDHsnssD3VNF4cO
 Eg9h57ETPkJ4p8+siO59hcE0dYrmesaRtWskZqcGxXqJZSV6JWHdCytdGWlyJaXPMt5fjZlCx
 Woo/+76HMfPgrQNCeOcVQ8RV3kLvifr9MHbOTJtKsJps0BZLdK2Y6xxp63oHD1+spDmVW5TkK
 BuBWzC2t1h49SimDYw3WOZCWlwtQATfbdqoFCU/D2aZwGkWMPOdysl8P3LFNSxYs9+kIVUTo7
 TnQmMv9lVypS03YLObUyZeg9XuNjgZBwUsuE331U4QIbKqqrSReRM3/ZRy1pHG0K0VI1TdnWo
 d7vKslbQ/qcCIh4ETFcYPMv69FeHRN+/1T3Vp3/sUdvbXOwEiSPpYNJCBw/N3QFO4Krqj+6T4
 ZG3RaWlzd3YJyMehYXIYVtfqjkhsMEMSofFR2K7gp6aVxNXP0AUbPY+pGzqt1BM6945SXvC/x
 o1yPt3NgZzTIukzrbpF9sT1DGAiMv82wCX27lEHhWTOXFSY98EZbA+mhD5lVnHwZHCqsMU5E3
 Aywnr9gEkwVc8UOOdK1FTbwgYxdAvwbj7l0/M/Yi396BFG51eIIND1hZG6ug0NjfTRJ4kxiTX
 zd8yh9N4r5W2soOryf1PDSgD1zihJA+t4h3LwA6BH7Qi0=

> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

Please choose another imperative wording for an improved change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc5#n94

Regards,
Markus

