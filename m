Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479FA793F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjIFOhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjIFOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:37:52 -0400
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63927172C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=claudiocambra.com;
        s=sig1; t=1694010494;
        bh=AaRc3mMsr8uRyqgPIujCCQ/LoqhOzGj7mkw/qGVUYvo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=qot7WPymvuwFj+OlrVZyZC3DoY/FRwqfQ+3WxcbIL4cUTbkakJbzTcB/bp1eXozZg
         X9pntqH13fcOurFqD4hv0+jpnt/ZBK9pbAferowtlVkAe+kpLqcm9dkavK/pFvC6N0
         lnOwdoGh5OgvlD8NPqK3W7HX3uwHg4JDktU5TswWJJgzbcobGzf8efvVd+eQh8cxHZ
         R1AQZTTvW5rUoeF8zH2rGmlkWN7d2g6hpF6m6gRk5do+6rTDMZ7hPrOv3EXdbvgXJ2
         ZBOMtoOaI9WT/gQAJqcHekt1ddPEndVeqogOAMKhEOVeWRflLD7dWnksyMqSYFhXzh
         1SSWihFQurA5Q==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 896356801FC;
        Wed,  6 Sep 2023 14:28:10 +0000 (UTC)
From:   Claudio Cambra <developer@claudiocambra.com>
To:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Claudio Cambra <developer@claudiocambra.com>
Subject: [PATCH] docs/gpu: fix docs compile error for i915
Date:   Wed,  6 Sep 2023 22:27:47 +0800
Message-ID: <20230906142746.93411-2-developer@claudiocambra.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kGJWdrJrYEXPy6-Q0WNuhlvTyFeG0nx7
X-Proofpoint-ORIG-GUID: kGJWdrJrYEXPy6-Q0WNuhlvTyFeG0nx7
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=613 mlxscore=0 clxscore=1030 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309060125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile error was caused by improper doc comment whitespacing

Extra task for "Documentation task"
Linux kernel Bug Fixing Fall Unpaid 2023

Signed-off-by: Claudio Cambra <developer@claudiocambra.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_huc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
index ddd146265beb..fa70defcb5b2 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
@@ -26,6 +26,7 @@
  * The kernel driver is only responsible for loading the HuC firmware and
  * triggering its security authentication. This is done differently depending
  * on the platform:
+ *
  * - older platforms (from Gen9 to most Gen12s): the load is performed via DMA
  *   and the authentication via GuC
  * - DG2: load and authentication are both performed via GSC.
@@ -33,6 +34,7 @@
  *   not-DG2 older platforms), while the authentication is done in 2-steps,
  *   a first auth for clear-media workloads via GuC and a second one for all
  *   workloads via GSC.
+ *
  * On platforms where the GuC does the authentication, to correctly do so the
  * HuC binary must be loaded before the GuC one.
  * Loading the HuC is optional; however, not using the HuC might negatively
-- 
2.41.0

