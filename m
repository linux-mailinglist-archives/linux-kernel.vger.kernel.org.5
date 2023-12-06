Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1548B806C74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377679AbjLFKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377590AbjLFKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:46:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5FD69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16CAC433CA;
        Wed,  6 Dec 2023 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859569;
        bh=xe8eVGKu/XYmHuEoIZMJuRKeejCeK3tXEXZTN95j7H4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=p/V24cCj1KRSHgsgd5i5dZAaHhZQjmlFYwWm01hLqIY71xppRpjrSJLUv61St7Xtd
         Twma7NYl+zYQ/twfiel9Iz7EE9e17rdG9omSSE2AzkZWXZcWrb7q8eBluyJkYJ7H+l
         hcRbp4z1yEPa0d0yqkKH70SvGNXI6//q0bTBD356SVcqzEx/4QLdswTMmuCuKKHypm
         0z+MDrrMRikpjD2gSiznnb97AAqgd1QRmZidI7KgvDdMyGYIVz/Ql2/3dT/cxjh4Wb
         88rmxIlpucTV2I7CSOl6PWQos8jkA8hXOB/hYbG3Nv8z9v/z55XNNm4fue0d4tCM4+
         m2e/90XFE996A==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Wed, 06 Dec 2023 11:45:52 +0100
Subject: [PATCH v2 01/15] selftests/hid: vmtest.sh: update vm2c and
 container
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-wip-selftests-v2-1-c0350c2f5986@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701859565; l=1505;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xe8eVGKu/XYmHuEoIZMJuRKeejCeK3tXEXZTN95j7H4=;
 b=w3esJ6OZB5/67cvr1kVy1UEwjVZq3DHyoxhXDwXzVwyXa3DCUkWYwmK9D5bfCPgRjOmmXY+7c
 3eu5e8bLDkXCQXx8F0M2TW01T4M+qh6eVIcYZe6bWILWD8kij100PZL
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

boot2container is now on an official project, so let's use that.
The container image is now the same I use for the CI, so let's keep
to it.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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

