Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B727AB8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjIVSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjIVSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814935BD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so2029146b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405262; x=1696010062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ISP2L+rvg6dxZG1wcmYnXloNsZywrTUtixv49IhJ0I=;
        b=jIWF4/z4UcLuiRz0wCvniJrPmxP3Z9Xk2oBg1jRX5yU4wYwfGGP/1BJZg2TWhJikah
         5clKmlgZHGFLNRHpFcSj682t3/0f1EFPjRE1yYxe3GMcAk0BgYOGVSupcP/q3lT7fST8
         er+emuk5vVib37xngsMQ973oBiMxxSXfF65B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405262; x=1696010062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ISP2L+rvg6dxZG1wcmYnXloNsZywrTUtixv49IhJ0I=;
        b=w0JdVhTJDnGEzc8yRiKATbaqV0TCGIduenohVjZxz1EYrZhkAFn+ZMmUGvlnt+iX4B
         cyodc8KFWBMmP03G4ZBRihx9xvPfrrxC06t5dz/6rvfy+4jtsgoeTwnOSoejg1WeOv7z
         bhKOBZn+ipFPOs8wm93dAlBq482VwvNJHrTxCEm0tpBwWo7soGFfBwcndDhXc/YmUxyo
         WPqdhiCWjNmj7kH/SSD/dDWEaIcpDjSkCvnfQPe0HBvGIHQhFfhDpORqEdufOUY9nG7a
         yw3U1k8WsiExg4HP9JpyZ6CuzPc9j5lpvke+Gjit1q3/Wy3EDLUEpnh/Ycs46cUYI1dz
         kSeA==
X-Gm-Message-State: AOJu0YxCxd/kMcxpvQCcB5FGwhpYH0xi+opy1flzE2xod8OVRg+JM3bl
        y3elYRAawyjHor7dif5KacV0T3Nv4lhShz6nDScMng==
X-Google-Smtp-Source: AGHT+IGxW0pO6A2XYuuil33uTylCAIbRaQSzobX5s7nUCpWCckLaGOgJJl/22O16HRisYCP+P0WYhg==
X-Received: by 2002:a05:6a20:9499:b0:13b:a2c9:922e with SMTP id hs25-20020a056a20949900b0013ba2c9922emr268710pzb.27.1695405262686;
        Fri, 22 Sep 2023 10:54:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78c07000000b006878cc942f1sm3457800pfd.54.2023.09.22.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Lopez <jorge.lopez2@hp.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] platform/x86: hp-bioscfg: Annotate struct bios_args with __counted_by
Date:   Fri, 22 Sep 2023 10:54:21 -0700
Message-Id: <20230922175420.work.701-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=keescook@chromium.org;
 h=from:subject:message-id; bh=kt0VlUdlEwKUKwWP1rv6tofv8fjvexz2uhyfkXWj6p8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTMfB+LYH5eKEwcBoqoFlTtLOyMMpn1kR2Sa
 TizrkR/ooiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UzAAKCRCJcvTf3G3A
 JsfnD/wN2QM835WwG5VD399xvmpEfqV/waSzTryLMYZxcqIlyuTG4pL75mWspCtqsPuHkcPq/5+
 dS56aaMDY1kiOZILGtGY/o+GWgizQ0X87eI7vpaVFKNq5aVB81SWua/rKAzQ02ogL1ld6i21Bax
 iKS3RQ4mhGVuAyMeSzgYg6LVxU7VHCAX1MzNuZBEbxxYYc9ePrN+y0Hkr39IRDtkwVWcx2PaZr+
 ZPLbM7Gr1c73OWGB0bhxLfHaX1rgfqmB9gXC3lJW/WyMNt2wnbyTplB/202KUySHEVGpzzl7+TK
 1cMerBWqiNFK3BmK1tZOZh3L/GUu6t+hXEG1zkNP3sFOGOsRItI8w2yDQEocODb2NVCQZr5t3B+
 HELziLz9sxbCa7uWd78WEaYlS+jm4KnMPuXwIOm49XG7eeyCEqDz1zHK07JijFrG3CMQkyWttQ/
 J92lXH7PGL8Jnme0WvdP5OUM1swG3A1kKndnO4G2vXJ464QIOn+OsvQC02MTg4EG2OF2cvXaXuz
 V7+ZvYpLopVQKGVbWWY5H2WfbsVTdPZQHrTdnHLHVkmL6vLAD8wnzqR4fR9rDCWgCGtAzfNnpDD
 MMUbIToTezIl9ipPdd7j5G99rxqHhdMNHOS6KM1DGgOhQzpxGIl2uXlE55Wb3yx3OZcsI/MIXov
 dMn7rbm UmQyK2GQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct bios_args.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jorge Lopez <jorge.lopez2@hp.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
index dea54f35b8b5..4da99cb7218d 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
@@ -19,7 +19,7 @@ struct bios_args {
 	u32 command;
 	u32 commandtype;
 	u32 datasize;
-	u8 data[];
+	u8 data[] __counted_by(datasize);
 };
 
 /**
-- 
2.34.1

