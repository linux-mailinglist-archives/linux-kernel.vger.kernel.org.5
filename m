Return-Path: <linux-kernel+bounces-117675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C6888AE51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B091F2A267
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6474419;
	Mon, 25 Mar 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq1Mn8fG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081A70CA8;
	Mon, 25 Mar 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389808; cv=none; b=WWrdPpMdEx9lZrhSdxc2bTHyoPOaJ+ubsSVJ+0df+PJBU1B5WmDh0ATLpOfs7t6063MGuJE1FjVFPO1sYoe45f+bjO27KWGkh13wZ6V4GOELsPB/jehrX0M41Vk5g2KIkNJVN1bzC0eUR1Ebn2hSVToIe247Dh4pqXO8GEaPkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389808; c=relaxed/simple;
	bh=6+aIENBQ8bUXwWkA6EnXZ933SM0pP3PJVnA3VIK47xg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aJ+Uqmb93D9ANMsk/T5ElkiWtf9xX0vsvSZfq4jPZ9CZbbAZWGv8of7YHqnV1yg7V98yj3ZXwP4NWcibobtJFIOSrvT1uN/nGdcyaNY3nGJsIEbIvfQDyWdj+ZvHs+Q0T64UfEfFtnOkjqey8p1Kzv+MrHTTyPyiFM795Qz5T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq1Mn8fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964A5C433C7;
	Mon, 25 Mar 2024 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389808;
	bh=6+aIENBQ8bUXwWkA6EnXZ933SM0pP3PJVnA3VIK47xg=;
	h=Date:From:To:Cc:Subject:From;
	b=dq1Mn8fGGfsZ7tJAfQ+3OhyYR5QfWL6XrXUuY9mS1GYl7W53Ib/aikb7asrkQrZ7f
	 tSHeRw9IFMClejcSerQAQyJrUUT45VJ7R9GcYqCt+XxduE3aSrQQ0C5JnOmhSE2E/o
	 d+P7UXX/rdIwUaSrP8qTgBaRNAFkoXjNX1s72E8LribBKvcUtk9iGSuMncDud67AZv
	 UZARax0GISEquSgX74aQjGebHkhj0Kg9kQhEcLRWK8B8Sq9ddyrH8H76LaxKo/ZEXV
	 WmvuPwVdX4BgnUhVxJT0wJJ9T5hr/rDm/yzSFVc11ShZ2ewCLo/mgD2h5aEltlcXst
	 YYp+Yn/zESgPg==
Date: Mon, 25 Mar 2024 12:03:25 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] rpmsg: glink: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgG8bbEzhmX5nGRE@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There is currently an object (`msg`) in multiple structures that
contains a flexible structure (`struct glink_msg`), for example:

struct glink_defer_cmd {
        ...

        struct glink_msg msg;
        u8 data[];
};

So, in order to avoid ending up with a flexible-array member in the
middle of another structure, we use the `__struct_group()` helper
to separate the flexible array from the rest of the members in the
flexible structure:

struct glink_msg {
        __struct_group(glink_msg_hdr, hdr, __packed,

        ... the rest of members

        );
        u8 data[];
} __packed;

With the change described above, we now declare objects of the type of
the tagged struct, in this case `struct glink_msg_hdr`, without
embedding flexible arrays in the middle of other structures:

struct glink_defer_cmd {
        ...

        struct glink_msg_hdr msg;
        u8 data[];
};

Also, use `container_of()` to retrieve a pointer to the flexible structure.

We also use the `DEFINE_RAW_FLEX()` helper for an in-stack definition of
a flexible structure where the size of the flexible-array member is known
at compile-time.

So, with these changes, fix the following warnings:
drivers/rpmsg/qcom_glink_native.c:51:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/rpmsg/qcom_glink_native.c:459:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/rpmsg/qcom_glink_native.c:846:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/rpmsg/qcom_glink_native.c:968:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/rpmsg/qcom_glink_native.c:1380:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/rpmsg/qcom_glink_native.c | 38 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 82d460ff4777..878e3461bce1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -30,9 +30,12 @@
 #define RPM_GLINK_CID_MAX	65536
 
 struct glink_msg {
-	__le16 cmd;
-	__le16 param1;
-	__le32 param2;
+	/* New members must be added within the __struct_group() macro below. */
+	__struct_group(glink_msg_hdr, hdr, __packed,
+		__le16 cmd;
+		__le16 param1;
+		__le32 param2;
+	);
 	u8 data[];
 } __packed;
 
@@ -48,7 +51,7 @@ struct glink_msg {
 struct glink_defer_cmd {
 	struct list_head node;
 
-	struct glink_msg msg;
+	struct glink_msg_hdr msg;
 	u8 data[];
 };
 
@@ -455,12 +458,9 @@ static void qcom_glink_intent_req_abort(struct glink_channel *channel)
 static int qcom_glink_send_open_req(struct qcom_glink *glink,
 				    struct glink_channel *channel)
 {
-	struct {
-		struct glink_msg msg;
-		u8 name[GLINK_NAME_SIZE];
-	} __packed req;
+	DEFINE_RAW_FLEX(struct glink_msg, req, data, GLINK_NAME_SIZE);
 	int name_len = strlen(channel->name) + 1;
-	int req_len = ALIGN(sizeof(req.msg) + name_len, 8);
+	int req_len = ALIGN(sizeof(*req) + name_len, 8);
 	int ret;
 	unsigned long flags;
 
@@ -476,10 +476,10 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 
 	channel->lcid = ret;
 
-	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
-	req.msg.param1 = cpu_to_le16(channel->lcid);
-	req.msg.param2 = cpu_to_le32(name_len);
-	strcpy(req.name, channel->name);
+	req->cmd = cpu_to_le16(GLINK_CMD_OPEN);
+	req->param1 = cpu_to_le16(channel->lcid);
+	req->param2 = cpu_to_le32(name_len);
+	strcpy(req->data, channel->name);
 
 	ret = qcom_glink_tx(glink, &req, req_len, NULL, 0, true);
 	if (ret)
@@ -826,7 +826,9 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
 
 	INIT_LIST_HEAD(&dcmd->node);
 
-	qcom_glink_rx_peek(glink, &dcmd->msg, 0, sizeof(dcmd->msg) + extra);
+	qcom_glink_rx_peek(glink,
+			   container_of(&dcmd->msg, struct glink_msg, hdr), 0,
+			   sizeof(dcmd->msg) + extra);
 
 	spin_lock(&glink->rx_lock);
 	list_add_tail(&dcmd->node, &glink->rx_queue);
@@ -843,7 +845,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 	struct glink_core_rx_intent *intent;
 	struct glink_channel *channel;
 	struct {
-		struct glink_msg msg;
+		struct glink_msg_hdr msg;
 		__le32 chunk_size;
 		__le32 left_size;
 	} __packed hdr;
@@ -965,7 +967,7 @@ static void qcom_glink_handle_intent(struct qcom_glink *glink,
 	};
 
 	struct {
-		struct glink_msg msg;
+		struct glink_msg_hdr msg;
 		struct intent_pair intents[];
 	} __packed * msg;
 
@@ -1377,7 +1379,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	struct glink_core_rx_intent *tmp;
 	int iid = 0;
 	struct {
-		struct glink_msg msg;
+		struct glink_msg_hdr msg;
 		__le32 chunk_size;
 		__le32 left_size;
 	} __packed req;
@@ -1685,7 +1687,7 @@ static void qcom_glink_work(struct work_struct *work)
 		list_del(&dcmd->node);
 		spin_unlock_irqrestore(&glink->rx_lock, flags);
 
-		msg = &dcmd->msg;
+		msg = container_of(&dcmd->msg, struct glink_msg, hdr);
 		cmd = le16_to_cpu(msg->cmd);
 		param1 = le16_to_cpu(msg->param1);
 		param2 = le32_to_cpu(msg->param2);
-- 
2.34.1


