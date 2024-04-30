Return-Path: <linux-kernel+bounces-163313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE708B694A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB771C219FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15397125BA;
	Tue, 30 Apr 2024 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ygYcon6u"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D2101C5;
	Tue, 30 Apr 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714449854; cv=none; b=S1or4uFZt6B6Nb6txl3Z2mmyPHqdYYJK5FdDDFvQ+iKmC0ggyBVNwOP/pcd0htqCce/BnsRHWjLWfJQBuW3hEo65QDFapjwLYtBZlYVXat7Y/u1+MK6MWSctQV+6o1g760E/J58gviRieni2oY/aXlAeAQt7Nk77UwhCybJBzdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714449854; c=relaxed/simple;
	bh=xquYkdl9fpC+Wtb+uNSGETdm8v6yEqPydZ0+Pzg3qgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq1VohRHK0EFAEEzJkt8rddurMzzSZ6zYd9rTUEKJ0iouCCkaUEF73I9Uc5PPkfbmjsf5RCpwW2Nbt68CWl/9t1/WZQeSuANwEauV4pCfM/BDpFGkTQ6VJIJDGTAlzGL6tVEivwqeRNjlpVoFlKc7apx41dgui3gA/1JGmqq5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ygYcon6u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cc+/1xCquATq7FO6eqR8t3cu5To1zwP4PfeaYzwibME=; b=ygYcon6u+jC+Jl55WVeEYJm703
	J1rriCyFT2G+/Pn2LZnU9UoMC8vwxFmABUJz74+YLijBxCsgIdBi8j+gAq867BDTjKUsIIuJU8245
	TaDr1fqX9HlBLkUt91nrh73ciReXhJ1AnCQJNPlPOqTWfF4D6+rhceGAheF0JIaqhzwiBAXo6wtRK
	2WB+fea1l1SgR4qQDrQUpJo5kcNmAiTlmapV+gNuSWn+HCW0RUp6juUrWOnTntDm22Au2KNHCJfi5
	4QBULQfXtIeXXe8BkRWjKXdJWCDh87FBDqgQVmIdQRUMNCjNw/3aSFyGnvfJ/cJAMe1QPP9ISQK18
	jOWXwLWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1eiw-00000004zYR-48Wf;
	Tue, 30 Apr 2024 04:04:10 +0000
Date: Mon, 29 Apr 2024 21:04:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 1/2] xfs: Remove duplicate xfs_da_format.h header
Message-ID: <ZjBtuvRX4vncJGMs@infradead.org>
References: <20240430034728.86811-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430034728.86811-1-jiapeng.chong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 30, 2024 at 11:47:27AM +0800, Jiapeng Chong wrote:
> ./fs/xfs/libxfs/xfs_trans_resv.c: xfs_da_format.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8931

I don't think we do Closes for random bugzilla, never mind for trivial
cleanups.

The changes itself looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>

