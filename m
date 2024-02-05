Return-Path: <linux-kernel+bounces-51960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0900C8491F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455711C21C53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201FA94C;
	Mon,  5 Feb 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lbHNT8Z1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17539474
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707091461; cv=none; b=LFCNb4uyb/tVZL/Q9kWc4IuGnyaDlMj7EReEwPsXdqAez4LGYrD8iMXNCO0UlnfEcdKbNH368Crn6v8R3OGzMLq7+F4RUzgAkZqEBzKC0FhuGYHoAsMETvuc8NwHpFuYIEHmB6eQ9EteVENpRiC5WnJyPtNbuVjIFxNYv8xszeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707091461; c=relaxed/simple;
	bh=SCetIew51dJbYcIqSnrPHe54RgWCSP6GOCbrfMIMgbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8682crsdYchIgPpbuj/jImRxebvsn7aBOoJO3PyP5qcLrFy88ySHW8x8/edZUx41z7fc/La9fNEPLkQhh/n+Bk7lCyadUirMF098GNNnT7ExqTbL64UORc/EfihkstsqVxb7z46HTaPjkokdQlWuDaPGh40zeQ9jMRUikKRm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lbHNT8Z1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=3TPBEhVKkUi3MUXWKbW5M7J+VojJA4DV60zXIZ2deSk=; b=lbHNT8Z1K4U23/zJsje4Uur+Yy
	5Fpkv6IB6bHVR365sc74jef3XaAdacZeWtTkgsg7x45muIOQcDLImbE8bkdxHtLKRt4ibzsuWKON+
	c3SHV1rK0ypmNUjLoTM87vjZe4GGCD+EwIIAZv3xpny9oQySRQAZHPTEAyNNccLi3OMAILmpq1kpg
	QnlA/BJbtS4NEyb7VJv9yvTba20pWnwjncoZ2zqIUMUA8lWxKDXm29z5s3D4mhtRQnn40LeQezjn3
	7VG+UdGabOUTeDppM/jbw8s08eyEY7ljGabb7ryaX0d2w/KW/TmBoqeji5RxjWDa5QtQdpboUSbf8
	DJRld2CQ==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWmT1-00000007uaG-3GPX;
	Mon, 05 Feb 2024 00:04:09 +0000
Message-ID: <04c1b434-2ae6-401d-93ff-61641e1396af@infradead.org>
Date: Mon, 5 Feb 2024 09:04:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] powerpc: ps3: make ps3_system_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
 <20240204-bus_cleanup-powerpc-v1-2-c763f0e142e9@marliere.net>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-2-c763f0e142e9@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/24 23:21, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ps3_system_bus_type variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.

> -static struct bus_type ps3_system_bus_type = {
> +static const struct bus_type ps3_system_bus_type = {
>  	.name = "ps3_system_bus",
>  	.match = ps3_system_bus_match,
>  	.uevent = ps3_system_bus_uevent,

Seems fine.

Acked-by: Geoff Levand <geoff@infradead.org>

 


