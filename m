Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253DE7ED5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjKOVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjKOVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:08:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156D196;
        Wed, 15 Nov 2023 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700082503;
        bh=CTsA5lI8lYA3WInzrUfmp2TktRtuX8KANJ9jWl+c2CI=;
        h=From:Subject:Date:To:Cc:From;
        b=koQhOm6G5G1RG9ZKWXvmByD+QGyClLiOMkJb9OOolK+2P9sJ74045B1QbpGr1WSgm
         4Bp1UB6KmItqigfIb18Mi1SyHnFqcprm7rWoCz+UJawiiT6Y/funPD4fvi13KXA3B8
         3k8poHJU1j6TAHBvLL/8ZtsatHm7xEFL7xyZTCq8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/3] selftests/nolibc: introduce new test harness
Date:   Wed, 15 Nov 2023 22:08:18 +0100
Message-Id: <20231115-nolibc-harness-v1-0-4d61382d9bf3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEIzVWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNT3bz8nMykZN2MxKK81OJiXSOLZFNLAyPLFPNEUyWgpoKi1LTMCrC
 B0UpBbs5KsbW1AJUtSMNlAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700082502; l=1050;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CTsA5lI8lYA3WInzrUfmp2TktRtuX8KANJ9jWl+c2CI=;
 b=dNZ9JoznMaHKgGB6ViC2QV3bBhhy8b+gqTcUwfMSwdNBrwfj8egGjyvVpxskDj+9/Ut4raMbf
 LNm5lXAs4tWDIu3wAg2qMSfSd02rXVacSQGsOrtchXQRuqwUgkm6hYc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new test harness for nolibc.
It is similar to kselftest-harness and google test.
More information in patch 1.

This is an RFC to gather feedback, especially if it can be integrated
with the original kselftest-harness somehow.

Note:

When run under qemu-loongarch64 8.1.2 the test "mmap_munmap_good" fails.
This is a bug in qemu-user and already fixed there on master.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      selftests/nolibc: add custom test harness
      selftests/nolibc: migrate startup tests to new harness
      selftests/nolibc: migrate vfprintf tests to new harness

 tools/testing/selftests/nolibc/nolibc-harness.h | 269 ++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c    | 180 ++++++++--------
 2 files changed, 353 insertions(+), 96 deletions(-)
---
base-commit: d38d5366cb1c51f687b4720277adee97074b22e9
change-id: 20231105-nolibc-harness-28c59029d7a5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

