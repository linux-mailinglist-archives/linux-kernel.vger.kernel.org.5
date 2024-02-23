Return-Path: <linux-kernel+bounces-79324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A6B8620C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD391C2370B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFEC14DFEF;
	Fri, 23 Feb 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TV6rtj6D"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA22208E;
	Fri, 23 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732135; cv=none; b=DeDgG4Huduk2xwUk4iZ2B3U4rXuoGMs1AfV6OVGlz/nkb5kJ9XpnRVu7FLKuaxMVJRQBzDFw66el4rz/EhPsJEpEhZ3YW8b8fxIw9NWYDbhytT9MMNSj7ydWpLckNvUokd3IPpvUkNQG3ILpBmxxEHE1yUpg/BjbglyVV5VhASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732135; c=relaxed/simple;
	bh=fvpyRaZ+8TEYR8lMFo6J514kOiTCEMuXS85we5xIG30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO/yetuzSCL+UcndRkBoXy/B1IiR451sgMluPqkN4KxWADlwvgv8ltabW6QRrFQKzpqnfjAUVqUUt++SZWdMgBGPGaqRLersEuAtBNyxFsx1RI1D6uk5pKTGHJJywY4yxuchLKZaD+0pqyldixd2jAWLoNap5ZgRJ1V33VZZPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TV6rtj6D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ww5uExFoKbn25tdkVztxb4PG5AB6VVz88Ce+yCeXpJE=; b=TV6rtj6DxiCYBMvrbyiNZHv5IV
	1vkMZOguBj7eA7lJaovkFlyx5ncEW+P8L/vPDQlW5L2NLgEgWbdJDhetboeGlY3w29LyHcIDON1LE
	NEUNl61TciQvyyu76RRs89cALKPBGH00eb7zPRGm0YgQgHbRT+Hh5fA2rryzCA44WCu1ofyXRa2zy
	mdSO/7sjRn/s2W5Bewpzy7Vf7vu0gUObkCN9t0rzj2URB360ejM4Zom/1pVdXnDHlKM5eMjVy3u2o
	JqrXvH1Kssl8rJJiuLnswNdoUEumIHn5REhifHNMy7YoWgzkXXNSQSol62557fZqYgLs85bCrCIcq
	+I/kjrmw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfHh-0000000Bbrt-13lD;
	Fri, 23 Feb 2024 23:48:53 +0000
Message-ID: <c402a890-3282-4502-883e-e8937ed29258@infradead.org>
Date: Fri, 23 Feb 2024 15:48:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 23 (net/core/net-sysfs.o)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240223154029.18368677@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223154029.18368677@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/22/24 20:40, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240222:
> 

on loongarch, when CONFIG_BQL and CONFIG_DQL are not set:

loongarch64-linux-ld: net/core/net-sysfs.o: in function `.L404':
net-sysfs.c:(.text+0x2cb4): undefined reference to `dql_group'
loongarch64-linux-ld: net-sysfs.c:(.text+0x2cb8): undefined reference to `dql_group'
loongarch64-linux-ld: net/core/net-sysfs.o: in function `.L760':
net-sysfs.c:(.text+0x584c): undefined reference to `dql_group'
loongarch64-linux-ld: net-sysfs.c:(.text+0x585c): undefined reference to `dql_group'


-- 
#Randy

