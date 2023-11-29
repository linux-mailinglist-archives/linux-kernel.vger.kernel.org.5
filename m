Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFEF7FDB36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjK2PY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjK2PY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:24:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC184
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:25:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1FC433C9;
        Wed, 29 Nov 2023 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701271503;
        bh=lglUK6Ur3CdUwASQTgBslEe65vEhczn7ZV7KCziVP0g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sxc4fHzh0Y2eCyN3G/k7rWHDOyvotcqkxnNlOupZYGA60Vu8k8v9V4HEn1M5DCzAl
         P24rYW7EvJ8OcZwP1+vryNP1tNiUXcjKNVLPVTUqWbwYwNW6lNX9gXnwprXWzIR1pd
         qxy9E5Fcn06mwO3aphaRu69QB76wATBhmf84K5poEnkewpsiWv9TxIPJb4nC8WJ4bt
         eqH35xNdtxQTLeii+XplLEaw4ABkB44PUXu2Js4BUmN+pdTqQo6jOvQjK5elfCgwoB
         ARgTMi3ykGZrRRZTsQSphhLFm+pOl46ee1qYXUZFfja+hkhq+/L1l9Q6flvbn6jSqY
         /KFgvBgn+U0IA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 29 Nov 2023 16:24:26 +0100
Subject: [PATCH 01/12] selftests/hid: vmtest.sh: update vm2c and container
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-wip-selftests-v1-1-ba15a1fe1b0d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701271499; l=1422;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lglUK6Ur3CdUwASQTgBslEe65vEhczn7ZV7KCziVP0g=;
 b=UyNv9qDRZwVXeIiBK4TZRTOaBbeXhh9LFXi5nHBY/ucZyQcGfBVWczCmmvf+mWaKSYZfURa29
 Lb2gKk+5bIvCRNcQDqCQMElrQSIDmEsYI2w4zQWhrEdwn6mWBbwJMkB
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

boot2container is now on an official project, so let's use that.
The container image is now the same I use for the CI, so let's keep
to it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 4da48bf6b328..301b4e162336 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -19,12 +19,12 @@ esac
 SCRIPT_DIR="$(dirname $(realpath $0))"
 OUTPUT_DIR="$SCRIPT_DIR/results"
 KCONFIG_REL_PATHS=("${SCRIPT_DIR}/config" "${SCRIPT_DIR}/config.common" "${SCRIPT_DIR}/config.${ARCH}")
-B2C_URL="https://gitlab.freedesktop.org/mupuf/boot2container/-/raw/master/vm2c.py"
+B2C_URL="https://gitlab.freedesktop.org/gfx-ci/boot2container/-/raw/main/vm2c.py"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"hid_selftests.%Y-%m-%d_%H-%M-%S")"
 LOG_FILE="${LOG_FILE_BASE}.log"
 EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
-CONTAINER_IMAGE="registry.freedesktop.org/libevdev/hid-tools/fedora/37:2023-02-17.1"
+CONTAINER_IMAGE="registry.freedesktop.org/bentiss/hid/fedora/39:2023-11-22.1"
 
 TARGETS="${TARGETS:=$(basename ${SCRIPT_DIR})}"
 DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"

-- 
2.41.0

