Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AEF7CE3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjJRRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjJRRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:06:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D983126;
        Wed, 18 Oct 2023 10:06:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a26fbfcf8eso283859439f.2;
        Wed, 18 Oct 2023 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648778; x=1698253578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEjUcd2gIGh+rcuXSmEeq7H3LSdL8L2dg7mL1DHpCLA=;
        b=maMKkGaV4mxX/wucP6WE+Q4mVNNfIDMwNHPyxzk3ze6HyqH+GDUcz6CWF1FX2xkm5c
         c3l+p8WZTsF9fNZguLM/mnFLB0je8RyzSJUrJ/dMoWaR8AOPMBh3OCyTkFLsos2w3uAD
         Efo1ctAsf5dHAyROhmXlWFL8G5gQIUQgz1AJRWwbC87jhT2LYAbapMlvLnze5mjqMvvd
         8so+7d5ANe3W9dYQ/wOOjorbx0kFQ3+qthKmJHyEYkbWnnjPIjyPdX68zITMjayMTyYL
         O36iezsOSwYIDDr85LigLPrC0ut9OVrpPEL607/68Zkh790MJuY73XzdGu2kxgu6lUZl
         A4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648778; x=1698253578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEjUcd2gIGh+rcuXSmEeq7H3LSdL8L2dg7mL1DHpCLA=;
        b=LbVqRQh2d9rXuNpA9RgWeA8C+/E+/5dHTFEe7wlEAwC4lmnA/iY8LAE9PeFy+/+NaY
         dHBnPlE8HpwBPueBOJZD2f+eIlqdSYVzSpPKsXkFbMBPAUlGEkyoSP8wcmBe5i8RexuW
         z9LDigZMPKt6fVLHr/BB2E8Q4D3DXM0MPZRS8eSE9wi4soFafVI6tHdTEqk8TJbZSayP
         nwFU7rKcOzZuJ5E+7J5f7ShX2sKGw3XZqzZjnBjfdy81EuaCTV5M2pun4OHaeL7r0+Ag
         fT9sHoPcoopDnyAv5018VpGNOPAgq+afwyYY81lgsbdRaitbrNlcz/JypDEg6VBmQM9l
         BbWQ==
X-Gm-Message-State: AOJu0Yzy0ujpawL8YR0BeBUyRv8laGetE0S07GHSBSg4vCBatFiWsni5
        srAuOHpS4rvlPmRW4uwoOpwj09xFpqvmiA==
X-Google-Smtp-Source: AGHT+IHiPCmw3qmoMK7AeF6o0eJf+It/UBfoaChJE/QZZEZ5eOiSjJ85hXm9m0W3TLpYoiqoPplX+w==
X-Received: by 2002:a05:6602:2b81:b0:79f:cb49:f476 with SMTP id r1-20020a0566022b8100b0079fcb49f476mr7627926iov.21.1697648778066;
        Wed, 18 Oct 2023 10:06:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:17 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 07/24] dyndbg: drop NUM_TYPE_ARRAY
Date:   Wed, 18 Oct 2023 11:05:47 -0600
Message-ID: <20231018170604.569042-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b53217e4b711..8116d0a0d33a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.41.0

