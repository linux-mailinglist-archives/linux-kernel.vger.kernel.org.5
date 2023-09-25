Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F47AE1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjIYWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:50:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E211C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:50:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso6724721b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695682205; x=1696287005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0dp/fAcpQgkENk/LOljqWA22kzkVBHyOPNf+RuAGkU=;
        b=MbhyoIdjzOBiTVsmLndpkBMh/wlEt8GrN4FiTG0idqF392tC5htnX4l6iY8j8bPKsR
         DUWuiOF3zm2BpindK+N9yy8D/NI7I4NYwPzzkBAerCokZjNKOBAOZudhH2AAnYgywk7n
         gyvfWtjcrV8uGe1L1nCuxJiCsA5Ukz+OseRXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682205; x=1696287005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0dp/fAcpQgkENk/LOljqWA22kzkVBHyOPNf+RuAGkU=;
        b=Vwbtr+pPTfTC4O+YIAAbW7YYbSxlXtJD9zDGNhH0nR9HiSKGtEOFCkeC0i1dXGZfzg
         gcWtdqATYEXnBo9X4aSJ/VB62hrNHFlxq1hdwQukGVFPDJoqGQ6N4wbdUV5vIZY2nHTH
         psbqsCr4tY2M4NQyF6Qorgpmg/dS3CO6fsyta7GOqVEj5gPZ+DooQ/U/isorcRj4z8m7
         UL2Y3rgjDAqe9LI1ya3ywrq5kjq39I7Opb2bzk71lcmBKdeXjtzC+fzidMglFtHN0hPX
         3dWXi/JplxFBxMkRNYNgRjGEzuYVytQZdAWBrbCp7cE3h2BAnbV4PQjrp6ozzsq0M853
         y1WQ==
X-Gm-Message-State: AOJu0YxbGMJcam7uiQJub7dIpgI6F0ezR/qg0LuK9ztgt6Rwkrj2J0Ea
        S7QwREn/D+mtaZc5LnKWSO5qOQ==
X-Google-Smtp-Source: AGHT+IE3Wjy1ZvQQEM8BRe/2ob5pENenBNG23SL14nx/qyY7KKQYio2BlW/P6HNU8mgBXzMJuupb3Q==
X-Received: by 2002:a05:6a21:3d8a:b0:15d:e68d:a850 with SMTP id bj10-20020a056a213d8a00b0015de68da850mr8051890pzc.29.1695682204844;
        Mon, 25 Sep 2023 15:50:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f75d:a4e1:226a:3071])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78c07000000b006878cc942f1sm8533209pfd.54.2023.09.25.15.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:50:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Document that the NXP i.MX 8MQ DCSS driver goes thru drm-misc
Date:   Mon, 25 Sep 2023 15:49:29 -0700
Message-ID: <20230925154929.1.I3287e895ce8e68d41b458494a49a1b5ec5c71013@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the discussion on the lists [1], changes to this driver
generally flow through drm-misc. Add a tag in MAINTAINERS to document
this

[1] https://lore.kernel.org/r/20230925054710.r3guqn5jzdl4giwd@fsr-ub1664-121.ea.freescale.net

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d72d3af551fb..d20a375ecd7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15225,6 +15225,7 @@ M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
 R:	Lucas Stach <l.stach@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
 F:	drivers/gpu/drm/imx/dcss/
 
-- 
2.42.0.515.g380fc7ccd1-goog

