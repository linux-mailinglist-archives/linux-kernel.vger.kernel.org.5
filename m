Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081A7528A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjGMQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGMQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E77359F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3466725f0beso3960465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266209; x=1691858209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vt/wHfetwQDHpRz65Llg9LjGES1lnjN8dFqGOHt2Ac=;
        b=glp7P9GjRU67Gp1MffApNvQw8LEldcVlfVMrc0FYDz/Ji+gCup2prH6rGPmMYwhPQ9
         8WmCpif59LAubxHCev8KU04P+nmlye8BjKr5dbHWKECz/C7PeUWtC//KYGEmzQEb9J5i
         xtD9nlmLiOIczFi9lyOuv8b31P3RMMKazReNtv96JbPeII5OObkeKXmXw7exZaQEfvuj
         v1/Z6fDnEonb5+7mgIbJVB0k+Vd1tUMKG8fUGg554pzJ+CL03akaAEDnrz7cYQgr7eTo
         bW3HJnaRoF5cyZgslcOlYe9DCDbIXQRz04Y4iJ+UPR1IJE/cvcDIMLis/yPM3ve1fcQA
         LLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266209; x=1691858209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vt/wHfetwQDHpRz65Llg9LjGES1lnjN8dFqGOHt2Ac=;
        b=OvmDmXBcqmuqSTX6xY4VwJ6jHn+cCNosr0E+NNCzIMgnqGIHupV0sjD2WDtDvwI/kD
         cUJV3ejlju/1HReR8Yf9JRDR4HjiKmPd8SVoQNcvR//G2rqycIQQ1qUbKP7pJXhTqxYG
         +gHYYHfMYNudAYALs4VDx6xMY2aPQ6GiTYo3+O5tdeELK1moQSS3LfDQ3ufhhNwdtjHf
         VmvuDt+wF1BPUt04PCYAuULeljGi8DAILgAHECFVX/8o16VINE1Imwne4J7QQh28M09K
         a/6eHFtmJlPc68Wk24rjDZ2PMx0QIPMf18rLizAnFJnixPJxQBTMQ6s5J1XyxrJsXBYt
         Uutg==
X-Gm-Message-State: ABy/qLaHdMBsDCvc2bCKM+VTglZK5yiOK1QnrCUrghExz5TuE71Sw0ZI
        b2R1dDzbRCC6wEi//97H53M=
X-Google-Smtp-Source: APBJJlGjqgEAcsN5h6ZfXb2PbVphArrccvvvD1WEJPQj8xEO/XamMG9APO5ITE1rMXWOtSczogeXdg==
X-Received: by 2002:a92:c6c1:0:b0:346:5aeb:44ec with SMTP id v1-20020a92c6c1000000b003465aeb44ecmr2256251ilm.22.1689266208806;
        Thu, 13 Jul 2023 09:36:48 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:36:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 03/21] dyndbg: make ddebug_class_param union members same size
Date:   Thu, 13 Jul 2023 10:36:08 -0600
Message-ID: <20230713163626.31338-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ddebug_class_param keeps a ref to the state-storage of the
param, make both flavors use the same unsigned long under-type.
ISTM this is simpler and safer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 061dd84d09f3..dc41e70dc2e1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -122,7 +122,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fdd6d9800a70..22a3182bf89f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -795,7 +795,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.41.0

