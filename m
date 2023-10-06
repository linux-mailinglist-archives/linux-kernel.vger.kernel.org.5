Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736C27BC034
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjJFUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjJFUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:19:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF5181
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:19:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6219307b2so18914905ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623544; x=1697228344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5f6ytO4v8vRnOLZhCY/GWjs+tAFnZkSFkkdvYDNCuiM=;
        b=TaI8cg108Z+FMYXbLmtGXzt85khSvCQ8ZqpzT3S5C0ne8ixhqMJ7RNhBEtYJHOeydC
         YJcsNxvGlw2FmWA+n5cB6Qm+GrbrNTNCxBCD7TICWsP7rViIvVK03P/rb40VesaRN+RC
         IcKZYsz7m2dcT5K6DXy5FgJ7Zr8XXln/ZZNOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623544; x=1697228344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5f6ytO4v8vRnOLZhCY/GWjs+tAFnZkSFkkdvYDNCuiM=;
        b=NBLhjOWS3ffH8q0M5gZj0bRkJAY76PxUHVN7pBS3uPhc692MCP+rhdTRKJhk51PiDU
         6u0+XdlVsziEfswGRzdaZazeJGrBUx+6BgHdM4Vq4VTqdPcuWiS9c5B0667XNiZFx1vM
         e91DRz2FnDOMBDKltnXVoAedBR5LXXM8h2pM/2DVVnghqcUx9OXuPw5zBDGxqgFYWEmL
         HbBA13Fsd/bQDhChAg5u5AGv/wixWelLkD+BVRKMojGUy+aFwM4eJqllcnL0Zr2ORRnZ
         K3hPQFPI2UQTa87yPYBi8j4zLuUY7lbWSkwFk6GtkN9t0x0oxixPtVc+6BIjVlcNTSSK
         /qxQ==
X-Gm-Message-State: AOJu0YyM3L+3e1pxJrIiy0Yyfhj7OxWKh7GLe0GHozA22PVInY1YsRIr
        27gTenVdCnwQ/qpr/ayXFLisUw==
X-Google-Smtp-Source: AGHT+IHoIlMhgrt/e6wSDVo6U3GrZoPZTlLlZDAUuVIjDuJVhWRmiaJrCWW+kz/LaH09wQ+DUjWSpg==
X-Received: by 2002:a17:903:1245:b0:1c4:4dbc:92bc with SMTP id u5-20020a170903124500b001c44dbc92bcmr10579883plh.16.1696623543892;
        Fri, 06 Oct 2023 13:19:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001acae9734c0sm4331895pld.266.2023.10.06.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:19:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] wifi: intersil: hostap: Annotate struct prism2_download_data with __counted_by
Date:   Fri,  6 Oct 2023 13:19:02 -0700
Message-Id: <20231006201901.work.278-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TKH2rwBEryE3wL9UTdezXy/1pyU6gGSThNovHiWR+yA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGu2xaMzE8hOMdtfFrRZu2+Af9UD+Je6xgVdx
 MTm5JiaiHGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrtgAKCRCJcvTf3G3A
 Ju49EACitXCernnFJ9biGqz8FuXcSt+CYk4lCp82ncDmztIE7w8s7PrVYr3qyIXD5St+yemEvIY
 8+TFJqHuSJ+paWaoNHAhsxTg1r09JWvOimJUZ3ElMl6n/Bd8/pxwY1ZHbmnlgOkLvs8+kXiYhfN
 /6++V7c10DTQExTdfUBlANEEoIZ8mQdJEHPv6sbSbxYOFYQeKo4XW3BxYi9WU4g1JcCmoRSNQB3
 /k0E9TD8cAbbKU8FvNLEMCG9ME9FlhoA9yskpT6t7sTt4eBqzc1XNpXHTEnqwn9kHsRmi2WaUui
 vCgEF5gre80jNXK/sNllBjTiVbWYgBw3dyX1ghrHZMJmec97kDFi+IDdwdp9X68JKFcIqwEdM0i
 eJROy9QnWw9Rqo9gH+mfkop6wvtjTIlAfOTHlRzMvS+rIXhZAdMu/q88krRTEI4Q39mFJnxOuCE
 gOHoMiSxFoo+Lk8jQ4psIWfiq616RjfdOkBeWatRJ1SXz5clGVKm/GIjrmAUNUfQQ03Tnnj08W3
 YQzgJWjH7EcBu0Yi0xiAELx8XW4MBy1Dn+rlcWlyOXyMd0J0W3M0iPxQD0ttRrhHVa/pILy9THj
 ACXphBwkKUpFySPa87ZUKJkkZETjbhD+ROuipwdrpc9vCOeiP22iA6esHKK6LteyO+UPePjIBJE
 ouK1x0v ulZR6wig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
prism2_download_data.

Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intersil/hostap/hostap_wlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
index c25cd21d18bd..f71c0545c0be 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
+++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
@@ -617,7 +617,7 @@ struct prism2_download_data {
 		u32 addr; /* wlan card address */
 		u32 len;
 		u8 *data; /* allocated data */
-	} data[];
+	} data[] __counted_by(num_areas);
 };
 
 
-- 
2.34.1

