Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C57528A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjGMQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjGMQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:10 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6CE3596
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:47 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-345e55a62d8so3752415ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266207; x=1691858207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EpDVIlDX2H9hcBKUU2bnV2uAgz8tLVHVeXAEtG+jYc=;
        b=ScYmlxUqCGHtoYkCe/XAPIYLYXG3kX1g+sGc64KIc1SPlphq1iH3iLFxyNaQBB652f
         hklDrCTTYlW92m6CVnwtS0cEz78sbOuxuzeOu08ZcspU6NOI6P1F8PdWKgGbnFtecvzS
         GrmN5EGlNJ/oBdbvs9E6fELTDXD4FiHOtHKM/Lp3fAxM9aeJsDhGjW28UGtL3zIjYIjB
         enDjJsx+6UOF551dJI3KRt49ObrxSOddSYnnYM4BpZp2Nst0oOcMQVvPoYypaDWrC7HK
         D8DLgRmFCnb4Np40k53LjcQDwnJALjI4wEx5gmjsmbmyWw25obaPUSxuiSCu4CdKYdDP
         ZnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266207; x=1691858207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EpDVIlDX2H9hcBKUU2bnV2uAgz8tLVHVeXAEtG+jYc=;
        b=gXHLsi7LLHWdMM6hGI2r1MQDMEkGxMSnuYEbvdckHb0gDrSyrnV/yPZ+4mPOeRPlaO
         3dPQoETsn67dORiepc7PFdSTpJLCyou8s+f1CwAKs+yGmRP5f1OBuZbHTNy/Y9xdlLvq
         P4/uIQqNv+jytZ7MB4Q3Dg0u79EGJapRpkJhqjcio05Iq9sdULuNa1XHKwMcfHNWtGeI
         QDnYcEmPO1Zp8UjjB756By7wzskvu+zRlf0fe4fEHjcjIuESvJ7iXjLbVTUGlr885ld5
         QcuqmFkquTemgOMf71zQRA43+zliRbAjL7ekvaiYuEUOEML5+tARYIvhB5hcHTeacTLz
         suhQ==
X-Gm-Message-State: ABy/qLaui0JftpIWbH6kxVvGxf0Wv8PgKdMVzHxUY0DCs6Zsu8FkHa0M
        D3kKLYhc1/uc2zJsfUHLXT4=
X-Google-Smtp-Source: APBJJlEKbFktiFQ/78FtlpMN0cgiNpYvultfFSQZab8UdWpq20qsbPfbNKW5a6SBlQ9oXjRJlEalhA==
X-Received: by 2002:a92:d4cb:0:b0:346:7502:aeaa with SMTP id o11-20020a92d4cb000000b003467502aeaamr1751455ilm.18.1689266206905;
        Thu, 13 Jul 2023 09:36:46 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:36:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 01/21] drm: use correct ccflags-y syntax
Date:   Thu, 13 Jul 2023 10:36:06 -0600
Message-ID: <20230713163626.31338-2-jim.cromie@gmail.com>
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

Incorrect CFLAGS- usage failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
but without DYNAMIC_DEBUG

Nobody noticed because a larger regression emerged.

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index a33257d2bc7f..670bf046019e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 drm-y := \
 	drm_aperture.o \
-- 
2.41.0

