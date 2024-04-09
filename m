Return-Path: <linux-kernel+bounces-136577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1E89D5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1230B2145A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEE839EB;
	Tue,  9 Apr 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sx8d13vW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OiKdrmYF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sx8d13vW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OiKdrmYF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97380622
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655322; cv=none; b=neMJB8hAxSmP/vbG6cVaCoflv9BjLXGAKCa/FdaNCHIBHiWLOzao6ZjLB8iLXKqd6cQLo1WxuKixeDCAhNbLEP2oxpgPjYTtcanz3CRBxNuERlN5V4bfHiRQSNfokVJY8/8gw/Q4ykBYe5sUjfrwbtC89Mz5zEEXsD/xCsd5Iyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655322; c=relaxed/simple;
	bh=37Ao40vTSYJOIXfRSYd5x/u++1FdVyWWm5aKc0yxPa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lteuMvzgzunq4SCM4DNEVsR8MqV/ekQ9GtgwnqGC0raH+ayxXK+X0QV4ZdjW6cundmCmPjGf5vUH+NDRKJwhU9tENtI9dyXS62I1QnxYrU92g8k9xy8Pgb561+gdtuqPRR0JdyJzGhQwl+bUwmw3eFdXlCnAgJUSoXE84NeGQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sx8d13vW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OiKdrmYF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sx8d13vW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OiKdrmYF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF39338F6;
	Tue,  9 Apr 2024 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oM34Us2ktSVFTfwciRCqFanb54oyHFo1BVoN+ip5H4=;
	b=sx8d13vW8trMKGKZN3Z/dgTLqlTsUZQ4dDpVBMk9XVU4Rb4VKWh6Vk0KFFCcfCGx1JGWo9
	edBH+LCxRDxC/nSwb1ZXSCzKuwRHQDd6ybE38bNFNAaKligY0y3qjvgBSXtg3ApoVM58OR
	XyYsttJKADaOTsALhJZM66yJ82JQOSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oM34Us2ktSVFTfwciRCqFanb54oyHFo1BVoN+ip5H4=;
	b=OiKdrmYFoIyfpDDoqNaG6wYIVPuwVztl0lOaYee2wSOLn0LbQyGOVyOXjLoyT6+bMJZz4L
	N69aCWA8vNIQjeBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712655318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oM34Us2ktSVFTfwciRCqFanb54oyHFo1BVoN+ip5H4=;
	b=sx8d13vW8trMKGKZN3Z/dgTLqlTsUZQ4dDpVBMk9XVU4Rb4VKWh6Vk0KFFCcfCGx1JGWo9
	edBH+LCxRDxC/nSwb1ZXSCzKuwRHQDd6ybE38bNFNAaKligY0y3qjvgBSXtg3ApoVM58OR
	XyYsttJKADaOTsALhJZM66yJ82JQOSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712655318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oM34Us2ktSVFTfwciRCqFanb54oyHFo1BVoN+ip5H4=;
	b=OiKdrmYFoIyfpDDoqNaG6wYIVPuwVztl0lOaYee2wSOLn0LbQyGOVyOXjLoyT6+bMJZz4L
	N69aCWA8vNIQjeBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 768DA13AAF;
	Tue,  9 Apr 2024 09:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UHN/G9YLFWayRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 6/6] nvmet: return DHCHAP status codes from nvmet_setup_auth()
Date: Tue,  9 Apr 2024 11:35:10 +0200
Message-ID: <20240409093510.12321-7-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
References: <20240409093510.12321-1-dwagner@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	RCVD_TLS_ALL(0.00)[]

From: Hannes Reinecke <hare@kernel.org>

A failure in nvmet_setup_auth() does not mean that the NVMe
authentication command failed, so we should rather return a protocol
error with a 'failure1' response than an NVMe status.

Also update the type used for dhchap_step and dhchap_status to u8 to
avoid confusions with nvme status. Furthermore, split dhchap_status and
nvme status so we don't accidentally mix these return values.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[dwagner: - use u8 as type for dhchap_{step|status}
          - separate nvme status from dhcap_status]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/auth.c             | 20 +++++------
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++-------------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++---
 drivers/nvme/target/nvmet.h            |  8 ++---
 4 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9afc28f1ffac..53bf1a084469 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -126,12 +126,11 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
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
index eb7785be0ca7..d61b8c6ff3b2 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -31,7 +31,7 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 }
 
-static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_negotiate_data *data = d;
@@ -109,7 +109,7 @@ static u16 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
+static u8 nvmet_auth_reply(struct nvmet_req *req, void *d)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmf_auth_dhchap_reply_data *data = d;
@@ -172,7 +172,7 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	return 0;
 }
 
-static u16 nvmet_auth_failure2(void *d)
+static u8 nvmet_auth_failure2(void *d)
 {
 	struct nvmf_auth_dhchap_failure_data *data = d;
 
@@ -186,6 +186,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	void *d;
 	u32 tl;
 	u16 status = 0;
+	u8 dhchap_status;
 
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -237,30 +238,32 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	if (data->auth_type == NVME_AUTH_COMMON_MESSAGES) {
 		if (data->auth_id == NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE) {
 			/* Restart negotiation */
-			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
-				 ctrl->cntlid, req->sq->qid);
+			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
+				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				if (nvmet_setup_auth(ctrl) < 0) {
-					status = NVME_SC_INTERNAL;
-					pr_err("ctrl %d qid 0 failed to setup"
-					       "re-authentication",
+				dhchap_status = nvmet_setup_auth(ctrl);
+				if (dhchap_status) {
+					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
-					goto done_failure1;
+					req->sq->dhchap_status = dhchap_status;
+					req->sq->dhchap_step =
+						NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+					goto done_kfree;
 				}
 			}
-			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
+			req->sq->dhchap_step =
+				NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 		} else if (data->auth_id != req->sq->dhchap_step)
 			goto done_failure1;
 		/* Validate negotiation parameters */
-		status = nvmet_auth_negotiate(req, d);
-		if (status == 0)
+		dhchap_status = nvmet_auth_negotiate(req, d);
+		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
 		else {
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
-			req->sq->dhchap_status = status;
-			status = 0;
+			req->sq->dhchap_status = dhchap_status;
 		}
 		goto done_kfree;
 	}
@@ -284,15 +287,14 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 
 	switch (data->auth_id) {
 	case NVME_AUTH_DHCHAP_MESSAGE_REPLY:
-		status = nvmet_auth_reply(req, d);
-		if (status == 0)
+		dhchap_status = nvmet_auth_reply(req, d);
+		if (dhchap_status == 0)
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1;
 		else {
 			req->sq->dhchap_step =
 				NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
-			req->sq->dhchap_status = status;
-			status = 0;
+			req->sq->dhchap_status = dhchap_status;
 		}
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2:
@@ -301,13 +303,12 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			 __func__, ctrl->cntlid, req->sq->qid);
 		goto done_kfree;
 	case NVME_AUTH_DHCHAP_MESSAGE_FAILURE2:
-		status = nvmet_auth_failure2(d);
-		if (status) {
+		dhchap_status = nvmet_auth_failure2(d);
+		if (dhchap_status) {
 			pr_warn("ctrl %d qid %d: authentication failed (%d)\n",
-				ctrl->cntlid, req->sq->qid, status);
-			req->sq->dhchap_status = status;
+				ctrl->cntlid, req->sq->qid, dhchap_status);
+			req->sq->dhchap_status = dhchap_status;
 			req->sq->authenticated = false;
-			status = 0;
 		}
 		goto done_kfree;
 	default:
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index b23f4cf840bd..042b379cbb36 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -211,7 +211,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmf_connect_data *d;
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status;
-	int ret;
+	u8 dhchap_status;
 
 	if (!nvmet_check_transfer_len(req, sizeof(struct nvmf_connect_data)))
 		return;
@@ -254,11 +254,12 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
-	ret = nvmet_setup_auth(ctrl);
-	if (ret < 0) {
-		pr_err("Failed to setup authentication, error %d\n", ret);
+	dhchap_status = nvmet_setup_auth(ctrl);
+	if (dhchap_status) {
+		pr_err("Failed to setup authentication, dhchap status %u\n",
+		       dhchap_status);
 		nvmet_ctrl_put(ctrl);
-		if (ret == -EPERM)
+		if (dhchap_status == NVME_AUTH_DHCHAP_FAILURE_FAILED)
 			status = (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR);
 		else
 			status = NVME_SC_INTERNAL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 257cace53924..5d6adb5c2fc0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -113,8 +113,8 @@ struct nvmet_sq {
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
 	u16			dhchap_tid;
-	u16			dhchap_status;
-	int			dhchap_step;
+	u8			dhchap_status;
+	u8			dhchap_step;
 	u8			*dhchap_c1;
 	u8			*dhchap_c2;
 	u32			dhchap_s1;
@@ -721,7 +721,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-int nvmet_setup_auth(struct nvmet_ctrl *ctrl);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -740,7 +740,7 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 			    u8 *buf, int buf_size);
 #else
-static inline int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
+static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 {
 	return 0;
 }
-- 
2.44.0


