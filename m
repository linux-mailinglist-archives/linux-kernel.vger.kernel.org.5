Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CA80821E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378049AbjLGHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378044AbjLGHnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:43:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE712D5E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:43:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso759513a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701934996; x=1702539796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4tM450hhK81w0oM7jZEhaWUepBXozQ46MIkYyj0Nte0=;
        b=htRcmMwAHlDt+fusDi1/mP2wTyw0o+bK5hOKHfVLBM09ifv6MmnlIAsJy3211uXK3o
         ggHZP7lFhJknFqo/Ncdmr489EVS8t7qN3gq2nY6LtikD9RauOJsm1O8JxPwTv/8keYeF
         18G+swRjuB8ysiA4NRwGEVT8nB8jypQKrd1Yh2Yj/ztCJghrpRY1MtkW+jnu7VTXIedU
         MnLylZG4QKMXyFcWoq16warsrgz4gBrOOFSnqGpNCOxm/cqtfZPJmJRSOdDoZEq5w0M5
         OvY3ovfvyUjsxAFDk0naw+aHGy0oMHQdMYX00Ep32B7HhFO+W44UEjOuD6gjrn+nXLti
         mybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701934996; x=1702539796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tM450hhK81w0oM7jZEhaWUepBXozQ46MIkYyj0Nte0=;
        b=AtrOx5wZt0+OPnWlx3ENHtsmBTWGQnMCEteMjWyHFl2hWnzp0C7ndmMoSbIutziQ2h
         fUviZ8yyEcvXlPF+m/bGiM8LAUJgSCIZtkDjP4F5z0Glch5OPtozWvgx145JHCRFcz16
         nF2EvyCaT+osLzSSX6q+SLjPW63oP5e7VGszn/CQP/b07wGIh4ulOgvitHGNF8GYrLTt
         dd2A3ji9muGMA2iJEibLA/G1eXSZ3rcCovM4YUed/SS/EpHFFe9SOL0PWsYNxWUG/s5Q
         5j4x6aLoXTYalwDmmC45V67L4CKMI8Bnt9ndvU+BaiiazifyOtKS3At+tGyyburEMEIg
         ntpQ==
X-Gm-Message-State: AOJu0Yy4fKih4A32uYlTPdOhsFmnAxXwRfVGzn7yiHA5gwfKPWSzykZA
        fXGfXjVxCLan0grMWLYhLOw=
X-Google-Smtp-Source: AGHT+IFIsSA4zdfdGgHUigFW+l+XxGe2W7Jx/7n0J2vlXZxYJ4Cp8IkegNM+J+rTrQVtTpLuRJG9JQ==
X-Received: by 2002:a17:907:1a58:b0:a19:a19b:78b0 with SMTP id mf24-20020a1709071a5800b00a19a19b78b0mr1160791ejc.115.1701934995649;
        Wed, 06 Dec 2023 23:43:15 -0800 (PST)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906369500b00a1e3ce0948esm451435ejc.141.2023.12.06.23.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:43:15 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Christian Gmeiner <cgmeiner@igalia.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/etnaviv: add sensitive state for PE_RT_ADDR_4_PIPE(3, 0|1) address
Date:   Thu,  7 Dec 2023 08:43:08 +0100
Message-ID: <20231207074308.393008-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gmeiner <cgmeiner@igalia.com>

0x1540 is the address of 4th render target address pair (two pixel pipes).

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c b/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
index b106e8b288ad..9bf47327f436 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmd_parser.c
@@ -54,6 +54,7 @@ static const struct {
 	ST(0x1480, 8),
 	ST(0x1500, 8),
 	ST(0x1520, 8),
+	ST(0x1540, 8),
 	ST(0x1608, 1),
 	ST(0x1610, 1),
 	ST(0x1658, 1),
-- 
2.43.0

