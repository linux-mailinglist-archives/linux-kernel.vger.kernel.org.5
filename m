Return-Path: <linux-kernel+bounces-27252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8682ECC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7075B1C23037
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D731759A;
	Tue, 16 Jan 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dzAq6shk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1717594
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337b71a0240so334443f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1705401096; x=1706005896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IIJ9L+Hm/MEkaJDfX4lbcUfmEYPL2ke1pt+l5k7Zhc=;
        b=dzAq6shkTghxQnr+enP51oZCrRkLqiVlHOT7SHgojuVtbe1UYaMQ96ZFd7N45O4CEH
         /nSI4LzHiHQ7VzfZtFmWsHm+97Kx/xYeobZnWWg/naxz6P5nEEKeusTTP7QmaighE8Hn
         Ri2GjF8TqRd09mrssfOuJYwbFY4DRoa7mCNOQtXgEc6WZ1OQZ0R+x2C5n2Obl0qUmy1b
         EnKEf/Rj/3yUIxxRp/ST24huuMUfKvppG/pdrA5damH+ViG/OnOm/5kiNjGal2iSvA2M
         JgzP4PBrpRBnhRNCqHe4zr3dHb49B+s/z1Arr8nPvCFDDvvMS4MGub7zVTVUceXCFsym
         k3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401096; x=1706005896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IIJ9L+Hm/MEkaJDfX4lbcUfmEYPL2ke1pt+l5k7Zhc=;
        b=g20C5I8XkzglGabGsF06cYQOJbge7+76bZllFnuLH4RaO5dx5XWTM0PshiMRO8B26N
         /uzC3AjeXy+5GqmJAKOAHiL7/N087+P6j9pD59T3ssk9ZlMF3qa3pNa6jwTSGaVGVIgP
         DYgShEdrh9nINzHQRBSYijiZLtMAUOHQ1w9EATOBfWbybPnhiMn4BO8o6DZQcuNxNEBn
         IpfPxmTJbUi4EDkQ2BLgF6Kxne4pYlYGHDOeAeAarKrWroOU+RVNIwdzVvK6/ya3kdOM
         hoL6ArCD0XQStPxh0Gk+3cPi6AUVia/nwkr7k5ov4ZjIioxrixGxf3Hdww4J9ItArAPG
         9o/A==
X-Gm-Message-State: AOJu0Yz+uJnXl4DEOUH497hkO+RWxYmHtTTGxImYc0M0xYZhjT8hD2w/
	ZftmIThbJ4VZeOZhRmvmur3BK0Ov97ZfhA==
X-Google-Smtp-Source: AGHT+IHFEsPQ1u4to3ntDUPCfo0/Wf2vCqQ4yafN4IDUDwh1HUSyh/eeZMtucbscxTgnMK6tpnFnMw==
X-Received: by 2002:adf:e647:0:b0:336:7f03:4af with SMTP id b7-20020adfe647000000b003367f0304afmr4203110wrn.123.1705401096420;
        Tue, 16 Jan 2024 02:31:36 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d65d0000000b003365951cef9sm14161527wrw.55.2024.01.16.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 02:31:35 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: broonie@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulator: event: Add netlink command for event mask
Date: Tue, 16 Jan 2024 16:01:30 +0530
Message-ID: <20240116103131.413205-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netlink command to enable perticular event(s) broadcasting instead
of all regulator events.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

..
Changes in v2:
- Update attribute to REG_GENL_ATTR_SET_EVENT_MASK
---
 drivers/regulator/event.c          | 28 ++++++++++++++++++++++++++++
 include/uapi/regulator/regulator.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
index ea3bd49544e8..181d16f54a21 100644
--- a/drivers/regulator/event.c
+++ b/drivers/regulator/event.c
@@ -14,17 +14,41 @@
 
 static atomic_t reg_event_seqnum = ATOMIC_INIT(0);
 
+static u64 event_mask;
+
 static const struct genl_multicast_group reg_event_mcgrps[] = {
 	{ .name = REG_GENL_MCAST_GROUP_NAME, },
 };
 
+static int reg_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[REG_GENL_ATTR_SET_EVENT_MASK]) {
+		event_mask = nla_get_u64(info->attrs[REG_GENL_ATTR_SET_EVENT_MASK]);
+		pr_info("event_mask -> %llx", event_mask);
+		return 0;
+	}
+	pr_warn("Unknown attribute.");
+	return -EOPNOTSUPP;
+}
+
+static const struct genl_small_ops reg_genl_ops[] = {
+	{
+		.cmd = REG_GENL_CMD_EVENT,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = reg_genl_cmd_doit,
+	}
+};
+
 static struct genl_family reg_event_genl_family __ro_after_init = {
 	.module = THIS_MODULE,
 	.name = REG_GENL_FAMILY_NAME,
 	.version = REG_GENL_VERSION,
 	.maxattr = REG_GENL_ATTR_MAX,
+	.small_ops	= reg_genl_ops,
+	.n_small_ops	= ARRAY_SIZE(reg_genl_ops),
 	.mcgrps = reg_event_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(reg_event_mcgrps),
+	.resv_start_op = __REG_GENL_CMD_MAX,
 };
 
 int reg_generate_netlink_event(const char *reg_name, u64 event)
@@ -35,6 +59,9 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
 	void *msg_header;
 	int size;
 
+	if (!(event_mask & event))
+		return 0;
+
 	/* allocate memory */
 	size = nla_total_size(sizeof(struct reg_genl_event)) +
 	    nla_total_size(0);
@@ -73,6 +100,7 @@ int reg_generate_netlink_event(const char *reg_name, u64 event)
 
 static int __init reg_event_genetlink_init(void)
 {
+	event_mask = 0;
 	return genl_register_family(&reg_event_genl_family);
 }
 
diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
index 71bf71a22e7f..2a0af512b61c 100644
--- a/include/uapi/regulator/regulator.h
+++ b/include/uapi/regulator/regulator.h
@@ -69,6 +69,7 @@ struct reg_genl_event {
 enum {
 	REG_GENL_ATTR_UNSPEC,
 	REG_GENL_ATTR_EVENT,	/* reg event info needed by user space */
+	REG_GENL_ATTR_SET_EVENT_MASK,	/* reg event mask */
 	__REG_GENL_ATTR_MAX,
 };
 

base-commit: 94cc3087aac4103c33c6da84c092301afd783200
-- 
2.41.0


