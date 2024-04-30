Return-Path: <linux-kernel+bounces-164126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14058B7958
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C7D2818B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABF1C233F;
	Tue, 30 Apr 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eM33BEt2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70030172BBF;
	Tue, 30 Apr 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486592; cv=none; b=Pmx9adVH8aulzjjPCxBSvRMz8B1nQ5i47+RXVGa67dz2s8koJcBWXVn+S8JuzF1zF4+1QF8mgaAV1dXI+mBUrCWu5P/4QPimtGCwvI80MMey+6c1DFjJASPoiQ2VvR1MeBpFNWZNPFzGhIONB4OTChg8MdMHbtUYbJNCk5INpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486592; c=relaxed/simple;
	bh=VnGje2vsuNNX86eGecKjoz4Ax6Vr3kuQDPJzyTb3N4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npfk3x1e2J4ds/2y1UbFeWxxGhEw1jQoPzNOpDTxRy7BAZQEaObQGf8x4p/SsuNp61NrZ2iBAEmsEiJsOVP9J/NsLshU/UQgrCN6h5LjVzfmI4aasHyGKkL5O7xjPGIjF4VZ6x01y6FRZC4g+nQQHkHFriexOpNf88tERopiq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eM33BEt2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UECFHR010344;
	Tue, 30 Apr 2024 14:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=aYJ3Kt9c1VzZVEbwIY2J3w38JrUTcaE16SfYcftkq5k=;
 b=eM33BEt2s1CrqyJ8/PJsfz8A5enMTgibxiszTdTzQts6IxnOZqknRg1NPl0YuiEDzjQb
 EdKvgSQ9LwfWZF94EHYEDJRjkKepuXKpfJ5B64k3plmxZpFCVdGi7ekIdnVqr+SwDCqN
 QoMTZQg5Z6Cnj0Kj5PLxXsz6eGyLFv/+wh02SkqVvSpRCTw+pqK6DZzDL0NVODIQMdKV
 xOZi34UqOTiu1JiAl+Xs07zAbQ97sYAh5J5QwZC804JaFk/Ah1cbGhoS0sYPmQ435Cp0
 xx411gqN7oyeuCBRm9lc5bp57s1TOXRaNmp3Xahj3WjuLbeXIVmFv+7yMHfj00stm225 QQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu221r0x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:16:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43UE0G77022177;
	Tue, 30 Apr 2024 14:16:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6mn90s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:16:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UEGAT536241686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:16:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F67B20073;
	Tue, 30 Apr 2024 14:16:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6BF92004D;
	Tue, 30 Apr 2024 14:16:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2024 14:16:09 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>, imx@lists.linux.dev,
        Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>, peng.fan@nxp.com
Subject: [PATCH] clk: imx: imx8mp: Add missing CONFIG_PM ifdefs
Date: Tue, 30 Apr 2024 16:16:09 +0200
Message-Id: <20240430141609.2244416-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
References: <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pJou94LF_Dl22Dca5rhnWdRvx8EVHD0a
X-Proofpoint-ORIG-GUID: pJou94LF_Dl22Dca5rhnWdRvx8EVHD0a
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300101

Add missing CONFIG_PM ifdefs to fix this allmodconfig compile error:

drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: error:
'clk_imx8mp_audiomix_runtime_suspend' defined but not used
[-Werror=unused-function]
  356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com
Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 574a032309c1..6549e55e94c9 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -217,6 +217,8 @@ struct clk_imx8mp_audiomix_priv {
 	struct clk_hw_onecell_data clk_data;
 };
 
+#ifdef CONFIG_PM
+
 static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
 {
 	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
@@ -232,6 +234,8 @@ static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
 	}
 }
 
+#endif /* CONFIG_PM */
+
 static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 {
 	struct clk_imx8mp_audiomix_priv *priv;
@@ -353,6 +357,8 @@ static int clk_imx8mp_audiomix_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+
 static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
 {
 	clk_imx8mp_audiomix_save_restore(dev, true);
@@ -367,6 +373,8 @@ static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
 	return 0;
 }
 
+#endif /* CONFIG_PM */
+
 static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops = {
 	SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
 			   clk_imx8mp_audiomix_runtime_resume, NULL)
-- 
2.40.1


