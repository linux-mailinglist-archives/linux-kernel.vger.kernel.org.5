Return-Path: <linux-kernel+bounces-77846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B57860AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9911F25510
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827712E72;
	Fri, 23 Feb 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HlVkx3mN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92671191;
	Fri, 23 Feb 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670950; cv=none; b=NcxSXBepedPEVIOLeZR/JRglMaaRXM8VogXoJCGMTiLDRo3gj20tq//eTV7nfUiRKpPJccJEpPtIU0JAEiEfEz4ElgPx2CXv4VjDU9UPjCvvT+JfGqv+EQBwyBuFn/j26sRzKW5EZ4ndELb0M3C7NtUMCLQ2K1iSgMfKq7zbRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670950; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDOytqNsEu2thQF1aZRiHj+MqpK4iJsZgLTBJGUsrxGzKweRefptOKGVBVtYm2bDRLiRfRYC4PqzJAUcE263z3jqaWrR79SGQsWBuCWF+ZZ7UQaQnFXS0mPwTD2WvU7Nb7jBtKvsB8BPXe2pXGmkCusL4hw6ZkyfPMRBv8IWh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HlVkx3mN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HlVkx3mN8anTHOwMUkMm246ur6
	Uy23FJrkfCC1kYBYpVKCVP2Rhq+veB/i0p1v7riMyZ57wsrRtj0+5Ve+uceBa5gqeyK9i1LWuLVY7
	WZlfz0RCDWt0fS8vXH0UgamcRauanonw6SxFR3eIh98wR2JKAkpJawEhiFKczDt6R155IKwyDHJlP
	qyuP8DaxKJ66RF2tcQRfICfsGF8ZjjNebq7xOT0vkik81vq5JIx4Ya+l32A+ffOX9HjBXPvr5WBpQ
	wy43IFHsE+QCka0D4+pF1Jh3SDUMxsEpHAyVjV06I/Cie2MdG1tmVt/QnBv5v9g9fW6emvgc3+85w
	VMagbtjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPMZ-00000008DVc-36Ko;
	Fri, 23 Feb 2024 06:48:51 +0000
Date: Thu, 22 Feb 2024 22:48:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com,
	linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2] block: fix deadlock between bd_link_disk_holder and
 partition scan
Message-ID: <Zdg_00aGej3p-uhF@infradead.org>
References: <20240221090122.1281868-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221090122.1281868-1-linan666@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

