Return-Path: <linux-kernel+bounces-10011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D365A81CEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14148B23938
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4AB2E653;
	Fri, 22 Dec 2023 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PkdJdEU9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25032C848;
	Fri, 22 Dec 2023 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6BLfvoqCIH2qZja4YAiB6MdUAbrnjNHwY87Yc5jCNXQ=; b=PkdJdEU9XGP8kLUPfU1eO1oV6a
	Jnh/ZpYZCYYstJo4v7tgNER/8V5cMlszx7wXtTltbGMMbTXEvKp+iX4aRYZdcmQ072Y8TMXwqPkZ1
	LN0/2IY06f2DhFt2XbiCcrxPrvr7XS7ZVsOoA3tq6+PAsDFiwrwSb/ZQvtzYMA5e1mmhmfHJcNNBN
	YCt18RIPFc8UJ4DmHKhTv6ndNLXttTrnd3hl4oN3wj1SGIT+aayfRq8uMi96Jvw4NSYD/4+81wfAY
	cAIBDLSVXqX/4c++2aeBtpTd3e5JB875AOuAckmvMPNen0JjuFACaC4XwCu0bbXb1t3CXy/xfgg4D
	m+BCl7wQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGkvd-006gN7-2X;
	Fri, 22 Dec 2023 19:11:25 +0000
Message-ID: <833d766b-8d95-4348-aac6-09075bda69db@infradead.org>
Date: Fri, 22 Dec 2023 11:11:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: move driver-api/dcdbas to
 userspace-api/
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>, Jonathan Corbet
 <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>,
 Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20231221124816.2978000-1-vegard.nossum@oracle.com>
 <20231221124816.2978000-3-vegard.nossum@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231221124816.2978000-3-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 04:48, Vegard Nossum wrote:
> This file documents a sysfs interface that is intended for systems
> management software. It does NOT document any kind of kernel driver
> API. It is also not meant to be used directly by system administrators
> or users.
> 
> Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/driver-api/index.rst                     | 1 -
>  Documentation/{driver-api => userspace-api}/dcdbas.rst | 0
>  Documentation/userspace-api/index.rst                  | 1 +
>  MAINTAINERS                                            | 2 +-
>  drivers/platform/x86/dell/Kconfig                      | 2 +-
>  drivers/platform/x86/dell/dcdbas.c                     | 2 +-
>  6 files changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/{driver-api => userspace-api}/dcdbas.rst (100%)
> 

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

