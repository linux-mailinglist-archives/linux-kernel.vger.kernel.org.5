Return-Path: <linux-kernel+bounces-104304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBEC87CBED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE411C21386
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B81B7EB;
	Fri, 15 Mar 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mY9ebyGm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3445199DC;
	Fri, 15 Mar 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501091; cv=none; b=c+a2nXPHvS1Kx+CMi1JgTQFYC0q8m/nFl/SRX8PyCItj8c2fWtFTIVMdsgLHY9NKuL1A6Hfr0WSs2lb89Oj4vyL2a7DFpCZUrUssIOJp9ca7MhbNNJU0sHV2tCkzdd6fFCXrHcgBS/ldnMMhxmfzqywJD6uBwoY2YpnkCKMe8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501091; c=relaxed/simple;
	bh=9qWrgESKWtucjl3ZyF0JeuKv/RBi6hE0zDMQkWKtl2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGH+idDcjz0qydakn1NCdvTKKHARJbfqZbnnlAsK+7OADDoFbBRmgCBUh2YBNP0ccILv3QIvyDxp6oBqRqYmcuxNC1V8goiiN2f0Mp0o6DBk3HAO9alOYdQs7nEFgvhvciEtDnR8PHR3PqC8NIuWn9NEvlGEEA6mko+nDCAKhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mY9ebyGm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FArqeM004545;
	Fri, 15 Mar 2024 11:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=m8Kpm8VxTdReH4Vw2Dr3MgtQdxcXGedujqAEYdMsfUQ=; b=mY
	9ebyGmaJS7fgg4iAAySNrC3kxvZKyeCBGERoQw6p0CtHcB90yHh/RFBeZYqMteK+
	EfLHZK+oTwMYWPbKRbnB2L/gqrnDZPuV1RlxqnH9bt+rAQtprVzd9sgMNGbZpUrF
	Q8J3mwXPMCikQ5NUE7HIdokpi6d2afqjzL3awt+CUTZd6ZzsuUcjdaKoS0xER3Cq
	5F1ulRuFNx1WECHaZxdazTeAnj2rJd9onYY2LOkvo6SVrni+Ci5ya3nQW83Cwt96
	MOoUdiTMpM6Pmp13iqmqtnIqLqZqz3WbeQFTRte4twQ2Gpt4zC4ZxHlPBIUvvqHe
	x1Z252QhbOKPuxvp9cPw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva0es287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42FBBItJ008959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 11:11:18 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Mar 2024 04:11:10 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>, Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V5 1/5] PM: domains: Allow devices attached to genpd to be managed by HW
Date: Fri, 15 Mar 2024 16:40:42 +0530
Message-ID: <20240315111046.22136-2-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315111046.22136-1-quic_jkona@quicinc.com>
References: <20240315111046.22136-1-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3D2EZw9aOuTefMQCDJLcyneL9O6dBtWr
X-Proofpoint-ORIG-GUID: 3D2EZw9aOuTefMQCDJLcyneL9O6dBtWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403150091

From: Ulf Hansson <ulf.hansson@linaro.org>

Some power-domains may be capable of relying on the HW to control the power
for a device that's hooked up to it. Typically, for these kinds of
configurations the consumer driver should be able to change the behavior of
power domain at runtime, control the power domain in SW mode for certain
configurations and handover the control to HW mode for other usecases.

To allow a consumer driver to change the behaviour of the PM domain for its
device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
which the genpd provider should implement if it can support switching
between HW controlled mode and SW controlled mode. Similarly, add the
dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
its corresponding optional genpd callback, ->get_hwmode_dev(), which the
genpd provider can also implement to synchronize the initial HW mode
state in genpd_add_device() by reading back the mode from the hardware.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pmdomain/core.c   | 64 +++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h | 17 +++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c..70d8634dd9e8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -578,6 +578,68 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
 
+/**
+ * dev_pm_genpd_set_hwmode() - Set the HW mode for the device and its PM domain.
+ *
+ * @dev: Device for which the HW-mode should be changed.
+ * @enable: Value to set or unset the HW-mode.
+ *
+ * Some PM domains can rely on HW signals to control the power for a device. To
+ * allow a consumer driver to switch the behaviour for its device in runtime,
+ * which may be beneficial from a latency or energy point of view, this function
+ * may be called.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	struct generic_pm_domain *genpd;
+	int ret = 0;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (!genpd->set_hwmode_dev)
+		return -EOPNOTSUPP;
+
+	genpd_lock(genpd);
+
+	if (dev_gpd_data(dev)->hw_mode == enable)
+		goto out;
+
+	ret = genpd->set_hwmode_dev(genpd, dev, enable);
+	if (!ret)
+		dev_gpd_data(dev)->hw_mode = enable;
+
+out:
+	genpd_unlock(genpd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_hwmode);
+
+/**
+ * dev_pm_genpd_get_hwmode() - Get the HW mode setting for the device.
+ *
+ * @dev: Device for which the current HW-mode setting should be fetched.
+ *
+ * This helper function allows consumer drivers to fetch the current HW mode
+ * setting of its the device.
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Return: Returns the HW mode setting of device from SW cached hw_mode.
+ */
+bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return dev_gpd_data(dev)->hw_mode;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -1676,6 +1738,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
 
+	gpd_data->hw_mode = genpd->get_hwmode_dev ? genpd->get_hwmode_dev(genpd, dev) : false;
+
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35f..797b3987b37b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -175,6 +175,10 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
+	int (*set_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev, bool enable);
+	bool (*get_hwmode_dev)(struct generic_pm_domain *domain,
+			      struct device *dev);
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -237,6 +241,7 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
+	bool hw_mode;
 	void *data;
 };
 
@@ -266,6 +271,8 @@ int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
 ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 void dev_pm_genpd_synced_poweroff(struct device *dev);
+int dev_pm_genpd_set_hwmode(struct device *dev, bool enable);
+bool dev_pm_genpd_get_hwmode(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -334,6 +341,16 @@ static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
 static inline void dev_pm_genpd_synced_poweroff(struct device *dev)
 { }
 
+static inline int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool dev_pm_genpd_get_hwmode(struct device *dev)
+{
+	return false;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.43.0


