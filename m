Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3EF7C74AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442071AbjJLRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbjJLRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6DFD4C;
        Thu, 12 Oct 2023 10:22:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso48034839f.3;
        Thu, 12 Oct 2023 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131327; x=1697736127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=VmuarUcVVYDLC/7neX1gwKEoQ4RcbnPh4McMO7tHS7zIHCgSC+KwGWGi24xQKqQTUN
         xwb661R+xTwd8I3Z3Y3w0/fODeF/gLCMG8Hi+OlncLzq1jA23pX5sIIx2AOHpUiSI5Ia
         y/Z4RC6hFciZ7wmyr5vvk1A+Wtwf6VjvN1MnuFtCabueHsIA4HOACDgH3WtMqiqbrmnJ
         KDT8h/YMUBlM2doz9G4bEOzuF0TPhZBT650rwB8LAs0TsMkPvouqx9InY2HbQ3EGes5f
         iq9JPxgeWgvXVDcwmlpJhHzgFyfBefqtfJJ/yyPhVRpQnaRoxp4H7p38hoXVqyFd6I0S
         85wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131327; x=1697736127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=USZQj8IdRmYf7X3haK5FwWZ5p9Zh/vTTZVOE9AHII0ZOhc7U6Ogf1EOl23/MIx5iS+
         L+weBLK/xfoBlmNQU2ze6MZIdakJeuSaEQQsUuUru/rR0HAQnYslRg0fv8ViKJCdoJZ5
         6vL7SWuPpurksJJSkCSYwNg297gksQx7+5hQ4cXHvkB4tjqBvkCPyrlYRvxXWTFtkMHH
         KosVs/apDBzvGKkSnEq9JufsA0Szb4nrxtdek/VqF4xrNwMtEMFJ752Oi7M6kbMEJaW3
         DVJLcrlqzTIuHxmP46TjU390SgWUZeKvE8bhRJZLv3f5lYDzhmp8oCaUIsP7l9xscwJd
         J0VQ==
X-Gm-Message-State: AOJu0YyFYusD2GxWe7ShDfjQU/+LBMnT3ycxnxcKp7Drug1xCAsKxB8e
        aWZ1TQVz7buXQDpcNH0UwzYwTFgnQjQpww==
X-Google-Smtp-Source: AGHT+IFpbfRnBrgPW4IEW44BazUZxQseAXdtHGsGKsp7DLNKg8MghbtpPSrpD3uVR1lc7lXiDFp2JA==
X-Received: by 2002:a5e:8f4d:0:b0:791:2db5:c779 with SMTP id x13-20020a5e8f4d000000b007912db5c779mr30620110iop.10.1697131327569;
        Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 19/25] dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
Date:   Thu, 12 Oct 2023 11:21:30 -0600
Message-ID: <20231012172137.3286566-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
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

Reserve bit 7 to remember that a pr-debug callsite is/was:
- enabled, with +p
- wants a dynamic-prefix, with one+ of module:function:sourcfile
- was previously called
- was thus saved in the cache. NOT YET.

Its unclear whether any cache fetch would be faster than 2-3 field
fetches, but theres another factor; the 3 columns in the __dyndbg
section are highly redundant and compressible, but to get the
compression, we need field accessors, which will rebalance the
tradeoff.

So, for now, its just the bit reservation.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f182f95caabb..927cb14f24e0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,6 +38,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-- 
2.41.0

