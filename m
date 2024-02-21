Return-Path: <linux-kernel+bounces-74222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989AD85D14A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C45E1F217C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329713C08F;
	Wed, 21 Feb 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6/se6yJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAC3C067
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500364; cv=none; b=D58ywZcKRMD/prhDFsnKVu7A+hcEGxC2Q/rKuUogQEnzz/Hl3gk0YjNqiuhPnENHgVFhjjYX2NIndqdEjPW/9d/f55MJBMN/m/JkGNAOEi9FhwaN0YIibt/olHTQgsrLOBobjKYjHo97R6xJCFrqlJUTgtrYX9wPDltGrRLiq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500364; c=relaxed/simple;
	bh=z6ST30DhfjFMGQqZeBRbgY3AuVaPwi+nrpGEqRaPmVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfNGhG/7X94zrphFWXDBASnW7X4RDGgFc3P3/9iqijzVOGgNEWDrBLRefGn1meeFJcNmQWx8smEFyXCUuqLj64S6gtI+iANJfN/TZ9cJuT2a6GGeC2Azz210hd3iP6bxj8hk2E6qauCnOufxZKpO3Rw+tF4ewt/EOc9W2qt4omM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6/se6yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FC5C433F1;
	Wed, 21 Feb 2024 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708500364;
	bh=z6ST30DhfjFMGQqZeBRbgY3AuVaPwi+nrpGEqRaPmVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6/se6yJnA1S2AqN8uoHKQXWB9RMgmYTfyir3E+zm7LMat+dOlj8tBRERPTjybr89
	 pl3rArXSDyqiUXrWEkb5Esa8IeDT9lXTO0zQRr/fITouVQI/xb88Hcs3YPdL7AfbE2
	 9j3eXBvSuHyen28o1wKXFfLQsHWVxmlwDslA31vs=
Date: Wed, 21 Feb 2024 08:02:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: matt.hsiao@hpe.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, keng-yu.lin@hpe.com
Subject: Re: [PATCH] MAINTAINERS: change the maintainer for hpilo driver
Message-ID: <2024022107-amuck-festival-873f@gregkh>
References: <20240221040307.23019-1-matt.hsiao@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221040307.23019-1-matt.hsiao@hpe.com>

On Wed, Feb 21, 2024 at 12:03:07PM +0800, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Change the maintainer to Keng-Yu Lin as I am moving out of the project.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed4d3868539..f41e77672dad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9426,7 +9426,7 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/usb/hdpvr/
>  
>  HEWLETT PACKARD ENTERPRISE ILO CHIF DRIVER
> -M:	Matt Hsiao <matt.hsiao@hpe.com>
> +M:	Keng-Yu Lin <keng-yu.lin@hpe.com>

Great, but I need an ack from Keng-Yu for obvious reasons :)

thanks,

greg k-h

