Return-Path: <linux-kernel+bounces-105548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3EE87DFF7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2E01F215B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148D200DE;
	Sun, 17 Mar 2024 20:23:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077079E3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706993; cv=none; b=l2DmfRw9HrtSRMSK/dr5EFwcqjEmAuCK055MIS4jE9KiDCRKHRU9iP3skzsD/QMKn6TDvLna80TSAOcKiIuv6naOzOJxQr16VSKoEc1l9u+L73nYqAHNcD6QC1hsqwV1yXhySvTLKwnOhvn1nOFtgFPwMhwL4lFEsO2dgdoTaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706993; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKepg7zM+kn3S75reAb8e5dmiUBeWlkGaeNrLiycb1+5PtWfglfpG8yTe8a9vMgkhV2nmSY4CBqibWcx2BNZczfKwlcs86+386r5/3WlwE9Mk+EPULhVL0x8IvfVTPbL82Co6KN3Tg/PiQ/FbZQtRRiZSn3f6sIbmlfi+VxPCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D3FA67373; Sun, 17 Mar 2024 21:23:01 +0100 (CET)
Date: Sun, 17 Mar 2024 21:23:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: iBug <i@ibugone.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Message-ID: <20240317202300.GA5593@lst.de>
References: <20240315192747.1749119-3-i@ibugone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

