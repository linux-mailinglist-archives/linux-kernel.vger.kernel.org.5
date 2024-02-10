Return-Path: <linux-kernel+bounces-60509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A898505DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F30285B82
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652E5D485;
	Sat, 10 Feb 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yLSYN6pm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CA259B;
	Sat, 10 Feb 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588137; cv=none; b=fi2vDibhybN0JHCYO0TGePVvCbkwWumME0aNBNxEXC44T0GyCGM2GZaRzLo2j26U7lrS2o4koWge9iQ7A5Lss5CADBPLAYNVZyv3nJypjY4VcEhK1QxOnAeZS049Y3dRflnlcoGtSVUec689uDTpuWQsJ3QPZboaOELNSUK2ngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588137; c=relaxed/simple;
	bh=g69G+aInOtubj4ogLlXXUVqcag4r03m/f/OWs2Zw2/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qH9DngTH+XXuxasefA5KmnvkoIUATMZ8eAcANE4RlXf3cntPQg4poxZg5HW6l00XaRALjoTcLxJU63/LURLjtZqWnIVJcF80zDtV5cC553Jr0GnoK3I9dgWI4vBcvkYJt382pr9aTPIzZzNXNP/fxXGX+HhKkWquV3SEa7O6Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yLSYN6pm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=O1CQPPpYyrG/AzjnYm4PVqIcHy5+IFQRJvndX74NChA=; b=yLSYN6pmi+40LK55ECIhGOoNyJ
	jXCBXi5PmT7FK1F6nJlcoId2KzRIZq2vxVxOgaYtQ8re0ICGehmdAczj0iG+G9d8FRbhSSqKZ0YIN
	dOiuDuu1mIn0ET4yx+jjzxHaGZbynboZLpJK/vab8u8EM3hjfEl6SKwtlTttCeKR09iNmDS/FX588
	yM8gigjHhLP0OyNAcF9ZGjD5P6hwvxRbeG8hQh2Tk7OohvGo7pHdyian7paigFqAEHgKPvLE5Qtpz
	XqvrFEuPO+3pC2r5UBEcBJNo9NQlDy2EeAWTuOpnl+FT34oWM4coVnHtMywSY4hCk9Aaj8HdptTSq
	XT8kodyg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYrg1-00000001tB1-3knC;
	Sat, 10 Feb 2024 18:02:09 +0000
Message-ID: <811de246-8b5c-4b44-b112-c24391f4b280@infradead.org>
Date: Sat, 10 Feb 2024 10:02:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kbuild: Kconfig: Fix grammar and formatting
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210152003.861-1-thorsten.blum@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240210152003.861-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/24 07:20, Thorsten Blum wrote:
> - Remove unnecessary spaces
> - Fix grammar s/to solution/solution/
> - Remove newline to be consistent with other headings
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/kbuild/Kconfig.recursion-issue-01 | 6 +++---
>  Documentation/kbuild/kconfig.rst                | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 

-- 
#Randy

