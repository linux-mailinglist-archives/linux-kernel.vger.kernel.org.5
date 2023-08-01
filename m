Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032A76BAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjHAREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjHARDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:43 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CF2D64
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3490f207680so18531545ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909408; x=1691514208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge7HQUHFN0SdBhoqRDpb0JNuijpwX6fCYvOeNIH8KRc=;
        b=XoYdmGsTMlulPJct/ABIxSbZoK18Cv7kP1AzUiL91Yb1nBSLYcbtqRKN0DXUroyAVV
         cJwwFC8CBFj9X03dWGM6SvnUMtaaceLMZumTKE7ZHFOdLj7bNXaLe5gRhRFvIsmdzHv6
         uyiquPu8kk/Jiw/7Mtc09FZ3OFL878XoSThLg209/jN+YAZmRrzXtgnD2WTvnM66cAKF
         orQDSxpF0LVVq+Gl7nxjDYQAXPlmL1CqPZCTzx+ZGHsK2qQp8+4BB9E0+G1yB/CqRVrU
         3wXSCYp4vXCaivLas3bj6YihtkUGtlt6mLnqHJFACdc8mtkUew8ev/kTRKklkmhTG/ZQ
         evzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909408; x=1691514208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge7HQUHFN0SdBhoqRDpb0JNuijpwX6fCYvOeNIH8KRc=;
        b=DaFT/xiJ8eMFPwEETX3r/oPKxWlf3KEFbW2wvO/6FM9aQL1/+1Alv7RCLmz+08KkUI
         YiztWxeVqKzCeJ2d6Q7f7hBIWNbH+8GrgDgKrET/fRwxD7BUzrpdYEg7Ew3o+dbk4lLw
         AEP3NwNQoA897GqfSXjN612bEDbrPN2OHrS/+fklKagfHW1KZEb3ethWkkc9sYTBeAzX
         lZ4u9EWCHtmPebXkTtJTI1DMFd1YqCaqF3M4ABZFWF9SMgOcN6Wo7V1WEZDwEr65mzdL
         S5wiSwdZntA8S7JCAKvuvbDBRvIRwhAqe8djIBB8QmNsB6n4B7tCDkj8MgHzshfD96JZ
         OpPg==
X-Gm-Message-State: ABy/qLampC4DqM/+4FDj+ifKNh7dwIW9dWGreSeztNkn0TuoV/7oDWGW
        axRdaP1irRcKb+DJU4ZIzQg=
X-Google-Smtp-Source: APBJJlGltELSLt9anu8HDYWhg8avza3TmSZ4hq49jTZpdTl/+zOZagkQpF4b+AFSmxescLjY6zVaNQ==
X-Received: by 2002:a05:6e02:f44:b0:348:e180:831d with SMTP id y4-20020a056e020f4400b00348e180831dmr11360972ilj.20.1690909407776;
        Tue, 01 Aug 2023 10:03:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 09/22] dyndbg: silence debugs with no-change updates
Date:   Tue,  1 Aug 2023 11:02:41 -0600
Message-ID: <20230801170255.163237-10-jim.cromie@gmail.com>
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

check for actual changes before announcing them, declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2a5cbb68d88d..a8973d1a6896 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -590,7 +590,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -601,8 +601,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -617,8 +618,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.41.0

