Return-Path: <linux-kernel+bounces-115871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B288969E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908AF1F31FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAE159216;
	Mon, 25 Mar 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iII5Qdmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53D14600A;
	Sun, 24 Mar 2024 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322066; cv=none; b=rA2O6Z4MQ6n4I7HX8mR8POymvDT8LmFhy5pekLQdmfcLcJC1HvRkmNYuxgq7YmDrd1RcAjNAZUTJNLd+PZrtPXPFW9Vx65mKRI4xL30B3bAP5K4q2+zqg0is3sheUtzp08PwzZ+368MCMlOc3FUTyhMWKxfN211mr/X4Kg8H7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322066; c=relaxed/simple;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3dIxbgVuyp92WZ7PkuVpNvMAjy8ObaH4Y9rgwRaJdHyCwduESeeJkq5dsge2/AfmmNyjJitINtKbvvKyeRO0k+V/Qw9fSl3PwkKhR51kBmL7Ytjv/++Sq0guED9vamZn1mIEidnNLjycibo1YI0piPp7SOMqop1pM0uALoG2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iII5Qdmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A4BC43394;
	Sun, 24 Mar 2024 23:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322065;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iII5QdmuNCr48bmZCPZ7/hv9Gf7fMWGh7dDzVDxg2nQNCB13uTBn5lORj5rMpge6f
	 jCVJQLF8BU67Aao2ngzfEPU5E0M0hADDvngYvVCuJGnyEMelZBCynruzF7l1WqmZDh
	 txjzIQBQ+LJV+hZ3IZ02Nfun+d525c7apFViYSxjZusD7IJ099gC67yqOh4Hh06RDu
	 d1fPm4aLNwySZPGyy+mb7y8bigyr/ieGzzAXzXQz3CmG+HD1Tyme2PjoKDXm4nedPe
	 A/gJtG2P1RjjdzeC0sJJ/25ogJGGHs0cqcdcu97O16kItpd1d0MyuA600Nr61MkDbZ
	 3wuO0WlxPcJzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 138/451] selftests: forwarding: Add missing config entries
Date: Sun, 24 Mar 2024 19:06:54 -0400
Message-ID: <20240324231207.1351418-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


