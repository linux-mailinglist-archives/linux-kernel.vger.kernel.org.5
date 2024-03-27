Return-Path: <linux-kernel+bounces-121359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB588E6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F71C280F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FB13AD21;
	Wed, 27 Mar 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y7jtTKcr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47623139D1D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545493; cv=none; b=Qax1bEvd23zHafqt0H8USYucmvx2vQ2nzGrJMVS+FgOmYR7zH/jQ91fj38n6KPt7fENKbZKGPaofYVb7cRv0fjCIz+ASBgbqHENEqxlX/E0kEdHNwb0c2YuCkTNNE8qus6q/qqr6po/Zy0hK4csdNcpZtKjNc+qaINrKn/Hewwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545493; c=relaxed/simple;
	bh=K5p0LQUVGEjvqZlnZQdHgOEYJ2uEEM4vsv9v1Xr+OhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgJ+Fg/lZE4BsI2vRfPxUPke0XQAADOrHsWiDQ9B/ycVKlv+0ME5FW0/fJfR5aC+w6tv0INJg//o76DSFiszIYnBjHXq290YjlbFOtDZJhQantlt9wLEvAfZnrwX0WVDqI0jfmBrlLsYVZdWxZprZKdtzZ2OpBlIrfuQt74SyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Y7jtTKcr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75E1A675;
	Wed, 27 Mar 2024 14:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711545457;
	bh=K5p0LQUVGEjvqZlnZQdHgOEYJ2uEEM4vsv9v1Xr+OhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7jtTKcr2CCJPe2Q35s1BtZbsbxNS9bdvXO5tUBBMTz/t9tWOeuEfmvtNrDI2TEiG
	 BxiNafgPsql1Qg6JkM9UTC4xTDDRrp4QOM/idKGkGFmTpYLsWFruNwZAzGWpvUY3+v
	 3WQTEc1Ot0102n8nV6IkhmFjIouj5OGvpPVyjqrA=
Date: Wed, 27 Mar 2024 15:18:00 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for Xilinx DRM
 drivers
Message-ID: <20240327131800.GA4666@pendragon.ideasonboard.com>
References: <20240327-xilinx-maintainer-v1-1-c5fdc115f448@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327-xilinx-maintainer-v1-1-c5fdc115f448@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Mar 27, 2024 at 03:03:33PM +0200, Tomi Valkeinen wrote:
> Add myself as a co-maintainer for Xilinx DRM drivers to help Laurent.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Much appreciated :-)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aabf1c15bb3..79ef5a6bf21b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7306,6 +7306,7 @@ F:	drivers/gpu/drm/xen/
>  
>  DRM DRIVERS FOR XILINX
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> 
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240327-xilinx-maintainer-f6020f6cba4d

-- 
Regards,

Laurent Pinchart

