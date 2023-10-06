Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC147BBF88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjJFTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJFTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4319D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53142351997so840306a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619135; x=1697223935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PddiH55x+W9MXtYbdET9UUNCdNqM/zZgQg6IQuIHC9o=;
        b=IhPsBXv3iUXTGifKWumGQODxOo1rYP0OK3zyDyeoe/0cuAOAr8XbvkfMfueiOGfUJR
         wak8dYcLSS2cjSJqnAS0M2hpBIG1bSsp3Pl3NLs3NrihwCiNunt7rF2ph4dPZYqoSSex
         wtPX0EXVf8RQPx5cIWXQaR3RUMZDyChxumRXZEuQ8BD7ZesUigToNk+qMTped8JIB0nO
         xVGJCcApjyGOQ5KOnsfLw462C9LGeYwn5KXxi1LQNTIBmHKYIZh++/cP3pZjqKg0/cLD
         A8YcY9+WtiImZqr9gpHrvpiOMMSbFKXc3o1Tq7Qvw2bUJYfo2xNoTDrvHVBhqRQ6YP8w
         c3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619135; x=1697223935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PddiH55x+W9MXtYbdET9UUNCdNqM/zZgQg6IQuIHC9o=;
        b=MYzSgarER7LThMVCpoP024JSHGyMInlc1szqQWb4Oqy9meMxGUI5hiBpFyQ6LlS9VX
         ctlyUjVWs6H7raytRuEFx/ewdcELf3TbL+ZBbdvQzFO5T1QnB8r/kEOqnB5ZfHxAYRac
         +4bg4Zgt+ShCYPC5XvaLEKEkW1LA0f4nIbLDhB5Grxlm07smjBnyQpEmxcXL9JsMkX7c
         ZH2PBPLTzLDgInQErl/+VTG/znJl+ufFcG3/1qWliq0IHApNriyNoCkWZT1QlOX74dMg
         gibNSFVuLlL2SMBDqXeg5fCz4wQp9ErqKm/PUoLsPhhbWshkN/ou93q6/yba8C3yA+gU
         RNYQ==
X-Gm-Message-State: AOJu0Yxxz7IbZhH9qdL6Qe8U26a9SgInlQGU3U1LaExrMzyMwRPCk0MH
        J+IvqyzG+47elnztYweQY3Q=
X-Google-Smtp-Source: AGHT+IE2VILWoBXLlNlCUEQmPGaZVpyEYdfY/rkrsyVHLJ2oREeSk84ug6GcPexj47mIt+w5VC3Nmg==
X-Received: by 2002:a05:6402:40c2:b0:523:37cf:6f37 with SMTP id z2-20020a05640240c200b0052337cf6f37mr7470007edb.4.1696619135304;
        Fri, 06 Oct 2023 12:05:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b0053782c81c69sm2933456edy.96.2023.10.06.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:35 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Remove unused variable
 rt_global_debug_component
Message-ID: <082272e20dc0659e7700f7756a6bf1a8b71c411e.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable rt_global_debug_component.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_debug.h  | 2 --
 drivers/staging/rtl8192e/rtllib_module.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
index f6b23defe225..06adfebd7c89 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -14,8 +14,6 @@
 #define DRV_NAME "rtllib_92e"
 #endif
 
-extern u32 rt_global_debug_component;
-
 /* These are the defines for rt_global_debug_component */
 enum RTL_DEBUG {
 	COMP_TRACE		= BIT(0),
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 195d8aa88138..f280c9e94958 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -34,9 +34,6 @@
 #include <net/arp.h>
 #include "rtllib.h"
 
-u32 rt_global_debug_component = COMP_ERR;
-EXPORT_SYMBOL(rt_global_debug_component);
-
 static inline int rtllib_networks_allocate(struct rtllib_device *ieee)
 {
 	if (ieee->networks)
-- 
2.42.0

