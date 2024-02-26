Return-Path: <linux-kernel+bounces-80607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F88866A49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5706E1F211A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054131BC5C;
	Mon, 26 Feb 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="evbXDi+5";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VDabwXod"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B041BC22;
	Mon, 26 Feb 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930205; cv=none; b=QtJJKr2XlajzFiv1cAn8Tm2/azx/SAziPP7Adp49EtfT0SOfXV8n1TazkLTnAHK7X8VtYTN1nXCDrxsO1JPkfKZ7Eg+C3DJ9hd8cE6KovMPnXE4f4+DZ53/YPgCkPG+hXCWArbXApqURQXHSFQzPmoJg7FEXdkNLoCyARHIwGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930205; c=relaxed/simple;
	bh=utfovlb6iGUZxJTgTBi8R7FxTD70n5B62sNrBoBhyyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRh53UY1EL+y7wA6BV2cyJ5jQ+7/um7pzWcABDro4iZC9yMHQf6uK275CAC2HS2S+kGGDKfTx4avp7hMeD16McggJTeh0t+jVFkTXsPCODIT0GVwVhuTQ8SuH26EVabQBttTCASG7lYX/2oeg1kY8ePnLPZ7tBuK0fuQqwVk2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=evbXDi+5; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=VDabwXod; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708930202;
	bh=utfovlb6iGUZxJTgTBi8R7FxTD70n5B62sNrBoBhyyo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=evbXDi+5y4qsEvfaC10gugiTHz1v8yEUa4W18CGGxbEADM3eXPqDxCNIGAKZzENvl
	 cOyOMqV478c5lTuKK9+KVodbXvCrXGA16jDwG8QovdUExB6oce55q2SnHx8C4WyYIP
	 th+nm9lsin2m/edb97raB3lh5GqmjRBF5blZkGFI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2BCF612860BE;
	Mon, 26 Feb 2024 01:50:02 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Xq4EyvsWYnr9; Mon, 26 Feb 2024 01:50:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708930201;
	bh=utfovlb6iGUZxJTgTBi8R7FxTD70n5B62sNrBoBhyyo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=VDabwXodFPoDcsWGjmfMp3Gam3xyimZZDgHiLNahVqSyfNTc2TnPSlLPjXYbGCboZ
	 w0pZGXFnM7z5g43nL75edUoLySO8fcsIBnON5BqS5kSR/YHQDvfWnYz6BUtUJkb8/2
	 +XTz+CuHP0BraUineL5yewplLcOJEPFCt4EcoZHs=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BF32312860BC;
	Mon, 26 Feb 2024 01:49:59 -0500 (EST)
Message-ID: <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, Peter
	Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Date: Mon, 26 Feb 2024 13:49:50 +0700
In-Reply-To: <20240226062245.2279635-1-jarkko@kernel.org>
References: <20240226062245.2279635-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-02-26 at 08:22 +0200, Jarkko Sakkinen wrote:
> Add TPM driver test suite URL to the MAINTAINERS files and move the
> wiki
> URL to more appropriate location.
> 
> Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf77be03fb2b..6380c1109b86 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11947,6 +11947,7 @@ M:      Mimi Zohar <zohar@linux.ibm.com>
>  L:     linux-integrity@vger.kernel.org
>  L:     keyrings@vger.kernel.org
>  S:     Supported
> +W:     https://kernsec.org/wiki/index.php/inux_Kernel_Integrity
                                             ^
                                         Missing L

James


