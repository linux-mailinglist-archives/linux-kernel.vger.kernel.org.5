Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA37AD0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjIYGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjIYGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:55:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DFCA3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:54:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c240e637aso111927637b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695624892; x=1696229692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4qgvAyWUZmvKSaJjAnRidu6a0XvqHy58yVMteTj637s=;
        b=yaaDKnLtZH+/Tdt5STGdY7QN9HpFrnMcDTZ7+8j+vB6hNUFPMxaskBleGmnRDIsC53
         TyAtAtb9HVcv6/chkhEzJ3tENFxFw+dMH4FLu/EM3MiNZZ5DLoWHjsK1aOB4RD4oyKbw
         3YWYfz58ySprNjHDCdHsXw20AgBNBRDMyCGw6OFFdTk6zyhaXZ3HtkInWsA24F8xpz84
         ukbUwPfkAZqn6zzrLgkKoqTM7WqOx9zqWRRReacQVtRzTGU3mLD5LOu5EDWNo5TJdJyH
         Xy5J5AjETqH0JBG1hBxZXqBr1kQ2vd5ViXdOxkcSe9t0R+7v311JJvrLAPxWoK90BFhB
         09VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624892; x=1696229692;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qgvAyWUZmvKSaJjAnRidu6a0XvqHy58yVMteTj637s=;
        b=h/44zBk8tHgdOIa2WtskwOjUzKttPsCQuI0z9cwj2SYZrIePQrvB6ZJknDLfvTPajJ
         zK7R+C4bVkeT1p303skOiTLgQ8rHLqe6JuU1zuTjAcCttR3bkBOhv+tcuTrc+094rz+r
         W1AscMaEiUxKqc31reuEYA/6FZhsqjiD3KgUhhFLMC43vz5CoJFnSppLinVP687ICGmJ
         xFlL0wxE6/Sup2R+k0FwT1+GznFDaVVgowZm1E0Ifom9FTkTIjNQA3qnXcRXdbMuDOd/
         aUrS5zJgKjMWelh2ATBuSWFjnAu9VO6JDx78c8+3mLDl+PhdQ1shEr/0Y6tNbGb2h3iq
         owlQ==
X-Gm-Message-State: AOJu0YwpmmsMHQd7iZp1zOqYkWznlGFSdex+yRKGzIRGhWLeHBUH2/nc
        K3zkyHuHap3x7ZkcdSCkMtLG++QZnH54l5VcSw==
X-Google-Smtp-Source: AGHT+IHh3Z2bhRl8t+p0wMHkCiMSmYA+8DreMQdFY+BpQD4KVns1eJVE9TT9Fv/XfJ0JWH6G9aD58bYeO2ylB6HfLQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abac:0:b0:d81:fc08:29ea with SMTP
 id v41-20020a25abac000000b00d81fc0829eamr50788ybi.2.1695624892658; Sun, 24
 Sep 2023 23:54:52 -0700 (PDT)
Date:   Mon, 25 Sep 2023 06:54:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALouEWUC/x3MQQqEMAwAwK9Izgbaiqj7lcWDpFEDWiUR2UX8u
 8XjXOYCYxU2+BQXKJ9isqUMXxZA85AmRonZEFyoXBdqtEMT7X+MKier4RoxrigbHQsS8lCTd9w 0XeshH7vyKL/3//b3/QDRb0d9bwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695624891; l=2033;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Xzkm/GfG5TixyIwt6w7TZiwEMeENCaF2BkA9N23/JYw=; b=Pll71UQQ271YXI/KDgT1SxB3YKLk0+/ZGgantJ+FeHwnT8xz+5ogZmc5HFnm704SlWm1akCpq
 lljdGZ0RX37DLGe4jPvoXlZJ0ncg6zPG3SltsZPVIXUsB9kS4PDBH/N
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-ioctl-c-v1-1-f0bfa093ef14@google.com>
Subject: [PATCH] dm ioctl: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `spec->target_type` to be NUL-terminated based on its use with
a format string after `dm_table_add_target()` is called
| 	r = dm_table_add_target(table, spec->target_type,
| 				(sector_t) spec->sector_start,
| 				(sector_t) spec->length,
| 				target_params);
... wherein `spec->target_type` is passed as parameter `type` and later
printed with DMERR:
|       DMERR("%s: %s: unknown target type", dm_device_name(t->md), type);

It appears that `spec` is not zero-allocated and thus NUL-padding may be
required in this ioctl context.

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees NUL-termination whilst maintaining the
NUL-padding behavior that strncpy provides.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/md/dm-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 21ebb6c39394..e65058e0ed06 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1295,8 +1295,8 @@ static void retrieve_status(struct dm_table *table,
 		spec->status = 0;
 		spec->sector_start = ti->begin;
 		spec->length = ti->len;
-		strncpy(spec->target_type, ti->type->name,
-			sizeof(spec->target_type) - 1);
+		strscpy_pad(spec->target_type, ti->type->name,
+			sizeof(spec->target_type));
 
 		outptr += sizeof(struct dm_target_spec);
 		remaining = len - (outptr - outbuf);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-ioctl-c-ea5c10e77981

Best regards,
--
Justin Stitt <justinstitt@google.com>

