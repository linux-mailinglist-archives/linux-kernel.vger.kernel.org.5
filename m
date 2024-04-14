Return-Path: <linux-kernel+bounces-144356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F348A44EC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63B51B21037
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39864137743;
	Sun, 14 Apr 2024 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HopZP4nR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE713665A;
	Sun, 14 Apr 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123124; cv=none; b=CpcRnXYZDQqTFu4XSt23T1ooikriD02ggnW76PCk2laZwGefWQUsjFxsQ+QPigXLlP1Oya2wJPCWwWKSUA+/1az7dXv4milpSC7QQxpKBGq8a6pGkiP6rqUpsHcnQNWyxiNYNxXLNOgPY4TKdrYOuziR/OEmYgoLkQn1v1c0f/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123124; c=relaxed/simple;
	bh=ElqcwFFV6FolaKOKByryz3E6FEkM0S1+SLpNImWPQbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KRhLKnbTBKdK3J4OPItwGdDd674hXikFlYscuG6hECUit/MZkqoZpRjVY+2VmNXb8U/zriKDvFNR2zoYNLwrO29Y7ow83gL/DwuHHcWhtxNmcArYeOr2B6+Ya91SjZu7a4q3ZODqp4jIOXLKojEm3emm3rRJt001uUBBfOdXBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HopZP4nR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EJVeDo017100;
	Sun, 14 Apr 2024 19:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=RNjLHUKinxzK2tr7e9QDLuCIeMf+TtB+kX44HBB8p3M
	=; b=HopZP4nRVBX3q3kqhTZxMRBDUzaRfTNrMYB8p98WVO1SxognxVI0lbm5gFw
	oO0RlnUoh1mfKK3G0MlMbowGprJ2Rh84pyzEn7S1MltX3cWs+lec828Xj0/XeO/Q
	yoimCqc26Sfy92r0k9Zzr4Xz1Xjpvu7Rz7THb+xjzSIly49NbAZ0r3G3ql2LGfPN
	yHxTPS53Ua5ysURbnE9e8VRyu84XV9QxDIp01UBJkWV1USRFTILtyZfbmHNjrNya
	evUnUTpy63iWdKWaShzDwEs4jI+PpdlnVPAAP2lMb9C43KavB4eEmI6zRDYocyEG
	n+9gim8fx5+Dt3BCUsEkGlCaBHg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfj9at7pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EJVc7q023182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 19:31:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 14 Apr 2024 12:30:31 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Sun, 14 Apr 2024 12:30:26 -0700
Subject: [PATCH v2 3/4] firmware: psci: Read and use vendor reset types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240414-arm-psci-system_reset2-vendor-reboots-v2-3-da9a055a648f@quicinc.com>
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
In-Reply-To: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nYb4k0hKs4yY-3JulsNjt_AVykxN54J9
X-Proofpoint-GUID: nYb4k0hKs4yY-3JulsNjt_AVykxN54J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140142

SoC vendors have different types of resets and are controlled through
various registers. For instance, Qualcomm chipsets can reboot to a
"download mode" that allows a RAM dump to be collected. Another example
is they also support writing a cookie that can be read by bootloader
during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
vendor reset types to be implemented without requiring drivers for every
register/cookie.

Add support in PSCI to statically map reboot mode commands from
userspace to a vendor reset and cookie value using the device tree.

Reboot mode framework is close but doesn't quite fit with the
design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
be solved but doesn't seem reasonable in sum:
 1. reboot mode registers against the reboot_notifier_list, which is too
    early to call SYSTEM_RESET2. PSCI would need to remember the reset
    type from the reboot-mode framework callback and use it
    psci_sys_reset.
 2. reboot mode assumes only one cookie/parameter is described in the
    device tree. SYSTEM_RESET2 uses 2: one for the type and one for
    cookie.
 3. psci cpuidle driver already registers a driver against the
    arm,psci-1.0 compatible. Refactoring would be needed to have both a
    cpuidle and reboot-mode driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/psci/psci.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..e0a764743a20 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -29,6 +29,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#define REBOOT_PREFIX "mode-"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -79,6 +81,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+struct psci_reset_param {
+	const char *mode;
+	u32 reset_type;
+	u32 cookie;
+};
+static struct psci_reset_param *psci_reset_params;
+static size_t num_psci_reset_params;
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static void psci_vendor_sys_reset2(unsigned long action, void *data)
+{
+	const char *cmd = data;
+	unsigned long ret;
+	size_t i;
+
+	for (i = 0; i < num_psci_reset_params; i++) {
+		if (!strcmp(psci_reset_params[i].mode, cmd)) {
+			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+					     psci_reset_params[i].reset_type,
+					     psci_reset_params[i].cookie, 0);
+			pr_err("failed to perform reset \"%s\": %ld\n",
+				cmd, (long)ret);
+		}
+	}
+}
+
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
+	if (data && num_psci_reset_params)
+		psci_vendor_sys_reset2(action, data);
+
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
@@ -748,6 +778,66 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+static int __init psci_init_system_reset2_modes(void)
+{
+	const size_t len = strlen(REBOOT_PREFIX);
+	struct psci_reset_param *param;
+	struct device_node *np;
+	struct property *prop;
+	size_t count = 0;
+	u32 magic[2];
+	int num;
+
+	if (!psci_system_reset2_supported)
+		return 0;
+
+	np = of_find_matching_node(NULL, psci_of_match);
+	if (!np)
+		return 0;
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+		num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
+		if (num != 1 && num != 2)
+			continue;
+
+		count++;
+	}
+
+	param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
+	if (!psci_reset_params) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+
+		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (!param->mode)
+			continue;
+
+		num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
+		if (num < 0) {
+			pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
+			kfree_const(param->mode);
+			continue;
+		}
+
+		/* Force reset type to be in vendor space */
+		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
+		param->cookie = num == 2 ? magic[1] : 0;
+		param++;
+		num_psci_reset_params++;
+	}
+
+	of_node_put(np);
+	return 0;
+}
+arch_initcall(psci_init_system_reset2_modes);
+
 int __init psci_dt_init(void)
 {
 	struct device_node *np;

-- 
2.34.1


