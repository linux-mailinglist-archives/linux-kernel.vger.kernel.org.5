Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB647D2D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJWJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJWJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:06:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B398
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:06:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c2a0725825so445238766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698051980; x=1698656780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PST0E4VALAaStd8rk46zMSQH1CNUm8AVihtY3+BphI=;
        b=KxP03XwwtSAl/Tuc+JtHXg3xubfRvvmhUi4YLWNqV46T3N2aXFnYRVrZOMvgDpnHqW
         bwz4EZpjjFsIpy0c3ADOgfYHtdLZUmF0whJSHmqti17CfpRyGN4QdemqeJpTh0VzKmTi
         uSrbPQ508hF1r0jyhUK3EGpv/PdluTv0dyWso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051980; x=1698656780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PST0E4VALAaStd8rk46zMSQH1CNUm8AVihtY3+BphI=;
        b=uIxErHxSEfWK2EwkpTLAu6UucJGk/r4G3Ux0qOKYNLPQRLQnGp1xiZ8I7HXeblB4c5
         RNQZWJH34AN8Uc/Yl3eLXaHsIN7CogYkQaNXpb5BKAUsD+PVGS+TCa+BwqS6jt1jS5Ef
         AQhTKNHupEHOQKQ9dD8hos40iGGIEjWlRqakZWPKky0Ewa3jC+xaBHskAUhabGy1Cy3+
         CwVD/R7HdS5Jw5ZjAO7Se2/0RYwMAmHKL/kSMbkMtRg/39L3qoWdmro0geNsC5B94qsf
         DtjwVmSKDCDefIyusyaZ8LCXI4Wce9Tejey6J5z3hik3pBNhsQsZRwYywFA6ne1XWBNW
         QWlQ==
X-Gm-Message-State: AOJu0Yzw6N7kIfnNLWWq1OXDrC/uQsPv10JOxeHaDz559yCM+LXAF0pX
        2FTnMnbkF/iLMNgU2fM85MKiD8sOFmHb8si9T9CC2A==
X-Google-Smtp-Source: AGHT+IF809PwCXbbmMNGSyv5w64YO8aByKgFPLkm6Wc2EM2lbMg3NSWzG9UL+vkUDj4GrCOjwjOI2w==
X-Received: by 2002:a17:907:c21:b0:9bf:80f0:7813 with SMTP id ga33-20020a1709070c2100b009bf80f07813mr7090615ejc.16.1698051979955;
        Mon, 23 Oct 2023 02:06:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-79-45-223-184.retail.telecomitalia.it. [79.45.223.184])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906089100b009c3f8f46c22sm6321868eje.77.2023.10.23.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:06:18 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel: nt35510: fix typo
Date:   Mon, 23 Oct 2023 11:05:56 +0200
Message-ID: <20231023090613.1694133-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'HFP' with 'HBP'.

Fixes: 899f24ed8d3a ("drm/panel: Add driver for Novatek NT35510-based panels")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index d6dceb858008..83a9cf53d269 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1023,7 +1023,7 @@ static const struct nt35510_config nt35510_hydis_hva40wv1 = {
 		.hdisplay = 480,
 		.hsync_start = 480 + 2, /* HFP = 2 */
 		.hsync_end = 480 + 2 + 0, /* HSync = 0 */
-		.htotal = 480 + 2 + 0 + 5, /* HFP = 5 */
+		.htotal = 480 + 2 + 0 + 5, /* HBP = 5 */
 		.vdisplay = 800,
 		.vsync_start = 800 + 2, /* VFP = 2 */
 		.vsync_end = 800 + 2 + 0, /* VSync = 0 */
-- 
2.42.0

