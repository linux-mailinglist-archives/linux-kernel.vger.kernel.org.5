Return-Path: <linux-kernel+bounces-149992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FC8A98DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FD0282BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456215E7F1;
	Thu, 18 Apr 2024 11:43:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2156464
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440608; cv=none; b=BwZyYLQ3RyjxwN5Lun7jAgCAxyxeakTqnZDR4JPalB5G0SE+3/cZUJUBLQqxRyz6Bec5NeJyXwZo1qGn8yuizVvi4RwYTa0+yscSq1pVg+NQ6UGWHDmKO/kNpbtC+nRH3RBMeC/DnmpghAOtHbjzA+uKNxq7KHLlYSliTzyK+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440608; c=relaxed/simple;
	bh=hjgxql/TvoPEfUZHDYJEYDtWin16CxsW4II6SCrMIaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejYM8Py9vxPtl8NXSoMdfcBRzcJCBSXW91jkvj7Jg5R30DX0IkS3BNFsVSDb9oACL0OlMpwl8j5XsDb7yrC3dKSOiMGz8IMin483X60mf2VvS5+HlfJQ/zuLUTOBjwMGTiVD3b0c1tMpUb7OIoQNE7KyJ+LjG8rY+oZtR2XkD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rxQAe-0005H2-QC; Thu, 18 Apr 2024 13:43:16 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rxQAd-00Cxsn-Kq; Thu, 18 Apr 2024 13:43:15 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rxQAd-001Wn2-1o;
	Thu, 18 Apr 2024 13:43:15 +0200
Date: Thu, 18 Apr 2024 13:43:15 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <ZiEHUz3wicDJscGP@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
 <20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
 <ZiDCKGlG4MZ23Tqo@pengutronix.de>
 <20240418113244.6e535d3f@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418113244.6e535d3f@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2024 at 11:32:44AM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 08:48:08 +0200:
> 
> > On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote:
> > > The NAND core enabled subpage reads when a largepage NAND is used with
> > > SOFT_ECC. The i.MX NAND controller doesn't support subpage reads, so
> > > clear the flag again.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> > > index f44c130dca18d..19b46210bd194 100644
> > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_device *pdev)
> > >  	if (err)
> > >  		goto escan;
> > >  
> > > +	this->options &= ~NAND_SUBPAGE_READ;
> > > +  
> > 
> > Nah, it doesn't work like this. It turns out the BBT is read using
> > subpage reads before we can disable them here.
> >
> > This is the code in nand_scan_tail() we stumble upon:
> > 
> > 	/* Large page NAND with SOFT_ECC should support subpage reads */
> > 	switch (ecc->engine_type) {
> > 	case NAND_ECC_ENGINE_TYPE_SOFT:
> > 		if (chip->page_shift > 9)
> > 			chip->options |= NAND_SUBPAGE_READ;
> > 		break;
> > 
> > 	default:
> > 		break;
> > 	}
> > 
> > So the code assumes subpage reads are ok when SOFT_ECC is in use, which
> > in my case is not true. I guess some drivers depend on the
> > NAND_SUBPAGE_READ bit magically be set, so simply removing this code is
> > likely not an option.  Any ideas what to do?
> 
> Can you elaborate why subpage reads are not an option in your
> situation? While subpage writes depend on chip capabilities, reads
> however should always work: it's just the controller selecting the
> column where to start and then reading less data than it could from the
> NAND cache. It's a very basic NAND controller feature, and I remember
> this was working on eg. an i.MX27.

On the i.MX27 reading a full 2k page means triggering one read operation
per 512 bytes in the NAND controller, so it would be possible to read
subpages by triggering only one read operation instead of four in a row.

The newer SoCs like i.MX25 always read a full page with a single read
operation. We could likely read subpages by temporarily configuring the
controller for a 512b page size NAND.

I just realized the real problem comes with reading the OOB data. With
software BCH the NAND layer hardcodes the read_subpage hook to
nand_read_subpage() which uses nand_change_read_column_op() to read the
OOB data. This uses NAND_CMD_RNDOUT and I have now idea if/how this can
be implemented in the i.MX NAND driver. Right now the controller indeed
reads some data and then the SRAM buffer really contains part of the
desired OOB data, but also part of the user data.

We might overcome these problems, but I am not sure if it's worth it.
It's ancient hardware that I don't want to put too much effort into and
I doubt that the end result would have a better performance when we need
one operation to read the subpage and another one to read OOB as opposed
to always read full pages (which is only one operation, say one
interrupt latency, for each page read).

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

