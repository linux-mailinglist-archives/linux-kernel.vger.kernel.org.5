Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DBC7AD4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjIYJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIYJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:49:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACC9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:49:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so118852817b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695635358; x=1696240158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNKA1Hnc4RjaO6AH2fv63+ZGpcGBvExfQ+lR664bMdQ=;
        b=zbVQlnOZ6010Or/YsXkUbCdUyqNMCzubKAHRKDJQQuJdQhzM8yCTGXh1Hf5It6qijq
         byoV1xW8VLQ9m+TTk2EUWemjtdd+8LCcDBHPB83Ot1l93vuuIr1kdcxWMKC/8gdBPthd
         OgKaqT4sTMt/WUYmk0cNJUe3cgK95/zqZ1EFJXCWa4qmUGEHC1hmxqs00Hd2FOV9SI0r
         qPf5YE3ArikYD8jpgQAR0d9mKQRsmCR9qG6FunkttE5FWIG/a/3ULRtpnKPNQlaXwXU+
         JdV7hY6u96AAxjM1kDlBa/NCPxAuDo1Zhhva75FJEyu/mjq3gZt35DljO1i7E2SJ6eST
         82Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695635358; x=1696240158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNKA1Hnc4RjaO6AH2fv63+ZGpcGBvExfQ+lR664bMdQ=;
        b=ZouY1xgUlxBiD99zkU+YR+mBsFAIH8U/Evxvbug9GlM+ACwhKVdrIRcnejf+QPDITg
         Z1XiP73rm3JYSi/zpI00X1i8tu02h1a735Tz/P/DdSNtHF3jAY/wG5GCjN4fZrQjPIJt
         kPpQMsVs8XfXRgU9eVZMBGpM0gfZjz4xT0a1fg7UfV3CzzE9O355yVryHoUv790HhNWX
         OA3ZHIZXMsYiE+sDc8r+XrA2/y1/VAyqA3/fMs06oVdNTn5YQ32bI5B8AGknknRMlA6v
         2atoEKl6IELQ1o2isr/FfvP060QEZgkpCUAawnfFrc6Yu5kBg/lmGMxvRepSsobovnTt
         ZZiA==
X-Gm-Message-State: AOJu0YxQ21CRj1G4/jDSb2EEoJO+2TdN/6927mdsQ3/ezofC+92sV9Fj
        dW05URd7txZflDEhz3BfeitvTcoXgfMdwRP10w==
X-Google-Smtp-Source: AGHT+IFT/EoU9lF7/VSsXmZNp13EyCokrNfEwzOn2ORuhycPRZW5LSoattYb6Rv3yo/3wgjyJcwA1oRaojmXPxV9KQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ab4a:0:b0:d82:9342:8627 with SMTP
 id u68-20020a25ab4a000000b00d8293428627mr54397ybi.6.1695635358682; Mon, 25
 Sep 2023 02:49:18 -0700 (PDT)
Date:   Mon, 25 Sep 2023 09:49:17 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJxXEWUC/x2MQQqEMAwAvyI5G6h1q6xfEQ/aRs1hqyQiivj3r
 cJc5jBzgZIwKTTZBUI7Ky8xSZFn4Oc+ToQckoM1tjRf61A3iX49MQjvJIq/8OCR6to58ymroh8 g1avQyMd7brv7/gN2ckahaQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695635357; l=4211;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=RjrTr0cPh729SghrvkaIM4sQRHLM0A9sLRviR1AfBFw=; b=L2D/Pw7TiJhA8KqYSyzmqfnA3+R9aVlA2dlttmP8heuAPcLNDjh0ZCx88XvOZQstWCrmGCR5x
 2ZqRJaLQa2JAf7CGkq9+6n5cq26REsMTKlVHwJ7qUOEmMtADI8PKZuk
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-md-c-v1-1-2b0093b89c2b@google.com>
Subject: [PATCH] md: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

There are three such strncpy uses that this patch addresses:

The respective destination buffers are:
1) mddev->clevel
2) clevel
3) mddev->metadata_type

We expect mddev->clevel to be NUL-terminated due to its use with format
strings:
|       ret = sprintf(page, "%s\n", mddev->clevel);

Furthermore, we can see that mddev->clevel is not expected to be
NUL-padded as `md_clean()` merely set's its first byte to NULL -- not
the entire buffer:
|       static void md_clean(struct mddev *mddev)
|       {
|       	mddev->array_sectors = 0;
|       	mddev->external_size = 0;
|               ...
|       	mddev->level = LEVEL_NONE;
|       	mddev->clevel[0] = 0;
|               ...

A suitable replacement for this instance is `memcpy` as we know the
number of bytes to copy and perform manual NUL-termination at a
specified offset. This really decays to just a byte copy from one buffer
to another. `strscpy` is also a considerable replacement but using
`slen` as the length argument would result in truncation of the last
byte unless something like `slen + 1` was provided which isn't the most
idiomatic strscpy usage.

For the next case, the destination buffer `clevel` is expected to be
NUL-terminated based on its usage within kstrtol() which expects
NUL-terminated strings. Note that, in context, this code removes a
trailing newline which is seemingly not required as kstrtol() can handle
trailing newlines implicitly. However, there exists further usage of
clevel (or buf) that would also like to have the newline removed. All in
all, with similar reasoning to the first case, let's just use memcpy as
this is just a byte copy and NUL-termination is handled manually.

The third and final case concerning `mddev->metadata_type` is more or
less the same as the other two. We expect that it be NUL-terminated
based on its usage with seq_printf:
|       seq_printf(seq, " super external:%s",
|       	   mddev->metadata_type);
... and we can surmise that NUL-padding isn't required either due to how
it is handled in md_clean():
|       static void md_clean(struct mddev *mddev)
|       {
|       ...
|       mddev->metadata_type[0] = 0;
|       ...

So really, all these instances have precisely calculated lengths and
purposeful NUL-termination so we can just use memcpy to remove ambiguity
surrounding strncpy.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a104a025084d..73846c275880 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3879,7 +3879,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 		return rv;
 
 	if (mddev->pers == NULL) {
-		strncpy(mddev->clevel, buf, slen);
+		memcpy(mddev->clevel, buf, slen);
 		if (mddev->clevel[slen-1] == '\n')
 			slen--;
 		mddev->clevel[slen] = 0;
@@ -3912,7 +3912,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 
 	/* Now find the new personality */
-	strncpy(clevel, buf, slen);
+	memcpy(clevel, buf, slen);
 	if (clevel[slen-1] == '\n')
 		slen--;
 	clevel[slen] = 0;
@@ -4698,7 +4698,7 @@ metadata_store(struct mddev *mddev, const char *buf, size_t len)
 		size_t namelen = len-9;
 		if (namelen >= sizeof(mddev->metadata_type))
 			namelen = sizeof(mddev->metadata_type)-1;
-		strncpy(mddev->metadata_type, buf+9, namelen);
+		memcpy(mddev->metadata_type, buf+9, namelen);
 		mddev->metadata_type[namelen] = 0;
 		if (namelen && mddev->metadata_type[namelen-1] == '\n')
 			mddev->metadata_type[--namelen] = 0;

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-md-c-e775504361ab

Best regards,
--
Justin Stitt <justinstitt@google.com>

