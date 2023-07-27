Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E40765E70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjG0VxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjG0VxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:53:00 -0400
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9930E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494761; bh=kgGzA4dJRcbkTCFkI8WKFmpxvWUvUAQu2bilJrVHeBw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=lOgjzsYj3O24lMtX7deLh2NMJOaknYNi4dG3G7pJAlC2tpYVbUbR89MwUBNYxLyGo
         bxakESUnPGEprmHFo768pGBNc73smnhJsu8d+3BnRBYNKPFlS+AMbCoChH1tm2cy1P
         AceGT2ZVSXqewMUfTbfk27YcaknLlYejy/cclN4tShbUWy4K8CxTxBmZZzzu3nFJvQ
         kWaDcag4Rt7ChsHhulbej5p8VZOwMovG/ZDunwnaqJEezXdQ3Wp0r4trdEzd7K4I5o
         3DWMfSw1kn6ZIOc3aF3IWiF0PwvoGWNChpBCUsANuXph75mOXTONN+RHsOPeM2VzoA
         Tmjz3rDCz3q/g==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 5BC196180164;
        Thu, 27 Jul 2023 21:52:40 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alain Volmat <avolmat@me.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] drm/sti: add more possible GDP / VID planes entries in sti_plane
Date:   Thu, 27 Jul 2023 21:51:31 +0000
Message-Id: <20230727215141.53910-8-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wpH9KuNuuv4dX_dTTxW3ntkSM4BIxeZ0
X-Proofpoint-GUID: wpH9KuNuuv4dX_dTTxW3ntkSM4BIxeZ0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 mlxlogscore=771 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to address the STiH418, add more entries in sti_plane

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/gpu/drm/sti/sti_plane.c | 8 ++++++++
 drivers/gpu/drm/sti/sti_plane.h | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_plane.c b/drivers/gpu/drm/sti/sti_plane.c
index 29e669ccec5b..f8d65d608b64 100644
--- a/drivers/gpu/drm/sti/sti_plane.c
+++ b/drivers/gpu/drm/sti/sti_plane.c
@@ -28,8 +28,16 @@ const char *sti_plane_to_str(struct sti_plane *plane)
 		return "GDP2";
 	case STI_GDP_3:
 		return "GDP3";
+	case STI_GDP_4:
+		return "GDP4";
+	case STI_GDP_5:
+		return "GDP5";
 	case STI_HQVDP_0:
 		return "HQVDP0";
+	case STI_HQVDP_1:
+		return "HQVDP1";
+	case STI_HQVDP_2:
+		return "HQVDP2";
 	case STI_CURSOR:
 		return "CURSOR";
 	default:
diff --git a/drivers/gpu/drm/sti/sti_plane.h b/drivers/gpu/drm/sti/sti_plane.h
index 2c0156bede9c..51fc25ed0287 100644
--- a/drivers/gpu/drm/sti/sti_plane.h
+++ b/drivers/gpu/drm/sti/sti_plane.h
@@ -25,7 +25,9 @@ enum sti_plane_id_of_type {
 	STI_ID_0 = 0,
 	STI_ID_1 = 1,
 	STI_ID_2 = 2,
-	STI_ID_3 = 3
+	STI_ID_3 = 3,
+	STI_ID_4 = 4,
+	STI_ID_5 = 5,
 };
 
 enum sti_plane_desc {
@@ -33,7 +35,11 @@ enum sti_plane_desc {
 	STI_GDP_1       = STI_GDP | STI_ID_1,
 	STI_GDP_2       = STI_GDP | STI_ID_2,
 	STI_GDP_3       = STI_GDP | STI_ID_3,
+	STI_GDP_4       = STI_GDP | STI_ID_4,
+	STI_GDP_5       = STI_GDP | STI_ID_5,
 	STI_HQVDP_0     = STI_VDP | STI_ID_0,
+	STI_HQVDP_1     = STI_VDP | STI_ID_1,
+	STI_HQVDP_2     = STI_VDP | STI_ID_2,
 	STI_CURSOR      = STI_CUR,
 	STI_BACK        = STI_BCK
 };
-- 
2.34.1

