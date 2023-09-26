Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFF7AF7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjI0BWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjI0BUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:20:43 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FF15EB5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 16:07:17 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b5ef5b947so5478152eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1695769636; x=1696374436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbGNzQXq6nzIoCstD7NrK5H4Ms2M/wqIpWZdQeS0vns=;
        b=nN6H/sAdPaSwv+v51iJjYvN+E06oZ8t47WbqG9MCp1tbtVOy4IejPz/M++I7OU3L9M
         cm5P+yK1Q14VpfmS29BMLIxmefMOG3Mu2yMUE9y6ghRrviXSOhrziaoeF7FcHRFcRT4+
         ysItgS6UHm6cKdoAPEE7iSTSHUg832OcXdh8JZodDI1Sy+bJYUdljC8CgT0yvbw7HO0B
         6vzjJolymt3j8B4HTTkYFJiBpcPIFzkiriyCdaq6NpWbgtlUJIUUoY3W5qzvabcGwrSk
         apwk7TraAhxTo1jEQeI3PZktHa+SzCYudavdJLlcyMFUXAW/vEZW+6YGBtZpI0c8ugPt
         Uq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695769636; x=1696374436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbGNzQXq6nzIoCstD7NrK5H4Ms2M/wqIpWZdQeS0vns=;
        b=i3ukfwwkZ4oUto3SrReq/RezQR+nng5PFQc4bdfbxkL3iC/S9wVlwuL6CqEPpAW2DI
         huOpMwknXVgwvY26jnC9sdD79oROcuVNmZuTguFsZnVsfLgjy5m9+bSSbZxcGk0fw2n9
         o4HfT8E9NhvCq6A6KOrHXEmG+K9rk6ZpDOD6xb8ZqT/5vIbtcRjagmPR4qRwdkIv3Ocd
         hX7/qCLm96fxwsfyea2X5mLzMY17ie30GD8gcMsYBJ5wZfAwEDssPWr97LiViLa5og1f
         WKG89r1H/smO3Y1Cc5MAi5vRswvMMkysXfDxlepWMs6PgXV6eqwYi03B9C2WwBwysIcm
         fZoQ==
X-Gm-Message-State: AOJu0Yx6vL/IPlA/PIBNuyGT19hyJM5ZHnbLXyMqdNJZCbckAOFQmnO+
        GISCEJKRsD0khAGXGkaMm8WHEwYXdmU1JgA72Iw=
X-Google-Smtp-Source: AGHT+IEDl0OVELxCvoVMiAycsjRZGePvNya7jDXx/GJj1rVeP8DaJWh0R4B7YNM7QyYeoENoqOiwxA==
X-Received: by 2002:a05:6358:930d:b0:143:723:8f89 with SMTP id x13-20020a056358930d00b0014307238f89mr606360rwa.4.1695769636472;
        Tue, 26 Sep 2023 16:07:16 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2620:15c:2a3:200:214c:d626:7850:b693])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b00688c733fe92sm10471463pfr.215.2023.09.26.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 16:07:16 -0700 (PDT)
From:   "William A. Kennington III" <william@wkennington.com>
To:     peda@axentia.se
Cc:     linux-kernel@vger.kernel.org,
        "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH] mux: Make it possible to select MULTIPLEXER if EXPERT
Date:   Tue, 26 Sep 2023 16:07:12 -0700
Message-ID: <20230926230712.516709-1-william@wkennington.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, there is no way to enable multiplexer support unless another
config option selects it. When using `allnoconfig` with CONFIG_EXPERT,
this is deselected with no way to enable it.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/mux/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 80f015cf6e54..5d585d778312 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config MULTIPLEXER
-	tristate
+	tristate "Multiplexer"
 
 menu "Multiplexer drivers"
 	depends on MULTIPLEXER
-- 
2.42.0.582.g8ccd20d70d-goog

