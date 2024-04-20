Return-Path: <linux-kernel+bounces-152221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB08ABAE3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4104D1F21CF6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF817BCD;
	Sat, 20 Apr 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EIP+zP69"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99B17BA2;
	Sat, 20 Apr 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713607005; cv=none; b=qPVWIAXMRDvdf3TthWARkW9AjlFxKPRriC01H6q782ORuDO55I7mJN9NKAjCdOkFKuJ7CtwTj69xJMiAZQtFLpgEB8WMcBiwGRFlctlshJiMD8Lr4L23iTWBNwB+JAIY678H0HcbQOqsdaR7JVwQqUc7G9Nup7+cQaAFZI3+fCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713607005; c=relaxed/simple;
	bh=YnDJ9iQswre7+Wp5XM9k/4hBgmOQZWPn8D89KIrVcUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1vKlg/2zksQRvPRNziN1TaoFFpivIUPZHgZ1r/FGlw7bh0D4CAW+OXHUaswcImE8B2oOzDPTIDw5AExZILGPShMiDU8H5EGff4s88i8LXtEd03zgB3fbetoUJGxKUVKJv1TRtnnSYWfIAp3srpKUitwTU6P4gnZiKrhlVisSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EIP+zP69; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id y7STrmGoLbyODy7STrLNUG; Sat, 20 Apr 2024 11:56:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713606994;
	bh=iIdz/SjudWPu/QGXeFWNz+lXR/mtDYvMXAN2tDXR2p8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EIP+zP698o4SomTdn3e2e0YBXn9Tf4u7QeLCQ0QDmcI+oppT3+dlRY5lnmqn/6aOu
	 PPgKdwYlNoZ/ZonTIHvLOmm9XMHZqaDsVBt2ByEp4/13d8UK4D1lta7r20OA8DXWAK
	 NA4E8FidjfabQNfASxm3lJV6/0+6uQEwTF3kVR6qTe7VQ9YlKkm81moUhn5hiYX9aF
	 XRx1VJB7qUwY08ZGCmQ5G/cCxvhrMpaUagH6OyUuw51sPAGBIH9wLzuCtdReMDhpwD
	 VBQkfYWAjBGZtktBZknkMHzX4CxDpknqi6HRaO0u5O5OqXo4z5QrcXlHY5687ahhuo
	 yDfOIqmsVqm9Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Apr 2024 11:56:34 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] nvmem: Update a comment related to struct nvmem_config
Date: Sat, 20 Apr 2024 11:56:30 +0200
Message-ID: <032b8035bd1f2dcc13ffc781c8348d9fbdf9e3b2.1713606957.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update a comment to match the function used in nvmem_register().
ida_simple_get() was replaced by ida_alloc() in commit 1eb51d6a4fce
("nvmem: switch to simpler IDA interface")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/nvmem-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3ebeaa0ded00..9a5f262d20f5 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -103,7 +103,7 @@ struct nvmem_cell_info {
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
- * generated with ida_simple_get() and provided id field is ignored.
+ * generated with ida_alloc() and provided id field is ignored.
  *
  * Note: Specifying name and setting id to -1 implies a unique device
  * whose name is provided as-is (kept unaltered).
-- 
2.44.0


