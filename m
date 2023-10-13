Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339757C9109
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjJMWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjJMWuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:50:25 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEA10F9;
        Fri, 13 Oct 2023 15:49:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3573fa82923so10020235ab.1;
        Fri, 13 Oct 2023 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237338; x=1697842138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LQP5MFDhA+xfUDGLuGe24GCmwsysAw7CRqOtSg8az8=;
        b=ZZbXOhW7JaSsN11r5F43e857Af14VhSTciXLWgdDpxfLgiCpc6mZv5X1u6Hz5wCvvg
         p70I939YzL3nRYnaTTUnkiNNWtUphXYrM/TNbKyuoMyv2R7Q7fcf/FW0LnVTY/zpK/82
         EPgfmuTaL3thd5Va8v88yHCyVOlsTP3t1LTtUdu9eksd1M+ibD4NXgaG0i4y+k91ORvI
         Qr3L5xcdP13FVT87OwTbh3mYuftcFR536ntNIZHIEkD01jkeXTdnuhjL0tDGVQYWJ9xL
         6qaqkG04kBgCFTQznbnpmWzqe6iBqW6T4veGirvACPK00hRacuLNBpIcqCAoney6w9LK
         3K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237338; x=1697842138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LQP5MFDhA+xfUDGLuGe24GCmwsysAw7CRqOtSg8az8=;
        b=Pg6rRsfa7fHJ+034jnLE2FAJQ7CPeDfGTJf/xoj+Wa7eWNX3w0PEC2TU2ZY4gn6U5C
         CJ9oGx9WTkkg7gySbAvtU+BWxZmPvGaxK4RVulGFXh07oFdRD9jixIP4RtpkPS9r5U2o
         9SaMyMbsodhm8kP+8AC5hjTLKLheodRwZN7PQPJfiDODS03eAZFl5ZlHYhBPBPEdDFkX
         ig4ULGlJ4dz6KYBOm44whotPwUsEultq3U52IK9sDLVQllj8cnY4JoE1G65lpcXRhX1L
         J7sfJ2jfp9yh8BWwj/Y0x7gtbNNa3f7YuIg06o67SY+RUILGqCLEU6YAtUNLkogrMEQn
         FGEw==
X-Gm-Message-State: AOJu0YwKfcltXrXuAMCs517ZSstCvElcjgwbCAaAev2RuTI0JN8musDW
        uZnfQ8BQ+ArbHgUs287WvM/DdX/WxNkQ3w==
X-Google-Smtp-Source: AGHT+IEJ4ihDtxg4i0f+O3a1nP1WX/0PhyVsSYrOk6CkMFZeWPrAYYUPoiqiZdr7DHr2MyHDmzJNlQ==
X-Received: by 2002:a92:c269:0:b0:357:5234:802d with SMTP id h9-20020a92c269000000b003575234802dmr9521151ild.10.1697237338045;
        Fri, 13 Oct 2023 15:48:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 23/25] drm: use correct ccflags-y spelling
Date:   Fri, 13 Oct 2023 16:48:15 -0600
Message-ID: <20231013224818.3456409-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DYNAMIC_DEBUG=n

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 215e78e79125..22b1984cc982 100644
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

