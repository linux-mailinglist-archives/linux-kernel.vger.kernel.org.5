Return-Path: <linux-kernel+bounces-90648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D18702B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A18B1F2590F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A643DB81;
	Mon,  4 Mar 2024 13:28:52 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732A3D972;
	Mon,  4 Mar 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558931; cv=none; b=fjvycX1FT+DZjE+dwiVutw2U5tsnRXEfIAreYjBvASjRaf3LB02gnylJnd6uwe8B7vAM4IxETW/ehK5smaTHKRtrFVthrCKwbG6nbMUp+jO5wMsQ+fPH+8z/XkKWWd+gnnjGnCyVtxPY0k8gHSL789FRJehplhAk/AKD62W30A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558931; c=relaxed/simple;
	bh=BEO8P8uY2vHmsLa6kmOHSjrmcdzy9ApctBc2hcPtw3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJkR9DyjzIue0NPBtwtwt/WHfMgv6I5VP4UN1uCE+MRivIG2Om5TYo3iN/I6Qsuh1WRqnyj8Nt16Fvr6R425ZAUIu05H3PgMyFzhdSSaK7fbng8VNHn3U+uyq36C8sfvDFMvIOH4kC18UMKgY5hJQikoceNNPl++cuOo6Tq0H5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rh8Mx-0004e1-00; Mon, 04 Mar 2024 14:28:39 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 84BF8C0267; Mon,  4 Mar 2024 14:28:28 +0100 (CET)
Date: Mon, 4 Mar 2024 14:28:28 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove entry to non-existing file in
 MOBILEYE MIPS SOCS
Message-ID: <ZeXMfP6UeFcV7k4y@alpha.franken.de>
References: <20240222143312.27757-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222143312.27757-1-lukas.bulwahn@gmail.com>

On Thu, Feb 22, 2024 at 03:33:12PM +0100, Lukas Bulwahn wrote:
> Commit f34158edd249 ("MAINTAINERS: Add entry for Mobileye MIPS SoCs") adds
> the section MOBILEYE MIPS SOCS with a file entry to the non-existing file
> include/dt-bindings/soc/mobileye,eyeq5.h.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Possibly, this file was part of an early patch series, but in the final
> patch series, this file does not appear anymore.
> 
> Delete this file entry in the MOBILEYE MIPS SOCS section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28b2013031bd..19ac6a8e46b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14914,7 +14914,6 @@ F:	Documentation/devicetree/bindings/mips/mobileye.yaml
>  F:	arch/mips/boot/dts/mobileye/
>  F:	arch/mips/configs/eyeq5_defconfig
>  F:	arch/mips/mobileye/board-epm5.its.S
> -F:	include/dt-bindings/soc/mobileye,eyeq5.h
>  
>  MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

