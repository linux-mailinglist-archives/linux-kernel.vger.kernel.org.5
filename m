Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A429A7C9078
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjJMWsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJMWse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F2C0;
        Fri, 13 Oct 2023 15:48:33 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3573e6dd79bso9362465ab.2;
        Fri, 13 Oct 2023 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237312; x=1697842112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ctyB3lbzkdQhDzqOoTWBErv3Q5efkvJrKvFBj8oTC8=;
        b=ALL1cusBCMQf156PVG6PY61uRoMWmtHR61g7aArR/L7xPySuSlYhpspaINqaYfdOZ1
         kerMEXFlxeK3aeXn4ftOR1HS28sJlGXTCaC0sstXZI7FUvkKNC++8W+qmvg520HUUXc2
         GuxoTZjJ+C1qvjkWN3qXoUJuJT24UhyaE4xeTzT1k71vYbUQVeboMGqvbPEnV6edEvg8
         Aw8EvtRQE8OG9nqqByp+NRZ+NYgi3ZoICUWlB59/mh8oB8GAGBR7TytnfqUYJ4EYayRZ
         lqrEd+tt9MtjesEGvleykDavdqQSPBAOjTQo0YqG192lGijJBhUMhDdc9j1EY1uXc/lx
         YBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237312; x=1697842112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ctyB3lbzkdQhDzqOoTWBErv3Q5efkvJrKvFBj8oTC8=;
        b=v5CH7m0pA5LA7bj5Qq47L2PeU5kkjHtkpvqKZkhVXYUMUL+bX6MBITIkZmNuAShpcV
         7mvQwOSiUy1S8SXX+zSgHdMiVqdGPZ/Jz4jwvUwDSBTJyjPlBP6VeXnKb167lDHK8EOE
         006KNzmC6uz70+nKqgR7/niasx/A49+eLVmL/h6fAHMQMRmdX6rvHF3H5YNEkZ/FynIT
         cPSrm+WPcrXZe45QQOkU90+jgux04nHtgAG7mraI5YsnS3psJXBPvzIyAd5S/WzmmjoU
         Mo0WuLRVZHGWp8jp/JryofdLrSSG6pBVVSr8qF+nLioo1g08Rlywoi970C3E5Y39rVVv
         AS5g==
X-Gm-Message-State: AOJu0Yz/lMoZYaEvUiudi+qqC6vV7k1lNa+enaQpDAXA2pywAVphqMyL
        I2F08nlJERYYF5pwfOSVlxvum0NSntLgXQ==
X-Google-Smtp-Source: AGHT+IGrDx/xhixmqvzmaR/QNUT5+O9N36ypuiAiSw2lR0C8FgpfvIsuC3aggKtg532I+m11zDgKSQ==
X-Received: by 2002:a05:6e02:1d89:b0:34f:2756:8fd with SMTP id h9-20020a056e021d8900b0034f275608fdmr33304624ila.9.1697237312386;
        Fri, 13 Oct 2023 15:48:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:32 -0700 (PDT)
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
Subject: [PATCH v7b 02/25] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date:   Fri, 13 Oct 2023 16:47:54 -0600
Message-ID: <20231013224818.3456409-3-jim.cromie@gmail.com>
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

This appears in the control-file to report an unknown class-name, which
indicates that the class_id is not authorized, and dyndbg will ignore
changes to it.  Generally, this means that a DYNDBG_CLASSMAP_DEFINE or
DYNDBG_CLASSMAP_USE is missing.

But the word "unknown" appears in quite a few prdbg formats, so thats
a suboptimal search term to find occurrences of the problem.  Thus
change it to "_UNKNOWN_" which properly shouts the condition.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..ceb3067a5c83 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1151,7 +1151,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.41.0

