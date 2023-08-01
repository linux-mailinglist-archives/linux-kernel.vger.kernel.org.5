Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680876BA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHARDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjHARDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9172103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:16 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-348de515667so25489475ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909396; x=1691514196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vt/wHfetwQDHpRz65Llg9LjGES1lnjN8dFqGOHt2Ac=;
        b=ZiaDkevfnJ+ET3/E1+KGU6hHq3/PIlb0BSs1FiUfYHGgnKdThqy4KHppHnLBhDBFAF
         F42XOPx6zWICKq8MmL1Y4zBPDdkSeW+oWkEEu4OeuQl1Y6VQa0S2M1kKxAcn9j0RsjXP
         GIU56DsDz2KKJDndnFBBaGKN2BLz9n3SK/t8Im3ajkCx/2Dn8Xo4OFSjREqh3wG1crJs
         7CtTADXR2se7VIj+DJfc2aiVwfTQ9FY8PU6WVP91xUCI512OIZBEAGf/u7C3IQHJTbNP
         Bzi9Ufp9dor29EQJyfvpPpLC7hQHrXvGVCzj/cvhXikXCJw/WBX5iQCithmQTAWVSOXr
         PyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909396; x=1691514196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Vt/wHfetwQDHpRz65Llg9LjGES1lnjN8dFqGOHt2Ac=;
        b=DXzGH3lisKIl/zgksVq1TwmQZRBevqLAoKi0uaskb6xpybYwwKLpY90jKBktoV9QQI
         LKVbQvm/AP0IzSggl0OUMN0cj2jEcBNSay11NyuNjPHTI9ZA7VNyhmpC1M6si31cUtJt
         pI4vXTG/a5imFb0gpfWeewhUl7iaNoMEjmJkQwIxa0E5FSrPz4DHORK8OUGpjosnjV3B
         CzcXh4ewAeT/1+UbQMIn5/h2Tlq9eafigEjEhwHjq3w5JhFCdKl7e67vYjHVWrEyfUN+
         0KhcTO8mg9edfZCi6d086BiLEMjPcABEP6nJ96rSTTxcOSt6TcIzH967cVbcWYHsmM2f
         ewQw==
X-Gm-Message-State: ABy/qLYYQ/YpKGnbXtmK0zpXX9o1CVnBACUvVevXusaWFznq+Z76tmaS
        HZp2avmMrevF53MrdLUcpu4=
X-Google-Smtp-Source: APBJJlFXRa1Etl6yfHFGR6ePAm5/gYzcKoBWdY+UiSYPpDx3PiIMvJYXjeJATdKSxpfNJXMYeySpBg==
X-Received: by 2002:a92:c248:0:b0:348:f4c1:4817 with SMTP id k8-20020a92c248000000b00348f4c14817mr13197730ilo.6.1690909395900;
        Tue, 01 Aug 2023 10:03:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 03/22] dyndbg: make ddebug_class_param union members same size
Date:   Tue,  1 Aug 2023 11:02:35 -0600
Message-ID: <20230801170255.163237-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
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

