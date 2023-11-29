Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A97FDB42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjK2PZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjK2PZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:25:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FF98
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A0C43391;
        Wed, 29 Nov 2023 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271509;
        bh=Nb8tm7B+NGdmZAEx/i4rqoigQ/eiqRZPYosDwPWo2AY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aaCfdq/T8P3k/Qh4KXZku0Z8B6cIu0RbB0RNZZzkHHLmxHjrN4it8JR0XeEBV0Cf0
         QPI/cHNqaekn6Itmep5rX9+ohdRNG2iK/P8bCByOn1VCUhnv5b/AfQdK/h25N2lBts
         9vQ42H8RWu9a4l4+sm8ziQbwuAMcGNcNOPcQpfXtoO+gSSejcGFW24/wWczAJDe4Dm
         XIHVKaoLbzdJNsVKlXAUuP9NAbbQf1zAmj4MHPyP5+4qTPLboI1s4ItCxh3OgEgqXb
         gfcE+JdDssCVAumDxPrgIORL3hA/oEFYeq+VdxUh3sz0jtp/twfIcrKPsd/laqirnA
         jetXg8F0898gw==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:29 +0100
Subject: [PATCH 04/12] selftests/hid: tablets: remove unused class
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-4-ba15a1fe1b0d@kernel.org>
References: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
In-Reply-To: <20231129-wip-selftests-v1-0-ba15a1fe1b0d@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Nb8tm7B+NGdmZAEx/i4rqoigQ/eiqRZPYosDwPWo2AY=;
 b=PzPLUKbSzIb01Kpd2ou7OVM+vn83H+oaUcMIdpFBv7EfvQ2pYb8b3prdb4B/UOxafTCBqIaQR
 LmL0bOn3IM7ASYsWao6gT0wYsQYOl5E8zJrc5S695rHCF3mWCmjuqMc
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this is a leftover

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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

