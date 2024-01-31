Return-Path: <linux-kernel+bounces-45829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D88436B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA9F1F220B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A013F8E0;
	Wed, 31 Jan 2024 06:28:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608833F8D8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682493; cv=none; b=X9U1GglMaH/cijFqZYnBKTzPTh0PUzvegkFInQ886C73zRlm82bNpNJJEAXKyOsaA82eFPqTgGx2isZ6opc1WDpcGpL6N+vabdaiuNSs4A2gETHsJrKYVB4JPPSd2CXc0BceUt9VZg4F5yPgoWBMw6onfWix44Q18pTx+aXF/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682493; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiKN1CB33MQ+YsLNGDPg/9irNVsPSnkeZgMnFu6Dq3Sz13S/BRjySpbJKUfa/jyonHC/cVdVvnq8cUwWGSwxmpTwCjM89EW+gaL13/+7oL+7L2ieGTqwPcNwjU6lgsPlcYCYgXvoUmeDoOEFUzIMbrMWOtlHUYzw0Q1sgef5DCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39ED868B05; Wed, 31 Jan 2024 07:28:09 +0100 (CET)
Date: Wed, 31 Jan 2024 07:28:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/12] nvmet-fc: do not tack refs on tgtports from
 assoc
Message-ID: <20240131062809.GG16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-9-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-9-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

