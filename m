Return-Path: <linux-kernel+bounces-29075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45C8307EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFD428624C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E07208AD;
	Wed, 17 Jan 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VMn4qsHi"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B28208A0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501422; cv=none; b=PA7Z5t9jdEkBOXcwyrlXrYwJF0MDSsv7Ramq/egDboOCYPunjyCcHlcDf1n/KA8QnyWf7WCIsk1OAgg6hEYsnMFDvk8DbUWevmHZNSKU4e//y4AkxbyRd/Z2MHcD6a0G3ExPf5RAw5H7Nv3S1gQ/OqbPSg7OM+w1gTK5UDiLLEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501422; c=relaxed/simple;
	bh=dXOeYu9ggWmzyIC3akHRQqTJ5XlpJZMzEgPrXY4d6mw=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ZtOqr6OYcMvPO5F13YdtJRBtTJPgK3DrTy41Nx3aUuIw2VSatT59A9rDgfndpGVXF9XZUXMm4ebVwAyV0oKMVwt1qNYLm5oSuLY6vOwwxY2DOxi9tM/bqhvCa7ug7u+/rICTKn/8z4D3BmO4fOu8e5IHFhsuu7glS5fMBrCSTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VMn4qsHi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F08D07EC;
	Wed, 17 Jan 2024 15:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705501350;
	bh=dXOeYu9ggWmzyIC3akHRQqTJ5XlpJZMzEgPrXY4d6mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMn4qsHi7ppcVV7CoFFLGYd3xK0BxH1krOxGyszjba1Yx6FK/Q7ezXi30c0Xj9/iq
	 LjwFAQ0S4mgRKeMx8cTtdAF4DcXqrUFyD0XuQVE+uDqtrzfQR/GUIiYztLReCQU9pD
	 VDNKDVQIEd5Dv7kuNn5paKz9VebqmbHJGGQMVa14=
Date: Wed, 17 Jan 2024 16:23:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, daniel@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
Message-ID: <20240117142343.GD17920@pendragon.ideasonboard.com>
References: <20240112234222.913138-1-anatoliy.klymenko@amd.com>
 <6jhwss2wego6yoo5mwmphwawhsj5bbj62gwrzcpapoixwkrkli@g4fbxdooopby>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6jhwss2wego6yoo5mwmphwawhsj5bbj62gwrzcpapoixwkrkli@g4fbxdooopby>

On Mon, Jan 15, 2024 at 09:28:39AM +0100, Maxime Ripard wrote:
> On Fri, Jan 12, 2024 at 03:42:18PM -0800, Anatoliy Klymenko wrote:
> > Patches 1/4,2/4,3/4 are minor fixes.
> > 
> > DPSUB requires input live video format to be configured.
> > Patch 4/4: The DP Subsystem requires the input live video format to be
> > configured. In this patch we are assuming that the CRTC's bus format is fixed
> > and comes from the device tree. This is a proposed solution, as there are no api
> > to query CRTC output bus format.
> > 
> > Is this a good approach to go with?
> 
> I guess you would need to expand a bit on what "live video input" is? Is
> it some kind of mechanism to bypass memory and take your pixels straight
> from a FIFO from another device, or something else?

Yes and no.

The DPSUB integrates DMA engines, a blending engine (two planes), and a
DP encoder. The dpsub driver supports all of this, and creates a DRM
device. The DP encoder hardware always takes its input data from the
output of the blending engine.

The blending engine can optionally take input data from a bus connected
to the FPGA fabric, instead of taking it from the DPSUB internal DMA
engines. When operating in that mode, the dpsub driver exposes the DP
encoder as a bridge, and internally programs the blending engine to
disable blending. Typically, the FPGA fabric will then contain a CRTC of
some sort, with a driver that will acquire the DP encoder bridge as
usually done.

In this mode of operation, it is typical for the IP cores in FPGA fabric
to be synthesized with a fixed format (as that saves resources), while
the DPSUB supports multiple input formats. Bridge drivers in the
upstream kernel work the other way around, with the bridge hardware
supporting a limited set of formats, and the CRTC then being programmed
with whatever the bridges chain needs. Here, the negotiation needs to go
the other way around, as the CRTC is the limiting factor, not the
bridge.

Is this explanation clear ?

-- 
Regards,

Laurent Pinchart

