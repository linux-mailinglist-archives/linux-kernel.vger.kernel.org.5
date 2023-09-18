Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0B7A436F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjIRHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjIRHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:49:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF619A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:47:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so4450546276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695023250; x=1695628050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c03jgG6UPUVv4dkBa68RaV74op6Gpdw7+TjZxJ/11z0=;
        b=wpE22ZKpX8Qv/zsD0pUR/w71PTS4A9xEY6VwRpF5sTN/7P1f3b01mPSSY59dJfHnOj
         0d08fddXjo6PM9kyYdw9GJo2LJeBYGcqFfSMlPTb+W2Olt5OqyivMhbiU1I8t8Yk+nwy
         Y4/bPybZQZER0/JKFp346KleTyTnJ1mdqfF8GBg5S/A8I9WLIjSD+XJ5vmStVOGWxWz3
         g94687KeF6zo+6I+yJM1LAFCpQmPWhm+9nhcOYzaAwHqkr7G2VZa1IliDgStxXlLBXUX
         HuGIJNO9NjSGQk42Aec4LeqxluwZGDCkGWQfjqdisczPVGLS72zXeaIveRDS1pqMsws7
         R+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695023250; x=1695628050;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c03jgG6UPUVv4dkBa68RaV74op6Gpdw7+TjZxJ/11z0=;
        b=pf4i20Rnk4JdITB7WeaHZ0967+LFuU2TIUjK2u47nGG0e/pildMYJj2fzAM+ZZOf72
         v9G0M+sHqfXzuBiLy85qEshCADCbTmzlifq7KuJhJjIMDmuDakM8elZINDJnzbE0vgv8
         Hy/G4dEns3qPLU9Tbo0yr3+YsyKWGKEo3+yTWWAPcv6LTfRt33i0bX6+BP93yxufLjPr
         uPbUCzBQsFDh5kSthF+t1CAhu1RC+mDHRvSC58kuh416BnHk77Wa4VuyuGlSqmq+q0TR
         EFT1+Mqc1X0VH0X5uMe68a6aHGI3ZX03R0KhASHOmhHQ4jNV9ormvbRfOMwV8RZouEq9
         KaMA==
X-Gm-Message-State: AOJu0YwHX4YvNkknhonEZXQ01O8nutIugoZOWpTN1DB6rYv2TS0t99TP
        kERtDTF1nZ4TQzAwIh6g1gaquLLXOHS9cMlmwA==
X-Google-Smtp-Source: AGHT+IGTDr3Dy7I+cobweHOprEBzHrOm5Ywphx1rZmAjGdhNhjk6+hzphIqVJ9sY25UCgk80Etl7sKAhXVjZ5VgzNA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c74e:0:b0:d7e:add7:4de6 with SMTP
 id w75-20020a25c74e000000b00d7eadd74de6mr176757ybe.4.1695023250077; Mon, 18
 Sep 2023 00:47:30 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:47:29 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJAACGUC/53NQQrCMBCF4atI1kaSmVqtK+8hUppkWgPaSEaCp
 fTupt2JK7sZ+GfxvVEwRU8sTptRREqefehzFNuNsLem70h6l1uAAlSVRsmv2NvnIF30iSJLco1
 dTv2wNQ/cssxd6soopaFoUGTqGan172Xmcs198/wKcVhWk56/fw4kLbV0gHCstFF7o85dCN2dd jY8xLyQYI0KWQUHVBpXYFnAj4prVMwqHq125uBAHdovdZqmD1x8BOWFAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695023249; l=2257;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=kSqtPPjVErEzvTmLterf2KWiZWVkSR+ZWtp6NzTRscs=; b=vfxI1CKO/Sfmoxxp4Ftnt5VToso21f8QPC12xv3gdJV9EkfnC79IrQNuVYp+rHdeqjfq65Typ
 /UcH7t3BqtxAMeMCPBoIWe1CJRAJLMbyKaWbgWJEW90cBLlyw2P4GbL
X-Mailer: b4 0.12.3
Message-ID: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
Subject: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We've already calculated bounds, possible truncation with '\0' or '\n'
and manually NUL-terminated. The situation is now just a literal byte
copy from one buffer to another, let's treat it as such and use a less
ambiguous interface in memcpy.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- prefer memcpy to strscpy (thanks Kees)
- Link to v3: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v3-1-38c1db7d207f@google.com

Changes in v3:
- prefer strscpy to strscpy_pad (thanks Tony)
- Link to v2: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v2-1-2d2e6bd43642@google.com

Changes in v2:
- included refactor of another strncpy in same file
- Link to v1: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com
---
Note: build-tested only.
---
 drivers/edac/edac_mc_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..5116873c3330 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -229,7 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
 		return -EINVAL;
 
-	strncpy(rank->dimm->label, data, copy_count);
+	memcpy(rank->dimm->label, data, copy_count);
 	rank->dimm->label[copy_count] = '\0';
 
 	return count;
@@ -535,7 +535,7 @@ static ssize_t dimmdev_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(dimm->label))
 		return -EINVAL;
 
-	strncpy(dimm->label, data, copy_count);
+	memcpy(dimm->label, data, copy_count);
 	dimm->label[copy_count] = '\0';
 
 	return count;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

