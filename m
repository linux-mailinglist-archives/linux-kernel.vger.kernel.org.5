Return-Path: <linux-kernel+bounces-70583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D1859976
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1FAB20CED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2D73183;
	Sun, 18 Feb 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Ed+rRW5Z"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9CC8C1A;
	Sun, 18 Feb 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708290124; cv=none; b=s8rLILAl0WlnARJDdhi82GuvhrIvs2RskK56E9BvARGkdLPRl3XiJncl1rDnk1xGe8r1k8XIi7RGttnyhxXdRQLrP1AkFD1UfP3/1c40qX8mJK0ty6WOLZR7pK/psAWJmm9XXAxCnjGsdeyIKQ/sRjNJwQYRbyMpD4F1kIdtLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708290124; c=relaxed/simple;
	bh=39o8JnW8nz8KkMiUIzgrvI2AwghlyIJYXxtWjH0s304=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to6j0de+l5S+ocGVncomYGjNOtu/YvCnuQzX0PObfUpQzhFY8ctNkMFznRt3RsRrIO+6LeBL7Kr5SQXMpVcaERoMylvWoBzo5nBJdBeYm/hDxQKEBOAaJn41LJWpBGnLap/22sasqe9Pe930Fe5YQWv/f7ZCFB4+HPfiYgiLpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Ed+rRW5Z; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708290112; bh=39o8JnW8nz8KkMiUIzgrvI2AwghlyIJYXxtWjH0s304=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Ed+rRW5Z7tE2mZTY1jKHk27CkPudDtGQ1cbiuMoBxacypMSu9w8G34XjGJOQFHrIL
	 k/mT6zz8U+8rbLJalPRs7hwgdGqw5pUPvCzO0vm0A9giknFGRsxVtsEgkkCW5WPkuX
	 h+isHpPP7Abm4idu09TyETKNShxT8nbo97FBJtes=
Date: Sun, 18 Feb 2024 22:01:52 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>, 
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, Paul Elder <paul.elder@ideasonboard.com>, 
	Umang Jain <umang.jain@ideasonboard.com>
Subject: Re: [PATCH] media: rkisp1: Allow higher input resolution
Message-ID: <pftafukuzq7qzbhlvwtmeg3mburnttylgy4246timlghtrdgx4@r6munvmj6oqt>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, 
	Dafna Hirschfeld <dafna@fastmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, "open list:ROCKCHIP ISP V1 DRIVER" <linux-media@vger.kernel.org>, 
	"open list:ROCKCHIP ISP V1 DRIVER" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, Paul Elder <paul.elder@ideasonboard.com>, 
	Umang Jain <umang.jain@ideasonboard.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240217185202.1754750-1-megi@xff.cz>
 <20240218205908.GA12766@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240218205908.GA12766@pendragon.ideasonboard.com>

On Sun, Feb 18, 2024 at 10:59:08PM +0200, Laurent Pinchart wrote:
> Hi Ondrej,
> 
> (CC'ing Paul and Umang)
> 
> Thank you for the patch.
> 
> On Sat, Feb 17, 2024 at 07:51:58PM +0100, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > In BSP driver, it is allowed, and it works in practice. Tested on
> > Pinephone Pro/RK3399 with IMX258 at full res.
> 
> Paul, Umang, do I recall correctly that you have a similar change ?
> Could you review and test this (especially on the i.MX8MP) ?

It's also a limit from the datasheet, so the change should not be that
controversial:

  https://megous.com/dl/tmp/d2b333043ecebaf3.png

(so that it doesn't sound like I just copied the BSP values)

regards,
	o.

> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> >  drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > index 4b6b28c05b89..74098ddbeeb3 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > @@ -33,8 +33,8 @@ struct dentry;
> >  #define RKISP1_ISP_SD_SINK			BIT(1)
> >  
> >  /* min and max values for the widths and heights of the entities */
> > -#define RKISP1_ISP_MAX_WIDTH			4032
> > -#define RKISP1_ISP_MAX_HEIGHT			3024
> > +#define RKISP1_ISP_MAX_WIDTH			4416
> > +#define RKISP1_ISP_MAX_HEIGHT			3312
> >  #define RKISP1_ISP_MIN_WIDTH			32
> >  #define RKISP1_ISP_MIN_HEIGHT			32
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

