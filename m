Return-Path: <linux-kernel+bounces-66389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0F855C05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE352823FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99913AC6;
	Thu, 15 Feb 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zsaxm202"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE435134CA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984559; cv=none; b=qlahPoB3PAswc5wm7Kn/5g1SpBq1NxhQM9FGiBkx972H+cySwm8xirCTMMB5BwUgUjZ2Weqh9Nr8pUOzyp3s4oemf42PhnzEPSN/3s9rmoxzjsSUKCbkfqF5cmAXmFIKLdlAgm8EoAyFwRz1oN7QEWn+AfZaMbnIoR+LLAAoWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984559; c=relaxed/simple;
	bh=os2ejC1/FFEVbTRi0dZfoX5I51ndLrpxCGwFODLHC6E=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=mP+R/pWgJ4oRpk94zELvKw+icjMX8rgFDWl5bdHHViEU59V+6ik9gsh1QT4gVpLSQR8FZ6PgOQ7pkxr2vBvbQDxqC8qbN51JrS23AFeyzVWkWWhGIU7bTbx5CcHLIUglJQIdl3Yx8Fe/y+Amgs5/JKsabTJvidOqh51Huw4BP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zsaxm202; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240215080908epoutp021514024e7c318163cbc102e5613f7119~z_uXbtqjb1975319753epoutp02Z
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:09:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240215080908epoutp021514024e7c318163cbc102e5613f7119~z_uXbtqjb1975319753epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707984548;
	bh=fZsm0JDutQFfHlHVHia33p4T5epNvICN0al9bA90iJw=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=Zsaxm2029O6D9A7RwUe5nKIQbqsR5V6HoFXl/dllpFfbV4LGe1JgC302LZRyQgUYG
	 vyQtDmDaSwCeQWaGHEs3c6vLt8NL9e3LAwzU85wLwZP9qTzKbCcSLCLZkCjGib+2L8
	 M+TxC0On4JjZTYZ57BzOhd1zljPnKpC23Vo7qn7U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240215080908epcas2p41931e9cc6b162b429520119c7696c88f~z_uWur2dU2920429204epcas2p4a;
	Thu, 15 Feb 2024 08:09:08 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tb74g3jqYz4x9Pt; Thu, 15 Feb
	2024 08:09:07 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-59-65cdc6a35f47
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.04.18994.3A6CDC56; Thu, 15 Feb 2024 17:09:07 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2] perf: CXL: fix CPMU filter value mask length
Reply-To: hj96.nam@samsung.com
Sender: Hojin Nam <hj96.nam@samsung.com>
From: Hojin Nam <hj96.nam@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: Wonjae Lee <wj28.lee@samsung.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>
Date: Thu, 15 Feb 2024 17:09:06 +0900
X-CMS-MailID: 20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhe7iY2dTDbbNk7BYtfAam8XRPRwW
	mx5fY7U4P+sUi8XlXXPYLJZev8hk0XLH1GLj/XdsDhwea+atYfRoOfKW1WPTqk42j81L6j36
	tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
	QNctMwfoGiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJ
	laGBgZEpUGFCdsaB5TfYC7YJVFy+fpWpgXEpTxcjJ4eEgIlE1/sWti5GLg4hgT2MEhOOdwE5
	HBy8AoISf3cIg5jCAg4SvQ9UQMqFBOQk9pw4zwJiCwtoSKz9fpgdxGYTUJNYeP8SM4gtIlAl
	cf39UyaQkcwC25gk/j5cygixi1diRvtTFghbWmL78q1QcQ2JH8t6mSFsUYmbq9+yw9jvj82H
	qhGRaL13FqpGUOLBz91QcSmJT3c3QcWLJWbvXwYVL5BY8WMR1C59icbr79lAbF4BX4mOJU1g
	NouAqsTzc5dYIWpcJE68ngEWZxaQl9j+dg4zyO/MApoS63fpg5gSAsoSR26xQFTwSXQc/ssO
	89WOeU+YIGwlif0drVDXSEjcOXEZ6hoPiYknbjFBgjBQYv2xq6wTGBVmIcJ5FpK9sxD2LmBk
	XsUolVpQnJuemmxUYKibl1oOj97k/NxNjOCkqeW7g/H1+r96hxiZOBgPMUpwMCuJ8E7qPZMq
	xJuSWFmVWpQfX1Sak1p8iNEU6OuJzFKiyfnAtJ1XEm9oYmlgYmZmaG5kamCuJM57r3VuipBA
	emJJanZqakFqEUwfEwenVANT/tQIT0XFt1oLJk+3YZnxyiI8Ob3zx6yC3FeHFhbcjuSb/+Zb
	6tynHycecbaYnPH604/XL86ZnpzmcCpSapFe25wPNcqt2yepvZi8ftG5lREdomyO5ze2Scr/
	Ce6cIGHJ8YL7SPdFVYtZ3Ls5Zs5+Hf39/fRopinHwziZq/5stV39j5X91xEPwalX9PyvvepV
	fqt1rbxqubbR/R2XPh034r8n384Q5sHRFfXrsEG57IJMRR3ldVuUbW+2hd8rOHDzzYVFB9k7
	1mRukl24NvPMlrLHK5bJ7rJNyu/256qzsNtdeTJv9/mKjlPl/74q/b3fa/TscokC17xJqtb9
	fwuOe83zXrKhiz/0qNC83McpgUosxRmJhlrMRcWJADt1t34jBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958
References: <CGME20240215080906epcms2p2c49c6b9bfe271e1d089ad35ab527b958@epcms2p2>

CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
However, it is used as 2B length in code and comments.

Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---

Hi Jonathan,
as you said, I didn't actually hit this. I just found it by simply
comparing the code to the CXL Spec. I removed Fixes tag and 
repaired broken sign off, Thank you!

Changes since v1:
- Remove Fixes tag (Jonathan)
- Repair broken sign off (Jonathan)

 drivers/perf/cxl_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..ca5e92f28b4a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -59,7 +59,7 @@
 #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK     GENMASK_ULL(63, 59)

 #define CXL_PMU_FILTER_CFG_REG(n, f)   (0x400 + 4 * ((f) + (n) * 8))
-#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(15, 0)
+#define   CXL_PMU_FILTER_CFG_VALUE_MSK                 GENMASK(31, 0)

 #define CXL_PMU_COUNTER_REG(n)         (0xc00 + 8 * (n))

@@ -314,9 +314,9 @@ static bool cxl_pmu_config1_get_edge(struct perf_event *event)
 }

 /*
- * CPMU specification allows for 8 filters, each with a 16 bit value...
- * So we need to find 8x16bits to store it in.
- * As the value used for disable is 0xffff, a separate enable switch
+ * CPMU specification allows for 8 filters, each with a 32 bit value...
+ * So we need to find 8x32bits to store it in.
+ * As the value used for disable is 0xffff_ffff, a separate enable switch
  * is needed.
  */

@@ -642,7 +642,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
                if (cxl_pmu_config1_hdm_filter_en(event))
                        cfg = cxl_pmu_config2_get_hdm_decoder(event);
                else
-                       cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
+                       cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
                writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
        }

--
2.34.1

