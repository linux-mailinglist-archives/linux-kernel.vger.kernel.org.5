Return-Path: <linux-kernel+bounces-53930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFD84A828
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE191C280C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1513A25D;
	Mon,  5 Feb 2024 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XULFzQq1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541D482F6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166403; cv=none; b=sG98MY1zKImRmwWvXA0SdggmvSfyIQ19iTIAUOk24HK5dLvgO/l1M8vyHmfa/fqjbyfdCq6tuZEwnwVk6EaejD8gBwy9dkB7lqca0dmc/TRrkxN1272aIFQuvYVN0o62ZW4/PCxalHBPYpmhtbbeWJbNf00lE5zcPwJ68xPceD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166403; c=relaxed/simple;
	bh=qjYwOVL5n8E64xaUh8WKZwxYcEFG67CWrLt9pfQixAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iIUD/QsrVIJWniU7zOXcoHfn38DleOgD6Rkn5aGpqP0q+9eVx27fMxapOClLHOQWpFmfsKl27OB39PLI3Db6RZgD4sIjcbdotUJ5CpBK0QQSCEDItKaB28QtrZchXSUK9F6CDkXtxSNqqqHBM+mDqSPC/Xn/hXO7mxYyB6BGIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XULFzQq1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=UJm8rJ1kinAzDIjchPSEgbk/4aRLfbzaK3NU14FLAVs=; b=XULFzQq1dcTouy1K/K2W7HSHeG
	oBT40+u0le//7L668rhFwSlvtgOvJRNZxdyHnNiaLrdtJzLSLW04hg4pPk8D/YzMZADpbCGy7MOvM
	wEzNERT01234uRK4kKjtbvAhp1oh4YYJcNminzSHvN+yNK7PnD2FQ5amkI9t5PKpIPxSWycmSyP0i
	+azdLr+5oDOwEja4nBpDYZwMsJIVntDf+BMeDRZUJu92luhdKIU8vbFfdq2x4TchkAHw5drftdG+d
	8VuIfKEScEuUdUiYw3k+gXfym2L43MrEJjrkNLh92NeuyCT8/uMAFtIvpnuYPEWaC5Jeu2CWdipNh
	5cjImA9g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX5xx-000000057XX-1YEB;
	Mon, 05 Feb 2024 20:53:21 +0000
Message-ID: <da0da5de-09e1-4e79-98ab-cb4c503fd368@infradead.org>
Date: Mon, 5 Feb 2024 12:53:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] README: Fix spelling/capitalization
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>, linux-kernel@vger.kernel.org,
 trivial@kernel.org
References: <20240205120904.1711-1-thorsten.blum@toblux.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240205120904.1711-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 2/5/24 04:09, Thorsten Blum wrote:
> - Fix spelling/capitalization s/Restructured/ReStructured/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

We no longer use trivial@kernel.org for patches.
You will need to send this to a maintainer who will/can merge it.

Jonathan Corbet seems to have merged most of the README patches  lately.

Thanks.

> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 669ac7c32292..026eff0b8e06 100644
> --- a/README
> +++ b/README
> @@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
>      https://www.kernel.org/doc/html/latest/
>  
>  There are various text files in the Documentation/ subdirectory,
> -several of them using the Restructured Text markup notation.
> +several of them using the ReStructured Text markup notation.
>  
>  Please read the Documentation/process/changes.rst file, as it contains the
>  requirements for building and running the kernel, and information about

-- 
#Randy

