Return-Path: <linux-kernel+bounces-131787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE65898BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DC01F222D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59012D1EF;
	Thu,  4 Apr 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFtrvMwE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4C12AADB;
	Thu,  4 Apr 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246677; cv=none; b=ncNZ0DSLPuU+Brdlqs6BpRS5Gf4tnq8Z9PJ5g4WSjS7Mt88qxnEvbXQjh9QggAW+2pzlsB6I8WMtti3OfZqApcQ+LoZwRtrxuZ2XesytLLHgQfhi6zZGxk70+f/DgwEHyw7+JZ3o4Rjzp8m9kIYJd5xu2Lr+rzu9uKlskSRn158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246677; c=relaxed/simple;
	bh=JAnb7ekQrdFs07fy9SPZ/n1vc9+Tp4GolLxUfCmpr/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYFB2UTlT8vViuRzh44Oa/AqOR272Lp3bFcLHtWX+4tIBq/FrBPv7QA1dqi6HazVBZxZJ6JZjeYdRZbL2bxN4GujxrhZrnPM2uKGLNoZSVwhKxihx5t2UXf7CbqgXHjA/ZGWABAWIiOB7AyNSHtZ1r/ImODGPXtCSlhTC/vRK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFtrvMwE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712246675; x=1743782675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JAnb7ekQrdFs07fy9SPZ/n1vc9+Tp4GolLxUfCmpr/8=;
  b=WFtrvMwEtILW/TX7bdyjJJ6xVuA2NW1+wgaUD5y3jH0+Oye/biZ3YuoE
   PMY46S9JHwO5wpjgDCq2lfEZTvk6TwJk5ssMqM/pMIjYKucvrknFpkd3S
   tdZzRlLF9L6wlbZEEVB6WnORBk9zn+ZQbA/gqSjdobgx3dCaP1NpEDyt7
   wfkAIBRcc9HP/sVYMJpd9YbHEWGJo47J7l8onEZm3H9Ng4nFKVY04mEAl
   GA905HimcZHeI33M8VTQrByaPmpM9+TB/WEKSMMNCEAo00xo19C0Qaptr
   fSjhpKZKNB1OeKICO1u6XV4hqZ+V7T4Vf3/HrCfofDn7G+yblt4jVFtV5
   A==;
X-CSE-ConnectionGUID: lpWzxBsNRxiWKm8PzSsXmA==
X-CSE-MsgGUID: UIPHVl/GQdy658hxfwWaug==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11315329"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11315329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:04:25 -0700
X-CSE-ConnectionGUID: KVv5SIu9Tma6YHAJYSBMlQ==
X-CSE-MsgGUID: TTKSY83AQ5G201GXjbgN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23292859"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 09:04:22 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ip_tunnel: harden copying IP tunnel params to userspace
Date: Thu,  4 Apr 2024 18:03:02 +0200
Message-ID: <20240404160302.3585661-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Structures which are about to be copied to userspace shouldn't have
uninitialized fields or paddings.
memset() the whole &ip_tunnel_parm in ip_tunnel_parm_to_user() before
filling it with the kernel data. The compilers will hopefully combine
writes to it.

Fixes: 117aef12a7b1 ("ip_tunnel: use a separate struct to store tunnel params in the kernel")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/ipv4/ip_tunnel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index f63b573f66dc..6ec4365cefa5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1034,6 +1034,8 @@ bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
 	    !ip_tunnel_flags_is_be16_compat(kp->o_flags))
 		return false;
 
+	memset(&p, 0, sizeof(p));
+
 	strscpy(p.name, kp->name);
 	p.link = kp->link;
 	p.i_flags = ip_tunnel_flags_to_be16(kp->i_flags);
-- 
2.44.0


