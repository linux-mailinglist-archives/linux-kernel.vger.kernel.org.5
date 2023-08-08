Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A47746FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjHHTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjHHTH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:07:57 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D031C0A;
        Tue,  8 Aug 2023 09:30:00 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3785lw1Y024740;
        Tue, 8 Aug 2023 03:51:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s9kb1yvwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 03:51:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3787pbs8028447
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 03:51:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Aug 2023 03:51:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 8 Aug 2023 03:51:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 8 Aug 2023 03:51:36 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.173])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3787pN8x011820;
        Tue, 8 Aug 2023 03:51:29 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v5 2/3] iio: Add IIO_DELTA_VELOCITY channel type
Date:   Tue, 8 Aug 2023 10:50:58 +0300
Message-ID: <20230808075059.645525-3-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808075059.645525-1-ramona.bolboaca@analog.com>
References: <20230808075059.645525-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gK0YNr61qDXQ4cGrP3A75IUDw1kv_s1s
X-Proofpoint-ORIG-GUID: gK0YNr61qDXQ4cGrP3A75IUDw1kv_s1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308080070
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-bus-iio | 23 +++++++++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 363dd4b09930..59968b745518 100644
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
@@ -476,6 +491,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_deltaangl_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_deltavelocity_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_x_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_y_scale
@@ -1350,6 +1366,9 @@ What:		/sys/.../iio:deviceX/bufferY/in_accel_z_en
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_x_en
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_y_en
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_z_en
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_x_en
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_y_en
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_z_en
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_en
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_en
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_en
@@ -1381,6 +1400,7 @@ Description:
 
 What:		/sys/.../iio:deviceX/bufferY/in_accel_type
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_type
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_type
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_type
 What:		/sys/.../iio:deviceX/bufferY/in_magn_type
 What:		/sys/.../iio:deviceX/bufferY/in_incli_type
@@ -1438,6 +1458,9 @@ What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_x_index
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_y_index
 What:		/sys/.../iio:deviceX/bufferY/in_deltaangl_z_index
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_x_index
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_y_index
+What:		/sys/.../iio:deviceX/bufferY/in_deltavelocity_z_index
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_x_index
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_y_index
 What:		/sys/.../iio:deviceX/bufferY/in_anglvel_z_index
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

