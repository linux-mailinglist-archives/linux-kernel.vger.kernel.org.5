Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE976093B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGYF3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjGYF3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:29:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E93E4D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:29:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ed230c81so4837602b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690262976; x=1690867776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JffUwG5326xuKPzlEojNAz+P0KswaZOylMYMK9oigVI=;
        b=Puoaq6MlxKFy+9BHEaSqKQsnkMf3TZh+ZHQCggaH7fm0vvocL/n5gTMYzOzB4XlBTH
         7eScle8E3XsXUwItonwl3oZfT5EGkPq4deDf2fmEYSZ1qvI3F6TTCAgizR+aHfNJOaOW
         zJy7xZhu4AVdfqBRg+4l6BzpXPaYKYJtbbEiFYjeewtsNHiOK1MgPyG5jIwgGbX3MxDp
         C6BaKpqCxfcrAUv0C+M729VVUam8g3JB+Wcg7A7kH+bCILSsCEshrcvZejys5KFUCNrP
         Qwy9tQqxZSvPLew8hXVjBogQ0R3/PJi+o8Qt5A6h6xe0XbGPX+Gr99ifiL+vtFTCxWJu
         WD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690262976; x=1690867776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JffUwG5326xuKPzlEojNAz+P0KswaZOylMYMK9oigVI=;
        b=ah4l/BS9ZSlEOy0h6EHrgmZkA3dm6l3RMjSUg4hMKZAzBzPMqAh4mTLcykNnbSz9Ho
         VX4GRL6Sw/qKjaP/85QIbyw/m8nmow2NC6uiztB0QLo4i7789TO3wss6AxuixkOWQ5k9
         NfFFgcsUiTUnvq5k1kFKhvyMwY8c3hO9c/i0oDAP+gGPknnQ6Sc884AU9j/1uipk13jQ
         wEfKmLoQW6AmqeCEtq57Yv5JuoFp4YxRU88rgsVbDR49mqz9eh3l439z3HQUoqEcdt6e
         7ck3CTKTU8bOFWHAezodV2ZYyctLDnH7eKfb4U+7SLHaGmnfFucSjSDmwXxDQSt29bWb
         02wg==
X-Gm-Message-State: ABy/qLYHGyVqxa/BZ9svm/f3Ztecft57+r4AmuEeg8BMY3TOpoi6g5wl
        SstzseB4ivCVAD5Ft1U/31PC7g==
X-Google-Smtp-Source: APBJJlGz3kXzSjbB0E9FvWZVqQFWKgwDsonouogzNgTYWza1EtbTAGTPVNlmvSnX4SRgOibbs/IMIQ==
X-Received: by 2002:a05:6a00:1148:b0:641:3bf8:6514 with SMTP id b8-20020a056a00114800b006413bf86514mr12784986pfm.10.1690262975805;
        Mon, 24 Jul 2023 22:29:35 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b00684b64da08bsm8634597pfh.132.2023.07.24.22.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:29:35 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] PNP/ACPI: Fix string truncation warning
Date:   Tue, 25 Jul 2023 10:59:25 +0530
Message-Id: <20230725052925.1712680-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reports below warning when building for RISC-V.

drivers/pnp/pnpacpi/core.c:253:17:
warning: 'strncpy' specified bound 50 equals destination
size [-Wstringop-truncation]

This appears like a valid issue since the destination
string may not be null-terminated. To fix this, append
the NUL explicitly after the strncpy.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pnp/pnpacpi/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 38928ff7472b..6ab272c84b7b 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -254,6 +254,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	else
 		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
+	/* Handle possible string truncation */
+	dev->name[sizeof(dev->name) - 1] = '\0';
+
 	if (dev->active)
 		pnpacpi_parse_allocated_resource(dev);
 
-- 
2.39.2

