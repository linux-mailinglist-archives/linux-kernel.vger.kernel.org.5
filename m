Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F927A0FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjINVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:30:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404A2701
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:30:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so18879477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694727039; x=1695331839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHD/q/SJLFYWSfqzhKThHqH+If9tHeimdGSeLbCxs0o=;
        b=hrWZ08BykfiHG2QsWdmuUvMQq+1oJXqGe2HQuU9RhHU11cMPgYLCn9bfe7XN0ym5KC
         ntOOBLR7gL44pXPPuc2Vc4GsBjRFszkFHo3zLO/YJN5wmyKqQIHazj+qyPsOs5lxEyNA
         1vfiBQ3J0792zwRcznX6GdtdC8ZO+L0ZsFXCKBHW0F85BFR5f04Ahh43AvqiXW9fR1XD
         TqEtXzZFQPxOIzoVF0DopcuKQMpohK+BbNG7dbGJuwYekF3BbUSeEYTMJlPr+RN/xX6S
         mh/ZaaXte00KGx5kA+ZP+XExPWC08LaGFY7WoeUW+0VNpVU4XA2y3gd4kI73vNyqomKS
         62sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727039; x=1695331839;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHD/q/SJLFYWSfqzhKThHqH+If9tHeimdGSeLbCxs0o=;
        b=Rk+pOu1UYDnda8oCIAdCWY8ghoJc+nlL5j8LHdxrfAnGhHPjmB0fLOIcyfRBG6vJ4k
         FBolTl8OOhVROc5iDIeXBvm9Jb0O13pZCYt/z/luJXcKjC1jbhy+URgn1aP8bWa/PN11
         kjof7erJUyG9hCcpliOPyWrAD3YWWWb424CWjY6p5pRS1n66f33TlyqKEgPdMuQM5Qou
         yrbHCAV38h9r/CK5vR/ozNSDb8AXh573fCpOERa1fHwnU6rSkB7aSUK69fyEaKA+eZLp
         +RmQ8yPkgqyXkfHye+W5SJtVJr9r9KpUnsSL4+KdM3u+32Kias+/uK3jLfGP8MshLRMa
         xEmA==
X-Gm-Message-State: AOJu0YwzoqT3fFip7gbfARODvtcZgc+dNpGlf2qyohlHlRdkpWfycAKK
        f+Ux7Y2AVR61YeLWIY2G6yqqohgjk7AUgRddvQ==
X-Google-Smtp-Source: AGHT+IGX8yvrtUoKVn7mJlx7ANqKychzQ3OooCdQznWtzGJrkQcp6QG1fyYuUP8f+T6DjKoeAxURtoAR54eD/SD2gQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:450c:0:b0:586:a8ab:f8fe with SMTP
 id s12-20020a81450c000000b00586a8abf8femr176035ywa.10.1694727038901; Thu, 14
 Sep 2023 14:30:38 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:30:37 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHx7A2UC/x2NQQ6CQAxFr0K6tgnMqBGvYlxgKdhEy6RlJhrC3
 Z24e2/x/t/A2YQdrs0GxkVcFq3SHRqg56Azo4zVIbQhtn13RF9NKX1xNClsjnPKld+oSy48ZNQ iE9JLWFckvIRHDSme+1OEupmMJ/n8/273ff8B4I28qX8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694727038; l=1659;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Q5CFsZyxCfw6hgNgrBpo5UsVYRuZcWL5zSBOa/5AHCg=; b=J+RLdusJNzQ1fs2a8n+U6McsahNsvZ0DMJXnqsKtVDvGrjExGw+WOkTee3/eBqCw8pmFfoQkt
 3+dBjHWINIqCOHsLbFQ4KpmqaC+OrdCs40Utc/nsxWtXyWMQ05+y3O9
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-v1-1-dc3b3719fcb4@google.com>
Subject: [PATCH] drm/nouveau/nvif: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated and as such we should prefer more robust and
less ambiguous string interfaces.

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees NUL-termination on the destination buffer whilst also
maintaining the NUL-padding behavior that `strncpy` provides. I am not
sure whether NUL-padding is strictly needed but I see in
`nvif_object_ctor()` args is memcpy'd elsewhere so I figured we'd keep
the same functionality.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/gpu/drm/nouveau/nvif/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/client.c b/drivers/gpu/drm/nouveau/nvif/client.c
index a3264a0e933a..3a27245f467f 100644
--- a/drivers/gpu/drm/nouveau/nvif/client.c
+++ b/drivers/gpu/drm/nouveau/nvif/client.c
@@ -69,7 +69,7 @@ nvif_client_ctor(struct nvif_client *parent, const char *name, u64 device,
 	} nop = {};
 	int ret;
 
-	strncpy(args.name, name, sizeof(args.name));
+	strscpy_pad(args.name, name, sizeof(args.name));
 	ret = nvif_object_ctor(parent != client ? &parent->object : NULL,
 			       name ? name : "nvifClient", 0,
 			       NVIF_CLASS_CLIENT, &args, sizeof(args),

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvif-client-c-82b023c36953

Best regards,
--
Justin Stitt <justinstitt@google.com>

