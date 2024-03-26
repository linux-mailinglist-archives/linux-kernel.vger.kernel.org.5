Return-Path: <linux-kernel+bounces-118754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1285688BEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F023017D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507D67C53;
	Tue, 26 Mar 2024 10:09:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9958139;
	Tue, 26 Mar 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447751; cv=none; b=MIHdTmg85cohkzHw9F0PrwSoB35q8JX8puCMZnWOHHl1A2QHZ7E6GMCjFNAMQYKbsoZEd4Wld340La+DXJ+lnh74Oo6F+f0LccIhg7lVrSv+QiIpwZ8scQ7Yx84e8MmVSKsPXXzJ2flxSmjkUf06at3hsNpRbuoZ3+ty7aaWgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447751; c=relaxed/simple;
	bh=CSdOMSrem4e0F7hLbZ0M1Pb/vKICK+GZjqbyvHBGcws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR3tJoxiQomE4LEIDoKxe8rbXIpH1N3fkalZQ+B4IwjgV0BgTPP2MBDmq3geHd7Uz4He8vRlKr7S9l307vmw/ZRWs/cmMOyVrn9FSX5jwZKN1z5RPgYByxQDXh52Vmg7KSsBmcJGhXRZiFGQKWg/Ow90L/+gJW8KygElo7WPOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF682F4;
	Tue, 26 Mar 2024 03:09:39 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9B5B3F64C;
	Tue, 26 Mar 2024 03:09:04 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:09:02 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Balint Dobszay <balint.dobszay@arm.com>
Cc: op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jens.wiklander@linaro.org, sumit.garg@linaro.org, corbet@lwn.net,
	rdunlap@infradead.org, krzk@kernel.org, gyorgy.szing@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
Message-ID: <ZgKevs_YQYAhx98U@bogus>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
 <20240325151105.135667-6-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325151105.135667-6-balint.dobszay@arm.com>

On Mon, Mar 25, 2024 at 04:11:05PM +0100, Balint Dobszay wrote:
> Create an entry for the newly added Trusted Services TEE driver, with
> Sudeep and myself as maintainers.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd221a7d4d1c..eaa89feabd25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22470,6 +22470,15 @@ F:	Documentation/ABI/testing/configfs-tsm
>  F:	drivers/virt/coco/tsm.c
>  F:	include/linux/tsm.h
>  
> +TRUSTED SERVICES TEE DRIVER
> +M:	Balint Dobszay <balint.dobszay@arm.com>
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	trusted-services@lists.trustedfirmware.org
> +S:	Maintained
> +F:	Documentation/tee/ts-tee.rst
> +F:	drivers/tee/tstee/
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> -- 
> 2.34.1
> 

-- 
Regards,
Sudeep

