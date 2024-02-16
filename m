Return-Path: <linux-kernel+bounces-68951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D0858255
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7A01C2199B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637B12FF6A;
	Fri, 16 Feb 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="JmAQXqBD"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5E78B5C;
	Fri, 16 Feb 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100566; cv=none; b=K3MTbWNQTXUN78ZDNBmINYexHxnocEYBYY8SZ9x+632ZfkY0O2iWhg8ih+WlAiqNTj2xvGQk+B53zcUXsTyS+ChtkR+zvkqT4c5FQqJ2nUyNnX9eutmmFqv1u6id0OiaAobBsWdumkylw6vl7EsqKz7hINMZmeTvpQEgVsIvyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100566; c=relaxed/simple;
	bh=tqZk/F2kUUs8KKNbAeHCorX3lc0ZR1oe/NUwF6XZTYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ou9EblgETJu/dERob1fS/LPpL5IAYaNmUUlVT1FmJ7aMSfIljKTGH1zi/cjleHF59UdEmVbqX21dzIj0k4g5lKL2MezpHZzCx+dLblsE2kKmAt4yoYeTPyz0GDkjcd5DdihDm5ujs+90UFeQnMR85wyCekWauGE8Sbuk1YwUtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=JmAQXqBD; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tbxzl0DQHz681Z;
	Fri, 16 Feb 2024 17:22:43 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TbxzZ0013z681w;
	Fri, 16 Feb 2024 17:22:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100562;
	bh=wfmhXnx49BRBtPMqtcbBb/ZIo/Mc+0byxiHLNwHcVYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JmAQXqBDj1O81hg+7U5kPWKb7bWgnBRlgs9Boc1xKDUP4trOyNjzL+MDjneNaDGCc
	 eWog6BF8NBNNS2e1LJAHi2dkjli6z4W4GX2kd3nh3Sd7cOa19KeaOb6lFCUsyTxJ7k
	 000GbsrmBreIyYMiHxdL42FbGX2K5TsCyGEi/PRo=
Message-ID: <a9515355-3708-47ef-821d-9e95310b89d3@gaisler.com>
Date: Fri, 16 Feb 2024 17:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sparc64: NMI watchdog: fix return value of __setup
 handler
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Igor Zhbanov <izh1979@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20240211052802.22612-1-rdunlap@infradead.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240211052802.22612-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-11 06:28, Randy Dunlap wrote:
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) argument or environment
> strings. Also, error return codes don't mean anything to
> obsolete_checksetup() -- only non-zero (usually 1) or zero.
> So return 1 from setup_nmi_watchdog().
> 
> Fixes: e5553a6d0442 ("sparc64: Implement NMI watchdog on capable cpus.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <izh1979@gmail.com>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andreas Larsson <andreas@gaisler.com>

Applied to my for-next branch.

Thanks,
Andreas

