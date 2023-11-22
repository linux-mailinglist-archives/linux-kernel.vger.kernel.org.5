Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABF7F546E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjKVXVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:21:32 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A511719D;
        Wed, 22 Nov 2023 15:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700695286;
        bh=oGqFtVNsY4uJunPznNTx1DWHTr8c8+KYcdqYPF0S3cQ=;
        h=From:Subject:Date:To:Cc:From;
        b=KZqas2dV1BPsxXm/ONrZfXjzyQRrtNpYoHHU7bASiPN0jvLv1mEfwFqcMEP2bB7eY
         O8P8PZ9Z2isQXsrQFsO+zJCA+ChM++S3JnsfLtQBBOd5mdU5mB9eCuIJP7fH/UWgZT
         9yLblOO7l7Rkre5R10HRJCgXgOUPIDReYPgofIEY=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] tools/nolibc: rlimit support
Date:   Thu, 23 Nov 2023 00:21:24 +0100
Message-Id: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPSMXmUC/x3MQQqAIBBA0avErBNyshZdJVqkjTVgGhoRiHdPW
 r7F/xkSRaYEU5Mh0sOJg6+QbQPmWP1OgrdqwA57KRGFD461EdHxybfQetDS4qisUVCbK5Ll9//
 NSykfo0ok+V8AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700695285; l=841;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oGqFtVNsY4uJunPznNTx1DWHTr8c8+KYcdqYPF0S3cQ=;
 b=mXZlr6amppqA3OgesfNVudG4wKhJGI0XGrx6ad6rcL3bBr/+f+o4Rv7V2vqp2NIa72CzMowg0
 uen1Zb66GNMBy3YyVCN4qgDgHTx6P/nQbn/bOPHSBTq6gcqDBF+58FR
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

The series adds support for setrlimit/getrlimit.
Mainly to avoid spurious coredumps when running the tests under
qemu-user.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      tools/nolibc: drop custom definition of struct rusage
      tools/nolibc: add support for getrlimit/setrlimit
      selftests/nolibc: disable coredump via setrlimit

 tools/include/nolibc/sys.h                   | 38 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 | 21 +--------------
 tools/testing/selftests/nolibc/nolibc-test.c | 31 +++++++++++++++++++++++
 3 files changed, 70 insertions(+), 20 deletions(-)
---
base-commit: 0dbd4651f3f80151910a36416fa0df28a10c3b0a
change-id: 20231122-nolibc-rlimit-bb5b1f264fc4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

