Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635357A10DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjINWVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjINWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:21:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D87269D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:20:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59224c40275so19940477b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694730056; x=1695334856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L6wxH6wI0CxNppihK8yyqaPuo2ed2yk6gacxAzZ/YyQ=;
        b=BM0YwBiwVFb8TzWvXVSas5oaWU302JRAzBkTRI+IJcHdIVkdRsJF3FFMuhyJ2HaWFu
         18Ytjyc9eeDM8lYwHh1jc4D+h8FLxClwupHBsThQW0v81wsybwsoNl4RsebOtcNs56u8
         tDN9p/BUNZJx5F7KgWEjMHUmaGHQV2xCFQIvl+3oqHn2bo/YqvmjZ77LqclnkTtwb/pO
         lzHCFI4KMm4QIF2yKkrvYr/+CPP7BJnzBiA1v+0fppHAFh1Pyv2XZWmOkxccDYAiSuKV
         Xjc56ChPLmrh7sM8kleY6eAR4hhoUR5oPqq+EfVXqHIyzzzg+PBvucRKGuTm6Hk5RpdZ
         ahfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730056; x=1695334856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6wxH6wI0CxNppihK8yyqaPuo2ed2yk6gacxAzZ/YyQ=;
        b=mj8JUAY5q6MVIO4adU4Li7cSuiLmyMt6bXAc6L0L+cO7DITuHPUuWi3/NIIR/gdyZR
         OULwzLpJKqy9yjmyqzgVjPs1F8iiiaCaHCRBBqANYnlX+rUGozxDSg5sasKAQ7zwuJ4z
         SA28EpeBYNBVZtWeKymo1AQZ8Lwjs3XlfxEydqsnXs/jLf/puZFVjYu9VTfdDjbup0RF
         qmdE0jIGiV+Hr7iR+93b57X499xsNYz6ENc5O5L9il407qvPUqDTVK6X4w7wNZ3zGV9I
         7dT2MV6mv+lw2Fer674ZzNuLO56ONcnCCxM59QQXzYfqb6ToobDpuF8ti4Tjr+prZJTv
         YX1g==
X-Gm-Message-State: AOJu0YzFgIz7NreN6OPHPrPx2DI9TQy03tPGkDlheOog+5VUlsidkOMg
        tFeYSWBCehiRU2J5P27F+HVtoPjzfHqKfe1Xbw==
X-Google-Smtp-Source: AGHT+IEpoemOyU/gCfEy83llw70WSxP7zEz3SBbvICVjbWMxxJfMiydQwtaNCRNpaXfr7o3vwcXiY9NfsRvm3iC3KQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:710:b0:59b:f138:c83b with
 SMTP id bs16-20020a05690c071000b0059bf138c83bmr548ywb.3.1694730056164; Thu,
 14 Sep 2023 15:20:56 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:20:55 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEaHA2UC/x2NMQrDMAwAvxI0RxC7JtB+pXQIlhyLgmOkEhJM/
 l6T4YZb7hoYq7DBa2igvIvJVrq4cYCYl7IyCnUHP/nH9HQB7acl1hNJZWc1zEI3VTeSL5+GEWM KfnZh8Y4C9FJVTnLcl/fnuv40LAw+dQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694730055; l=2074;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+74GC7rHw1mTn7nixljv5X0qMRleq8S1K0Ou7Xb7zvw=; b=Kpg/iXSQK/dWh3bjDyW1nCyXP9t2hxjS3t8Kvy+Gk83wwymskJL9AwoLZSuYt0s95O1vww4sD
 edk9W7p0v+tDvqTc6FRuqWSc/e+ou1C/82uv+xmTsAPYQKfeT++S8J4
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hid-hid-prodikeys-c-v1-1-10c00550f2c2@google.com>
Subject: [PATCH] HID: prodikeys: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: for some reason if NUL-padding is needed let's opt for `strscpy_pad()`
---
 drivers/hid/hid-prodikeys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index e4e9471d0f1e..c16d2ba6ea16 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -639,9 +639,9 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail;
 	}
 
-	strncpy(card->driver, shortname, sizeof(card->driver));
-	strncpy(card->shortname, shortname, sizeof(card->shortname));
-	strncpy(card->longname, longname, sizeof(card->longname));
+	strscpy(card->driver, shortname, sizeof(card->driver));
+	strscpy(card->shortname, shortname, sizeof(card->shortname));
+	strscpy(card->longname, longname, sizeof(card->longname));
 
 	/* Set up rawmidi */
 	err = snd_rawmidi_new(card, card->shortname, 0,
@@ -652,7 +652,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 		goto fail;
 	}
 	pm->rwmidi = rwmidi;
-	strncpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
+	strscpy(rwmidi->name, card->shortname, sizeof(rwmidi->name));
 	rwmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
 	rwmidi->private_data = pm;
 

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hid-hid-prodikeys-c-cf42614a21d4

Best regards,
--
Justin Stitt <justinstitt@google.com>

