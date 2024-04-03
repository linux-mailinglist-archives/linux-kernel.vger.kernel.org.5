Return-Path: <linux-kernel+bounces-130693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B7897BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F531F28B35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A3153BEF;
	Wed,  3 Apr 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KbAyVNW9"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928F692FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184060; cv=none; b=QDkCGdaOBV549IE9SdoRjbrwhQP80vlTP8PxZolHVpPVeRfBl6arscDgKUfQk4iJydf28YNsjCH9oMrZZb8W/VuW346sJO8HKokOrPPEyy5vZee4yQlj7cCVK2en9LGgbYd9NEaABQM7u29lkKGMj6EJZpxa9zQDKKBZGOZhHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184060; c=relaxed/simple;
	bh=OIFHLvK09mRKrdktyHDc1sLp86x3YqRw5XW6oSN1NPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3SiAfDTL6R8jzHx19yQt1AKLZj/NvHlPJ0NW1emW4QoRLSpQaYPuVLrAfx3mWBrsEjkdQ1jP18rcXHcsaOHrNg5faYWnbj80yO1pqdqmj6FpYdC9duONyIntgaiQv99d09RKMv0mziEbx2161EFarEM4N2P4WGrTJuOHxC/4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KbAyVNW9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AtI1JIK1NoRkwkknKhPdkYxsf2oluTECmQZ1khbpJtY=; b=KbAyVNW987Lsd0Jv7bM6e1nKrq
	wMpnwl0Rh15B9TkzPzr/ajhRxaFUxsNFryFKqGHYGF9Ve+zJDP5FP9FAKODhoHU2caJJi42qI8eXR
	RnStCOc1FUn0hq1RrJ2KPQRHjekyr1wKh2MBKvC8E/1srZwVekbl/s+z9TiMzACYxk9c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs9Ho-00C7ez-CM; Thu, 04 Apr 2024 00:40:52 +0200
Date: Thu, 4 Apr 2024 00:40:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH v4] perf/marvell: Marvell PEM performance monitor support
Message-ID: <c48b0612-8682-4052-9631-e90526b78c25@lunn.ch>
References: <20240403054110.2057137-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403054110.2057137-1-gthiagarajan@marvell.com>

> +config MARVELL_PEM_PMU
> +	tristate "MARVELL PEM PMU Support"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)

Why the && 64BIT?

I expect any kernel function/macro should work on 32bit systems as
well, but might internally need a different implementation. But
drivers should not need to care.

If you get warning / errors with 32bit systems, it might suggests your
driver is not as clean as it could be.

	Andrew

