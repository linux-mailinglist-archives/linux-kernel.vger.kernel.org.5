Return-Path: <linux-kernel+bounces-137048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923A89DB96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B91F22CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F54131E34;
	Tue,  9 Apr 2024 14:01:23 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AE131BCD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671282; cv=none; b=hERMWRmmSXqtdpXVOo2ELcDvHFnA2gVw/hEJZ3GN6iPga0ijPCT3nMCUxFHnRsVeuuk3dRzIVZywQXwJe+JSuOxnwtXXwVOWrh40OaYd4gu/CKBS2meZFSwDiHYW3KWFzG+/Lli2+0ttTig8K04Hqhv/NgcnOhn0BN0ffvFVzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671282; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNFoAcJdfXwlISrF0vBYdnDaZOpSVydS+2QznThz6Rl2lrF8euVAxsqvMwVTheRjPLCAd+Fhqs68WzABu+6sfx4D08+USSVZgc6nB6tkyXqkvtEkiNuC0bjMhyeF9FH+1Oy4kvmKCWWEB5zbaOOs3STg1K8a1FpGK49nYXejwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71AFF68D09; Tue,  9 Apr 2024 16:01:18 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:01:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] nvme-fc: use nvme_ctrl_reconnect to decide
 reconnect attempts
Message-ID: <20240409140117.GD20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-6-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-6-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

