Return-Path: <linux-kernel+bounces-34703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A65838654
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377E4287D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103F6ABB;
	Tue, 23 Jan 2024 04:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWvV1Z7V"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4616127;
	Tue, 23 Jan 2024 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983414; cv=none; b=ASTEJgxM7d2APEySBiJdO1MakxanVtWLm5XKAJBEr99QGAcvRqF2qkGCs7p5xUDevZKHKWjxh7MInrmKdYl5Tk7r1DMGep53LyWMaWJhYBqsT00oVpxCBsnCjS8P8s/Iyp3jxrBWDeqd8FgRF6zFTgrD6prxacrxh3I8ZMwxQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983414; c=relaxed/simple;
	bh=zCto+i188eQzc9FI2y7lo2IV9MuPeqzQKsNrAs9syWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbQIrfEJKAXbLABwMEOE22ebPzjzBHr/R6ptF3VSIspBfOCrwk8aCxbYQC/zp1b1P1Y366cnCCbY3/4lN91Gm564pGlW9xOkzr4+Zhy1mKATxJue03SbSe1Tx/4gz9SQhSzsFZ1z7HhGCTFlvNGTfM81YCsXh0BtXx8RvDlj0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UWvV1Z7V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dPTs1UqD2uFsdR1Cq7cl+Z7O0iiQG+mRGXZOGMNFVe8=; b=UWvV1Z7V6tX549Jplae583oevZ
	kljkKaohO/hCCzq7+dkKTtypJAuVyoNkzGPNux4ejDm9gZaxaFptoISAsg5Z8GipdfWwS/8Zwwc1G
	FaWs6gutDCH60l2+vtCdDVb6DCfNviNIbNQI/RNwuGhMzdd1TSPWAETRaFMbgpgmgv0KnxRwawcEK
	uQ6o4sNsg3+iQw1KyvAAu1otr4Zk/7OuUnfe75j1lD2ezS0ZrfddQUUa6vtzRufZCvHRaNxLN+tfD
	EHou+ycW2Sm37FKNLvwiQlEl909T7bbPigCJk9oqw2RAx1hhcGgduUXxbmFOw5KxcJev7FoQKV5sn
	eMNXbGww==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rS8DT-00F3MO-2i;
	Tue, 23 Jan 2024 04:16:51 +0000
Message-ID: <3ce78854-e941-47e5-933e-38b18d5203d9@infradead.org>
Date: Mon, 22 Jan 2024 20:16:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/47] tty: vt: fix up kernel-doc
Content-Language: en-US
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122110401.7289-1-jirislaby@kernel.org>
 <20240122110401.7289-47-jirislaby@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240122110401.7289-47-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 03:04, Jiri Slaby (SUSE) wrote:
> selection.c and vt.c still uses tabs in the kernel-doc. This misrenders the
> functions in the output -- sphinx misinterprets the description. So
> remove these tabs, incl. those around dashes.
> 
> 'enum' keyword is needed before enum names. Fix that.
> 
> Superfluous \n after the comments are also removed. They are not
> completely faulty, but this unifies all the kernel-doc in the files.
> 
> Finally fix up the cross references.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/tty/vt/selection.c | 30 ++++++-------
>  drivers/tty/vt/vt.c        | 86 +++++++++++++++++++-------------------
>  include/linux/console.h    |  6 +--
>  3 files changed, 62 insertions(+), 60 deletions(-)
> 

-- 
#Randy

