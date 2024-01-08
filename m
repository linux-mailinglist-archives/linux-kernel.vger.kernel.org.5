Return-Path: <linux-kernel+bounces-20083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9E827913
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44951C230DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238555797;
	Mon,  8 Jan 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="kjT/Q3vS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113B56B9A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id A01B624002A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:17:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704745032; bh=J6kY8gZmU4XB9qAJZUwFxvhBWjXDFb5lmjy/iW0iY7U=;
	h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
	 Message-ID:From;
	b=kjT/Q3vS5/zfFzI+O9p4I4PffOSoJwwTC4wsnsJmy0Fl2h9i5zSyjodJ2SV3LKGlL
	 0DNVJNzbTtcQZZCsIQEguKc+/ZnfHYWMfqiw56cEoaORPx6KRMZZubhxQ7HAL5IYXy
	 oaWqo8RKLuTXRr/9uzTz5YwDXp9YlRFw7T8Zig4swmXXg/vCv9sKiWahXnHutPKbr8
	 Mve2iqdvRB96kI08DYGsMiOyr3nodm7vwPAQM1m/A2lyzqw31AAc7YD01PDdisNuuV
	 L1veOG34nIZjUcfWw3MywQ7brnO2Tdc2vIz2teKWacEDTIxMTOphu3kTv1g1B8/zrj
	 BIsVkhMVdsnLQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T852H5wMmz6tsg;
	Mon,  8 Jan 2024 21:17:11 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jan 2024 20:17:11 +0000
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Hu Haowen <src.res.211@gmail.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] coding-style: recommend reusing macros from
 split headers instead of kernel.h
In-Reply-To: <20240108193737.189282-1-shamrocklee@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108193737.189282-1-shamrocklee@posteo.net>
Message-ID: <176e5fad73a871e5f40d4ffafc5041a0@posteo.net>

On 2024-01-09 03:37, Yueh-Shun Li wrote:
> Dear Maintainers,
> 
> In this version of patch series, I drop the patch abouth the nameing
> conflicts caused by locally-defined macro variants to streamline the
> documentation.[1]
> 
> This series of patches targets the "Linux kernel coding style"
> documentation and recommend reusing macros inside the include/linux
> directory instead of the obsolete header "include/linux/kernel.h".
> 
> This addresses the issue 'Irrelevant documentation recommending the use
> of "include/linux/kernel.h"'[2][3] and help deprecating "kernel.h".
> 
> This series contains the update to the zh_TW and zh_CN translation of
> the corresponding documentation changes.
> 
> Best regards,
> 
> Shamrock
> 
> [1]: https://lore.kernel.org/linux-doc/87ederwuid.fsf@meer.lwn.net/
> [2]:
> https://lore.kernel.org/linux-doc/bc63acd7ef43bdd8d9609fa48dbf92f9@posteo.net/
> [3]:
> https://lore.kernel.org/linux-doc/107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org/
> 
> Yueh-Shun Li (3):
>   coding-style: recommend split headers instead of kernel.h
>   doc/zh_TW: coding-style: update content for section 18
>   doc/zh_CN: coding-style: update content of section 18
> 
>  Documentation/process/coding-style.rst        | 24 ++++++++++---------
>  .../zh_CN/process/coding-style.rst            | 22 ++++++++---------
>  .../zh_TW/process/coding-style.rst            | 22 ++++++++---------
>  3 files changed, 35 insertions(+), 33 deletions(-)

This series of patches didn't make it to the lists due to my loose ends.
Sorry for the noise.

Sincerely,

Shamrock

