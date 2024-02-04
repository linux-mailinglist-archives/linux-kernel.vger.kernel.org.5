Return-Path: <linux-kernel+bounces-51934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C7849197
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4691F21CF3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05F101DE;
	Sun,  4 Feb 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOniHsaw"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7894BA57;
	Sun,  4 Feb 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089271; cv=none; b=g7+CKDsU7C0eYwiXnE2F1AheWQVuJCeQjZ8l1CfXMQnhW3RLN4pjFqb91Wafo2ecWKKFIDRNw7R7derB0k43iRiM7PGgrrzwQTNeMuyanvFs/q1MsSxfdNj7xRhbmZxEb3BvSZgpIBFfkkr4yxaRd/70jrC/c+3wdtwLoSuBZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089271; c=relaxed/simple;
	bh=hCS2aSunhFrD9DEGkpc79H6g2xpOiEG3QZMlbosGi98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHVVxRGcJSQ1p9v0Qt5I77U5vZ6KMYmfesrJhN8lcI7xsnTbdqwILFjfznEX7IQ9xi3uqy03szZgUTZV7sncRdBU9LDRuTDS6+HI2+4lP6O75mlQOnt0KXcIDTUp+cLFtjudmqh7J7hj/TYpWC3eZevvcQ2sX8vLfoSQmD1ZzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOniHsaw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e03b32dfcbso79742b3a.3;
        Sun, 04 Feb 2024 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089269; x=1707694069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyCq+IsPoW1cFeL3otUPd5WJOAaYH3GsmKkRPvUde5E=;
        b=aOniHsawCFgnn5n0e7fbt4jZ1nsnDWMGbIzJdOmZKEP7JgPk1nDevcQw5tFDNTcezN
         Bh3+aORG+0/EJHaRfB1KBPr39/JzHLzZU1+XShluiQnx5ts0LUU6N0Fi0Rtg1TuvcFSz
         vzWcyE+ud5xOnXBzpC+NSh+OIFz+G15eWoydP1/OpsIjcmcaFveu9LZgNcL7lzyp288I
         5LvkxdlzyH6SwRSgcHceTu9J7BDmuoLV9BxyYzCNRSkXdaGkJ8aBIwAlfYHS+o9dolbY
         JfQHvUBi6MZoCAq5TQDYspSxsi7v42mJVP85mLVlN7K8XfeQX9e831ku5vMkvf0kQiT3
         rPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089269; x=1707694069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyCq+IsPoW1cFeL3otUPd5WJOAaYH3GsmKkRPvUde5E=;
        b=r4WCbfb+/9y9kJIty8gtwiJgdcYOl1QgZLETDXqEs0YGc6FciW6OspA6M/9ZPRB1Yw
         mSS1T+0RtV8SE2Wzi2falaFBlxsa8fwUwFAxiInIDOt7J2+RkweVZir8NiP/nYINn/9S
         THjJCSusOuUWqzc7gb/Q3jHOH7DU1VikrWgF8ApqIN4Gg7Tb4MruSCrObo3NUB8S1fUa
         NP6+46M9ydiG27KEBX+zpXanqDZlrWC6CEcyQ+pygN0sjIHXDnO8gaAASv7tzf0Qxh4C
         7nSS86FdgX8AmwY+4FiGnQOrndriG9D7ZDE4K93IzdryqXjn5qrULQJHxcj3X/C5HyoJ
         o33g==
X-Gm-Message-State: AOJu0YzuoPmS/7SIokTXputIA4YwpiHOg7OO6q4Ki53iOt7HnrB8VmJa
	yxdy6kBcSqAp2bu8x1RopHd3kAxq1CxLcAHnLeXor/8/G076asmL
X-Google-Smtp-Source: AGHT+IHb3yb71qnbWYVUpmsW69pmtZBvJYGxorE0dlBpKSzkaNcsvNb3W8mT75WVaPndOZb2pMSicQ==
X-Received: by 2002:a05:6a20:d044:b0:19c:a2ec:64f with SMTP id hv4-20020a056a20d04400b0019ca2ec064fmr7332654pzb.2.1707089269056;
        Sun, 04 Feb 2024 15:27:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOnkq7M4FaqNjLECzIvb8+DPDQ658/5RdxsRHkxVlT8bnGyzNypM4SOPMje4e0tQB+IoDVQ+fwrQMvtr/Y+FGxJHmrKQA0FllzltGZolQEZVBfDMKr7ZFtwMmF0ffgxkrhflSaQTV4Kn8qUoLBI4SjcTCtYGEcuLbRTiB5nJyQIjk/GnsmqMwCJyCatszo6L2GfDSp8XokR9n/dG56
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id s17-20020a632151000000b005cd8044c6fesm5620442pgm.23.2024.02.04.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:48 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/8] net: netconsole: cleanup formatting lints
Date: Sun,  4 Feb 2024 15:27:32 -0800
Message-ID: <20240204232744.91315-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address checkpatch lint suggestions in preparation for later changes

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 6e14ba5e06c8..93fc3b509706 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -49,7 +49,7 @@ static char config[MAX_PARAM_LENGTH];
 module_param_string(netconsole, config, MAX_PARAM_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]");
 
-static bool oops_only = false;
+static bool oops_only;
 module_param(oops_only, bool, 0600);
 MODULE_PARM_DESC(oops_only, "Only log oops messages");
 
@@ -501,6 +501,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 
 	if (strnchr(buf, count, ':')) {
 		const char *end;
+
 		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
 			if (*end && *end != '\n') {
 				pr_err("invalid IPv6 address at: <%c>\n", *end);
@@ -510,9 +511,9 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		} else
 			goto out_unlock;
 	} else {
-		if (!nt->np.ipv6) {
+		if (!nt->np.ipv6)
 			nt->np.local_ip.ip = in_aton(buf);
-		} else
+		else
 			goto out_unlock;
 	}
 
@@ -537,6 +538,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 
 	if (strnchr(buf, count, ':')) {
 		const char *end;
+
 		if (in6_pton(buf, count, nt->np.remote_ip.in6.s6_addr, -1, &end) > 0) {
 			if (*end && *end != '\n') {
 				pr_err("invalid IPv6 address at: <%c>\n", *end);
@@ -546,9 +548,9 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		} else
 			goto out_unlock;
 	} else {
-		if (!nt->np.ipv6) {
+		if (!nt->np.ipv6)
 			nt->np.remote_ip.ip = in_aton(buf);
-		} else
+		else
 			goto out_unlock;
 	}
 
@@ -781,6 +783,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 	if (stopped) {
 		const char *msg = "had an event";
+
 		switch (event) {
 		case NETDEV_UNREGISTER:
 			msg = "unregistered";
-- 
2.43.0


