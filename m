Return-Path: <linux-kernel+bounces-51295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED00A8488EE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B45228531D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAC12E4F;
	Sat,  3 Feb 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UCOqQ1Eq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436E12B7E;
	Sat,  3 Feb 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995392; cv=none; b=OyEA7AIQAJmtdbDcCMtLJ4Y3Q/Ss9J3oVNJ2kjbaxoLY9zIfMPSSBXiaA102Z1bDsEttDm2cfjsctT46uBCQ0OH5USDgiqAjLU3yTqVT6OWVZFVcVuHmlqk+FEBnkHZJY3lX4cx47Un25LrgADygbtcff6vUiIGVc7NH4E7Y4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995392; c=relaxed/simple;
	bh=VR41hfrFHakWSd1uNZVdfPOCIqQ5wThI76WV3pid3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoASNUuXEt20TnaMjSCtV9gTofLmzoicW7ponwVFX9Lr0umiHpG866st/71uk8Fq1tmININuAjzKP88b7zQviz+RTA0d0LGfty6Th/PuddDzcWJD/anlGqxdRBJlhMQ2dbC6NxRzyQF5NwnqMIcI6S9T7XxIDpToutpL/kPOOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCOqQ1Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B85C433F1;
	Sat,  3 Feb 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706995391;
	bh=VR41hfrFHakWSd1uNZVdfPOCIqQ5wThI76WV3pid3mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCOqQ1EqSz8p7BQKT31VEnA6YGLOcDawHwiSKSMLbOLOPt83MwrtQ6RCFE5MNuJNZ
	 TcgVYC2LOykwUToXuJnEapGBi97tWWRMBu8ocmaq5j8UdnQgz+pjpWYJGMWbYJAc5k
	 tdrC11v+ScDc/2SAk1OF94NaTCBdzzcrtFMFG4Ks=
Date: Sat, 3 Feb 2024 13:23:10 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	open-iscsi@googlegroups.com
Subject: Re: [PATCH 0/3] drivers: scsi: struct bus_type cleanup
Message-ID: <2024020351-groom-underline-d28d@gregkh>
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>

On Sat, Feb 03, 2024 at 03:38:59PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

