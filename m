Return-Path: <linux-kernel+bounces-6444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26E8198E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6651C283AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102013AC4;
	Wed, 20 Dec 2023 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2INhNg9s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C63168A9;
	Wed, 20 Dec 2023 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wiefhyyxdQ6+cVyIEandstncmSheKVNzQxTEt7IW79g=; b=2INhNg9suwi5GAzp9swSRhVD6R
	Mv9OiTfgp1DZKHL2ulgMJGFP4LQux5BoIzvOezYx0DtA1ZSphHQxK61kgbSfHMwPP4dGhEf4CMnvs
	jsSuLp26Jc7g6GM2AlHJSfliw8EaNrowDJlHGR9QqOoegkjzGq7pOi6TY3a9UhvRXzvHloDtymjYT
	RzPtxPrWG3KhccMBA5XFg8LjTrSMsU3wOYgXU2ZeB6IsiiM90g2IQoqBUlTSBIIbzNOhUVb6A8X09
	izq8WIYlUCbsNN/5QiZDUJVd1js53FOXWLVY2TemjLpjtnvmu77riy8P4QS4qglHgo65mjRxnIfwL
	30JDwsrQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqYG-00GLf7-1W;
	Wed, 20 Dec 2023 06:59:32 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH] nilfs2: cpfile: fix some kernel-doc warnings
Date: Tue, 19 Dec 2023 22:59:31 -0800
Message-ID: <20231220065931.2372-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function parameter names for nilfs_cpfile_get_info():

cpfile.c:564: warning: Function parameter or member 'cnop' not described in 'nilfs_cpfile_get_cpinfo'
cpfile.c:564: warning: Function parameter or member 'mode' not described in 'nilfs_cpfile_get_cpinfo'
cpfile.c:564: warning: Function parameter or member 'buf' not described in 'nilfs_cpfile_get_cpinfo'
cpfile.c:564: warning: Function parameter or member 'cisz' not described in 'nilfs_cpfile_get_cpinfo'
cpfile.c:564: warning: Excess function parameter 'cno' description in 'nilfs_cpfile_get_cpinfo'
cpfile.c:564: warning: Excess function parameter 'ci' description in 'nilfs_cpfile_get_cpinfo'

This still leaves a few kernel-doc warnings.
Also, the function parameters should have descriptions after them.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/cpfile.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -- a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -554,8 +554,10 @@ static ssize_t nilfs_cpfile_do_get_ssinf
 /**
  * nilfs_cpfile_get_cpinfo -
  * @cpfile:
- * @cno:
- * @ci:
+ * @cnop:
+ * @mode:
+ * @buf:
+ * @cisz:
  * @nci:
  */
 

