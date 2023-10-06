Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662197BBC33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjJFP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJFP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:56:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91BA6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:56:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so26066121fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696607760; x=1697212560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p79UdREZZAqJEG4ed9Cqy6ZZIFZqKWpUabzxjEUQnwI=;
        b=WU42yYtVrYVFv8ss3xhkEjCQ3qD/eO7zWetlcKbV4ajg5nLLmC+OnWY5DeL5Icw3M4
         vzr63Ys7QPmgLPsLuxFJOrfFccd4BOuMZkdB9pOfpxUrGQmGqgzxl/ngtkapKRQn8Fm1
         vv4k4KrwjFHwj4Ag7PjZ+cz/f0sMbE0/lnZqcDBYH4VAl5bILd4bJqaR1uyvh0HsMx+i
         Bq0Wue6pEAWPrZlaspLyFzbGwT67YT6m3/fbZQvMVCRnNgqz+Q7TG+MLG0nzv41vHBeF
         KZTCbt+sCL5jg2JWGcVBYWZfBcXGaRa1CEapXbs2dtI2V6WXOxVyZgfrIx5XB4zFAlv8
         58gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607760; x=1697212560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p79UdREZZAqJEG4ed9Cqy6ZZIFZqKWpUabzxjEUQnwI=;
        b=Q6vJFQ83r/X4R37myogEoiM8/Vvo7G8ftQPdZxX60jDPcAy6YoolYbKk3b56BktMm9
         Wojdtsouta5zq4bw5eT0tWAQPzgQ/zSdmyRoS3gkRZD/NUGik62Gk4d94rPDqpruDQnq
         fVdzFl/70EdsHlBwkyupuBAglYOVOmaebF1DutJjL9+pkpuNnTflPqp06eU7obK25T49
         l+nfy4B9OoY+ZIQwfBrX4GPEqZ/8pjsQH6nF5NgsyvFxS7/1/6roYAGoPKFqTv+PKux7
         Mwv5IS/jVA18KM5ZH2egyGSbeUEBYN6IuQchRfd1/rcr22fw2tcvpWLqN6jjO/ZUJjOP
         5FUA==
X-Gm-Message-State: AOJu0Yw2N0vDHcJ1bt5jfsvj7HITgzP6CTrgU+ixjJ125O/+Oq+HKvdp
        EJd/qfCr/MRs7ZGzT9MoUkA=
X-Google-Smtp-Source: AGHT+IFUwTAmliU6/8HaySJamov+AdflUtJK3/o9el7FvFWytzQwSVGEK8537qPiiJ7p1RoiHOgTKw==
X-Received: by 2002:a2e:9f42:0:b0:2c0:c9e:e276 with SMTP id v2-20020a2e9f42000000b002c00c9ee276mr7623038ljk.31.1696607759663;
        Fri, 06 Oct 2023 08:55:59 -0700 (PDT)
Received: from localhost.localdomain ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651c102d00b002b9e9a8532dsm825978ljm.138.2023.10.06.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:55:58 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH RESEND trivial v2] checkpatch: stop complaining about tags suggested/tested by syzkaller
Date:   Fri,  6 Oct 2023 18:55:02 +0300
Message-Id: <20231006155501.3120-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you submit a testing request to syzkaller it may reply with:
> syzbot has tested the proposed patch and the reproducer did not \
> trigger any issue:
>
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com

Checkpatch is ok with Reported-by tags, but complains about
Reported-and-tested-by tags:
> WARNING: Possible unwrapped commit description (prefer a maximum 75 \
> chars per line)
> #48:
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com

Adding the new tag to signature_tags removes this warning.

Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
PS: It's expected that checkpatch.pl will complain about this patch for
checkpatch.pl, although I tried to remove some warnings - see below.

v2:
  - suppress 4 warnings from checkpatch.pl, adding '>' to commit-msg
  - ./scripts/checkpatch.pl is still complaining about this patch
    (mostly about the keywords in diff):
      total: 6 errors, 14 warnings
    although it's not complaining too much about commit-msg (only about
    Reported-and-tested-by tag)
v1: https://lore.kernel.org/all/20230829123446.3455193-1-andrew.kanner@gmail.com/

 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..a9dbc9c6e26c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -617,6 +617,7 @@ our $signature_tags = qr{(?xi:
 	Tested-by:|
 	Reviewed-by:|
 	Reported-by:|
+	Reported-and-tested-by:|
 	Suggested-by:|
 	To:|
 	Cc:
@@ -711,7 +712,7 @@ sub find_standard_signature {
 	my ($sign_off) = @_;
 	my @standard_signature_tags = (
 		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
-		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
+		'Reviewed-by:', 'Reported-by:', 'Reported-and-tested-by:', 'Suggested-by:'
 	);
 	foreach my $signature (@standard_signature_tags) {
 		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
-- 
2.39.3

