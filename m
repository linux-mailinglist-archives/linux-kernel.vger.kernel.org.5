Return-Path: <linux-kernel+bounces-133488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A289A474
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5451F20C16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C453172BAE;
	Fri,  5 Apr 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+5e6+2l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934617279E;
	Fri,  5 Apr 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343454; cv=none; b=A4vVnFuAEdOmA+KZr2+/lAC7nQPwhYOqouuUMYC/m55sA9p6meNDitkWGJ1NFoDJz1OnEcf8iZ2kWozOJw6r83XXkEyDR4fYhnYnF3MKAYFMwdoeC3u0xUZdo9ZVyMQMR4iYRkR4suAbCMFwdgOKlz80Z08GRwYOuNWDqO7BOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343454; c=relaxed/simple;
	bh=LnamEoZaR3iwKuwi0MrPtYbjJA5iVWtngHBMfSeCOnc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=SaVewlGbXl/+CUkc4xe4OLGTMy7dN6zebgeNRAX6XM4ydtr7IODBzPG729S6iMQykUSTmWoFN/h/o+ApfpFCswbhCSxEHKHwHA1spL2QqFGpHuO0LtNbENy2h/2F2eLGJgUnDagYkR16P0k6u1F3nbJfNbELNQeZUwr2nwbZXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+5e6+2l; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712343453; x=1743879453;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=LnamEoZaR3iwKuwi0MrPtYbjJA5iVWtngHBMfSeCOnc=;
  b=S+5e6+2lylHUY1+aSCn5b3LDBG2DhrIHZCpQPhYP8HOmZIUkhlIXtEHu
   gCAfKKnmDhU/Mt7gXPc6eE50esYYKLOd8sHTDYQGDrsM+9+MXe73th1mM
   6zPbySyJOu6ad5CjV86ObjkIhEx4MSI5zCqd6KBkLp8byTeL0a9Cf/YfC
   XP2hjgqIfe72pfXUHCa6g13EUb/bcxYzYzPuC+mQmVFc4Cty1EV72mJbo
   YDs0aIBKxDstE26pAsgy3G6eXO4+Vnj9FBkWtiQLXUuKwyglwomQw0IaZ
   B8++6TMx9gNQvek7FlgowkgvScG2jmuNcw/fFxH7xaxW6WHor7GxEz64Z
   g==;
X-CSE-ConnectionGUID: ZRCEN42HQF6yaO6UWKtSEQ==
X-CSE-MsgGUID: NDAFJe+SRLibMf6AQxtA9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="30168079"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="30168079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:57:32 -0700
X-CSE-ConnectionGUID: WVTk02faR+GSXUEVAchgYw==
X-CSE-MsgGUID: 6tmd2CxkTNygQJMwk8i/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19275901"
Received: from yessieki-mobl.amr.corp.intel.com ([10.212.83.7])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:57:31 -0700
Message-ID: <afef90304a6985474a9d367efb21423b8c56cc88.camel@linux.intel.com>
Subject: [PATCH] crypto: iaa - Use cpumask_weight() when rebalancing
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 05 Apr 2024 13:57:30 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

If some cpus are offlined, or if the node mask is smaller than
expected, the 'nonexistent cpu' warning in rebalance_wq_table() may be
erroneously triggered.

Use cpumask_weight() to make sure we only iterate over the exact
number of cpus in the mask.

Also use num_possible_cpus() instead of num_online_cpus() to make sure
all slots in the wq table are initialized.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/in=
tel/iaa/iaa_crypto_main.c
index 6229b24b0d35..814fb2c31626 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -922,7 +922,7 @@ static void rebalance_wq_table(void)
 	for_each_node_with_cpus(node) {
 		node_cpus =3D cpumask_of_node(node);
=20
-		for (cpu =3D 0; cpu < nr_cpus_per_node; cpu++) {
+		for (cpu =3D 0; cpu <  cpumask_weight(node_cpus); cpu++) {
 			int node_cpu =3D cpumask_nth(cpu, node_cpus);
=20
 			if (WARN_ON(node_cpu >=3D nr_cpu_ids)) {
@@ -2005,7 +2005,7 @@ static int __init iaa_crypto_init_module(void)
 	int ret =3D 0;
 	int node;
=20
-	nr_cpus =3D num_online_cpus();
+	nr_cpus =3D num_possible_cpus();
 	for_each_node_with_cpus(node)
 		nr_nodes++;
 	if (!nr_nodes) {
--=20
2.38.1



