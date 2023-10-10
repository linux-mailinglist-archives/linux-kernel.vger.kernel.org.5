Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B67C43DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjJJW0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjJJW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:26:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD322D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:26:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ALHTYr030463;
        Tue, 10 Oct 2023 22:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=/RjSZVFNK9E06ffbGyJiSg+nkUelh8sulDb1cFG1V14=;
 b=N92p/1bj/XlarBSMxJLsRfDuQc/K7WLuFMKGq6wIe4h6OMSvWWZP1LuJP5i0c6dKDtFo
 esg3xu+5fdcDWs1fU/ZYPnK55RyR1e0t6kJxJTAgUQPQgJ2Q+tcB8GSTjHWZlrFDLuF5
 pFaquQD2nuZRAz1dt++NNbpZNcMgeDpY/zLvsXHf/g/+3Cyp8K3vVpKAS3t8PwTRy9HD
 asX9TuW/3E/h10FNaitdbJb7LvxwDY5okcMBd4Gq+cpNRBIOae5x4u3TAMMvB6m8pjbd
 B2e8MAQS62h/zradTKBmDEtnn897TAwg337kkKmW806/s6NDybdxE6cA8bqk3HnJhUQh Ww== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmw3j29bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 22:26:01 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39AMQ0ep024670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 22:26:00 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 15:26:00 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH 0/3] drm/ci: Add support for SM8250 Gitlab Runner
Date:   Tue, 10 Oct 2023 15:25:34 -0700
Message-ID: <20231010-rb5-runner-v1-0-aba1fcc6e3aa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7PJWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NL3aIkU92i0ry81CJdc/PUZGOjpBQzw1RzJaCGgqLUtMwKsGHRsbW
 1APCzI79cAAAA
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <robdclark@chromium.org>, <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976760; l=1258;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=7774+Yar/yF4QNmVtl4jiaQb4T4f9W0lL92diuZmKh8=;
 b=R/BWz8KXrPfJtJq095CJvGnQuc5TbPCYAF7hiht5u5RwOB4GMLCpDD5jv/Kyf6hhhq98huFd8
 pi6rp3wR5BNBcJ9rmeztCFtq6UolF2yOoGxzRy44jjU42FJifRQcivT
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: riyVsbYpsz8ta3U7mvt8SgBJtxrCl1p_
X-Proofpoint-ORIG-GUID: riyVsbYpsz8ta3U7mvt8SgBJtxrCl1p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_18,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=744 malwarescore=0 adultscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we've registered a Gitlab runner for a Qualcomm RB5 device that will be
hosted and maintained in Qualcomm labs.

This series will add a corresponding CI job for testing SM8250 devices and add the
skip/fails/flakes list. We were able to complete a successful run [1] with these
changes.

For now, we will keep the job as manual trigger only and drop that rule later
after we stabilize the tests.

[1] https://gitlab.freedesktop.org/drm/msm/-/jobs/50092719

---
Jessica Zhang (3):
      drm/ci: Add SM8250 job to CI
      drm/ci: enable CONFIG_INTERCONNECT_QCOM_SM8250 for arm64 config
      drm/ci: Add skips, fails and flakes for SM8250

 drivers/gpu/drm/ci/arm64.config                 |  1 +
 drivers/gpu/drm/ci/build.sh                     |  1 +
 drivers/gpu/drm/ci/test.yml                     | 15 +++++++++++++
 drivers/gpu/drm/ci/xfails/msm-sm8250-fails.txt  | 29 +++++++++++++++++++++++++
 drivers/gpu/drm/ci/xfails/msm-sm8250-flakes.txt |  3 +++
 drivers/gpu/drm/ci/xfails/msm-sm8250-skips.txt  |  8 +++++++
 6 files changed, 57 insertions(+)
---
base-commit: dcd88f8c63341ed11a8c5019408f62202cd9d1f2
change-id: 20230919-rb5-runner-77ec32bd61e7

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>

