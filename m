Return-Path: <linux-kernel+bounces-131748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBC898B65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5081F29DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A0112B145;
	Thu,  4 Apr 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zx72GqoI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CP5iOcvm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zx72GqoI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CP5iOcvm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41404763F4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245511; cv=none; b=SSnF4NV0QZI/KbQA9OZ/44qi4UKnnqK+r4QsVXcJl4UT6XvBQY2OVe2Pc40mptYZFjdHuxnHh5uAcRgklT/LV5ub5qi504nse0YQ0Ckh0+xhmkvT1bzxbeNF46WoW2bARag6z3xF5jHKv1ms/KMijzCDJY7J3yJkcNsn9f2rZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245511; c=relaxed/simple;
	bh=VxQDniNp1GvFx1AJkcj8trNLxPPYXZuO3OK1Fi/n0Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZl72Q3/hQYWriBLLrf13m1iRwACkgD/HGbOEJnUNIZnw/gMOJz9aO4bYXJEiWtZZa2KKP6MuHcAZ71UMZhTzcG+ivj7gdsvDkA9w1M1Md1ZM1z4EGHFp+D6yoy1NvWAKlrOfUB/m91RNTNfdGxx837PyRYkJb2yo8ojjm/IfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zx72GqoI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CP5iOcvm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zx72GqoI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CP5iOcvm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8569C5F8A4;
	Thu,  4 Apr 2024 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWs/Gd1Hr0vOWvB9JrSbgOUDhqUyFVhZ4d5LzP32gcM=;
	b=Zx72GqoIytVZqcaQrKq1pYaU9wbEskpQkK//ZxEs3m0UWaXugZH+Ia4RAqOIZrScvdLepg
	PaekupjrsxvDYi05r4dAh9j5SNHYJRNxdQ49QwREnxK9heReJ3EatAGVdcIeCJxtjsJUgH
	OYiBdMDUXpgK10jKJ3w4C8HbqNB0Ky0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWs/Gd1Hr0vOWvB9JrSbgOUDhqUyFVhZ4d5LzP32gcM=;
	b=CP5iOcvm3JjmeYcj7rXD6n9Kmmp0gBDg2/3KMP8peFHGD9TXoB/KdUefoVNhlkq6Cm8zKs
	agJMB3gfuZuM36AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWs/Gd1Hr0vOWvB9JrSbgOUDhqUyFVhZ4d5LzP32gcM=;
	b=Zx72GqoIytVZqcaQrKq1pYaU9wbEskpQkK//ZxEs3m0UWaXugZH+Ia4RAqOIZrScvdLepg
	PaekupjrsxvDYi05r4dAh9j5SNHYJRNxdQ49QwREnxK9heReJ3EatAGVdcIeCJxtjsJUgH
	OYiBdMDUXpgK10jKJ3w4C8HbqNB0Ky0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWs/Gd1Hr0vOWvB9JrSbgOUDhqUyFVhZ4d5LzP32gcM=;
	b=CP5iOcvm3JjmeYcj7rXD6n9Kmmp0gBDg2/3KMP8peFHGD9TXoB/KdUefoVNhlkq6Cm8zKs
	agJMB3gfuZuM36AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 73CFE139E8;
	Thu,  4 Apr 2024 15:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OljVGgTLDmYIIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 3/5] nvmet: return DHCHAP status codes from nvmet_setup_auth()
Date: Thu,  4 Apr 2024 17:44:58 +0200
Message-ID: <20240404154500.2101-4-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404154500.2101-1-dwagner@suse.de>
References: <20240404154500.2101-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

From: Hannes Reinecke <hare@kernel.org>

A failure in nvmet_setup_auth() does not mean that the NVMe
authentication command failed, so we should rather return a
protocol error with a 'failure1' response than an NVMe status.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/auth.c             | 18 +++++++-----------
 drivers/nvme/target/fabrics-cmd-auth.c | 11 ++++++-----
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9afc28f1ffac..1079281a202e 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -131,7 +131,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
-	const char *hash_name;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -149,13 +148,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	}
 	if (!host) {
 		pr_debug("host %s not found\n", ctrl->hostnqn);
-		ret = -EPERM;
+		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		goto out_unlock;
 	}
 
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
+		ret = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		goto out_unlock;
+	}
 
 	if (!host->dhchap_secret) {
 		pr_debug("No authentication provided\n");
@@ -166,12 +168,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		pr_debug("Re-use existing hash ID %d\n",
 			 ctrl->shash_id);
 	} else {
-		hash_name = nvme_auth_hmac_name(host->dhchap_hash_id);
-		if (!hash_name) {
-			pr_warn("Hash ID %d invalid\n", host->dhchap_hash_id);
-			ret = -EINVAL;
-			goto out_unlock;
-		}
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
@@ -180,7 +176,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
 					       host->dhchap_key_hash);
 	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
@@ -198,7 +194,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
 					       host->dhchap_ctrl_key_hash);
 	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..a95dc6606396 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -240,12 +240,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
 				 ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				if (nvmet_setup_auth(ctrl) < 0) {
-					status = NVME_SC_INTERNAL;
-					pr_err("ctrl %d qid 0 failed to setup"
-					       "re-authentication",
+				status = nvmet_setup_auth(ctrl);
+				if (status) {
+					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
-					goto done_failure1;
+					req->sq->dhchap_status = status;
+					req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+					goto done_kfree;
 				}
 			}
 			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
-- 
2.44.0


