Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B903979B420
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjIKWpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356189AbjIKWDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:03:08 -0400
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2EC1B1A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:49:23 -0700 (PDT)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d7e79ec07b4so4809384276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694468808; x=1695073608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtlA+KB8kDzwUN9dvFmpQoLjgzbj73lXqnrIpi3kP44=;
        b=G+QllVzkEPCPiNlCpw4eIWREaNMv1LfC5mrnsPFPy4Pc6VXkstKOW+LAK75+jr06XS
         nDyo1Cpmz8IMV52bX3gPhS5IZmxmw6pXSXCTxKG3hUXEiQPbmtPK4PeKlWUTJ2p+tLlD
         ie1dU6d6mGzTCjAS2vgKvVc9Kl4eWk41aIzhkaLxllJhyeFXspf72u1bC3CXl3LqVL9U
         xNLr/STpbc+ChtdKBOmW5Fvj5uwmVbr+ngdaZlkNMm8unx8Hufxwu2TmI9OJ30RM+YtW
         3vbGFDFfoRmUlCqqLe30UndBNBrWysZzM6HImTqHYAgt/kJaMEboTn0KUYdKTF1Isd76
         p0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694468808; x=1695073608;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtlA+KB8kDzwUN9dvFmpQoLjgzbj73lXqnrIpi3kP44=;
        b=BEOvlUFmegLVhz751QX72xxJzQhQpL1SqErxl2zaLIM/7GmAoNZrkvY2lzZsvZkygk
         DaF0WL78+AOQwA2evzZCjRVS4ZOiDhOKoI01RqgbhyCrMAdrSptlBGMM2ep61f+lkuPj
         60jCUwE+v6vLcFZH/bITDkSMoXBUQhV+4a4z7gFjx/6RCsOL1VZW6BMWlJow3P9sAJW5
         rgjNms4X59sgApZfAHYVhhB7+9pzXWvCoJx4BiHC45gex0k7219RbsocFLCMgdrSYTQC
         4vbxSGEUTIStSKTaz8bFqteJ6MjTyKet1ZDUBhvD1/kC8FicHvs9LP0cx5G8WmfvYg/F
         j1uw==
X-Gm-Message-State: AOJu0YwbBvtosAqvHR5g7w+8DYW5UC1VrPBNCK4nr3gufqwi7FUMtFZR
        DhOjQNB2F14QhppBzPibBEYRmRtbJbAU1uStNg==
X-Google-Smtp-Source: AGHT+IGz+NEEOx+kTbptMq4j+qCzNxFKiPoF3JBZuUXHlbhZqlK9zFaMBms4PxAmrlhTc5ZEYgefWanCKL3AQYpMWA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:108f:b0:d78:3c2e:b186 with
 SMTP id v15-20020a056902108f00b00d783c2eb186mr249352ybu.5.1694468808319; Mon,
 11 Sep 2023 14:46:48 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:46:47 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMaK/2QC/x3NTQ6CQAxA4auQrm1CGX+CVzHEDEPVhrGQVomGc
 HcnLr/Neys4m7DDuVrBeBGXSQtoV0F6RL0zylAMTd2EuiVCf5mm+YuDycLm2OcpjajvnK99HvE ZRTHhKexbOgSmdIxQWrPxTT7/z6Xbth9z69SrdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694468807; l=2611;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OWFJFfLu6R2MwsjnUT9XcLBqmI6CZTKqrnm0bDPTtIs=; b=LosAEspLXhaxEqoWCE/7ubiC5QsQX1wQYH8Q5dr8Rfy5EG7JDg1ORMnj9pREXDAE8Nr93Ab+Y
 J92caMRvcnwDaSGYgXwZQ8Lx07/ZJwt/KYaxiWbdy76qkHtaDS+f8AL
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com>
Subject: [PATCH] null_blk: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should favor a more robust and less ambiguous interface.

We know `nullb->disk_name` is NUL-terminated and we expect that
`disk->disk_name` also be NUL-terminated:
|     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
|              "%s", config_item_name(&dev->group.cg_item));

It seems like NUL-padding may be required due to __assign_disk_name()
utilizing a memcpy as opposed to a `str*cpy` api.
| static inline void __assign_disk_name(char *name, struct gendisk *disk)
| {
| 	if (disk)
| 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
| 	else
| 		memset(name, 0, DISK_NAME_LEN);
| }

This puzzles me as immediately after assigning the disk name we
go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
| #define __print_disk_name(name) nullb_trace_disk_name(p, name)

This function obviously expects a NUL-terminated string.
| const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
| {
| 	const char *ret = trace_seq_buffer_ptr(p);
|
| 	if (name && *name)
| 		trace_seq_printf(p, "disk=%s, ", name);
| 	trace_seq_putc(p, 0);
|
| 	return ret;
| }

I suspect that NUL-padding is _not_ needed but to be overly cautious
let's use `strscpy_pad` (although I strongly suspect that whole memcpy
thing should be changed).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..994919c63f05 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1938,7 +1938,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	else
 		disk->fops		= &null_bio_ops;
 	disk->private_data	= nullb;
-	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+	strscpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
 		int ret = null_register_zoned_dev(nullb);

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-null_blk-main-c-7349153e1c6a

Best regards,
--
Justin Stitt <justinstitt@google.com>

