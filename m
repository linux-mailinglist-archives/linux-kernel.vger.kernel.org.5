Return-Path: <linux-kernel+bounces-70444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D546B8597E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05CA1C20A86
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32281E86E;
	Sun, 18 Feb 2024 16:56:02 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912C2B9A7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275362; cv=none; b=Q2JmEIxuTEjxAw8axloISAC2yFkUDw/Ofn/zX5ETJmM7WyiSqaApx3Xxbsny8AVG0YA/tp49TVB/8wKIYnujfDFkiEodJsGn2JG/DD6ndpwakR1w9reQh03wjEKy18q+l5TVYuRHyzI4he6dND+czqtFidj0s/+PXk0KjQAB//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275362; c=relaxed/simple;
	bh=gGH62aeXvokbpcopLVI6grO0xWk+Vyx+RDj634wpw8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1ja8EE4TLti/EhAmjy3Ra89ZtpOtaO4ex+ChL1ti9IAPzAEIwGAOof7DwPfJpsiHvJdudV2JrpT1ECeh2DXt4jViiAtnLdHKfyvLiY4e7MeMZCd5vviR2Y7KExRxZ22Y6liORBgdSIpPROKSDCzitTdjRqEXGlFQ2b9ZC3vaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id A02AD200056;
	Sun, 18 Feb 2024 16:49:49 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 79795A0083; Sun, 18 Feb 2024 17:49:36 +0100 (CET)
Date: Sun, 18 Feb 2024 17:49:36 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pcmcia: ds: make pcmcia_bus_type const
Message-ID: <ZdI1IMf9ZMK-yNvQ@shine.dominikbrodowski.net>
References: <20240213-bus_cleanup-pcmcia-v1-1-97273c37e277@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-pcmcia-v1-1-97273c37e277@marliere.net>

Am Tue, Feb 13, 2024 at 11:48:45AM -0300 schrieb Ricardo B. Marliere:
> Now that the driver core can properly handle constant struct bus_type,
> move the pcmcia_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to pcmcia-next.

Thanks,
	Dominik

