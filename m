Return-Path: <linux-kernel+bounces-5148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34481871D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08503286BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E61918645;
	Tue, 19 Dec 2023 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ixqChi/6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9D1804D;
	Tue, 19 Dec 2023 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ixqChi/6uDbV0hCMZ6+muKrEck
	VHqGbw/nDFSWW8AMCFftBnCA7MELrj2s7mv6D7vkYtFcfLbwGtoVcfG20fG7NBqvCp0nT/0k1SPOL
	1+V8qc8jmIUP35+31rmbhWvVidts68XvYHJurOAlw/LF3IcOaMX547NQDx4qeR4Mmko0kadBdJZnV
	aOnyw60ZIrfZEw8uq9JlIrsXdN+UCr8bQ9puZcucCHsCXnyKtnxqXWCV6LgIdO6hUAWImsa3CD47q
	b0QFsLRqiHpy8hefuLkoEhy90bGIR99ETwYqqdqQxti86R/ohYOtUOnJ4xoFSOGWiRScm3Y/HQVn5
	0MRaJV0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYwI-00DyRT-2j;
	Tue, 19 Dec 2023 12:11:10 +0000
Date: Tue, 19 Dec 2023 04:11:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, penguin-kernel@i-love.sakura.ne.jp,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] block: add check of 'minors' and 'first_minor' in
 device_add_disk()
Message-ID: <ZYGIXp21xmdUtfTh@infradead.org>
References: <20231219075942.840255-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219075942.840255-1-linan666@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

