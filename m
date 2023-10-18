Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D77CEB75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJRWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:48:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA19114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:48:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b3ae01c0so112044127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697669330; x=1698274130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=gInKwQPEan85wo+wHCJe1s91K8I/+OYBZigEUPoAf21eDXGWzAIBMH2J3nf5kqd3g7
         yKn49VFOaPzGPlZzrXVG6vT788Ngics3kvSkIiIdYxwDB/yD31OSAaMN21jGybJnD89x
         /938DYxr0UcAmdPfeSykAYcgByOFQDNDlS4M4LtZ3yc2Y9BMQ0Ri2WGeklOYf+Tj/wJP
         RMGLphqBHbTrS0IMk3tBXJjKVCF99bJ+h+2RIaGmrEo4kwLdMhj8IGajfKquEcJj7PS+
         WFikqZ1PXePbzZMY0bGcMDyhyp+XZ3T0V9TfzP6CE3uoqOO6RF/WhvEDPEfM1iMUTE93
         SAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669330; x=1698274130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=qfF6vOv7FZD0FIgMPkYdh1ncMvukR6zSUtOqXKWRt5qo8vxY5mwAO13fIed2RvXKky
         onIB8wn5SlPG1e5sJTb3Fa9TazLaARBQNVGfIrp5IlXB1KyU6C3pcQYyOExfIuadCGl0
         Ya9rSGkb7E2axRc9PG3kEHCWMZbVBVjerrM1czBj6fDza70HHwycswNdRHZD0SBV/Vtp
         ol0bO86ohuNqOVQna3ypexN86Yz6v7fGQtLjtSI2UztVaKOQm9owcke4pP12WFK+Ap8A
         zgzxLLLcjKhiF+WFh67HA2Rz55iKlFkUKVzZtow2NJ8AZ13KJ7dlNlt59tbYcp1pl0UL
         yMsQ==
X-Gm-Message-State: AOJu0Yzeluwwf2e3ARH+zmmI4TvV5dRz4ng06wscX+VmAYMxbcpe4Opb
        q81BU24rHUI+4yvzhiKRVkSKkGSAEFY+ZKxFqw==
X-Google-Smtp-Source: AGHT+IGqdbWqQ7PEH4cUhxYJPzQti8rdqGeesI2OpR3f/9GfHYGXO/4kPNJHLV8sRzDs+qy+E+CBZAMToF2ahSILCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:5217:0:b0:57a:118a:f31 with SMTP
 id g23-20020a815217000000b0057a118a0f31mr15075ywb.7.1697669330350; Wed, 18
 Oct 2023 15:48:50 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:48:49 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANBgMGUC/x3NMQ6DMAxA0asgz7VEDFRpr1IxhGDAQwOyUdQKc
 Xcixrf8f4CxChu8qwOUs5isqcA9KohLSDOjjMVANTWudh5t1xS3P44qmdUw5S/jstqOUxhUomH E1j2p84Goe3kopU15kt99+fTneQF0i0XsdQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697669329; l=2668;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eTZl8RLmSTRi1g6HBFXiHkDVcGwMrh/QN3Blnb4tlGM=; b=NqNL716tMxkz9di1bgPcw2w6eC4c776nurW+wFygYEOGZYbyCCVOYleoxDFKohV9u1XrQ7RvN
 UxB6tgf9Ik5CsmgFtVwMYknNxVzD3Jah1eF23yTnA5oMSFhciN+z9AP
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
Subject: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
based on their usage with format specifier ("%s"):
fabrics.c:
322: dev_err(ctrl->device,
323:   "%s, subsysnqn \"%s\"\n",
324:   inv_data, data->subsysnqn);
...
349: dev_err(ctrl->device,
350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
351: 	 data->subsysnqn, data->hostnqn);

Moreover, there's no need to NUL-pad since `data` is zero-allocated
already in fabrics.c:
383: data = kzalloc(sizeof(*data), GFP_KERNEL);
... therefore any further NUL-padding is rendered useless.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

I opted not to switch NVMF_NQN_SIZE to sizeof(data->xyz) because the
size is defined as:
|       /* NQN names in commands fields specified one size */
|       #define NVMF_NQN_FIELD_LEN	256

... while NVMF_NQN_SIZE is defined as:
|       /* However the max length of a qualified name is another size */
|       #define NVMF_NQN_SIZE		223

Since 223 seems pretty magic, I'm not going to touch it.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8175d49f2909..57aad3ce311a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -386,8 +386,8 @@ static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
 
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(cntlid);
-	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
-	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
+	strscpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
+	strscpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	return data;
 }

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-nvme-host-fabrics-c-416258a22598

Best regards,
--
Justin Stitt <justinstitt@google.com>

