Return-Path: <linux-kernel+bounces-114162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E28888CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D489D1C2666B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE9246E30;
	Sun, 24 Mar 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rej8Uvbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C1204FA2;
	Sun, 24 Mar 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321477; cv=none; b=RkeIvsp99bhk/gzm6wA/FoGsZ0tlsuY7bwxEqj+zJirgHf7kVHvqdbk+QqeRmiTqd5EWZ3PuTzlU/p37jJz19NQN4NsMjCRiqQWHSsISRdugNO0P7pcrXUCU/8dO6WCuFotTc+0p8aB7Ln3oU81nrwBXM+lcSk8fs5/xjkTonZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321477; c=relaxed/simple;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tahdsGNy2gYWWBVeF17boEv0eXKyA50GCEMm3FE9qqKJ476KSVkc2+tKE0bm6XLG6RgrtVZEAGzB+mrrCW4pz7PsB9zUeLSo4TxbXpNjAHivP0i2pMU1fulE9YdHtzCJfPFWlli9UnaJUvQzmfz1aHkDXoXfcLKQdhNw+EszDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rej8Uvbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC56C433F1;
	Sun, 24 Mar 2024 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321475;
	bh=of02US8bUUeHmltBhwO0q0jgCHO9nnXXigQFqbU83BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rej8UvbgwW/JVhS1jMst/WIQpKE86KlUD/b8DRDJu/R72uu/gCnWBbILiOOZSvhZO
	 XRf9bE9QURobD6FqGH6n7QXPi/phb6xa5oqJlTr7k9txZaelzFUU48V1t/xWReB8Oh
	 bCthv7iTwzCUm5PyfMfss6BNLJGlD39zWyIerfrgZetPKOb+IX4WVq0yOlms3cCqM/
	 biYqebNesvil+M+jnpefmqlHTzj6qp+PGBtJJNOPmqmjwA/Qnc360pkvLZ92KqtDku
	 d9H+MorJLObas/Q6UT0NE5R7pdmIFwvrycTcHuoNbaLuVj5O+Y8jlIGb8u1uGv2BUo
	 pV3s34hgZ2NbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 201/638] selftests: forwarding: Add missing config entries
Date: Sun, 24 Mar 2024 18:53:58 -0400
Message-ID: <20240324230116.1348576-202-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


