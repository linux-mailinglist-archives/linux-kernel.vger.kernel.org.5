Return-Path: <linux-kernel+bounces-65662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77F85502A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7831F21ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DF129A78;
	Wed, 14 Feb 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rd8CoPG6"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19884A24;
	Wed, 14 Feb 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931362; cv=none; b=h/LA78PwkYu2oyTCKmdccMBhC1ipf8HSic78nJNXv6zHeainfR57F/Bywc3wOIyDlRR9AlSkUIbN1pOpQy0YHBdmF/g56ygAYXAahbSmg1MWHbnDGbVUPXJ7GO27WK75+z3gxUFJ+G9ghNd3iFakvjHbMdXAdyEkpjbi3Qa5LLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931362; c=relaxed/simple;
	bh=45+ZI0onSdA3aIo1s59eVulQGX8hv5CVs3B4xK1z4Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WigSzKzAY1N/EghxiSh6O/rdkW2lVl1j7iMtlD/2GT24diwVx4uqJ6ippcIvw6RoZgICUTcAK9I71lImDDh1rQE2PfU3m8OEqzJW5KPJGEGFAkb37V0O963MPfQJ0IXUiAd8uCNW4rnY55CrEY0njZRH7OwLxIjGZ7vXqUYbZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rd8CoPG6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EGl1KZ006294;
	Wed, 14 Feb 2024 18:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=/xRSgnYV0eg6fwcJrQsSBoZNZwjEYDji4NLNmw4GryI=; b=rd
	8CoPG6RIUClGrR9e7aV4n4q/n84iEC/UZuZIIwbAXp4xRLdzQ8Ab8uWGi3wzHXEv
	ytN1ZesQ1CFLRjfiQmBEt/UgNqQjkGolrjbiH7jCus6Ohkzl2EJDpG0BrdwyHM9c
	SH/U2mQERrsCeZy2vIhyQZDEp+3lbXk9VZUgAa1VWW3CXrCljo3GbRab98Ilwfkh
	I5RXZnyvl0y4y0AJF+abk5Ui7uP6/AEsKdP22TjVgfcJBzkZM3fhWH7ShqGUzP5o
	cgeBkqdAyUS4tq+7On23YhLghmUD7Cpn9wVVgrCkMRNLvYK2dhpx2m9K+wqpIGK0
	m0H7a+ei+cw0J58wADww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62shywsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:22:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CD3B040046;
	Wed, 14 Feb 2024 18:22:18 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B9DE72CA54C;
	Wed, 14 Feb 2024 18:21:33 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:33 +0100
Received: from localhost (10.201.20.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 14 Feb
 2024 18:21:33 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 3/7] remoteproc: core: Add check on cached_table pointer
Date: Wed, 14 Feb 2024 18:21:23 +0100
Message-ID: <20240214172127.1022199-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02

Add a check on the optional rproc->cached_table to perform the memory
copy only if it is not null.

2 use cases to support:
- starting on boot, in which case rproc->cached_table can be null,
- starting on crash recovery, where the cached table is used to save
  the resource table configuration on stop and re-apply the configuration
  on the re-start.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 283ca071e35c..34b0093689da 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1278,7 +1278,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	 * that any subsequent changes will be applied to the loaded version.
 	 */
 	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
-	if (loaded_table) {
+	if (loaded_table && rproc->cached_table) {
 		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
 		rproc->table_ptr = loaded_table;
 	}
-- 
2.25.1


