Return-Path: <linux-kernel+bounces-10010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF44081CEAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5009A1F22AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9E2E3F1;
	Fri, 22 Dec 2023 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WN0C8Mbj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853F2C844;
	Fri, 22 Dec 2023 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FnUWXUKDiEF2aBrjIZkaYhL1kHnmdseYDG2uP7w8EAo=; b=WN0C8MbjR8jyiZpRe/AHwfToER
	KIVeQq/EUjfNAADrnV7UtCMWActJONXUYbSFlLKidtUrPdwDHMOaO64oPtMRm1BQp6mEeOqlEJhcb
	cxMA1qYrrC0NKylCb9vQdiHCpp3qiZl2d/6rphoEXTh2CGDuP5jWh85cPU2Q5wOcDX88qHsXWNplU
	FCvPO3onuEXfJn4saUw/Zj6Q7ONgZRnloPNE60W8/b+5/tiY8n1YXh9n95VizPh8PteBMStUE+l8Q
	AEivnfHeVegS+zEFNKna9paZP+snTm8iZ8yDoHSHlhRg+3SV+ALoHJ9/1RGBSf+BRIKf+xtsyjnvs
	HROi++Pg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGkvg-006gN7-27;
	Fri, 22 Dec 2023 19:11:28 +0000
Message-ID: <70679be0-d77d-48e8-8b30-027a05e38917@infradead.org>
Date: Fri, 22 Dec 2023 11:11:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: move driver-api/isapnp to
 userspace-api/
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet
 <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
 <20231221124816.2978000-2-vegard.nossum@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231221124816.2978000-2-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 04:48, Vegard Nossum wrote:
> driver-api/isapnp documents /proc interfaces for interfacing directly
> with ISA Plug & Play devices, not any kind of API for kernel developers,
> and should thus also live under userspace-api/.
> 
> Also fix a few issues while we're at it.
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/driver-api/index.rst                     | 1 -
>  Documentation/userspace-api/index.rst                  | 1 +
>  Documentation/{driver-api => userspace-api}/isapnp.rst | 8 ++++----
>  MAINTAINERS                                            | 2 +-
>  drivers/pnp/isapnp/Kconfig                             | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>  rename Documentation/{driver-api => userspace-api}/isapnp.rst (51%)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

