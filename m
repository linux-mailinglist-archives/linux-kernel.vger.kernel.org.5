Return-Path: <linux-kernel+bounces-116799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D888B219
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6806BB60C47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154212D767;
	Mon, 25 Mar 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Xyi6vghX"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822A181CEC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361242; cv=none; b=MpvXB+Ln9u+OrErOWwTNOXKMmKjT0dGUX9NGvthPDt99+VXzZQfx0jh0mrW8yEKpc1dc2XG+bhFeOB0luyEwb3kZBisCxgbOSJ6e62Mfu5oBZVBujR5ZwxkyWqgFFhniIA2OARLDZ+hgG1D0PzSdYNJIaVzOfavOtuxEPZz8h9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361242; c=relaxed/simple;
	bh=MXPVqAABq7kB9ZThxwEzUc/ew8Bqvh+Zyd4mkqv/lus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwLs9Hd2PHvVNZSmUSq93F4RagporYXZ5EOJdV+StFmr+ukcrjawG+A5myi9Y4rryp/2o5L8vgdtzrWPfBjDTK9/PJ+7XFqPrn9h17LB9fwAeITnkZ2fxizNVSjsB2xpFzkyazZsenKb7T0F2yeZcz4WehTeXKk5zimG+l8lbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Xyi6vghX; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 472731484B07;
	Mon, 25 Mar 2024 10:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1711360765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CamFrT0reqTDJ7jbhj/1NySGwvpXr3L1a1Ko18MM4wI=;
	b=Xyi6vghXh4FTX8vYs+zIjiiogALaahRNb8Cc56dQkwsVwBkWneolgu3D9b5oH9WkpSzQSo
	WlkfY/7V5NvgfWugGODt3oLdnWpkGXsKKOzcPKb2gpbi5PWrxFVzV3px1PM5VblbbZHiXy
	8Hk4lwaZwyBFxjHTOA6uc4KVYr7tkdxbhRxsqwIfECkHQQfTKirrt3u7GoRo/BYM0wRl3h
	YLzciLsQW+/zekSNbvuUzAg2fxwkUbvxkybccTsPHpN4GB/0LlUeWH1qpE0k9FFNhgjBz9
	f0oilnIchjFMWGvTP4k1VzgolnqWYQ/7SuETD/SkMh81+GxqPdzsLXAfk1tqOg==
Date: Mon, 25 Mar 2024 10:59:09 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Dahl <ada@thorsis.com>, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240325-dig-user-c4b9af6f8ea2@thorsis.com>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
 <20240306164831.29eed907@xps-13>
 <20240307-pantry-deceit-78ce20f47899@thorsis.com>
 <20240307181931.440c9c3f@xps-13>
 <20240325100917.502c75b7@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325100917.502c75b7@xps-13>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Miquèl,

Am Mon, Mar 25, 2024 at 10:09:16AM +0100 schrieb Miquel Raynal:
> Hello Alexander,
> 
> > > > > The condition is true and nand_change_read_column_op() returns with
> > > > > -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> > > > > that code path.  Those are probably initialized later, maybe with
> > > > > parameters read from that ONFI param page?
> > > > > 
> > > > > Returning with error from nand_change_read_column_op() leads to
> > > > > jumping out of nand_onfi_detect() early, and no ONFI param page is
> > > > > evaluated at all, although the second or third page could be intact.
> > > > > 
> > > > > I guess this would also fail with any other reason for not matching
> > > > > CRCs in the first page, but I have not faulty NAND flash chip to
> > > > > confirm that.    
> > > > 
> > > > Thanks for the whole report, it is interesting and should lead to fixes:
> > > > - why does the controller refuses the datain op?    
> > > 
> > > See above.
> > >   
> > > > - why nand_soft_waitrdy is not enough?    
> > > 
> > > I don't know.  That's one reason I asked here.
> > >   
> > > > - changing the condition in nand_change_read_column_op()
> > > > 
> > > > Can you take care of these?    
> 
> Now would be a perfect time to send these fixes. Could you work on them?

I'm sorry, no not yet.  Have some more important work to do, which
will take another one or two weeks before I can return to this
problem.  Will have to wait, at least from my side.

Greets
Alex

> 
> Thanks!
> Miquèl

