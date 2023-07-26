Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4907636A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjGZMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjGZMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:47:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3919A4;
        Wed, 26 Jul 2023 05:46:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3A361F86C;
        Wed, 26 Jul 2023 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690375612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPu1H25NivJSbCg/HOPZlHb/EYJ8Nwpyhat3/mx8rj4=;
        b=Tn+yQogVjjrExaH7TgBLRjyqSj/XHsYYh9U/orXU3Xhc+QFw51TNxPX8VNaSDescnI7GRo
        Qn4uoURcw1Yt+QocG+zLj2KiRHToPCA0ihLNUs5FRofBZ70u9GXd3fscRdIJ77Ik41d3Yu
        0DXERg+BFPGQ842JF3e5W+9Zp6MHnF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690375612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPu1H25NivJSbCg/HOPZlHb/EYJ8Nwpyhat3/mx8rj4=;
        b=WtmT96tCNeHhncXIO579hxODuA5CSGn5zBcmPhax6mZHhoRvy6gl15fB/45mcP1qN1fJ0E
        pKKxKZWUsmzS7gCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98862139BD;
        Wed, 26 Jul 2023 12:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TBPuI7wVwWQgUAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:52 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group all variables declarations
Date:   Wed, 26 Jul 2023 14:46:34 +0200
Message-ID: <20230726124644.12619-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group all variable declarations together at the beginning of the
function.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 | 3 ++-
 tests/nvme/004 | 3 ++-
 tests/nvme/005 | 5 +++--
 tests/nvme/013 | 1 -
 tests/nvme/046 | 1 +
 tests/nvme/049 | 1 +
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index 6604012d2068..aa26abf8d8b3 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -22,10 +22,11 @@ test() {
 
 	_setup_nvmet
 
+	local loop_dev
 	local port
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	local loop_dev
 	loop_dev="$(losetup -f)"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index cab98ff44326..1e5c2b8b3e87 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -23,11 +23,12 @@ test() {
 	_setup_nvmet
 
 	local port
+	local loop_dev
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
-	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
diff --git a/tests/nvme/005 b/tests/nvme/005
index 8e15a13f3794..836854086822 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -22,11 +22,13 @@ test() {
 	_setup_nvmet
 
 	local port
+	local loop_dev
+	local nvmedev
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
-	local loop_dev
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
@@ -35,7 +37,6 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
-	local nvmedev
 	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
 
 	udevadm settle
diff --git a/tests/nvme/013 b/tests/nvme/013
index 14e646a19c47..2be8681616d1 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -26,7 +26,6 @@ test() {
 	local port
 	local nvmedev
 	local file_path="${TMPDIR}/img"
-
 	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/046 b/tests/nvme/046
index b37b9e98a559..942f25206c17 100755
--- a/tests/nvme/046
+++ b/tests/nvme/046
@@ -16,6 +16,7 @@ requires() {
 
 test_device() {
 	echo "Running ${TEST_NAME}"
+
 	local ngdev=${TEST_DEV/nvme/ng}
 	local perm nsid
 
diff --git a/tests/nvme/049 b/tests/nvme/049
index f72862c6426d..599ab58d7a29 100755
--- a/tests/nvme/049
+++ b/tests/nvme/049
@@ -17,6 +17,7 @@ requires() {
 
 test_device() {
 	echo "Running ${TEST_NAME}"
+
 	local ngdev=${TEST_DEV/nvme/ng}
 	local common_args=(
 		--size=1M
-- 
2.41.0

