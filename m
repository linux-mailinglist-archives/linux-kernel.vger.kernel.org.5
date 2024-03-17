Return-Path: <linux-kernel+bounces-105568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC887E08C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2091F21983
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674B210E4;
	Sun, 17 Mar 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p54FNH2z"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2C208B0;
	Sun, 17 Mar 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712415; cv=none; b=jKCM7rM2zhCsfHdrb2MLVTeCEvnwMxTkxCRhxgM/+7HDPMTLQITmYgzMK5lrj8WjWzZSbIUb9lnCNtPkRo7Iwy2+hCuQii266oyntZmTqPBTJcB9MwttsKxDyBvu1I0ZfjuiXKTaY5exaiHzpgQUTHd+iAu933x4Mz5w+e4aBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712415; c=relaxed/simple;
	bh=ilalbKVBXkrC10VfaIDbYqnOUHDSFrZQGceQb8uxhCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9BO9a+HzzRsTYXK/We3FlSieyAMLWlts0vaA6Ux1GiDHfCHAx8AKgrR0WmZvhPvGsET6yDTEUtUT69CoaLz+D8/XcXksYcZJYB2qwOGXbM5lDqHXLxAjtSip1inD6i+v5jC3GWEJXGAjjtXPpkrzDDhzedYwF9TQCmlOLnQ46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p54FNH2z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=T+gvoO8pGh75mibQQg+oDvnzUDtv9SNELSjGcmT3lnA=; b=p54FNH2zmF8HUAGMyM++qCenJS
	ZPezggs1zbJSAszE9S1di5OSXDBaEns+mNlvfeQyBLjX+8oxRy2L39UfnVtwbiwiVtMgC7m9juG+F
	XfCKTxHjlEIOnppG01wbezfqUtzfwbzdLFt/eJBH5HwDJzI34EGeBuVrLduUs8vDS79ngj1E/Ir9+
	xsR3M5K2vTlKKXggqYPaqLBtW9ZeUjKQ7bvXvQLzX0X/UNZn+gYgUqx7vPQNRCBm8fwzSHQ1LKAUz
	y1jfuCRKr2jzv5uKA+ovKrKEH5Pp4RkuiiUPMrnskw+jmvtf2plc54OxZQqMisooZeJZKKJVicu+p
	vWTVNDDw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlyRg-00000006ZLX-384I;
	Sun, 17 Mar 2024 21:53:33 +0000
Message-ID: <40effb4e-9ea5-4102-a31f-43892e258b09@infradead.org>
Date: Sun, 17 Mar 2024 14:53:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: Fix typo in comment
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240317154731.2801-2-thorsten.blum@toblux.com>
 <Zfdcrtk3b6UfgQRF@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Zfdcrtk3b6UfgQRF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


s/somethign/something/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/xfs/xfs_log_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index e30c06ec20e3..25b6d6cdd545 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -683,7 +683,7 @@ xlog_valid_lsn(
  * flags to control the kmalloc() behaviour within kvmalloc(). Hence kmalloc()
  * will do direct reclaim and compaction in the slow path, both of which are
  * horrendously expensive. We just want kmalloc to fail fast and fall back to
- * vmalloc if it can't get somethign straight away from the free lists or
+ * vmalloc if it can't get something straight away from the free lists or
  * buddy allocator. Hence we have to open code kvmalloc outselves here.
  *
  * This assumes that the caller uses memalloc_nofs_save task context here, so



Also s/straight away/straightaway/
or even use "immediately".

thanks.
-- 
#Randy

