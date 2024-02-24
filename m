Return-Path: <linux-kernel+bounces-79362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A3862133
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C191C234CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7610E4;
	Sat, 24 Feb 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2bLBwXkE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC84691;
	Sat, 24 Feb 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734484; cv=none; b=gS4nyqvTNouiI29cTFwp39FO01g46DPKyxMlZLROej4fTtq6JEJo+U8HHmrxVk5liJrIiDnPRO/TOzIrLxCu+NiuhVlYhKBZWC119tMgAuOQlADWiUwxZQMI+DKg/XdqcQe4rQigzuI4qzBijDTdvF4K1/BbDHJFt7n3aeUQb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734484; c=relaxed/simple;
	bh=NwR9fscsq/Z9wph/cvnBMUgbO/ZBDPfWvW+2MzOwJoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMwMaLAjM65wZRLuudiVdBRj6GEF7c283ydUhjjEnGDIw5IGsU14U+S0LHPImMM/S9mG25reBKgJDTtgqeX0VBj5h4acFbs+3DBpFcgD9BWNTweBwAxXDoXQvSdrkh/LSGJELr1/sntock7rA3X3ABRhwPOu6y8RSTwijCZtAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2bLBwXkE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Fe3seCHrpz4BgKtTk0jHwfPx3F5LHnvSlEG3Di7kPQU=; b=2bLBwXkEbDtOsycM0M2GYB0TeS
	I1CdcrPwYqSMQBR3+w7my1zhJpm5CDWWbWNxWCCeHHJyaKqZX7b1u3004eLm9fKYv1xK7uTRBC3al
	L/idDKIHLNI4ccmzY8lpEAjZud89uXMhi+XH0ZfOIdDfDu5D9QSqLO3887ZQCjg2x/ZFuTqa1hvgD
	0rKHqHqebcUhkoUaKfUMcl9236RE/+OP3tmVZbbsNCPAvCHVjpervgb3pO2N6UYBsf5juJrijiiy6
	4JSFwc4EbgJDShtRheMjpFRV6nXxRzgy386V4hP8G978CfXmMkXAfCgNQXVDEX4qmyvSy2zb39Xem
	uWFgY6oA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdftV-0000000BgUh-1xbk;
	Sat, 24 Feb 2024 00:27:57 +0000
Message-ID: <d2c68134-6e61-4ef3-b03a-4a4884960959@infradead.org>
Date: Fri, 23 Feb 2024 16:27:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sparc32: Use generic cmpdi2/ucmpdi2 variants
Content-Language: en-US
To: sam@ravnborg.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-1-5c60fd5c9250@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-1-5c60fd5c9250@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/24 11:36, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Use the generic variants - the implementation is the same.
> As a nice side-effect fix the following warnings:
> 
> cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]
> ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  arch/sparc/Kconfig       |  2 ++
>  arch/sparc/lib/Makefile  |  4 ++--
>  arch/sparc/lib/cmpdi2.c  | 28 ----------------------------
>  arch/sparc/lib/ucmpdi2.c | 20 --------------------
>  4 files changed, 4 insertions(+), 50 deletions(-)
> 

-- 
#Randy

