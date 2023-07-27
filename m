Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D90765E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjG0VxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjG0Vw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:56 -0400
Received: from qs51p00im-qukt01072301.me.com (qs51p00im-qukt01072301.me.com [17.57.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BC2736
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494758; bh=YktwkpXyaGBIT8GsziofZlNMbhT2j8LgV+O0AEQuBJU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=QUK2MinujpZIVzM9jqSwTClsGYBGoJnXMLPmEYJTXNIYv1CKGNPvScMaW/CUV7u5H
         qnECqzPJpsQrb0VfPu+GNHedd8umWgLVfuTmslj8WGnXSQK4Zsxd3hH45klyQVJdj3
         GA5JaUUguVIKc9IN1qxSVLuTWsS6pnYugh/Ua9NnbR1g5fMxnFpL3ebagpLagdFRr6
         zCsGaMHBY2B/Q1JlruyDnk7E37+aJouBeSaYLebGveEHiFbeLPvRGXLZP3PL4e2Anx
         UEXBV+EjJLp+a5XAUoMJOj1plbqxEd9zKO4tr65rjfVUaBSxUuasSKHfzKiNk0h20h
         K8UY3cjgEBrmA==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072301.me.com (Postfix) with ESMTPSA id 8353F254016F;
        Thu, 27 Jul 2023 21:52:37 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alain Volmat <avolmat@me.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] drm/sti: remove VTG_SYNC_ID_HDMI from sti_vtg.h
Date:   Thu, 27 Jul 2023 21:51:30 +0000
Message-Id: <20230727215141.53910-7-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mB9QGKLmq2zplK26TClZnVryBqDr75Nm
X-Proofpoint-GUID: mB9QGKLmq2zplK26TClZnVryBqDr75Nm
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=923 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the synchro signal used for hdmi output and coming from the
VTG differs between the stih407 and stih418 platforms, we cannot
rely anymore on hardcoded value and involve drivers use compatible
to figure out the value.
The macro VTG_SYNC_ID_HDMI can thus be removed.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/gpu/drm/sti/sti_vtg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_vtg.h b/drivers/gpu/drm/sti/sti_vtg.h
index 46faf141b2d9..bd0437bd1c8d 100644
--- a/drivers/gpu/drm/sti/sti_vtg.h
+++ b/drivers/gpu/drm/sti/sti_vtg.h
@@ -10,7 +10,6 @@
 #define VTG_TOP_FIELD_EVENT     1
 #define VTG_BOTTOM_FIELD_EVENT  2
 
-#define VTG_SYNC_ID_HDMI        1
 #define VTG_SYNC_ID_HDDCS       2
 #define VTG_SYNC_ID_HDF         3
 #define VTG_SYNC_ID_DVO         4
-- 
2.34.1

