Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1378B77B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjH1Sos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjH1SoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:14 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478CB0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:12 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso2581443fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248251; x=1693853051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgFnNChBwcTiKeUa47qLSJ3+y5tq48ar+mqpea6xw3o=;
        b=m+JJ9p9W5ZEw25kxIfUumOUfiBD2gSE1elhHLoYbAZtF4WzvKYMTDpvrp5lMeDq542
         20XvSvtYU/sx+yl1YzFNOXJdby2OxCz133IS+H1XNQMpCb4+vV06B0K1sRNtpkMHHEVn
         Kolt4h8rauFNyZlCFtgUqSlIYU2KVCM+4fkLM6uENxcAgTIVLoZSOLq0sEUJDh1C7T+n
         x/+WstWv7EnHOiBP0Gum6f/Tc6qNUIAofXG+LChq06mFwcQp+M2H5oQIb0hIvb315GQd
         bTLTR6U/WGGh/DxxRMLuqogUv/f1h8xgmjNhh+U1iYVoevKjvYqrLjUKyhViMDu+Lq+G
         CEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248251; x=1693853051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgFnNChBwcTiKeUa47qLSJ3+y5tq48ar+mqpea6xw3o=;
        b=eETuoC4oaidjUrcYda+F77VW9mjxocHO5ukpuoug6zpI8+/2Ve0AsWFmcg54DOXvJ0
         QNVGKRPfb0Fxg718xTg+mFCOvnHmVFen55l4zUpYMXhXIX5Eul3hAbhUcfdTUTKC71ok
         fquFFH/5crsWA4ebnhRIY43dN8gRcDFuXOlKup2qSWVvGAo4lZnR/uxQcqkR74rclgzw
         qblyqATYs/V5dwu/x58SNwqFf6No4vtQH6DKVbyMP1QIra4UAeWv5vLvgUO4zF2AapFQ
         JgaZ+oyclE64gzWEiWJbVBdwtld2plEfn8XtKSqoFDD8kowApCV0KlV36fbxO8MQhR6m
         0eWA==
X-Gm-Message-State: AOJu0Yyb8gw4dUJjNR/aeTY5anL15B934KmjY+ap+TZZCrAho07/6kQ5
        uEjE3HwfttUfA2ok/C6dNUHPEgeUMS4=
X-Google-Smtp-Source: AGHT+IFM0sXQ5G5lxLZ02JJZWjy/muQx+1MPzsLF8b0XlOH3jMR7cmqDtQIfae5SbOppmQUvH7M3JQ==
X-Received: by 2002:a05:6870:1695:b0:1bb:c50d:7451 with SMTP id j21-20020a056870169500b001bbc50d7451mr13902536oae.46.1693248251417;
        Mon, 28 Aug 2023 11:44:11 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id dt37-20020a0568705aa500b001c4fe8e78e1sm4595312oab.43.2023.08.28.11.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:11 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 10/12] bitmap: separate handling of identity and remapping parts in bitmap_remap()
Date:   Mon, 28 Aug 2023 11:43:50 -0700
Message-Id: <20230828184353.5145-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
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

For unset bits in 'old' map (identity mapping), 'src' bits must be copied
to 'dst'. Doing that separately from remapping in a for-loop has some
advantages:
 - implicitly initialize 'dst' without calling bitmap_zero();
 - optimize performance of handling identity parts, because per-word
   bitmap_andnot() is faster than per-bit set_bit() in a for-loop;
 - make inner part of the loop unconditional;
 - when 'old' map is empty, new logic simiply skips the for-loop part.

While here, replace set_bit() with a non-atomic version, because the whole
function is non-atomic anyways. If atomicity required, it should be handled
by user.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 50385d61e6ea..f62ea97e942c 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -996,11 +996,10 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		unsigned int nbits)
 {
-	unsigned int oldbit, w;
+	unsigned int oldbit, w, n;
 
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
-	bitmap_zero(dst, nbits);
 
 	w = bitmap_weight(new, nbits);
 	if (w == 0) {
@@ -1008,13 +1007,13 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		return;
 	}
 
-	for_each_set_bit(oldbit, src, nbits) {
-		int n = bitmap_pos_to_ord(old, oldbit, nbits);
+	/* Identity part */
+	bitmap_andnot(dst, src, old, nbits);
 
-		if (n < 0 || w == 0)
-			set_bit(oldbit, dst);	/* identity map */
-		else
-			set_bit(find_nth_bit(new, nbits, n % w), dst);
+	/* Remapping part */
+	for_each_and_bit(oldbit, src, old, nbits) {
+		n = bitmap_weight(old, oldbit);
+		__set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
 }
 EXPORT_SYMBOL(__bitmap_remap);
-- 
2.39.2

