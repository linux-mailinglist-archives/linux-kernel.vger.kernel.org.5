Return-Path: <linux-kernel+bounces-7175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BB81A2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA7B28B17D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751213FE4E;
	Wed, 20 Dec 2023 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejQ2PFPu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Irkd7Gr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779183FB04;
	Wed, 20 Dec 2023 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703086509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwb3TBF8ZkmmGchbIYHoNeOIl9Lz8S3txVTK+sa+eW0=;
	b=ejQ2PFPu/OLQocj56zGeoqvAIN8yuELzXuIYDdIg6gh0vQKM97WEZqEZYlaOYqolBf4JwT
	LDcx0GAbCSFRMYWKrJpBApjMeqTs0+LLes3b6ad87cjxQ80SCMBueg+Xo2vqq5VX5t3wIf
	Q0eHWOhjV+3WFtRQvv1ct2yi2CTTDcZLAnkKfuSpjwvOi5WiWWXmEhNEgLfxj4HNoIJrVd
	W4HULw6Dmrw+zqoFTedSH4skjg11Bkem8MMpI0le9ILUyzfXsmbtsAFcIz60NpBT5dGE+3
	bajhh8DCkmggv01+dvbHJlXutJDruvJVIsc+Wc0tQm0uNgZq8SGcBclbkPslvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703086509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwb3TBF8ZkmmGchbIYHoNeOIl9Lz8S3txVTK+sa+eW0=;
	b=3Irkd7Gr+cCWaRx1wpmZS/NSRKDOvJf6vZxWrH+EBHdSZCiIc8HNqkvfLi+ukhmi/No2ds
	Y8erMO1+OOehysCg==
From: "tip-bot2 for xiaoming Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Increase the number of dynamic states
Cc: Xiaoming Wang <xiaoming.wang@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219033411.816100-1-xiaoming.wang@intel.com>
References: <20231219033411.816100-1-xiaoming.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308650830.398.5666378578181413090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     fe22944cf05ede8e6f841cfecdb7093a53a3d9b3
Gitweb:        https://git.kernel.org/tip/fe22944cf05ede8e6f841cfecdb7093a53a3d9b3
Author:        xiaoming Wang <xiaoming.wang@intel.com>
AuthorDate:    Tue, 19 Dec 2023 11:34:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:25:15 +01:00

cpu/hotplug: Increase the number of dynamic states

The dynamically allocatable hotplug state space can be exhausted by
the existing drivers and infrastructure which install CPU hotplug
states dynamically. That prevents new drivers and infrastructure from
installing dynamically allocated states.

Increase the size of the CPUHP_AP_ONLINE_DYN state by 10 to make
room.

Signed-off-by: Xiaoming Wang <xiaoming.wang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231219033411.816100-1-xiaoming.wang@intel.com
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index af6c21a..8bd454d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -239,7 +239,7 @@ enum cpuhp_state {
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_BASE_CACHEINFO_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
+	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 40,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
 	CPUHP_AP_ACTIVE,

