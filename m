Return-Path: <linux-kernel+bounces-113065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64088812F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C6D2816AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261A537F6;
	Sun, 24 Mar 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9JqIpQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF91487D1;
	Sun, 24 Mar 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319873; cv=none; b=R+4MPjeHaR5BOQnOqHkHktgtiPNNgECPcMJl7QqE8oI1oDA5QmQyPLrbv+Rm05CJvW7bqkagV/vYU22DvLGdKOF9wh89j7zBDVA768J649q3szG4RTf/b1A0ktOoQaeovH5iDin+fBSfBkeeU1NaStweezhufk0LhiBag65t3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319873; c=relaxed/simple;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULa7ioaxFcD3qDF0uJSMPC7uMgRmbjc/UxkwxYRfIBvm99eZYhb+JS40Acg8UYWvQ/2wqWPFTA2Xs0pf/lgovcAXhNpwy2uxYY8vQWolX4GMOm+D8a6nSxn4cgpf6ww7/Qh3ZQ0BFPDE++KHzLPmPaKyZNxC3p0RAKJ6GmaqCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9JqIpQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D450C433C7;
	Sun, 24 Mar 2024 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319873;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9JqIpQup9qw13yc7zZmx/gAkceQXh3ygNHBeVtn9hIlHw7lZMWzEkQyOnqvCBgBX
	 ZVVMZAr40IwuO+FLtddxPMbtVmBr3bNqfJOJSf+9bcUxjWfTM4TqVfBjjVlNSh7iyp
	 K+hgaS36vGmugmoxc+8P8iYucjnbQ9NhA49/4thBFZto7OzR6KsseEbzXZd1VnKI0A
	 +vBvjX+VXjoH27E0O8G0My4Cg10MSHIyESZenU2TwXVbNKE7McyweGsEs2dA5dS9sr
	 DLzxYnOO7tcc573OxewXNHYEJ2H4+X9xD/oq1+pHmJaX+3stDCkOWhZnv1eyEaHcYV
	 8hZqjHHzjBxbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 178/715] selftests: forwarding: Add missing config entries
Date: Sun, 24 Mar 2024 18:25:57 -0400
Message-ID: <20240324223455.1342824-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit 4acf4e62cd572b0c806035046b3698f5585ab821 ]

The config file contains a partial kernel configuration to be used by
`virtme-configkernel --custom'. The presumption is that the config file
contains all Kconfig options needed by the selftests from the directory.

In net/forwarding/config, many are missing, which manifests as spurious
failures when running the selftests, with messages about unknown device
types, qdisc kinds or classifier actions. Add the missing configurations.

Tested the resulting configuration using virtme-ng as follows:

 # vng -b -f tools/testing/selftests/net/forwarding/config
 # vng --user root
 (within the VM:)
 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests

Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://lore.kernel.org/r/025abded7ff9cea5874a7fe35dcd3fd41bf5e6ac.1706286755.git.petrm@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: f0ddf15f0a74 ("selftests: forwarding: Add missing multicast routing config entries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/config | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 697994a9278bb..ba23435145827 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -6,14 +6,42 @@ CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_VRF=m
 CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
+CONFIG_DUMMY=m
+CONFIG_IPV6=y
+CONFIG_IPV6_GRE=m
+CONFIG_MACVLAN=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_NET_ACT_MPLS=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_POLICE=m
+CONFIG_NET_ACT_SAMPLE=m
+CONFIG_NET_ACT_SKBEDIT=m
+CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_VLAN=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_EMATCH=y
+CONFIG_NET_EMATCH_META=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPIP=m
+CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_ACT_GACT=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_TC_SKB_EXT=y
+CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_LOADBALANCE=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_FLOW_TABLE=m
+CONFIG_NF_TABLES=m
 CONFIG_VETH=m
 CONFIG_NAMESPACES=y
 CONFIG_NET_NS=y
+CONFIG_VXLAN=m
+CONFIG_XFRM_USER=m
-- 
2.43.0


