Return-Path: <linux-kernel+bounces-51164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFEF848740
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E07D1C2292C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9477D5F85E;
	Sat,  3 Feb 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ksPAVLFs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B95F557;
	Sat,  3 Feb 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975857; cv=none; b=mfSEj4+5odnmAog2Hcb+lP112AenXPIIR5Vt0rHRitJHoIn141aNJ4IDG0wrdkePurLpxKWdEPijRln7/DKK+hhZjv8uxCqw51pyf8SCViUfRI3/OqVVHU77zNpv5Ala7ePW4QdsdyGk48sOeFundLVxNSTe+pJXSRIPNSwu060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975857; c=relaxed/simple;
	bh=dshOJS4N3pd4aPqoR2rq5Jh64ntgtbu8Mpn7QXGGWNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdj7J78tRGL3uhDIlt30Zn0BhP+XE7pDR54PYN6N/TbDsWLufc/jSzY3x0y9AATLA+B2KK4mlOZLPzq9JePrAE7J2ffwr40C/dPCsPqzEjgreqYdsFTEt4ubL0Sp4ddGMhL/OcGNdTzgWYw+VDjDnJVWBAdN34ZIhlltePPdDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ksPAVLFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DDDC433F1;
	Sat,  3 Feb 2024 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706975856;
	bh=dshOJS4N3pd4aPqoR2rq5Jh64ntgtbu8Mpn7QXGGWNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksPAVLFsGPjLOApCixqXuulqd/S2BjZWAAMUTsWRGrGeT7wGsTecHvX2GTc9PjaK9
	 BW4ILM7Zw/VdSreDX6bkcm5bH6+Oi/rwr3t7dJPjUw6UT3LFvatOKlSgz8VmymOVTF
	 MRnKcFo9zCdElTBfivjd6xPtRxyiRWv28p1EIvgs=
Date: Sat, 3 Feb 2024 07:20:35 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] s390: struct bus_type cleanup
Message-ID: <2024020317-darkish-reboot-eeef@gregkh>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>

On Sat, Feb 03, 2024 at 11:57:57AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks for doing this!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

