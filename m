Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28BB77204B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHGLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjHGLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:14:28 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC5272A;
        Mon,  7 Aug 2023 04:13:36 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3778Ni6s017922;
        Mon, 7 Aug 2023 07:12:50 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s9g932hbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 07:12:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 377BCmJK034974
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 07:12:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 7 Aug 2023 07:12:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 7 Aug 2023 07:12:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 7 Aug 2023 07:12:47 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.173])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 377BCZxV011933;
        Mon, 7 Aug 2023 07:12:42 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v4 2/3] iio: Add IIO_DELTA_VELOCITY channel type
Date:   Mon, 7 Aug 2023 14:12:26 +0300
Message-ID: <20230807111227.374371-3-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807111227.374371-1-ramona.bolboaca@analog.com>
References: <20230807111227.374371-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: jbWX-zQRbwissRExkso2offcfcjqLKh-
X-Proofpoint-GUID: jbWX-zQRbwissRExkso2offcfcjqLKh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_10,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2308070104
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delta velocity is defined as a piece-wise integration of
acceleration data. The delta velocity represents the linear velocity
change between two consecutive measurements and it
is measured in m / s (meters per second).

In order to track the total linear velocity change during a desired
period of time, simply sum-up the delta velocity samples acquired
during that time.

IIO currently does not offer a suitable channel type for this
type of measurements hence this patch adds it.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 15 +++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 32675fa7dc6f..08db0b7724f0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -293,6 +293,21 @@ Description:
 		angle samples acquired during that time.
 		Units after application of scale and offset are radians.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_deltavelocity_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_deltavelocity_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_deltavelocity_z_raw
+KernelVersion:	6.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The linear velocity change between two consecutive samples on x,
+		y or z (may be arbitrarily assigned but should match other such
+		assignments on device).
+		In order to compute the total linear velocity change during a
+		desired period of time, the application should sum-up the delta
+		velocity samples acquired during that time.
+		Units after application of scale and offset are meters per
+		second.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
 KernelVersion:	4.17
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2e2fd0be2504..ba694b049629 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -90,6 +90,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
 	[IIO_DELTA_ANGL] = "deltaangl",
+	[IIO_DELTA_VELOCITY] = "deltavelocity",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 55666a17d311..9a341bd07702 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -48,6 +48,7 @@ enum iio_chan_type {
 	IIO_PHASE,
 	IIO_MASSCONCENTRATION,
 	IIO_DELTA_ANGL,
+	IIO_DELTA_VELOCITY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 3505450060e6..7e6761612246 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PHASE] = "phase",
 	[IIO_MASSCONCENTRATION] = "massconcentration",
 	[IIO_DELTA_ANGL] = "deltaangl",
+	[IIO_DELTA_VELOCITY] = "deltavelocity",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -175,6 +176,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_PHASE:
 	case IIO_MASSCONCENTRATION:
 	case IIO_DELTA_ANGL:
+	case IIO_DELTA_VELOCITY:
 		break;
 	default:
 		return false;
-- 
2.34.1

