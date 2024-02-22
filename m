Return-Path: <linux-kernel+bounces-77029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C31860044
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AF51F26C03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E9157E74;
	Thu, 22 Feb 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MhbNbS9t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAE14900B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624868; cv=none; b=p5GC0WK9KplOKb4wiyrcdiU8sArO7h+SfasbAJWbFPtMQOqvwhJf5lHyQugtw4wsicfUllQJGD671DuaWsmYOrZ3A1xWKHhg3Y6ryClmw5m/e5k6zVcB3RS+oYV5XEw5XDqiAKhcC/8lEiyklDrPabcf+cRlc5jPijLsW2dO31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624868; c=relaxed/simple;
	bh=0wPvoAeCpIhFyI99ib8KnWgxwHnATtwrLoUCe3nCOHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfxHeaThJRVINgW1xkSAXrpy5HGBwWWk8TgO+eK44K6zgJqFYuoIPb9URCB+IAbqkmFkqo9HZaqN3VvSuMvh/6prslwwy0O2NREq4NoAg7CZvV1EjnZyD6Y3pxYRN8X/CLbTe50GRPm+0jEzOearzV5xf0pRcbwUisGkLjcU484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MhbNbS9t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MGtKnl005491;
	Thu, 22 Feb 2024 18:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2oOJN+KlMCgqc/dt8oiHJLksH27lD5aUFyLRA+1xMcM=; b=Mh
	bNbS9toyDwwh1UePpvj9aZMVub8XlWBYpTS8zOfxdXjBZOTDz19HJEnEzWuxP0cs
	CqSJpsjAC0t+O0U08rtEailohsYld/Qz+szedisQHqOZwEWS+dwmolUqwE4y3736
	tkchv4nzEHVuRzq9F5bnzy8JuMXoOIHU1yCcU+TPsb/Li5p6uNtKkxTNXZf7fQBt
	UbVvcrCXPm2wWy3fU+Y4iNZStQ857Usq5bz0wCcEb/9oZE4oQxIVJjon63cINzMp
	nxykiMZxL298sYY1S2E0W0RgvtoHXAgsrQKls+lVVD70x2Gox7Eh4lOy6KhBamOA
	rDXtA+WMEtqQoUgMMLKw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wea7crau6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:00:59 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI0xYx016064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:00:59 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:00:56 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 1/8] firmware_loader: Refactor request firmware lower level functions
Date: Thu, 22 Feb 2024 23:30:26 +0530
Message-ID: <20240222180033.23775-2-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OXfnhS_-R6U3g2-8LxHC28-ExGFin0qa
X-Proofpoint-GUID: OXfnhS_-R6U3g2-8LxHC28-ExGFin0qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Refactor low level api's to do code reuse.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/main.c | 88 +++++++++++------------------
 1 file changed, 34 insertions(+), 54 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index da8ca01d011c..645d658facae 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -739,7 +739,7 @@ int assign_fw(struct firmware *fw, struct device *device)
  * or a negative error code
  */
 static int
-_request_firmware_prepare(struct firmware **firmware_p, const char *name,
+__request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
 			  size_t offset, u32 opt_flags)
 {
@@ -851,9 +851,9 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
 
 /* called from request_firmware() and request_firmware_work_func() */
 static int
-_request_firmware(const struct firmware **firmware_p, const char *name,
-		  struct device *device, void *buf, size_t size,
-		  size_t offset, u32 opt_flags)
+__request_firmware(const struct firmware **firmware_p, const char *name,
+		   struct device *device, void *buf, size_t size,
+		   size_t offset, u32 opt_flags)
 {
 	struct firmware *fw = NULL;
 	struct cred *kern_cred = NULL;
@@ -869,7 +869,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
-	ret = _request_firmware_prepare(&fw, name, device, buf, size,
+	ret = __request_firmware_prepare(&fw, name, device, buf, size,
 					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
@@ -932,6 +932,19 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	return ret;
 }
 
+static int
+_request_firmware(const struct firmware **firmware_p, const char *name,
+		  struct device *device, void *buf, size_t size,
+		  size_t offset, u32 opt_flags)
+{
+	int ret;
+
+	/* Need to pin this module until return */
+	__module_get(THIS_MODULE);
+	ret = __request_firmware(firmware_p, name, device, NULL, 0, 0, opt_flags);
+	module_put(THIS_MODULE);
+	return ret;
+}
 /**
  * request_firmware() - send firmware request and wait for it
  * @firmware_p: pointer to firmware image
@@ -956,14 +969,8 @@ int
 request_firmware(const struct firmware **firmware_p, const char *name,
 		 struct device *device)
 {
-	int ret;
-
-	/* Need to pin this module until return */
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
-				FW_OPT_UEVENT);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware_p, name, device, NULL, 0, 0,
+				 FW_OPT_UEVENT);
 }
 EXPORT_SYMBOL(request_firmware);
 
@@ -983,14 +990,8 @@ EXPORT_SYMBOL(request_firmware);
 int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 			    struct device *device)
 {
-	int ret;
-
-	/* Need to pin this module until return */
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware, name, device, NULL, 0, 0,
+				 FW_OPT_UEVENT | FW_OPT_NO_WARN);
 }
 EXPORT_SYMBOL_GPL(firmware_request_nowarn);
 
@@ -1008,14 +1009,9 @@ EXPORT_SYMBOL_GPL(firmware_request_nowarn);
 int request_firmware_direct(const struct firmware **firmware_p,
 			    const char *name, struct device *device)
 {
-	int ret;
-
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
-				FW_OPT_UEVENT | FW_OPT_NO_WARN |
-				FW_OPT_NOFALLBACK_SYSFS);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware_p, name, device, NULL, 0, 0,
+				 FW_OPT_UEVENT | FW_OPT_NO_WARN |
+				 FW_OPT_NOFALLBACK_SYSFS);
 }
 EXPORT_SYMBOL_GPL(request_firmware_direct);
 
@@ -1032,14 +1028,8 @@ EXPORT_SYMBOL_GPL(request_firmware_direct);
 int firmware_request_platform(const struct firmware **firmware,
 			      const char *name, struct device *device)
 {
-	int ret;
-
-	/* Need to pin this module until return */
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
-				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware, name, device, NULL, 0, 0,
+				 FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
 }
 EXPORT_SYMBOL_GPL(firmware_request_platform);
 
@@ -1086,16 +1076,11 @@ int
 request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
 			  struct device *device, void *buf, size_t size)
 {
-	int ret;
-
 	if (fw_cache_is_setup(device, name))
 		return -EOPNOTSUPP;
 
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
-				FW_OPT_UEVENT | FW_OPT_NOCACHE);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware_p, name, device, buf, size, 0,
+				 FW_OPT_UEVENT | FW_OPT_NOCACHE);
 }
 EXPORT_SYMBOL(request_firmware_into_buf);
 
@@ -1116,17 +1101,12 @@ request_partial_firmware_into_buf(const struct firmware **firmware_p,
 				  const char *name, struct device *device,
 				  void *buf, size_t size, size_t offset)
 {
-	int ret;
-
 	if (fw_cache_is_setup(device, name))
 		return -EOPNOTSUPP;
 
-	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, buf, size, offset,
-				FW_OPT_UEVENT | FW_OPT_NOCACHE |
-				FW_OPT_PARTIAL);
-	module_put(THIS_MODULE);
-	return ret;
+	return _request_firmware(firmware_p, name, device, buf, size, offset,
+				 FW_OPT_UEVENT | FW_OPT_NOCACHE |
+				 FW_OPT_PARTIAL);
 }
 EXPORT_SYMBOL(request_partial_firmware_into_buf);
 
@@ -1162,8 +1142,8 @@ static void request_firmware_work_func(struct work_struct *work)
 
 	fw_work = container_of(work, struct firmware_work, work);
 
-	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
-			  fw_work->opt_flags);
+	__request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
+			   fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
-- 
2.43.0.254.ga26002b62827


