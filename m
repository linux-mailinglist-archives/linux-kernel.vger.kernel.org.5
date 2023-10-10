Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96997C045B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjJJTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbjJJTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59D93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE33C433CC;
        Tue, 10 Oct 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696965729;
        bh=lsUvKMtLsJIj654EciF94nmsNpKkw3JX/6ih3ix4Eu4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Q3GYPoDx3z0kmpd/zfvvtaNatKmHt6/jTgoVqOTfsb+3Q8MmhefGYz+iRx37TPNn1
         5WbaRh01nMbW9pZ3AgCBRqkqjbFUZ3Rntxe1UAG8+25VstWYKlrGlmtz/Vvki3Hpp4
         NnuLrlQJx5EdKdv2xCrCSR5mJzbbG9voVexT3XPnJUXNTthj2P14s2LTerVN2wBsaA
         mMRLUEnsSgIYvqelO1juikXlju83Ca8J8THXKwzGtCgykjiqOxqMwidOc5I+GYs0ih
         pnYEd83xR0vNnEVs6rGlvqC7DPdRQHbLRrr7WOfWda4PFZ8uNBrAHV5yhTDVKTWJjC
         wQpmkZF781Rag==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 10 Oct 2023 21:21:44 +0200
Subject: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec for
 mptcp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10437; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KP6EllSmqpqVAJ5AFwXvlJP9SnekCqaTFAtt+Vf1Fy8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRVJk0P56bJhZb0UqWCW3B8bwRT8HAI+DAOj
 6KDpoA+Em2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c2QTEAC4jc/VvLwVtK6xx5I6z8D42c0HxpD5ko7NbnUDy1N4teYVaV+YPCMPiP78HG8VCm0iQhs
 Y8O5yHrR/Wvixzude9H2/4JSNvdcd4B3gQ7/VNxkac6eiBNLVR+Gozzg0TWWpsG3L94zHFFCkzi
 Jtn38nKH3vqinXkw8YbaKvyHkmx60LXBBCvr+b+Gy+MRJeqQClCk1xcLgR3X3hjLKDbN9Ze7n31
 VknDjyDqsvk6diKCbuKx/QzWBCBlP/sY0d+6EH6blDbjuZKmyyoJ5XG+aLyf8xmuHDVRq1F1yl/
 oXAxhztMHKs26PqOocYBWwj6zn0fXjwkdwmjShEbCINoRpnjOF+SLOQPRkCZjgxw5yIVPTfwfuO
 GOvFy8iSgHR1Tyjho0v/v4sMIvcO4xWKQIMdGTKUAzMb6d6pU0dDEhJ0XC5tXB0eqInxha+9aVO
 bNpRV0NI4kkynnyZhBVYQOiheHf66t2r9ZIvegKXx+JWr5/6iyXUvVtCo+5Zuer61UWnccGIw4U
 a/QaYlCJYv9b3dmp5Ma8/lOnRzYXPcMj6H0mPVVLP+qu8QiR27yvjUwD0S7V4yvgprHIfrgXtzd
 wT6MXjqJZcEydfyK/rsSQW+uoq4YAaw2OBXsTxtaqvhJOudhagHwI+GYJco3kScBQDy6OB3rvcL
 dhiT357SWaJk7Kg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

it describes most of the current netlink interface (uAPI definitions,
doit/dumpit operations and attributes)

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp.yaml | 394 +++++++++++++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 2 files changed, 395 insertions(+)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
new file mode 100644
index 000000000000..f8ebcd009592
--- /dev/null
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -0,0 +1,394 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: mptcp_pm
+protocol: genetlink-legacy
+doc: Multipath TCP.
+
+c-family-name: mptcp_pm_name
+c-version-name: mptcp_pm_ver
+max-by-define: true
+kernel-policy: per-op
+
+definitions:
+  -
+    type: enum
+    name: event-type
+    enum-name: mptcp_event_type
+    name-prefix: mptcp_event_
+    entries:
+     -
+      name: unspec
+      value: 0
+     -
+      name: created
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A new MPTCP connection has been created. It is the good time to
+        allocate memory and send ADD_ADDR if needed. Depending on the
+        traffic-patterns it can take a long time until the
+        MPTCP_EVENT_ESTABLISHED is sent.
+     -
+      name: established
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A MPTCP connection is established (can start new subflows).
+     -
+      name: closed
+      doc:
+        token
+        A MPTCP connection has stopped.
+     -
+      name: announced
+      value: 6
+      doc:
+        token, rem_id, family, daddr4 | daddr6 [, dport]
+        A new address has been announced by the peer.
+     -
+      name: removed
+      value: 7
+      doc:
+        token, rem_id
+        An address has been lost by the peer.
+     -
+      name: sub_established
+      value: 10
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A new subflow has been established. 'error' should not be set.
+     -
+      name: sub_closed
+      value: 11
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A subflow has been closed. An error (copy of sk_err) could be set if an
+        error has been detected for this subflow.
+     -
+      name: sub_priority
+      value: 13
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        The priority of a subflow has changed. 'error' should not be set.
+     -
+      name: listener_created
+      value: 15
+      doc:
+        family, sport, saddr4 | saddr6
+        A new PM listener is created.
+     -
+      name: listener_closed
+      value: 16
+      doc:
+        family, sport, saddr4 | saddr6
+        A PM listener is closed.
+
+attribute-sets:
+  -
+    name: address
+    name-prefix: mptcp_pm_addr_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: family
+        type: u16
+      -
+        name: id
+        type: u8
+      -
+        name: addr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: addr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: if_idx
+        type: s32
+  -
+    name: subflow-attribute
+    name-prefix: mptcp_subflow_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token_rem
+        type: u32
+      -
+        name: token_loc
+        type: u32
+      -
+        name: relwrite_seq
+        type: u32
+      -
+        name: map_seq
+        type: u64
+      -
+        name: map_sfseq
+        type: u32
+      -
+        name: ssn_offset
+        type: u32
+      -
+        name: map_datalen
+        type: u16
+      -
+        name: flags
+        type: u32
+      -
+        name: id_rem
+        type: u8
+      -
+        name: id_loc
+        type: u8
+      -
+        name: pad
+        type: pad
+  -
+    name: endpoint
+    name-prefix: mptcp_pm_endpoint_
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+  -
+    name: attr
+    name-prefix: mptcp_pm_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+      -
+        name: rcv_add_addrs
+        type: u32
+      -
+        name: subflows
+        type: u32
+      -
+        name: token
+        type: u32
+      -
+        name: loc_id
+        type: u8
+      -
+        name: addr_remote
+        type: nest
+        nested-attributes: address
+  -
+    name: event_attr
+    enum-name: mptcp_event_attr
+    name-prefix: mptcp_attr_
+    attributes:
+      -
+        name: UNSPEC
+        type: unused
+        value: 0
+      -
+        name: token
+        type: u32
+      -
+        name: family
+        type: u16
+      -
+        name: loc_id
+        type: u8
+      -
+        name: rem_id
+        type: u8
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: saddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: daddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: backup
+        type: u8
+      -
+        name: error
+        type: u8
+      -
+        name: flags
+        type: u16
+      -
+        name: timeout
+        type: u32
+      -
+        name: if_idx
+        type: u32
+      -
+        name: reset_reason
+        type: u32
+      -
+        name: reset_flags
+        type: u32
+      -
+        name: server_side
+        type: u8
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: add_addr
+      doc: Add endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &add_addr_attrs
+        request:
+          attributes:
+            - addr
+    -
+      name: del_addr
+      doc: Delete endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add_addr_attrs
+    -
+      name: get_addr
+      doc: Get endpoint information
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &get_addr_attrs
+        request:
+          attributes:
+           - addr
+        reply:
+          attributes:
+           - addr
+      dump:
+        reply:
+         attributes:
+           - addr
+    -
+      name:  flush_addrs
+      doc: flush addresses
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add_addr_attrs
+    -
+      name: set_limits
+      doc: Set protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp_limits
+        request:
+          attributes:
+            - rcv_add_addrs
+            - subflows
+    -
+      name: get_limits
+      doc: Get protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      do: &mptcp_get_limits
+        request:
+           attributes:
+            - rcv_add_addrs
+            - subflows
+        reply:
+          attributes:
+            - rcv_add_addrs
+            - subflows
+    -
+      name: set_flags
+      doc: Change endpoint flags
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp_set_flags
+        request:
+          attributes:
+            - addr
+            - token
+            - addr_remote
+    -
+      name: announce
+      doc: announce new sf
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &announce_add
+        request:
+          attributes:
+            - addr
+            - token
+    -
+      name: remove
+      doc: announce removal
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do:
+        request:
+         attributes:
+           - token
+           - loc_id
+    -
+      name: subflow_create
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &sf_create
+        request:
+          attributes:
+            - addr
+            - token
+            - addr_remote
+    -
+      name: subflow_destroy
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *sf_create
diff --git a/MAINTAINERS b/MAINTAINERS
index 1bd96045beb8..ab699a697616 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14960,6 +14960,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
+F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h

-- 
2.40.1

