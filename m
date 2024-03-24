Return-Path: <linux-kernel+bounces-114163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931B8888CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BA61F27548
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D962475CE;
	Sun, 24 Mar 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhemxXJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F3204FC3;
	Sun, 24 Mar 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321478; cv=none; b=UQcL50uNx2boJTApeD2jO3nyAztYuQywkoA7PprBeebnr+BTpLUZWdXiNKu8zC70AiOsw5FzyBNkG57H33hlfigB6R2FWSXAwY4v4Zzh+mDcmLNFxviT5EUnAzZJXSlCZTH6ktStwHqMFO/6z8h332J0TKwfxBGvk4EprVdqGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321478; c=relaxed/simple;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7v8Bbw7Cv8sLcNAgaUuaBuzhMutYcwtBDZqypTmO7hSgd47YLDnZE3iGqYnsZCi2d11sw7bubsuALjuGJcxMXdp/u5rhyn52E+AmMiT5/aDEJ+WNDg+QX66CWO2CY+YyC9NNZ7o2RxMz3kseCma3/cOvlWflCpZLkUNm29LH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhemxXJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B00C43390;
	Sun, 24 Mar 2024 23:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321476;
	bh=PixZTdAIXb+apt1+3VrFpubrgiRaiLYdNla0aHXf+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhemxXJ1PnYaBrbHS7N1nyvygK7qJs8u4Cx3pNYctoTOeH38HRaF5bfVJnXfNuVi4
	 FSdcgjSUQTHIiG48msPEqS8xTnaj2GyOL6mXC9Zs8yIXnH7kQWOkutmmpXAjq27f1B
	 G0ABH2fTsMYlR9CXftkEhdQKN+Wttvkncr6F4LDO7HJcGwBTE8EG2o4jlSTxjaxzJP
	 h6AT8qXrSoQbCwdZbsZQjn2noBRxwB9grXQ6z9ROalTs0GEO5EdP6JcUA5k8VNq77h
	 CYlpXW097CQJAdpNf4Tuc5Ntz2F6F7Z0tmJiVcfwZ67bgkr79IVwdfqt/4WkkiGqkH
	 /lsMUM28VBH0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 202/638] selftests: forwarding: Add missing multicast routing config entries
Date: Sun, 24 Mar 2024 18:53:59 -0400
Message-ID: <20240324230116.1348576-203-sashal@kernel.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit f0ddf15f0a74c27eb4b2271a90e69948acc3fa2c ]

The two tests that make use of multicast routig (router.sh and
router_multicast.sh) are currently failing in the netdev CI because the
kernel is missing multicast routing support.

Fix by adding the required config entries.

Fixes: 6d4efada3b82 ("selftests: forwarding: Add multicast routing test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240208165538.1303021-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/config | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index ba23435145827..8d7a1a004b7c3 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -9,6 +9,13 @@ CONFIG_CGROUP_BPF=y
 CONFIG_DUMMY=m
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=m
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
 CONFIG_MACVLAN=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_MIRRED=m
-- 
2.43.0


