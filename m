Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538381100D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbjLMLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjLMLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:33:21 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03581A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:02 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so85966751fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702467181; x=1703071981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSuSsAGCz1bsucla0R6QxbX9WoW2LywF9inDSTsLob4=;
        b=p1z2MXIGnOqP1TPTOq3yDs7kb75pDyyvPmg581vNx78x1TlTqNcb+oVWfmi9eNzuyD
         FOwgu+6pooiqC+fLlFmmVRUNDnhnK696T4n8QBD66TX4BMBN71MXMzvqtGB5Hx6RzPU3
         z1a8t6EVP9wQ3wSfrRznDx1i/2QWiiTe9ucDaZpJxzLstBfJ2tr6+hjVZZU4pj7PyrTx
         Z3ab2zSdSFDxOBqqeWgZaM3ttjlU0wt580nIZRyRB4p6b+af9GBmPuSOwW+8v3Q95+o8
         xURJwliApXsx37Tezhc5rNY+vpOdhYUZzOPcP3Ct6TwbW9LiMcw3Tuvih+d9pW8w2qnY
         CKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467181; x=1703071981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSuSsAGCz1bsucla0R6QxbX9WoW2LywF9inDSTsLob4=;
        b=ml0Xgxwx6XoUx7ikIu4JScvT9WT798iNRiWj2GkHQyjSNLMBkbtfd8ezK+S2uyxfzK
         Lf75AhCSnxzs0CbTqAOYSL4xprq8rxKqCkBG6p5OikywpQNPROQbkcJ19TpTXAy7nXTZ
         TQx/VXcM3u1Dv5/TY3WqdivimQJ+MD9I/gDxiD3EpUnGy7cPjk4d02xRcBHN6Ihz9UqU
         nMk76H1UUUN7hfq4hMQbgp3Xmx+lufBoMLi+Xg9MnoWweZkXijNHmpq67W3tQdb8dj7L
         g9+WT4VEGYKIzP7EyckfeM0iDtAQ0dKKGQsZeS/OwmuYXXGSQ9/MLnnS9gwNrVXqFTMF
         0AMg==
X-Gm-Message-State: AOJu0YxHWOjGyXsm/cahq/bb7p8n9fOa1INeyvyc2Sd4aAt/hQDxOB0w
        bxKjE1dCBJ/oukhv0bR62xgYWA==
X-Google-Smtp-Source: AGHT+IFfjiu96YZAhVw8RGb9KnLHzIXPeGt+cwOiHP2URRoBPSCcNNJIUlGsZdw4q0wcKrg5WYPNmw==
X-Received: by 2002:a05:651c:1a24:b0:2cb:28f3:244d with SMTP id by36-20020a05651c1a2400b002cb28f3244dmr2529901ljb.6.1702467181130;
        Wed, 13 Dec 2023 03:33:01 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id r6-20020a2e9946000000b002c9f71e61f3sm1812273ljj.6.2023.12.13.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:33:00 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: domains: Drop redundant header for genpd
Date:   Wed, 13 Dec 2023 12:32:45 +0100
Message-Id: <20231213113245.29075-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "power.h" is no longer needed by genpd, so let's simply drop the
include of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cf65b5a9783c..9ee1bf2ece10 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -23,8 +23,6 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
-#include "power.h"
-
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
-- 
2.34.1

