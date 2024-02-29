Return-Path: <linux-kernel+bounces-86152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0E86C084
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724561F248D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D43C47B;
	Thu, 29 Feb 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IHB86wWZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5413BBD8;
	Thu, 29 Feb 2024 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186670; cv=none; b=RiknXJn+pZMuV2TFIQb0sLAP0JDOwe39e6Ght4VWxgZfqzYsD6E1VI4lR6V4XsRb15FRKE4pMkrfSdJpDD1+7UiuN9zL1tCWgy0c2U1Q0iKcVtkaE262Ml483PxG23xJCdG4rZVn534NVICFQoODpjDHri7XoftMG/Kc0fyiwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186670; c=relaxed/simple;
	bh=lODg7xEbsH7/rJSZ6/Sv/aGlo0vRxv09DUpNmbq5mCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfNd3x/57YJEaig3tJrcJDc4+ofJ8Gmo00RqPb4ke/FxX3sS3l5QJIY33D/EvptOFrXA4A5CJWRSvmt9JQVNjS9tcwIgwvuP7CELWlbfyjk2YodBXMota/mm9BD/z0OJtoYROA1c2gOpliGKJPsk5SJrL1G7UuPKa2012+QlTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IHB86wWZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jVLaPOcNfzOtiM0Q70Qg2FhdH5/N6bESWo4OOnctJm8=; b=IHB86wWZoZTLVULVzh9BRzgavb
	b3VktEXdWG1SN43F3+etBoUkOEM9VcynLDn09CSQL44aUEN6YPJeMFbO4tn+E94XXWxlBqRt8ZpJr
	xtO8EG3kCO3XtC0tcC2CueZ3A7kuaDFAF3aTRAlT5MD5ateKPaonpQdzsOMBAvGEPWjiSvvF11khX
	xdGBSR0W6lI9UeWPHn64A/OSy2XAgzLztO2CzBH2U6Rf8pI2T5rOAjonKUyLf6ZNu2BQo4Hmeob91
	5YHCuaQMuh4APbYZgCmJqtDyi3MuVFVHasSfdqUufM0iKuP/F6U7T20HTMBdWt0n/qvQcO7Vh+Rv7
	oVZ2wVDQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfZWu-0000000CEVm-08oi;
	Thu, 29 Feb 2024 06:04:28 +0000
Message-ID: <a288a0b3-78fc-4166-b1c5-81a51441abb3@infradead.org>
Date: Wed, 28 Feb 2024 22:04:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs: submit-checklist: use subheadings
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
 <20240229030743.9125-3-lukas.bulwahn@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240229030743.9125-3-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 19:07, Lukas Bulwahn wrote:
> During review (see Link), Jani Nikula suggested to use proper subheadings
> instead of using italics to indicate the different new top-level
> categories in the checklist. Further the top heading should follow the
> common scheme.
> 
> Use subheadings. Adjust to common heading adornment.
> 
> Link: https://lore.kernel.org/linux-doc/87o7c3mlwb.fsf@intel.com/
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/process/submit-checklist.rst | 26 ++++++++++++----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
#Randy

