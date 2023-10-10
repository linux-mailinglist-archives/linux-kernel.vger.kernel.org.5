Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDB7C045C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJJTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbjJJTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E1B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:22:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2522C433CD;
        Tue, 10 Oct 2023 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696965732;
        bh=GGNRVGhxamEUe+mJiuy77cRN6IbWcukesNH+WghlWA0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lPaklZDbfu3ehromaBe8gYy3tMNXPynDRoVjY540rbsXZDrSXK14jwT/kygUhYC8r
         1JtXq4YH4FKdprdUtslbi2aeAc7OJLEuPNwq2I1SFuvq3O8bWuA0vS4D0h/dbmux7y
         6IBPg9SOnRSS900tf/EYKipYYFmLnYFBabjiSfl0nqmDGVjGGrmv5QCVav2QMmgYey
         SQGBQddsYT9ESOrk0wdM33FmOVop/3XEG32Ifb0AoJpOg9kRAkAlm3wsS5gGi/Dc1R
         SRNtg0aQIh0q3cAtN2BvBie7vYLx4oJ9rYzK8u9S0adXuYU3vgSNLFFzTq7pcb19/W
         htBsO+zJ2w8dg==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 10 Oct 2023 21:21:45 +0200
Subject: [PATCH net-next 4/6] uapi: mptcp: use header file generated from
 YAML spec
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-4-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12531; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iocgppS+/wVAdWSTWrLGaCc4r+55QRrVSnCsMDzeUyc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRVnXUGtJ2ZD62pg4pm4tHhki3/HV8N/o2t5
 5WKLpA64qOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c4o/D/0c6gI/WN8paIk6wLOjYQ3HWq3bszJn2c1mleR7UojIBl5EuQUKy/bO/5k0eeV3hKiHD8z
 JyaZuj86xtX9goF0kPIgxGuxLXh4GYKKXT+YlEKf+SEokLnqv8jJs8NoqfrEMLBbIHYWFoF/wcW
 IQ8iu+WhrY66+V9qxX5jE6KQKkxAMhOVlzvez5ZiZzRHeyuN7qxYdxduMDjM3bSw53S5lC+qXQt
 0MKUOBfNE+nc5ZvbIIFjDHBizEUUWVRz3dx7FVBIVice9H6rb/iOnKTlct5nZlaMCsd09XlLWD8
 w2kcpb+vOPOe1GQOg7I7bxTJhdH6lrItqNTPFRnqQTLSXexNxvKDtWQU20L3DaAzAZLSbK36+2E
 DEBckY17l5deCongxXoB36UQGIoaTwrRL/AYcH6pLs9hh+Q2u0fZISXc5EuQRfmxewb+vuvJLPb
 cgjvBrQefTnWf4XCeXhWUG6HnFqf1j/cICeEDLXXqVCHuMhyOG5Yx2lZoMNoG8R61IR7nYGo3u7
 N/fUelO6/sMOgjIOBWGxb1emrGTIeUk2BKLR8VZJGtjt9QZ9SaZBrN02Hx3t2jjE3DXL+ABqTQf
 Pg/9a9ssyKnXg+GxlC/dJstSoFwrFxW7vkVwdRgNWVbcD2qg8q4xMykHxnzy1Y0HbO0RCRR0pz4
 HIlrt5lHJPBLVpg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

generated with:

 $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
 > --spec Documentation/netlink/specs/mptcp.yaml \
 > --header -o include/uapi/linux/mptcp_pm.h

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 MAINTAINERS                   |   2 +-
 include/uapi/linux/mptcp.h    | 182 +++---------------------------------------
 include/uapi/linux/mptcp_pm.h | 149 ++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 173 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab699a697616..9a6e5c4c537d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14964,7 +14964,7 @@ F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
-F:	include/uapi/linux/mptcp.h
+F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 0e62937ab17c..64ecc8a3f9f2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -23,99 +23,24 @@
 #define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
 #define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
 
-enum {
-	MPTCP_SUBFLOW_ATTR_UNSPEC,
-	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
-	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
-	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
-	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
-	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
-	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
-	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
-	MPTCP_SUBFLOW_ATTR_FLAGS,
-	MPTCP_SUBFLOW_ATTR_ID_REM,
-	MPTCP_SUBFLOW_ATTR_ID_LOC,
-	MPTCP_SUBFLOW_ATTR_PAD,
-	__MPTCP_SUBFLOW_ATTR_MAX
-};
-
-#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
-
-/* netlink interface */
-#define MPTCP_PM_NAME		"mptcp_pm"
 #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
 #define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
-#define MPTCP_PM_VER		0x1
 
-/*
- * ATTR types defined for MPTCP
- */
-enum {
-	MPTCP_PM_ATTR_UNSPEC,
+#include <linux/mptcp_pm.h>
 
-	MPTCP_PM_ATTR_ADDR,				/* nested address */
-	MPTCP_PM_ATTR_RCV_ADD_ADDRS,			/* u32 */
-	MPTCP_PM_ATTR_SUBFLOWS,				/* u32 */
-	MPTCP_PM_ATTR_TOKEN,				/* u32 */
-	MPTCP_PM_ATTR_LOC_ID,				/* u8 */
-	MPTCP_PM_ATTR_ADDR_REMOTE,			/* nested address */
-
-	__MPTCP_PM_ATTR_MAX
-};
-
-#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
-
-enum {
-	MPTCP_PM_ENDPOINT_ADDR = 1,
-
-	__MPTCP_PM_ENDPOINT_MAX
-};
-
-#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
-
-enum {
-	MPTCP_PM_ADDR_ATTR_UNSPEC,
-
-	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
-	MPTCP_PM_ADDR_ATTR_ID,				/* u8 */
-	MPTCP_PM_ADDR_ATTR_ADDR4,			/* struct in_addr */
-	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
-	MPTCP_PM_ADDR_ATTR_PORT,			/* u16 */
-	MPTCP_PM_ADDR_ATTR_FLAGS,			/* u32 */
-	MPTCP_PM_ADDR_ATTR_IF_IDX,			/* s32 */
-
-	__MPTCP_PM_ADDR_ATTR_MAX
-};
-
-#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
-
-#define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
-#define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
-#define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
-#define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
-#define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
-
-enum {
-	MPTCP_PM_CMD_UNSPEC,
-
-	MPTCP_PM_CMD_ADD_ADDR,
-	MPTCP_PM_CMD_DEL_ADDR,
-	MPTCP_PM_CMD_GET_ADDR,
-	MPTCP_PM_CMD_FLUSH_ADDRS,
-	MPTCP_PM_CMD_SET_LIMITS,
-	MPTCP_PM_CMD_GET_LIMITS,
-	MPTCP_PM_CMD_SET_FLAGS,
-	MPTCP_PM_CMD_ANNOUNCE,
-	MPTCP_PM_CMD_REMOVE,
-	MPTCP_PM_CMD_SUBFLOW_CREATE,
-	MPTCP_PM_CMD_SUBFLOW_DESTROY,
-
-	__MPTCP_PM_CMD_AFTER_LAST
-};
+/* for backward compatibility */
+#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
+#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX
 
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
+#define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
+#define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
+#define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
+#define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
+#define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
+
 struct mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -138,93 +63,6 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_acked;
 };
 
-/*
- * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                      sport, dport
- * A new MPTCP connection has been created. It is the good time to allocate
- * memory and send ADD_ADDR if needed. Depending on the traffic-patterns
- * it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
- *
- * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *			    sport, dport
- * A MPTCP connection is established (can start new subflows).
- *
- * MPTCP_EVENT_CLOSED: token
- * A MPTCP connection has stopped.
- *
- * MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport]
- * A new address has been announced by the peer.
- *
- * MPTCP_EVENT_REMOVED: token, rem_id
- * An address has been lost by the peer.
- *
- * MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id,
- *                              saddr4 | saddr6, daddr4 | daddr6, sport,
- *                              dport, backup, if_idx [, error]
- * A new subflow has been established. 'error' should not be set.
- *
- * MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
- *                         daddr4 | daddr6, sport, dport, backup, if_idx
- *                         [, error]
- * A subflow has been closed. An error (copy of sk_err) could be set if an
- * error has been detected for this subflow.
- *
- * MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
- *                           daddr4 | daddr6, sport, dport, backup, if_idx
- *                           [, error]
- * The priority of a subflow has changed. 'error' should not be set.
- *
- * MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6
- * A new PM listener is created.
- *
- * MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6
- * A PM listener is closed.
- */
-enum mptcp_event_type {
-	MPTCP_EVENT_UNSPEC = 0,
-	MPTCP_EVENT_CREATED = 1,
-	MPTCP_EVENT_ESTABLISHED = 2,
-	MPTCP_EVENT_CLOSED = 3,
-
-	MPTCP_EVENT_ANNOUNCED = 6,
-	MPTCP_EVENT_REMOVED = 7,
-
-	MPTCP_EVENT_SUB_ESTABLISHED = 10,
-	MPTCP_EVENT_SUB_CLOSED = 11,
-
-	MPTCP_EVENT_SUB_PRIORITY = 13,
-
-	MPTCP_EVENT_LISTENER_CREATED = 15,
-	MPTCP_EVENT_LISTENER_CLOSED = 16,
-};
-
-enum mptcp_event_attr {
-	MPTCP_ATTR_UNSPEC = 0,
-
-	MPTCP_ATTR_TOKEN,	/* u32 */
-	MPTCP_ATTR_FAMILY,	/* u16 */
-	MPTCP_ATTR_LOC_ID,	/* u8 */
-	MPTCP_ATTR_REM_ID,	/* u8 */
-	MPTCP_ATTR_SADDR4,	/* be32 */
-	MPTCP_ATTR_SADDR6,	/* struct in6_addr */
-	MPTCP_ATTR_DADDR4,	/* be32 */
-	MPTCP_ATTR_DADDR6,	/* struct in6_addr */
-	MPTCP_ATTR_SPORT,	/* be16 */
-	MPTCP_ATTR_DPORT,	/* be16 */
-	MPTCP_ATTR_BACKUP,	/* u8 */
-	MPTCP_ATTR_ERROR,	/* u8 */
-	MPTCP_ATTR_FLAGS,	/* u16 */
-	MPTCP_ATTR_TIMEOUT,	/* u32 */
-	MPTCP_ATTR_IF_IDX,	/* s32 */
-	MPTCP_ATTR_RESET_REASON,/* u32 */
-	MPTCP_ATTR_RESET_FLAGS, /* u32 */
-	MPTCP_ATTR_SERVER_SIDE,	/* u8 */
-
-	__MPTCP_ATTR_AFTER_LAST
-};
-
-#define MPTCP_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
-
 /* MPTCP Reset reason codes, rfc8684 */
 #define MPTCP_RST_EUNSPEC	0
 #define MPTCP_RST_EMPTCP	1
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
new file mode 100644
index 000000000000..0c7206531eb1
--- /dev/null
+++ b/include/uapi/linux/mptcp_pm.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/mptcp.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_MPTCP_PM_H
+#define _UAPI_LINUX_MPTCP_PM_H
+
+#define MPTCP_PM_NAME	"mptcp_pm"
+#define MPTCP_PM_VER	1
+
+/**
+ * enum mptcp_event_type
+ * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport A new MPTCP connection has been created. It is the good time
+ *   to allocate memory and send ADD_ADDR if needed. Depending on the
+ *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
+ *   is sent.
+ * @MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
+ *   sport, dport A MPTCP connection is established (can start new subflows).
+ * @MPTCP_EVENT_CLOSED: token A MPTCP connection has stopped.
+ * @MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dport] A
+ *   new address has been announced by the peer.
+ * @MPTCP_EVENT_REMOVED: token, rem_id An address has been lost by the peer.
+ * @MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id, saddr4 |
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error] A new
+ *   subflow has been established. 'error' should not be set.
+ * @MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] A subflow has been
+ *   closed. An error (copy of sk_err) could be set if an error has been
+ *   detected for this subflow.
+ * @MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *   daddr4 | daddr6, sport, dport, backup, if_idx [, error] The priority of a
+ *   subflow has changed. 'error' should not be set.
+ * @MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6 A new PM
+ *   listener is created.
+ * @MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6 A PM listener
+ *   is closed.
+ */
+enum mptcp_event_type {
+	MPTCP_EVENT_UNSPEC,
+	MPTCP_EVENT_CREATED,
+	MPTCP_EVENT_ESTABLISHED,
+	MPTCP_EVENT_CLOSED,
+	MPTCP_EVENT_ANNOUNCED = 6,
+	MPTCP_EVENT_REMOVED,
+	MPTCP_EVENT_SUB_ESTABLISHED = 10,
+	MPTCP_EVENT_SUB_CLOSED,
+	MPTCP_EVENT_SUB_PRIORITY = 13,
+	MPTCP_EVENT_LISTENER_CREATED = 15,
+	MPTCP_EVENT_LISTENER_CLOSED,
+};
+
+enum {
+	MPTCP_PM_ADDR_ATTR_UNSPEC,
+	MPTCP_PM_ADDR_ATTR_FAMILY,
+	MPTCP_PM_ADDR_ATTR_ID,
+	MPTCP_PM_ADDR_ATTR_ADDR4,
+	MPTCP_PM_ADDR_ATTR_ADDR6,
+	MPTCP_PM_ADDR_ATTR_PORT,
+	MPTCP_PM_ADDR_ATTR_FLAGS,
+	MPTCP_PM_ADDR_ATTR_IF_IDX,
+
+	__MPTCP_PM_ADDR_ATTR_MAX
+};
+#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
+
+enum {
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+
+	__MPTCP_SUBFLOW_ATTR_MAX
+};
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
+
+enum {
+	MPTCP_PM_ENDPOINT_ADDR = 1,
+
+	__MPTCP_PM_ENDPOINT_MAX
+};
+#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
+
+enum {
+	MPTCP_PM_ATTR_UNSPEC,
+	MPTCP_PM_ATTR_ADDR,
+	MPTCP_PM_ATTR_RCV_ADD_ADDRS,
+	MPTCP_PM_ATTR_SUBFLOWS,
+	MPTCP_PM_ATTR_TOKEN,
+	MPTCP_PM_ATTR_LOC_ID,
+	MPTCP_PM_ATTR_ADDR_REMOTE,
+
+	__MPTCP_PM_ATTR_MAX
+};
+#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+
+enum mptcp_event_attr {
+	MPTCP_ATTR_UNSPEC,
+	MPTCP_ATTR_TOKEN,
+	MPTCP_ATTR_FAMILY,
+	MPTCP_ATTR_LOC_ID,
+	MPTCP_ATTR_REM_ID,
+	MPTCP_ATTR_SADDR4,
+	MPTCP_ATTR_SADDR6,
+	MPTCP_ATTR_DADDR4,
+	MPTCP_ATTR_DADDR6,
+	MPTCP_ATTR_SPORT,
+	MPTCP_ATTR_DPORT,
+	MPTCP_ATTR_BACKUP,
+	MPTCP_ATTR_ERROR,
+	MPTCP_ATTR_FLAGS,
+	MPTCP_ATTR_TIMEOUT,
+	MPTCP_ATTR_IF_IDX,
+	MPTCP_ATTR_RESET_REASON,
+	MPTCP_ATTR_RESET_FLAGS,
+	MPTCP_ATTR_SERVER_SIDE,
+
+	__MPTCP_ATTR_MAX
+};
+#define MPTCP_ATTR_MAX (__MPTCP_ATTR_MAX - 1)
+
+enum {
+	MPTCP_PM_CMD_UNSPEC,
+	MPTCP_PM_CMD_ADD_ADDR,
+	MPTCP_PM_CMD_DEL_ADDR,
+	MPTCP_PM_CMD_GET_ADDR,
+	MPTCP_PM_CMD_FLUSH_ADDRS,
+	MPTCP_PM_CMD_SET_LIMITS,
+	MPTCP_PM_CMD_GET_LIMITS,
+	MPTCP_PM_CMD_SET_FLAGS,
+	MPTCP_PM_CMD_ANNOUNCE,
+	MPTCP_PM_CMD_REMOVE,
+	MPTCP_PM_CMD_SUBFLOW_CREATE,
+	MPTCP_PM_CMD_SUBFLOW_DESTROY,
+
+	__MPTCP_PM_CMD_MAX
+};
+#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_MAX - 1)
+
+#endif /* _UAPI_LINUX_MPTCP_PM_H */

-- 
2.40.1

