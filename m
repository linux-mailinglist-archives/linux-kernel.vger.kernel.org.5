Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3627DA8C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjJ1TFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 15:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1TFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 15:05:37 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B05EB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:05:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ee23f043so25966307b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698519934; x=1699124734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWIdgRFmHPKvDHRv6SpMLld7lnUsj3xAHGK/xCXy82A=;
        b=m6ryLtQSiXg4dSbnpR7neKmb4+uTyzLGwooeb3LGKbTBDDIlcHvN+QpvUMJrwxEJm1
         qRlpOGKW/q70FUuISvesyHjpZ5VPcog/D5xETIIZ/xRrD63WkKvgUiGsxY5T27bIfh30
         BxRgA97tstbxJIkbdlz+sM9QbVRv2tGuz4T9+FPhP2LvcXVHYvQ37OVuOZItqJaHQbic
         BgVfsu7uhPHSXi5UT2k+HiKJr85kN+QP4NM6+0+TiIaXoQzrt4HpHxnt5/ZtSjgv1qc4
         3TJ7am0L4w4bOnF8PvsnVF+JOjRC+2qzbk+ixC+CxB7NfRvhMcgwXr9F/Gp4xd2xAeMC
         RRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698519934; x=1699124734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWIdgRFmHPKvDHRv6SpMLld7lnUsj3xAHGK/xCXy82A=;
        b=h01xQx8wl0SmGUkevjjX4CGTkkcgnk7PbzPiAdASk+zW0UPpu7L+1RnQm60iGboyxD
         87ycVPy9O8BOrx3iy8NDl4FVlT30ytWAe9IFyIBApavlEn8jEH4euYTclvpeJR8VmWLt
         WvDxwr23ZD4HJG+hlpD4QWjh8unA5emRfXnsMqZ/RZQihrfOpCn3EVWyQakp6NI4qAN2
         0MabE1fu/5OQPkBElpgWu1ETwzoS63Ab45K2q+ZuydTIB6PI4HBm+AhBxNednbjmtWZk
         YH2J7XBa6Wnfk8ZkN4vnQ3crjuK/LKUzqYhIQPEG20M6kszOR8VJ3OsWRN2RvGHak2aU
         J8ww==
X-Gm-Message-State: AOJu0Yy+IGQ+53b/uG2GZBP1N7OVR3kjQPuznlYrIFy6W9xi3bkkIajq
        uR5hQJC8Io6BkG9ZZEBfh/U5Xw3k+LxX3Q==
X-Google-Smtp-Source: AGHT+IHrYkEcI4lGnNKczgd7jKmjBl2FENry571J4NDiGCSS0z55WXV4VxfuaBzMq1fTTjksiMQJyw==
X-Received: by 2002:a81:e405:0:b0:5a7:aa65:c536 with SMTP id r5-20020a81e405000000b005a7aa65c536mr5224947ywl.0.1698519933977;
        Sat, 28 Oct 2023 12:05:33 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id o15-20020a81de4f000000b005add997ae53sm2119688ywl.81.2023.10.28.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 12:05:33 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] lib/find: optimize find_*_bit_wrap
Date:   Sat, 28 Oct 2023 12:05:29 -0700
Message-Id: <20231028190530.286300-1-yury.norov@gmail.com>
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

When an offset is 0, there's no need to search a bitmap from the
beginning after the 1st search failed, because each bit has already
been tested.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..241b6d028eda 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -405,7 +405,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
 {
 	unsigned long bit = find_next_and_bit(addr1, addr2, size, offset);
 
-	if (bit < size)
+	if (bit < size || offset == 0)
 		return bit;
 
 	bit = find_first_and_bit(addr1, addr2, offset);
@@ -427,7 +427,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
 {
 	unsigned long bit = find_next_bit(addr, size, offset);
 
-	if (bit < size)
+	if (bit < size || offset == 0)
 		return bit;
 
 	bit = find_first_bit(addr, offset);
-- 
2.39.2

