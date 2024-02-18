Return-Path: <linux-kernel+bounces-70582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E0859973
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5DA1C20C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE1745C1;
	Sun, 18 Feb 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BSuHcece"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D473174;
	Sun, 18 Feb 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289948; cv=none; b=f12vCtpRf3mEzN//JqH/2TGe8bpfEkGkRXz1QsfEb4F6nkof5/wO9pzML47NktVVs7IATO+qhOLo1K0UeWrSAbL/V+PG13j3xpSnRZJjvCjT1CXruCOYESNzl96XdhttBzvYDeLop7ymi/+pa8FgIl2hKk3+X0EdVq+w8LFJ+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289948; c=relaxed/simple;
	bh=khfnj274W3hIO2mm4nJSPvvGpMlSXQTa0mKP8vdFy2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/2WdgiyW/Ug2OMuOpm8BZqViqQeyZkLMaP/AlhlQ00HA1f76xzYkFq0vx7RPPibdyGlCiNJ3QjHm4E0KUeSPBTpaLh8QCH5Tnrsk8+A14ysfLOws7GgYi+4oTJWAO6mls7ElBwrZ7SwxTygJra8jbg2OPPl6cDo/kkBJ1RZlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BSuHcece; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF5BD480;
	Sun, 18 Feb 2024 21:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708289939;
	bh=khfnj274W3hIO2mm4nJSPvvGpMlSXQTa0mKP8vdFy2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSuHceceam2Vbvp9RA20ARGPGohQIdFGAlbTwzftZgQ4rIl5rhKwnTO/WhUVtPv52
	 DHpZIW7qPTEYHPkKNwBFReef7MunnXznqTC+2Wuy002AOwRWuzN/J8JnvqVstgzjY7
	 m74hrhd/pVXQECWZJ26fbguybcfTZ/AEQT+4cj0U=
Date: Sun, 18 Feb 2024 22:59:08 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>,
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH] media: rkisp1: Allow higher input resolution
Message-ID: <20240218205908.GA12766@pendragon.ideasonboard.com>
References: <20240217185202.1754750-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217185202.1754750-1-megi@xff.cz>

Hi Ondrej,

(CC'ing Paul and Umang)

Thank you for the patch.

On Sat, Feb 17, 2024 at 07:51:58PM +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> In BSP driver, it is allowed, and it works in practice. Tested on
> Pinephone Pro/RK3399 with IMX258 at full res.

Paul, Umang, do I recall correctly that you have a similar change ?
Could you review and test this (especially on the i.MX8MP) ?

> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index 4b6b28c05b89..74098ddbeeb3 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -33,8 +33,8 @@ struct dentry;
>  #define RKISP1_ISP_SD_SINK			BIT(1)
>  
>  /* min and max values for the widths and heights of the entities */
> -#define RKISP1_ISP_MAX_WIDTH			4032
> -#define RKISP1_ISP_MAX_HEIGHT			3024
> +#define RKISP1_ISP_MAX_WIDTH			4416
> +#define RKISP1_ISP_MAX_HEIGHT			3312
>  #define RKISP1_ISP_MIN_WIDTH			32
>  #define RKISP1_ISP_MIN_HEIGHT			32
>  

-- 
Regards,

Laurent Pinchart

