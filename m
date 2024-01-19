Return-Path: <linux-kernel+bounces-31131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EDE83297E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57241F235F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEC4F209;
	Fri, 19 Jan 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TgVqGdpd"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EF4EB2A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667401; cv=none; b=lGkZy+J1AsZi6yZ+i3IRdAc409YeH1qNI08S5Xay5ZT/qC78WWNayUpkHnkrXVCcBOAJ4wRaGQ8OHsqbSQskGmS55vKcyvlIbfkOoxIMc86G/Dxw8s2Xp7oA/2SFhVpcVrPFh4Hz9SxCvTbbCkk0bu3FwsQO3QANXou927XxjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667401; c=relaxed/simple;
	bh=LNk3nH8fFJa5teGVSdqfmDXLmD5Kzly/lQCrOP+9xSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEzcgiXu/8I05Dtt/11IIzIx0uX5ugaxAY1UfTiHTSD7PeN/9jB1nSdogJ0gHRe7sboozakTqBAzgpS4rMAqUbct62njUWnGjguPo1Kb/xp9T1B0giIEqyRzvX52eGF/88tYaDQHVI6gsJeOUJuZzIYYT80ElYlsoW4tWh0Ck+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TgVqGdpd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B4A59512;
	Fri, 19 Jan 2024 13:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705667320;
	bh=LNk3nH8fFJa5teGVSdqfmDXLmD5Kzly/lQCrOP+9xSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgVqGdpd0PjcqnI+5ZdE4TirX1GZMiqRURSHbIrnOvmb3U4wz7ivFGH4QLQ2YkyEU
	 7E3qebfIF4ueQvoPe/kHQVatuRrQiKawtM1iaAojL04vEqV7QopT2rDh1ceYoFuH+S
	 cPkyKziReuVVz0OaXT2w5JZk29VjmX/L02qkwcJ4=
Date: Fri, 19 Jan 2024 14:29:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Klymenko, Anatoliy" <Anatoliy.Klymenko@amd.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	"aarten.lankhorst@linux.intel.com" <aarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"Simek, Michal" <michal.simek@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm: xlnx: zynqmp_dpsub: Don't generate vblank in
 live mode
Message-ID: <20240119122954.GA13388@pendragon.ideasonboard.com>
References: <mailman.1660.1705501214.2415.dri-devel@lists.freedesktop.org>
 <MW4PR12MB7165B7BEA23F4C4185A48EE9E6702@MW4PR12MB7165.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW4PR12MB7165B7BEA23F4C4185A48EE9E6702@MW4PR12MB7165.namprd12.prod.outlook.com>

Hi Anatoliy,

On Fri, Jan 19, 2024 at 05:53:30AM +0000, Klymenko, Anatoliy wrote:
> On Wed, 17 Jan 2024 16:20:10 +0200, Tomi Valkeinen wrote:
> > On 13/01/2024 01:42, Anatoliy Klymenko wrote:
> > > Filter out status register against interrupts' mask.
> > > Some events are being reported via DP status register, even if
> > > corresponding interrupts have been disabled. Avoid processing of such
> > > events in interrupt handler context.
> > 
> > The subject talks about vblank and live mode, the the description doesn't. Can
> > you elaborate in the desc a bit about when this is an issue and why it wasn't
> > before?
> 
> Yes, I should make patch comment more consistent and elaborate. I will fix it in the next version. Thank you.
> 
> > 
> > > Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> > > ---
> > >   drivers/gpu/drm/xlnx/zynqmp_dp.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > index d60b7431603f..571c5dbc97e5 100644
> > > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > > @@ -1624,8 +1624,16 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
> > >       u32 status, mask;
> > >
> > >       status = zynqmp_dp_read(dp, ZYNQMP_DP_INT_STATUS);
> > > +     zynqmp_dp_write(dp, ZYNQMP_DP_INT_STATUS, status);
> > >       mask = zynqmp_dp_read(dp, ZYNQMP_DP_INT_MASK);
> > > -     if (!(status & ~mask))
> > > +
> > > +     /*
> > > +      * Status register may report some events, which corresponding interrupts
> > > +      * have been disabled. Filter out those events against interrupts' mask.
> > > +      */
> > > +     status &= ~mask;
> > > +
> > > +     if (!status)
> > >               return IRQ_NONE;
> > >
> > >       /* dbg for diagnostic, but not much that the driver can do */
> > > @@ -1634,7 +1642,6 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
> > >       if (status & ZYNQMP_DP_INT_CHBUF_OVERFLW_MASK)
> > >               dev_dbg_ratelimited(dp->dev, "overflow interrupt\n");
> > >
> > > -     zynqmp_dp_write(dp, ZYNQMP_DP_INT_STATUS, status);
> > >
> > >       if (status & ZYNQMP_DP_INT_VBLANK_START)
> > >               zynqmp_dpsub_drm_handle_vblank(dp->dpsub);
> > 
> > Moving the zynqmp_dp_write() is not related to this fix, is it? I think it should be in
> > a separate patch.
> 
> The sole purpose of zynqmp_dp_write() is to clear status register. The
> sooner we do it the better (after reading status in the local variable
> of course).

No disagreement about that. Tomi's point is that it's a good change, but
it should be done in a separate patch, by itself, not bundled with other
changes. The usual rule in the kernel is "one change, one commit".

> We can also reuse status variable for in-place filtering
> against the interrupt mask, which makes this change dependent on
> zynqmp_dp_write() reordering. I will add a comment explaining this. Is
> it ok?

-- 
Regards,

Laurent Pinchart

