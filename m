Return-Path: <linux-kernel+bounces-42951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080C084092E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A87C1C24C78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E90A15350F;
	Mon, 29 Jan 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTBklRkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D31534FE;
	Mon, 29 Jan 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540357; cv=none; b=ktcVcUOhY23jZo5OyJ6kfGOdnGK27Ft0EQCXz+H9AwIWrSRSy/LT6NG2pmUxOfgoaf4bTzYxUhKBl1w/E6ytFLBFX33NQX/8IfsBAG+0PyppLUmvCaj0DJr3wM3yuyFUGsjAaDIIMhrgQWX6/bkeaRz6EtgQxr92NC0Wro7QMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540357; c=relaxed/simple;
	bh=dQ1Gwrgs5POChbIuoLTiLMOiQb1TAN6CCHquky5LaAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjjRoVtIMOaXEO9bNZ0VYjLblOt396kIg1CSqtsz8GHJL9dL+cIYBwOjr/fOIYM3oq7Mdjy9VbLXSAJz0FXN0fomyxVc20IZauqxRmTTE54QIr3iTpuCiVE28IpE0SVrNxlWml0N2NOCG2ExZ1fSCs/wqm3++6kz+8zQXw0DHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTBklRkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A4C43390;
	Mon, 29 Jan 2024 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706540357;
	bh=dQ1Gwrgs5POChbIuoLTiLMOiQb1TAN6CCHquky5LaAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTBklRkRp96RdakC6VQ21Rfk6mbN1kj6NTpnajD754go9Ld1O2w1FnvYZ8EpJwvL+
	 /5OFhQMJasgfkrJeYaVPoiDdNoMUjti7RharV+W99DAazSyePdgOq21H2GvDOx1+RN
	 J99eHnoWZ2vgOLgBFBwjJjGAMBD1aW3rFJWsGobw=
Date: Mon, 29 Jan 2024 06:59:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: Re: [PATCH] usb: uhci-grlib: Explicitly include
 linux/platform_device.h
Message-ID: <2024012905-sulphuric-collie-7ede@gregkh>
References: <20240122082225.984523-1-andreas@gaisler.com>
 <2024012740-amaretto-unvarying-465a@gregkh>
 <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>
 <2024012943-print-wronged-e884@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012943-print-wronged-e884@gregkh>

On Mon, Jan 29, 2024 at 06:58:50AM -0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 29, 2024 at 08:41:50AM +0100, Andreas Larsson wrote:
> > On 2024-01-28 01:31, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 22, 2024 at 09:22:25AM +0100, Andreas Larsson wrote:
> > >> This fixes relying upon linux/of_platform.h to include
> > >> linux/platform_device.h, which it no longer does, thereby fixing
> > >> compilation problems like:
> > >>
> > >> In file included from drivers/usb/host/uhci-hcd.c:850:
> > >> drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
> > >> drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
> > >>    92 |  struct device_node *dn = op->dev.of_node;
> > >>       |                             ^~
> > >>
> > >> Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
> > > 
> > > I don't see this commit id in Linus's tree, where is it?
> > 
> > Ah, sorry, it went into Linus's tree with a different commit ID. I
> > should have referred to ef175b29a242.
> 
> Please fix up and resend.

Ah you did, just hadn't read all of my email yet, sorry for the noise...

