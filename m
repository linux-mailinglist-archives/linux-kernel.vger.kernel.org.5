Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62566806C93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377600AbjLFKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377706AbjLFKqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DB10FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6328C43397;
        Wed,  6 Dec 2023 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859575;
        bh=9Tw/V5BfsP8eOfjYMQJzQj/K+Mj6xP6MJHv7Smo4iQs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=L4ETiG5LfvSl+3wBwj0ztHDODdoDVkt3URSTG20y9a80+aNFViolXNTPMo8xiW4l+
         bwT+XtE/uSHBsxIsibmd1tNGXjd3dthrXJGk8U44CO2fkkUcggEWwRB3t4ppuKdBM5
         e00Ozzpc4p1sOkis+unr0rrYB4n6z/OobQoE6xNPzy5xM/5EwipgbOT7fA0I6Lwuud
         6E2Ih+1A0GmYU5D1O3cYVfLxrlot9ZTI2uVqjHSDhRpLu1HQ/L4VQgYXUkGYNJYvTv
         Lnysz/R/s1BiiQnjBI2prayV5EGfaGnFneYqRkHTQ1houWSm2wYhULjxBZut4Xe3Bv
         ytoJv32qz7zSA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:55 +0100
Subject: [PATCH v2 04/15] selftests/hid: tablets: remove unused class
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-4-c0350c2f5986@kernel.org>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=742;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9Tw/V5BfsP8eOfjYMQJzQj/K+Mj6xP6MJHv7Smo4iQs=;
 b=EK73Kr733r3Gdl1YZvIa3AtxB9ftadyv5o2jtBzWLNR3Y1jK6VnfXbhFsqW5sVbkuHl1zYZBR
 rFTKD7oO/0XBqV8cvIqA4EwTCuM8wJRT3CWZdTz+3AeLYGK8vug/eY2
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this is a leftover

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/tests/test_tablet.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/test_tablet.py b/tools/testing/selftests/hid/tests/test_tablet.py
index 303ffff9ee8d..cd9c1269afa6 100644
--- a/tools/testing/selftests/hid/tests/test_tablet.py
+++ b/tools/testing/selftests/hid/tests/test_tablet.py
@@ -133,10 +133,6 @@ class PenState(Enum):
         return tuple()
 
 
-class Data(object):
-    pass
-
-
 class Pen(object):
     def __init__(self, x, y):
         self.x = x

-- 
2.41.0

