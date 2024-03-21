Return-Path: <linux-kernel+bounces-109796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC218855D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3506F2826EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26757300;
	Thu, 21 Mar 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Whq8R8Wr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18A56448;
	Thu, 21 Mar 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009984; cv=none; b=u14dGRx8DFaX6fkHPl/pB5uAaEvbh74TVhJBlqjmwJYZIz/dA0mUi/bwhJySSECHvQ3YfnTKJ4yj+wwn52HENSHI2GAqnuVe3RRz2gaaJQqXTDXPp6xNFp/GKiaoUf3suYXY2k4gDgt0kdsm8EzGQPTGLahXI75uN1819UJ3a48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009984; c=relaxed/simple;
	bh=9Osz6ynVLJ8wEF1vBBiviUpb5oLI5hbY7RWeC3AHbKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=planruw0QG7U2OOXJpQto4rp85KJr9PgYGb8bi+CH+fl6K2xiKJXn8AbSPn3CSni1D5YJSRNpJm4fvPBrS1OcZivppwIDJ9iFfnoeglp+we1mjqImmUQURTLr1CHq2VRIKOu/8YUG9Rdvla8yYN926vjd1kjxcsrFkJNADKC7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Whq8R8Wr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6RRwQ013869;
	Thu, 21 Mar 2024 08:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=977eVCuzV7/oAe69oiBK
	0VnWXz/hrZsu+2HflhEkNxE=; b=Whq8R8WrN/jnPJy7a5VMP23duNsP1+Lomv2U
	aw3CgU5LXWNJotl4H290kGcoCMWUD8MuDCWD/cF4tPxIrPw+VXLgAlp9/yEw82/g
	Y5Z3jLXTCyW3GxNfmLyRhAsYBtgOHzmc1oXEd+1eElu5c+yJGx/WvVGfSSmJZ1IG
	Aq0tz4xr/2rko68fr3C9VXRhalRggZIL0owBJpnF3KSTKCg4Kb1rezqgVoR9iU0t
	6N35/d2+nhA6pxeWEmAdN0QEnsRG6Y7Pj3hThKMusbbGkycboC0eEIaWhQ10neC8
	7/NU/gyOVv0uuqsuMw07KqvtvjjA4MhKtN6a7GPxbXRs3gWqWA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fmwg7px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L8WeLL009128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:32:40 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 01:32:35 -0700
From: Tao Zhang <quic_taozha@quicinc.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao
	<quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
Subject: [PATCH 2/4] coresight: Add support for multiple output ports on the funnel
Date: Thu, 21 Mar 2024 16:32:05 +0800
Message-ID: <1711009927-17873-3-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q-Yq7yFbVYGxXzflWqTW_q52PBs22JVu
X-Proofpoint-ORIG-GUID: q-Yq7yFbVYGxXzflWqTW_q52PBs22JVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210056

Funnel devices are now capable of supporting multiple-inputs and
multiple-outputs configuration with in built hardware filtering
for TPDM devices. Add software support to this function. Output
port is selected according to the source in the trace path.

The source of the input port on funnels will be marked in the
device tree.
e.g.
tpdm@xxxxxxx {
    ... ... ... ...
};

funnel_XXX: funnel@xxxxxxx {
    ... ... ... ...
    out-ports {
        ... ... ... ...
        port@x {
            ... ... ... ...
            label = "xxxxxxx.tpdm"; <-- To label the source
        };                           corresponding to the output
    ... ... ... ...                  connection "port@x". And this
    };                               is a hardware static connections.
    ... ... ... ...                  Here needs to refer to hardware
};                                   design.

Then driver will parse the source label marked in the device tree, and
save it to the coresight path. When the function needs to know the
source label, it could obtain it from coresight path parameter. Finally,
the output port knows which source it corresponds to, and it also knows
which input port it corresponds to.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 81 ++++++++++++++++---
 .../hwtracing/coresight/coresight-platform.c  |  5 ++
 include/linux/coresight.h                     |  2 +
 3 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 5dde597403b3..b1b5e6d9ec7a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -113,15 +113,63 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
+static struct coresight_device *coresight_get_source(struct list_head *path)
+{
+	struct coresight_device *csdev;
+
+	if (!path)
+		return NULL;
+
+	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
+	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
+		return NULL;
+
+	return csdev;
+}
+
+/**
+ * coresight_source_filter - checks whether the connection matches the source
+ * of path if connection is binded to specific source.
+ * @path:	The list of devices
+ * @conn:	The connection of one outport
+ *
+ * Return zero if the connection doesn't have a source binded or source of the
+ * path matches the source binds to connection.
+ */
+static int coresight_source_filter(struct list_head *path,
+			struct coresight_connection *conn)
+{
+	int ret = 0;
+	struct coresight_device *source = NULL;
+
+	if (conn->source_label == NULL)
+		return ret;
+
+	source = coresight_get_source(path);
+	if (source == NULL)
+		return ret;
+
+	if (strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
+			conn->source_label))
+		ret = 0;
+	else
+		ret = -1;
+
+	return ret;
+}
+
 static struct coresight_connection *
 coresight_find_out_connection(struct coresight_device *src_dev,
-			      struct coresight_device *dest_dev)
+			      struct coresight_device *dest_dev,
+			      struct list_head *path)
 {
 	int i;
 	struct coresight_connection *conn;
 
 	for (i = 0; i < src_dev->pdata->nr_outconns; i++) {
 		conn = src_dev->pdata->out_conns[i];
+		if (coresight_source_filter(path, conn))
+			continue;
 		if (conn->dest_dev == dest_dev)
 			return conn;
 	}
@@ -312,7 +360,8 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child,
+				 struct list_head *path)
 {
 	int ret = 0;
 	int link_subtype;
@@ -321,8 +370,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return -EINVAL;
 
-	inconn = coresight_find_out_connection(parent, csdev);
-	outconn = coresight_find_out_connection(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev, path);
+	outconn = coresight_find_out_connection(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && IS_ERR(inconn))
@@ -341,7 +390,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child,
+				   struct list_head *path)
 {
 	int i;
 	int link_subtype;
@@ -350,8 +400,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	if (!parent || !child)
 		return;
 
-	inconn = coresight_find_out_connection(parent, csdev);
-	outconn = coresight_find_out_connection(csdev, child);
+	inconn = coresight_find_out_connection(parent, csdev, path);
+	outconn = coresight_find_out_connection(csdev, child, path);
 	link_subtype = csdev->subtype.link_subtype;
 
 	if (link_ops(csdev)->disable) {
@@ -507,7 +557,7 @@ static void coresight_disable_path_from(struct list_head *path,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, path);
 			break;
 		default:
 			break;
@@ -588,7 +638,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, path);
 			if (ret)
 				goto err;
 			break;
@@ -802,7 +852,8 @@ static void coresight_drop_device(struct coresight_device *csdev)
  */
 static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
-				 struct list_head *path)
+				 struct list_head *path,
+				 struct coresight_device *source)
 {
 	int i, ret;
 	bool found = false;
@@ -814,7 +865,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 
 	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
 	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
-		if (_coresight_build_path(sink, sink, path) == 0) {
+		if (_coresight_build_path(sink, sink, path, source) == 0) {
 			found = true;
 			goto out;
 		}
@@ -825,8 +876,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
 		struct coresight_device *child_dev;
 
 		child_dev = csdev->pdata->out_conns[i]->dest_dev;
+		if (csdev->pdata->out_conns[i]->source_label &&
+			!strstr(kobject_get_path(&source->dev.kobj, GFP_KERNEL),
+				csdev->pdata->out_conns[i]->source_label))
+			continue;
 		if (child_dev &&
-		    _coresight_build_path(child_dev, sink, path) == 0) {
+		    _coresight_build_path(child_dev, sink, path, source) == 0) {
 			found = true;
 			break;
 		}
@@ -871,7 +926,7 @@ struct list_head *coresight_build_path(struct coresight_device *source,
 
 	INIT_LIST_HEAD(path);
 
-	rc = _coresight_build_path(source, sink, path);
+	rc = _coresight_build_path(source, sink, path, source);
 	if (rc) {
 		kfree(path);
 		return ERR_PTR(rc);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 9d550f5697fa..f553fb20966d 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -205,6 +205,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	struct fwnode_handle *rdev_fwnode;
 	struct coresight_connection conn = {};
 	struct coresight_connection *new_conn;
+	const char *label;
 
 	do {
 		/* Parse the local port details */
@@ -243,6 +244,10 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		conn.dest_fwnode = fwnode_handle_get(rdev_fwnode);
 		conn.dest_port = rendpoint.port;
 
+		conn.source_label = NULL;
+		if (!of_property_read_string(ep, "label", &label))
+			conn.source_label = label;
+
 		new_conn = coresight_add_out_conn(dev, pdata, &conn);
 		if (IS_ERR_VALUE(new_conn)) {
 			fwnode_handle_put(conn.dest_fwnode);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e8b6e388218c..a9c06ef9bbb2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -167,6 +167,7 @@ struct coresight_desc {
  * struct coresight_connection - representation of a single connection
  * @src_port:	a connection's output port number.
  * @dest_port:	destination's input port number @src_port is connected to.
+ * @source_label: source component's label.
  * @dest_fwnode: destination component's fwnode handle.
  * @dest_dev:	a @coresight_device representation of the component
 		connected to @src_port. NULL until the device is created
@@ -195,6 +196,7 @@ struct coresight_desc {
 struct coresight_connection {
 	int src_port;
 	int dest_port;
+	const char *source_label;
 	struct fwnode_handle *dest_fwnode;
 	struct coresight_device *dest_dev;
 	struct coresight_sysfs_link *link;
-- 
2.17.1


