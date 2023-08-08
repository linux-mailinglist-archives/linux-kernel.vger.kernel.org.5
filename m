Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EF377463C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjHHSya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjHHSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:54:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347763F5E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:09:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c10ba30afso10274566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514544; x=1692119344;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anuYTtEViMW4nrjJPfmB+dcKnLZHUPG9Gjj/JVLBORE=;
        b=Lc5swfM+NlsRGhTjqLhELMAOgb+MTGxtg4ebXpVR7pkAtYtfzbqAw5zd4Njn7Fo7Rd
         NeQ4MjilpD4r8Yog7m4bTMQ/0p6WRZw6rsloR0/+V+BgOUp03izG8RpsU/Q+8LmAb/GL
         u+bZ/KdZAD8fJT3bxxkAkKrdnBZMFnRJKs1UER37ADqFq0o7PUGiYvXO4e8BtIe6DfDK
         DUt3IkAzr1NuEESIDfsfq1mjAbMxLa3qaJzjjqiSzfDWmSqae3RG9hLWTUXex4yk2P5K
         u5fC0gBb/v4bYQmrbHzWF+vLKXEQpccOZssAk3DprHnCnBfkyXe/uhXro3tf08t9jJuB
         brhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514544; x=1692119344;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anuYTtEViMW4nrjJPfmB+dcKnLZHUPG9Gjj/JVLBORE=;
        b=CYs1Etw7FQF7JCAejone098vRpATouW8Om2trKcU0+9PFm8iMB7TBsFbrqMkr5IS62
         WIDB8by4JA9EI5TRM7P7FnKibpn2qmBgydV3GNUfsU5rogh9gVSCydmPNYs4C5FMnfw7
         LVJsnkBZJ5hbGR2V2TGxi3hfzcQaF0H7Lqxok6xNMQBA7qnEmFwRhhLjvsUDmDdq51cT
         ezE1OmynDEHhsPU8eZns+wHAFXOUgDBIB+eV++a8cmLAZ5qrw+xLk3UWvKy4nLIJ0rl3
         suK9IBkXjIzrlgZTVtOu8bVxwnq+SHLdqrOTXKOD5sba3NIPI1xiXo7a8XLCzIP7G/Vx
         6D0A==
X-Gm-Message-State: AOJu0Ywr68mORxzZJRku4XYyCSS70dE37/1toT2aEcEmYufPtojjDMI/
        /N0oUvk0idcuC+DFgv/0/qQ0+61im88mpp0TyAo=
X-Google-Smtp-Source: AGHT+IExib52NOOu+oE06KDhOXHVNqwrDLcdqVkpVygSHkJ9Hrps2AVdFNXnNOa2I25iZ3v1cJAjCQ==
X-Received: by 2002:ac2:4e04:0:b0:4fb:8aca:6bb4 with SMTP id e4-20020ac24e04000000b004fb8aca6bb4mr2837425lfr.20.1691486994246;
        Tue, 08 Aug 2023 02:29:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r20-20020ac24d14000000b004f9c44b3e6dsm1809545lfi.127.2023.08.08.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:29:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 11:29:53 +0200
Subject: [PATCH] MIPS: Drop virt_to_phys define to self
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-virt-to-phys-mips-v1-1-af6fcd45ed31@linaro.org>
X-B4-Tracking: v=1; b=H4sIABAL0mQC/x3MQQ5AMBBA0avIrE1SJZSriEXD0Fmg6UhDGnfXW
 L7F/wmEApPAUCQIFFn4PDKqsoDZ2WMj5CUbtNK1Mspg5HDhdaJ3j+DOXlDrlhrVW9PYDnLnA61
 8/89xet8PyclIPWMAAAA=
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function virt_to_phys was defined to virt_to_phys and then
implemented right below.

I can't understand why, just drop it and let the actual function
slot in.

Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/include/asm/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index affd21e9c20b..18ed44843541 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -111,7 +111,6 @@ extern phys_addr_t __virt_to_phys(volatile const void *x);
 #define __virt_to_phys(x)	__virt_to_phys_nodebug(x)
 #endif
 
-#define virt_to_phys virt_to_phys
 static inline phys_addr_t virt_to_phys(const volatile void *x)
 {
 	return __virt_to_phys(x);

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-mips-226e409a84a7

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

