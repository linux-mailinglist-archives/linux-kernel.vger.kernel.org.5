Return-Path: <linux-kernel+bounces-86154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8186C089
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457D2B24FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF83C47B;
	Thu, 29 Feb 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMRdC/A+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405183BBD8;
	Thu, 29 Feb 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186784; cv=none; b=Vcjd4eOsjm84cPpOQZDo4r5+W0i7jwnqIluDjU3g5iabw2louybXevHtxCIZ49fM4zHeXqCPpAxW11Nl9palinqoaJw2qNRAKN2EEJAN0NWfAX9PxzjLt70NmhL59BIJ82i6PlwsKD8u39nL8B88E6fWXLkYg68Qw3c5+fAo8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186784; c=relaxed/simple;
	bh=9WQT0htHnIuS/yIfIbQmif+LhvsBLCUNRDOl504kjvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAD9rKSQ1D0dqrBBCvx4bprY1CUhnZIbIGHBBhmAG431RrXx1xYtOhlW132AqIjHrlZ2FmuAAhfvTle2JSnNj0pEG8cPvYHIlhpPrSrcsXjuPpeozYVOisVa1aBZJo8y7GNA6y+GoDcjlzp6+VMFsu7PpgWswLqMFgMa/ISbEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMRdC/A+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=z1l5CyWmh9G+M0xFTiEWNP6CGf0E3u0s2ktX6w5WuFI=; b=JMRdC/A+fbIRs5X8Bll3QvbZmA
	XKgQsWyKLuvGJR73bqH/UDrGDweRzjvugFSOpk0QU18oyPT6BDJInJkEvY0D/Dfqrfqe+zUF7fLif
	xADwDfBHfvuRmMh9EDHBholTxj1y0SyljquhGBxzxb4ChJJzjT1erZJV52KyiD6r70+oBAPBWiAM6
	D2We/BwNU4Bxy2hhSa2mShgwyj7Oa9WwVicuAc6s++OlXl938XYBqc0MGo659CFBXBNLdUoZkS8yJ
	rDulhxaIN/Pd2Y65Ex5PwhPT4JM7pkcU6LvWeYSiI3Ki7FDzAXnRjm/EPtMUZWCeiyY4nUXC9e3Lb
	qfojsU4g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfZYk-0000000CF2G-3Vjj;
	Thu, 29 Feb 2024 06:06:22 +0000
Message-ID: <550a60bd-69b5-425e-b960-5a66bc5a1af9@infradead.org>
Date: Wed, 28 Feb 2024 22:06:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered
 lists
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
 <20240229030743.9125-4-lukas.bulwahn@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 19:07, Lukas Bulwahn wrote:
> During review (see Link), Jani Nikula suggested to use autonumbered
> lists instead of manually-maintained bullet numbering.
> 
> Turn all lists into autonumbered lists.
> 
> Link: https://lore.kernel.org/linux-doc/87o7c3mlwb.fsf@intel.com/
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/process/submit-checklist.rst | 48 +++++++++++-----------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
#Randy

