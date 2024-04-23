Return-Path: <linux-kernel+bounces-154409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 643788ADBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E4B22AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF4214A8E;
	Tue, 23 Apr 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="e5JPVt6A"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933B12E75
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837482; cv=none; b=TmpVNnwpiWaQtQJr3ItTrv/t2mvkUYBs4E6llCspIJlCqQtHGC6imyHNzEFkfH+gCw3naBryF7OD7taz72FnNTcCqa4M7ElH38PiVIenzxjU718fmFKeYrTbzSCSqh2sC7nmnr/WOyLPcIoOj3xybciSMy6eoPJZBGgyDkAR54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837482; c=relaxed/simple;
	bh=CJ71Y+MJUKayvYKARogr2qdM1s0hARKWITmO/LkeVf0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Kxxv5/ZWMnXLeyxesGgD6gQM0pRgEtf1tC1/Z0T2j0GYAQ0a3odA4+UXk71dan/0qfQHGzpyUoyoj1evm0TjSd2/pF7nKedv5ldjufZxyr4wMwldfnQt3GF8OCSB/foVa4/PEW6anw+bU7imraVQwdGPwmnsS6x2etrYAw5J1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=e5JPVt6A; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bul97ErRvzV3DEAlBOTlUwNj8ZWcrdoMSwdc5QbKf4Y=; b=e5JPVt6AOEFOGeJebDZ6fC+8Km
	LPdb5gTTwvqBC2pa2kjslEmbpK/IIXYSe7VMrxrKllUUn8nvffIL47c3y647iDkN/wj0hGS51wgsg
	+1x9sOdxjZfq9Vo5lqh6a7mwCGtKEKqjL4cUtefaLek0SO+84+j2woMhr+bAslRHsh1Kh4ovQ11vX
	+Izu6SSHA4dL0dRx7DY9aee/sLZ8zIIJm/D3tc3O1QQ5SCywvexxSQRX38ynG9BNkrQSiqdwYS5ul
	6ylPIpfH/K2ktB8jd68iigbS43wdE2Ox3GrQKqlmK59U+lNA75I2nKSw90KpBcWlZlVts6Nn0BDm4
	WvhuCDOQ==;
Received: from [2a02:fe1:7001:f100:501f:16b8:2636:f4d7] (port=53794)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <B7T@malaika-12.net>)
	id 1rz5Pr-004rE8-Ht
	for linux-kernel@vger.kernel.org;
	Tue, 23 Apr 2024 03:57:51 +0200
Message-ID: <802fa134-98c4-4a14-bdf4-26028e2e6366@malaika-12.net>
Date: Tue, 23 Apr 2024 03:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <B7T@malaika-12.net>
Subject: Hac translated: Tru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A native form of (Al) Hac, that I talked about in previous mails, and 
that is known through "hacker", is (De) Tru. (For italic script).

Everything in computers can really be designed according to Tru.

See also my channel for more on this topic: 
https://www.youtube.com/@Ywe_Caerlyn_Samilands_East

Peace!



