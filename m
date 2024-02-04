Return-Path: <linux-kernel+bounces-51332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D08489E3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4815BB24797
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D4A32;
	Sun,  4 Feb 2024 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M+NGLImT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65710E9;
	Sun,  4 Feb 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707007976; cv=none; b=ftRB1GcVBTIiwdbHwo9z1Jr/wUdMUvC2WO2JaCtLR0PcLqi8iHmXgPXj/lpuS5xGEIQDwruwN/IWBtr+bjGG+X83NevDFZb8MMJaMsrRh2rfnz3/U1KOD7eKQ8dD/vPkphSHRkxXzb+FPfFY3pEnmrpf1ozXRAH5phTTyxn6YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707007976; c=relaxed/simple;
	bh=NwR5mrk+h7TdhdFOGitSGh+iNGlqjIx+uacgS5e2lkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYsjalrbIuhzqUE9uGtJzd+aJ9FkF+DsggU5Fdh1PMSkadVWtIeNWil4ITiDx7K0qF8Hc6JfxzBtuTOTWPmhxx3AzCOp9ZSeFUb3UM+0r+BlLORTaQYWn7tECvWhIqKWuCCZ4cORWPH7xmHoDLjxT6m5Eir8limc6ucqMqXjvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M+NGLImT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZBq6t6hl94U57roCBPNk4QRZAVbooskR2FOO/z2Cm68=; b=M+NGLImTQGpeatWl69IxZzvWnr
	VMqxiYggaHMbJaKrAFfe0QFBgePTucUK1q+6IBqyPt9IGJ8083s4ySfcvq5uQG+SqEb4aep24D0j8
	6jLi1/EHnG9TA1H4A4b3nH4/hiLsTggXyHVfpRd3Dh1/cvM1/XSsJTNDZ1gCubOPxY3L8vyTjTyeF
	FLvl9+Zd/2LmlmCo8sJHqpydq/lCTjVT97n8SWBXGut7NO+xvvmQbpGXS/wcY5AuAKl0xPNjQxrhX
	PUc9WT6ULrYubTU009673VwdN4rjlsVbRWDFQUguABOsbheQOsyqhLHn268pqVcbiMpJMkA0RoMOE
	RXp3XhLw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWQkd-0000000HT9J-1iaV;
	Sun, 04 Feb 2024 00:52:51 +0000
Message-ID: <933653c5-a944-403d-b686-5b12c13132ab@infradead.org>
Date: Sat, 3 Feb 2024 16:52:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: multiple .rst files: Fix grammar and more
 consistent formatting
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203215345.4396-1-thorsten.blum@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240203215345.4396-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/24 13:53, Thorsten Blum wrote:
> sphinx.rst:
> - remove unnecessary newline
> - fix grammar s/check/checks
> - capitalize heading "The C domain"
> 
> changes.rst:
> - remove colon after "pahole" to be consistent with other entries
> 
> howto.rst:
> - fix grammar s/you will/will you
> - hyphenate "real-world problems"
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/doc-guide/sphinx.rst | 7 +++----
>  Documentation/process/changes.rst  | 4 ++--
>  Documentation/process/howto.rst    | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 

-- 
#Randy

