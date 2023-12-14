Return-Path: <linux-kernel+bounces-245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F83813E37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED44A1F21722
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE66C6EB;
	Thu, 14 Dec 2023 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vJm4M7Cb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51F6C6FD;
	Thu, 14 Dec 2023 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhrTNp/COnrtt+KFPzZhUeVj+uuRwyotFa1wvdvpNpv4YUnDvxmcObflQah+FI9cl2kzCPmbo1NYNOAG4/cpXm4/v5zlEm3sGzyp9saLIwPG0fxd2Cs2O+CTOzKdvlMDSwnExaNYuHzBaj1FPWVvacxVajFN+y+63EojFTakDZIK1MTYp915R++fy0AFhb8CHypP14zCtQBIRzmtbWDA7MMyDNPT9j8w0XvBBmkWTaHgDeqHX5Dutqm4VwpSU3sYeakkf8F3kx3dVkHsnDmni6OFXko/imzNbzJYbcJLhqUlSVam5K9m8R7E5/fSd/J7ecJxr0ItnQbOwyUpU71GDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbMumdGpURWRTm00JP0YMQNHkY8Vzc/efMUrjyF/28o=;
 b=XfcIpY7VWeTR80MfgEZhey3H1CZzdhOzJgxiBFyHdU3j9rfcv0G4tdMH9/refQh57mA5nExol86vgxThlFk/Zc0n4VdfduFFf6WqIrTtCW3T8zXNjyzzZzzzc8AFQsnG8MvBngXULszubUiNrlYngel92/SCtW13wQPfwhqvjGCFJLFc4AjsFLHzvOCn10Jo/ULnTSPIMCsKLUZy98470G/aG5tXL6Sb5b5uuvRpTVj1ALhOvRQ+1PSKqKwMT7ebTaVwaBcjO68YecMoSdM2Sq/In0sg7MZxDQMH/1rzuPWz/mLoTFDCqJWsb/rf6fQQWKeT66cO1Sjx/iD+W7D2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbMumdGpURWRTm00JP0YMQNHkY8Vzc/efMUrjyF/28o=;
 b=vJm4M7CbCen3xTnt/ltk/6YP62p4KYy8R3YD5u+kUPrbNCzi18/3CrjNNW2Y1vkASHMAnMDkvxms8YMbALzJaNZFv23wTVJtiwnDtugZG3+kmjoRN1fwQ3laobXUz/HCQOhFALHkMQwWIC/gxMw1cpd2UceAnp9uHlGCGCGM74g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB8113.prod.exchangelabs.com (2603:10b6:806:35a::6) by
 SN7PR01MB8133.prod.exchangelabs.com (2603:10b6:806:353::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 23:23:40 +0000
Received: from SN7PR01MB8113.prod.exchangelabs.com
 ([fe80::7ba0:ac52:84a0:caa0]) by SN7PR01MB8113.prod.exchangelabs.com
 ([fe80::7ba0:ac52:84a0:caa0%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 23:23:40 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	pabeni@redhat.com,
	linmiaohe@huawei.com,
	rostedt@goodmis.org,
	leoyang.li@nxp.com,
	luoshengwei@huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 1/1] RAS: Report ARM processor information to userspace
Date: Thu, 14 Dec 2023 15:23:30 -0800
Message-ID: <20231214232330.306526-2-danielf@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214232330.306526-1-danielf@os.amperecomputing.com>
References: <20231214232330.306526-1-danielf@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:610:33::21) To SN7PR01MB8113.prod.exchangelabs.com
 (2603:10b6:806:35a::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB8113:EE_|SN7PR01MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ade02e-77d2-4224-0dc1-08dbfcfbb49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ebP2rLRwv/RvGr3MkSiX7fLHm6aaqLzGMruvRmm6RaCKNDqLtpxaHBgNOHrlWB/eKT10kaYRkR1VeAYZzzk+Bq3a14tx++ujhluYHmJMTi5nhkM5jsSWPGSwnQ7BDm8DJViNvFpir5CRcrCJzp3MrDFo5OMbAhCbi9YiiAfykrr140BLw2hRd77Wp/rQayVGGc6w2tEoUuiztdEUzfC76b1kk/V9WUXSghDbDARccfgTgB4PctrLRknXKxu64ik33J6/xhf5pHJrP99Cw4lDMbTNF3/OuFcH/Oyr9JDYIbT1gmB4blLCrexWO7jMiTqRotIeJjEFylbU9JklFWLPrGgvNGx657tMEVvnfNTbwhNlqNJzep5Sw7xw2vYRgpNxPAXRGbavSVIP83qJcJptC2ARS09sb4fWS17WtVeHZyLugrAnm+3ljMBSh6aJd3m3pz9Nrhc7EtuILf8ISVpzskbCEfHPKGMPMPiy9QFl1KSl1gDrL8sKPVRdOfPgpQQTv5j9ZchN6uHtDhNURa0dkGGH/7L/IrZwVwc8bB9u2sWPs10peeEMn5enAkr+E7IvgYFHYtSBTLGsjvMwJQMBiQwKEBnXVht3k5phgFL2Z4lt6bB7MdXTOdTcPTyJaZ8ceagY+vtjdYwatSLUavmng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB8113.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39850400004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(38100700002)(8936002)(8676002)(7416002)(2906002)(5660300002)(83380400001)(316002)(52116002)(26005)(2616005)(1076003)(4326008)(66556008)(66476007)(66946007)(921008)(41300700001)(38350700005)(6666004)(478600001)(6512007)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jczg2vfF6hJFJGp2FzWE7r1viAGXMZDyVE5w5PS1KPaoypIeoiD6HkZ4DhSu?=
 =?us-ascii?Q?WEH4oJfSeyVUxnnlD0UOUC3q7PigsFgjvc4fdz2KCZ6oGtxg9DFklxriZhxI?=
 =?us-ascii?Q?ZZjmYnbfyqcRs1fgtJRvJ/sxM9cV990Rztqijs26sdJPWn96MorxYAQMe3AG?=
 =?us-ascii?Q?W6XjllCv+2SQUOOi8B1uRUdWN5OikKAPvGq3HTVH6pQk4EmDr2BVSEm9UvhY?=
 =?us-ascii?Q?vVttR8R/NL7haY48EKE1QGVnLTjSlg58tULad+WDYT7+IwYnDxGB5T5HyR9n?=
 =?us-ascii?Q?v/ShTuyzKLf5GjYFzRPGFt9Sv9KYvFUatAge7Cu+iHA2YKlZsEbD1ar0+cjj?=
 =?us-ascii?Q?QRlWsi1G+kEciWPrC/KSLyLkADJhbz3NF0RAii9Xyx8uAkQxlm7egSih/12U?=
 =?us-ascii?Q?ozVQ/+hWkIaKOFXMKvFCwjg58oWMIkWk8S5AW8b9o81dIxtLtR4Zn5Waqxc/?=
 =?us-ascii?Q?PytC903LWM0lFkaGYNBaGTqi+lfflyDS5/okOknr+zDQzLvvMVczZqZF4BCb?=
 =?us-ascii?Q?mopQT5kmZAh46/GSgfa4RudhGX3MeErkA5mS6jxu23oP0jcCSf7T6ngAOFsi?=
 =?us-ascii?Q?erhQWIUeKNaUVzI5WNz2Wia7FykWYEXb0f062/twpK36D+MBbrXI4MVhsi6l?=
 =?us-ascii?Q?OtbuXl7TVvOnY162I1+0LPqx7qBKILRSpMldFtR4X5/EzCUD23bW/lUnBB7W?=
 =?us-ascii?Q?lWFeNBm10Zeauv71lXllpOv/W6fBPK5arGBO82z9P22vYCiMJwTWnUlh55w+?=
 =?us-ascii?Q?y/eVoyrw4FTgUNgo0KYVnqG9ozQyoNyA/ZFmDK85Ccg+H5MqP87V150zBfJl?=
 =?us-ascii?Q?mcmKXmebUh3wWM9oWXD3yq7u4BK9kTrtT7hhoMg6/CZ7fQX79EOjm0kzNlF0?=
 =?us-ascii?Q?ARA/QuxrSyWmz9n0ZZOzxHZ3cF8Qk2ASx6tpQ60Pg3EFhxSTEeFZU8UT+BWD?=
 =?us-ascii?Q?eAONWMpSY+t6Jc/Lwgy7GAFe0v/67QGiNJhNwDcCHYZuLuXLRMACjca3I8A8?=
 =?us-ascii?Q?MXx8/XLq+4/IXsslzdGnfc8bmmKb9QujSblcwWUyP6WksOYFePYrTkoRebMr?=
 =?us-ascii?Q?A0q6q2M0cpu3rXhZ0nVGqFrzL2XrMbUY4pXmzt+s/jx/99w7klbo08DU7s1u?=
 =?us-ascii?Q?/AE0MbLxTcWhHbkbGUgJbthRdDyu//RcQoMecyDXsHojMooiOm3KJXKRZU1v?=
 =?us-ascii?Q?wY+f12BDutxspb9FH13nbTQ5CY9Ej/n8h7pNMDZQPKQ1rpBfkaOKvKlsFnXk?=
 =?us-ascii?Q?kYxDiRjYJg2y3GvHNsHcLdCghugUxYOcJKQsSE8cU3RUteRhJg6fU46TQgS+?=
 =?us-ascii?Q?+ps1LkQJG8dHuZWdTnNWw6NRgdfVsDzmk89PF/XUs+9lOBDey3Q4N4kTQmfE?=
 =?us-ascii?Q?2bxujXsis9uJOo00gt4Y7LKsIPl27xO96N+AHDRmwhcqxHeXR5sxUl9j53VJ?=
 =?us-ascii?Q?N59Mf2h9Y7Ucoc4fSwi1MHmssqYx8Rq89I6aiTuUCP2F26uw4zsRgZh3JGmm?=
 =?us-ascii?Q?XLXsERuAVcX2eYUIn6TAylfKJEpZRxt6aml/yzyC49GQ/xFhsaSCvseVkjOC?=
 =?us-ascii?Q?xN3g6/l/kf5uxNbC7L3V9Gaj0I99GNW4EVIQ1kyEGNdD+84i1RjehNfwD8RD?=
 =?us-ascii?Q?kPkita1FvOnJqpUsE54Nbis=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ade02e-77d2-4224-0dc1-08dbfcfbb49a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB8113.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 23:23:40.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSZd8BcYWuYomu7t9mnR0WvhZns0vY8Hjk2k27LMRCVh9a51fMYEUhr1T1Yx0yV36SNMIQGNw3/apRydhk6P/NbDBRTiUo0bXCNx6JemXY01QmpmvnR1iQ570I4ibtLi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8133

From: Shengwei Luo <luoshengwei@huawei.com>

The original arm_event trace code only traces out ARM processor error
information data. It's not enough for user to take appropriate action.

According to UEFI_2_9 specification chapter N2.4.4, the ARM processor
error section includes several ARM processor error information, several
ARM processor context information and several vendor specific error
information structures. In addition to these info, there are error
severity and cpu logical index about the event. Report all of these
information to userspace via perf i/f. So that the user can do cpu core
isolation according to error severity and other info.

Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
---
 drivers/acpi/apei/ghes.c |  3 +--
 drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 15 +++++++++++--
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da..98c2bfffbabb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -504,9 +504,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea8dd9d..2a7f424d59b9 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -21,9 +21,51 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	u32 pei_len;
+	u32 ctx_len = 0;
+	s32 vsei_len;
+	u8 *pei_err;
+	u8 *ctx_err;
+	u8 *ven_err_data;
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	int n, sz;
+	int cpu;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
+						pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG
+			"section length: %d\n", err->section_length);
+		pr_warn(FW_BUG
+			"section length is too small\n");
+		pr_warn(FW_BUG
+			"firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	/* when return value is invalid, set cpu index to -1 */
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
 static int __init ras_init(void)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 1f4048bf2674..4529775374d0 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,7 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -32,7 +32,18 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM specific SMP header which provides a function mapping mpidr to
+ * cpu logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..0dac67d1cad4 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,24 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc, const u8 *pei_err,
+			const u32 pei_len,
+			const u8 *ctx_err,
+			const u32 ctx_len,
+			const u8 *oem,
+			const u32 oem_len,
+			u8 sev,
+			int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +193,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, buf1, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, buf2, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +220,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(buf1), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(buf2), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(buf1), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(buf2), __entry->oem_len))
 );
 
 /*
-- 
2.43.0


