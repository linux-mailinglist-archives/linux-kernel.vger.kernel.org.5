Return-Path: <linux-kernel+bounces-142017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE238A2639
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7971F2486A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAB200D4;
	Fri, 12 Apr 2024 06:09:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6358405C7;
	Fri, 12 Apr 2024 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902165; cv=none; b=lACwUPHfNvOPK7gM2dZVCFFHdzRYeq3Yza03OMUGYfuvY2J8RwpC36B/hpRdee8dHxGDBjADpe8Of+3bjF+3OhNMWQ+3wduC3MzZxoX8yB8l1svLEOI86UfmW3vLudTWhojRLJJnpLmQFeLns0Riz+Mcx6jF3OplQel1HMBZRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902165; c=relaxed/simple;
	bh=B43YITOTJ3PvlVPOv1ZEx+gz59dcQ4HvtELcT4QVYE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2TGSoDcZcZonc7cVx1UGoihvGffNYq/buUQ4k0ZC4bCdI2aUkwHzl+0GMfHexeq9Y28cSlcyu+p3is6RV7xt6fV56CtVKOQYIOCB/K+tY9sBDNBcNqyMA0vDEbELh0T10A1P21SZiiCKJYWEcAiPdC0hro+rsvpUcL87ZSNyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C35A068B05; Fri, 12 Apr 2024 08:09:11 +0200 (CEST)
Date: Fri, 12 Apr 2024 08:09:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20240412060911.GA32268@lst.de>
References: <20240412154607.1b5096b3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412154607.1b5096b3@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)

looks like the scsi tree failed to pick up:

uas: switch to using ->device_configure to configure queue limits

somehow, which was the commit just before the one removing
blk_queue_max_hw_sectors in the series.


