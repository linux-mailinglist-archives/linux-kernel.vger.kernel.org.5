Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020F57CE3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjJRRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJRRHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:07:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7856126;
        Wed, 18 Oct 2023 10:06:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso175715839f.1;
        Wed, 18 Oct 2023 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648791; x=1698253591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=OrKGQiXDpXrkWb4m+aGK3cL7xjmuU1Fbcw2mbXsUtiyDnV1FPxat05eqn2y6y0ow2b
         aROLd/dQAXSemuEp4bjng6BWMnm+K4PIARFrGmoDP6Bdep0bb4KM+FpM5xuFj5cJxwbp
         1KP4xZB6kxRQYW6W0raXe9BwxTLgEh5KaJKrevdfkQ6qKVBlPo9xbgWMAMdMU5/R39Ub
         x7gKOBEHC+rPeOFLoVbl1n4G3DspKQfiCpREf/219egd+9wky1mph8BGnd3F3pynAs/U
         YgAJFk+4bvWIaFHnyFxa0/3S+qRUJj9DoFI6/1feF1vAsRzMPVz1tBahUazwC83c3inY
         Rq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648791; x=1698253591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=n4wGJ5x/TQqhvMFNtAydFKk0mfwHl1eH8kpPIwKiKqebeguDmVE1Bh/SlQX6Tcwhq0
         fI98Jd2BgexoAH+PiB/PEJAx+a/9aIzM7lN+SPJbFP1hFUF1sikijvJueZk2JzTgMCxU
         tjPIfasQh7jaMC9WOizLwbuBdoL6VVj69SO35menmsnbBQ44f3p8Svaej4Y5emHBZbbe
         GR+YCyxePBSnnvLUtWrHkDoMr7L6gUPsHs9mFYD8FfNk1q82Nkb0lOqg3ogun2QdUI+5
         p5HjCvEtmiZQYIfD7y910OEFyNZEHoOn7V52LToJd+0tg6Scp/1uHHOtUW24u38lz6gR
         F/sg==
X-Gm-Message-State: AOJu0YzYaZ9021d/tsUU9yspE4z9ME2m6ZbiHbvc8eq6TcJGY6A1U2Eo
        MFf9hPKO+0ZjsD3iyQayBuHisbrxrUBdSg==
X-Google-Smtp-Source: AGHT+IHO6nI4UZVkO1MGJLmf3+IhMzZwOIgWYzq9QH1/8ZQ3okxX0Qw82NbwAuFhs1VVKVleGTXhcg==
X-Received: by 2002:a05:6602:8c6:b0:7a6:793d:2079 with SMTP id h6-20020a05660208c600b007a6793d2079mr1483172ioz.1.1697648791342;
        Wed, 18 Oct 2023 10:06:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:31 -0700 (PDT)
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
Subject: [PATCH v7c 18/24] dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
Date:   Wed, 18 Oct 2023 11:05:58 -0600
Message-ID: <20231018170604.569042-19-jim.cromie@gmail.com>
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

