Return-Path: <linux-kernel+bounces-119578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578588CAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE30B26752
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C81CD2E;
	Tue, 26 Mar 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="llFVUWay"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB621C6A7;
	Tue, 26 Mar 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473760; cv=none; b=SbZsEJh2a3qrE8KAapopuzzEywBOTBU+PIM5nKrb6qX1NMHCYJi3hZV65VKm+R7pilJn7MAiZQRCWTrj67oUi2fmDQ4T/0CfvJqgbJZ6Jm0JfP+jmDNYd2Dz/QDjke7h4FOxSPNU3gM+u4rDjSZJtQOSrycngeWuJ2KWPBSbAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473760; c=relaxed/simple;
	bh=i4uivnnh8i2q001tS5Bd7nvc5UIKJwi5G4X7w6z2GNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTDrJkS+WKNXaSQB9bA9LQdjqwsrQw/TiH5zgVuumqbiRUl/1lz0uLFnvpAjTL6DRjfGpOi02JXMi4hg3LGPUAWq732TOdBrkdHC+3pcpYhPYOl70Vgjbc4zV//88G48SXV9DGHEiUdVBgNZ3BH4ipnDr3qH19tvL1xFmfNL0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=llFVUWay; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6h251yPm3Wq8t9b+kki+EUWkMfqnGE1o7gX8jrHKETs=; b=llFVUWaynBRFvK8YyipYYct6gP
	jJw6+dgHp82GLWT5Gpu92J9gOygVCQSrYYexUCkC3TYGG9J5+3uLMihC4EN9VhGxKZwvcxv5hrNCL
	Zc8zR95+cIS58lQ6aGC0BG/ew77FoKczFxQ+VnUGzustvC+fnMBkgw0Eaf8fNeE44kdYdnG65Uqsj
	+LfAilcrtQxaTTm+zkOVTV6mVoZ8P7Rzox1rDeqxmkcun4fMvcHv7jrZkFunJejWKMQKReY+KDnSR
	YD2cNy0Zyi90pbcSN3KBo+kz/rOOcrxBx0XsNJ8XrqSCuAwwLg782/gdTgx47Xt3+F8GJ0z2j+45/
	Bn3rx+eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAVR-00000005haW-12YU;
	Tue, 26 Mar 2024 17:22:37 +0000
Date: Tue, 26 Mar 2024 10:22:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Avri Altman <avri.altman@wdc.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: Remove support for old UFSHCI versions
Message-ID: <ZgMEXZffmEqyRgVU@infradead.org>
References: <20240326083253.1303-1-avri.altman@wdc.com>
 <20240326083253.1303-2-avri.altman@wdc.com>
 <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3a83b5-6dc7-40d2-8a2e-bd5157a3f8ea@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 26, 2024 at 10:20:13AM -0700, Bart Van Assche wrote:
> On 3/26/24 01:32, Avri Altman wrote:
> > @@ -992,10 +976,6 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
> >   u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
> >   {
> > -	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
> > -	if (hba->ufs_version <= ufshci_version(1, 1))
> > -		return UFS_UNIPRO_VER_1_41;
> > -	else
> >   		return UFS_UNIPRO_VER_1_6;
> >   }
> 
> Please fix the indentation of the only remaining return statement in
> this function.

Even better just remove the function and use UFS_UNIPRO_VER_1_6
directly in the two callers.


