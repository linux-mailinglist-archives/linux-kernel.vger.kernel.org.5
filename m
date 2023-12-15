Return-Path: <linux-kernel+bounces-434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBB814118
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B455B21A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69F16AA7;
	Fri, 15 Dec 2023 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ziRAvL7t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91863A6;
	Fri, 15 Dec 2023 05:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ziRAvL7tm9saMD5YTNoMZqW995
	4WcupwVQxdLbzMpYJ+dpdJnggkpCAE8z12nqtPra8BAjqHUH2uncRjdjFMO5rDxQyrUbPtQg99TOS
	bhF4FvyJEOk3kKvPN1F2IcwVtEeJlIXJdSPRsSQPw3Lt/BPjrxvkq93u+b2EebBuGxhS6tG22Ij3h
	2h6lnoX1kRigY0jEBLqdvh6Id1IOVbq50DEegCq6tZPVPIpNsTvE6ukPw2kAxsUr33ubViFr7AYJz
	U3NmQUmDKByOu1fTfOUpnarfv3ZV18ZRcZ4jI5qjAI+BrsiFP7TnjRYVJGf9T/ZxnJagaazTPVNOR
	FKwBpnpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rE0J5-0021Zr-0c;
	Fri, 15 Dec 2023 05:00:15 +0000
Date: Thu, 14 Dec 2023 21:00:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ye Bin <yebin10@huawei.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: add CMD_LAST flag for error handle scsi
 command
Message-ID: <ZXvdX6lWbdG+uqz8@infradead.org>
References: <20231214122919.985087-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214122919.985087-1-yebin10@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

