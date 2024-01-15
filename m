Return-Path: <linux-kernel+bounces-25616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3882D3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A8FB20D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7AB28E3;
	Mon, 15 Jan 2024 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7lgAjgo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295223A2;
	Mon, 15 Jan 2024 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6XW9jqaIh1AQzD94ZZd4+VKcTSdu8kLFek2bVy3e7es=; b=X7lgAjgo2UkCI6NdpJtV3OUDpW
	2PKdoPGhk8T9JjakgBG17xMArruV5r5ilz+KhQCSj0MGSz8QVFjAMrdbjF67W6pyKYyBXFnrGxjS0
	9ecOLWG6PSod9bz8a13Lcz83W9OgMysBmflYpfmCRcfmN0xR/xYKYfqjnAjZLNuRlGVWUUzWdYm7c
	yLv4iCE6GFS1xUszSgcslfeM+hYXnTKpCVQaU3xTF+Uqocn0wdwfCr10L8SYnBOygPnKGJSYLrH5+
	qihKvCmehPE3yieaTexIbNAg9LputiJkcMMgvRQ+Xisa/1hmItUXmp3JCcmzh0ARyeH2/THCjzHed
	TTg/HB/w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPEjA-007ktb-05;
	Mon, 15 Jan 2024 04:37:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	John Johansen <john.johansen@canonical.com>,
	John Johansen <john@apparmor.net>,
	apparmor@lists.ubuntu.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: lsm: fix kernel-doc typo
Date: Sun, 14 Jan 2024 20:37:35 -0800
Message-ID: <20240115043735.7751-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a kernel-doc function parameter name to resolve two
kernel-doc warnings:

lsm.c:1136: warning: Function parameter or struct member 'protocol' not described in 'apparmor_socket_post_create'
lsm.c:1136: warning: Excess function parameter 'ptotocol' description in 'apparmor_socket_post_create'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: apparmor@lists.ubuntu.com
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/apparmor/lsm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/security/apparmor/lsm.c b/security/apparmor/lsm.c
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1122,7 +1122,7 @@ static int apparmor_socket_create(int fa
  * @sock: socket that is being setup
  * @family: family of socket being created
  * @type: type of the socket
- * @ptotocol: protocol of the socket
+ * @protocol: protocol of the socket
  * @kern: socket is a special kernel socket
  *
  * Note:

