Return-Path: <linux-kernel+bounces-113005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD98880B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD71C211A9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E5130E2E;
	Sun, 24 Mar 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ete0feBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303F130AF0;
	Sun, 24 Mar 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319816; cv=none; b=jwJ8x2s/aQGBJsqaZZQruAqYweiwy7pkqcapE5vun4DlS0Ole5O7oKaQay9fIAi9y/Zb9RcuSuB6Jx02g9KZmDOg93w4ejG+vZGvf6AAmaKXcXIouQaoYGW6xJN8fC4/FWGh3FQjIKvzYiELYWm1OvnzBqcVSLZJpVY2HFb13LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319816; c=relaxed/simple;
	bh=v7G71XpAS4tiF9hc66eXK5SwNfvpgF8Od1uEjij+cHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqAPuABDRCcmVPoYmHU6hgiNaskqKILtBF8nmoGOfZOual/FwIbQ6Rs232Aebwm115Cdm9mqvBJttIZ5Rn0b4xWGTQQi0Ow0mo9gXxizpcy31MAvPUl8VYPt7HuiDVRTL/yzlof1hi6doN9HqFTDrKaDTyYAMpQzxbdEdzob1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ete0feBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F53AC433A6;
	Sun, 24 Mar 2024 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319816;
	bh=v7G71XpAS4tiF9hc66eXK5SwNfvpgF8Od1uEjij+cHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ete0feBVfHrCncrbkfowqj5GRp8LIBvupWxIHatgHxA6X4tuLeyNFEfCr0Zamn1Fe
	 soWpsJqXjFZGNLQ2BDrxDijHJ+b/SH9E5rC0SgqTsjN0ASFvLVUJvsieqjw+xT6+1A
	 PRrzJ0iSbSk7BtpCwEMhpknt6k0Z9lKzgQCAqDbmYH5J36U0mmatgTBbgyfTQeTN/8
	 e/2WF1IpSwjLh15UTyHPEurCl4iXCE/W0YKZx+ihHLor5E8ELZoVJx+D5KNc2Chv3d
	 aLpIeLaufjQ2giCNKElz2jzc/1F0M1BcGfur3Xyku7FpOmyEC1+Vg91QsZ0jjh9y+U
	 CeqalD3GEoUXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 118/715] libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
Date: Sun, 24 Mar 2024 18:24:57 -0400
Message-ID: <20240324223455.1342824-119-sashal@kernel.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 93ee1eb85e28d1e35bb059c1f5965d65d5fc83c2 ]

LIBBPF_API annotation seems missing on libbpf_set_memlock_rlim API, so
add it to make this API callable from libbpf's shared library version.

Fixes: e542f2c4cd16 ("libbpf: Auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF")
Fixes: ab9a5a05dc48 ("libbpf: fix up few libbpf.map problems")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20240201172027.604869-3-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc02..dad7917903d19 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,7 +35,7 @@
 extern "C" {
 #endif
 
-int libbpf_set_memlock_rlim(size_t memlock_bytes);
+LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-- 
2.43.0


