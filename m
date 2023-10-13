Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1727C7B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJMCAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJMCAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:00:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51082C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:00:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so1283052b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697162407; x=1697767207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LXDLb7hZVgUIIyJsZzS09H6+EPiYEBX3NhLtdzTmiM=;
        b=TuenlSqR2Cp2S4iJm+TPtzwwRtOklwjeqIvUjBUD8N01z8xSxClM9uXtq3GQFm7djz
         COYkNPErDHZVpyaZfzEt76eh0NaYv/xVNEzmQng0+AvjcKLyUoTXypOoyC2q/aBvDFSq
         JPIV7ipOhvJNqVmIsMnddIs7rqfp+YB+DVnAeK4daktrrIwcHcbiDMQbWeQuhpF3yY4D
         e0rnD7jWaknwSMgsqNPYG8T85PqkmK2Qco7jg87F1WgefRIqIaGcWLSpZtTUXwVPafY2
         SF/1ids59YCv0CfGvfnnuRjjpK0r/BzTMqk+MYWwfQkBqODIb6Hw5PaAtosWpHy/ezxw
         gkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697162407; x=1697767207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LXDLb7hZVgUIIyJsZzS09H6+EPiYEBX3NhLtdzTmiM=;
        b=XKJf7UZUVCIylwYR5QlrxMQwJrHIqypDjL+LiOS7tgyqDMH1FwKuKqy17bzbxPwElI
         iUGNRqK6V1WJKvpkHqyVw29OI6I+d9BvDb19AGKTsaHPxtYE3ajwDo8h8MKzjD/T3aIu
         BjlQ2Qq36qA956vK1uBzfeCqOY6rzEeRmEMHP15pfzjv6q3ZkUZWCNk5ncHBQnD01axz
         IeZOZ3ZwMjqCmAIXf9xPVjpKbrddL0pwvLu6lpeVH5eVXMDcJ5LrQ0nXzNrXAKxHBb3j
         7W2MEg/y3q3yIwgubzkN6kjb48o3IKdxMAfPHV7tVZ133ExMV2MRn/8zq2hki/i9pK5p
         iUfQ==
X-Gm-Message-State: AOJu0YxQfcOGc4H9UsWY7XKbJflostD0TVI56wh+pdogRteQyO0QG99k
        fJNxh5INvxWibkjKpW5b1xk=
X-Google-Smtp-Source: AGHT+IE95yiqaM6y47Ls/ez+pfWl17G4U4EKJIdxmaQ9DdUseFD4IRzJJRYcteaopOkgtdcJyMEWHg==
X-Received: by 2002:a05:6a20:a110:b0:161:3013:b499 with SMTP id q16-20020a056a20a11000b001613013b499mr30784883pzk.60.1697162406075;
        Thu, 12 Oct 2023 19:00:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b2:f182:ece3:38de:3ac4:3149:fe7b])
        by smtp.gmail.com with ESMTPSA id mv21-20020a17090b199500b00276e8e4f1fbsm2520416pjb.1.2023.10.12.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:00:05 -0700 (PDT)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: pci: Missing a blank line after declarations
Date:   Thu, 12 Oct 2023 22:59:51 -0300
Message-Id: <20231013015951.16812-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Warning found by checkpatch.pl script. Adding blank line after declarations.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/lola/lola_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/lola/lola_proc.c b/sound/pci/lola/lola_proc.c
index a166672e22cb..1ee5997da3c9 100644
--- a/sound/pci/lola/lola_proc.c
+++ b/sound/pci/lola/lola_proc.c
@@ -137,6 +137,7 @@ static void lola_proc_codec_rw_write(struct snd_info_entry *entry,
 	struct lola *chip = entry->private_data;
 	char line[64];
 	unsigned int id, verb, data, extdata;
+
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%u %u %u %u", &id, &verb, &data, &extdata) != 4)
 			continue;
@@ -150,6 +151,7 @@ static void lola_proc_codec_rw_read(struct snd_info_entry *entry,
 				    struct snd_info_buffer *buffer)
 {
 	struct lola *chip = entry->private_data;
+
 	snd_iprintf(buffer, "0x%x 0x%x\n", chip->debug_res, chip->debug_res_ex);
 }
 
-- 
2.39.2

