Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB375904B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGSIbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEBB1724
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689755424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zD3UEKBWOcid7vW1ZcdBVv5pq+DD5Ikq9fhBF2xLfgw=;
        b=cP7IpKjMkqcAStVlt1abeOrsbMML7AypAHDZvws4Rc08XmTcafh+3JmNHbEQAGvP9KlxMf
        YvNNA9AZN4T1Az7pYA2lGhPfyMxLthvxRZMc0lvNffQFG7e9DjWaKmlH9j/1c0MyemLE4X
        MZOSLz0SVd1rbY9H6xn4OXguVGdfomM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-O0FBTxn0NQylKXNoi0dxhg-1; Wed, 19 Jul 2023 04:30:23 -0400
X-MC-Unique: O0FBTxn0NQylKXNoi0dxhg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7681da13a3fso418906085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689755423; x=1690360223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD3UEKBWOcid7vW1ZcdBVv5pq+DD5Ikq9fhBF2xLfgw=;
        b=Tc5sFljLTgQe1QicKq7nY9IOd+OsVFedo1vwWXxKrXA3rnvkyuMqyu5oevsf5vWo6v
         6XLOhLmkf4f3juP3+iTe4fqcybH5zVmxSDC4fZ4q4/aVXa6WItd0coJhFq4DSk8Pdtgl
         6Fp2R4bkKTJZN2kd1HabTKsi8/ABUcxkGCgD1W2K7ttq2dvxlcjf2EF3solCpd0FSnMA
         0CIpxWVRdum25mR23IOF4JI6riNuyspi4n2DqmrwgtoX9I1zjtvxx8A+g4G4suioROmY
         IqaFJl+BNoA8nEe/2GaWAOKHV5kYcfvMQg521s4WYCRWOxu7fF/yCqUuI7wGEmo/0zUf
         9n8g==
X-Gm-Message-State: ABy/qLZyynXiIihIeVAz0yBhRO0CrzCZVGmvKPQINOXIHzLamvo5ffE9
        gt3zv8dWeSJmpu/92OjFIGrfmq+BlqaU34jJs1CTZVBYpI9zfYtNA4mh+SQli+Dy09IdrZw12m1
        2ymnM0o2kcwmYiThC3VIwzSLq
X-Received: by 2002:a05:620a:2b84:b0:767:3efd:59f5 with SMTP id dz4-20020a05620a2b8400b007673efd59f5mr2324593qkb.17.1689755422947;
        Wed, 19 Jul 2023 01:30:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMCuOmES+gmpHbJ8RQH1GhgKReqWzo74ERtS6ZoY4W1EuXrABnuZoQibujcjfYF9KZ3hQ1XA==
X-Received: by 2002:a05:620a:2b84:b0:767:3efd:59f5 with SMTP id dz4-20020a05620a2b8400b007673efd59f5mr2324560qkb.17.1689755422654;
        Wed, 19 Jul 2023 01:30:22 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:4b84:700:e5a3:9a79:b307:264a])
        by smtp.gmail.com with ESMTPSA id t11-20020a0cb38b000000b00632191a70aesm1305450qve.88.2023.07.19.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:30:21 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
To:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>,
        Dana Elfassy <delfassy@redhat.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] selftests/input: add tests for the EVIOCSCLOCKID ioctl
Date:   Wed, 19 Jul 2023 11:30:03 +0300
Message-ID: <20230719083003.1562415-1-delfassy@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dana Elfassy <dangel101@gmail.com>

This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
coverage of the different clkids

Signed-off-by: Dana Elfassy <delfassy@redhat.com>
Reviewed-by: Enric Balletbo Serra <eballetbo@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes in v3:
- Modified signed-off-by email
- Added Reviewed-by tag

Changes in v2:
- Replaced clkids numerical values with their equivalent definition

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..83ce1a3c9b84 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <unistd.h>
+#include <linux/time.h>
 
 #include "../kselftest_harness.h"
 
@@ -234,4 +235,33 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsclockid_set_clockid)
+{
+	struct selftest_uinput *uidev;
+	int clkid = CLOCK_REALTIME;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_MONOTONIC;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_BOOTTIME;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case default
+	clkid = -1;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(-1, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

