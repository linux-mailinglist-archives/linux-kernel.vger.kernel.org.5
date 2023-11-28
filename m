Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFE7FC8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbjK1Vke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Vk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:40:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94F99
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso23062885ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701207635; x=1701812435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQusyzrWbRXd2hWyvgtHM4eFYw/jkvHj52PFedjE4u8=;
        b=MNzPDxQQog82ruT0Pm86elahz2XWC9NgB+Nn6hJoKHKqMOhqgb6dksbftGKJSRVUSQ
         VWZZ5tdg8mEjIfj32a1vIinHRAVpbvALXGQ4Ncaboa0w8S1Ji6/AG49Un6J1PfJD3x8I
         a+EQtpP0JeS4nbS5CHHQgkxMAo2TmA3RGWD6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207635; x=1701812435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQusyzrWbRXd2hWyvgtHM4eFYw/jkvHj52PFedjE4u8=;
        b=joChyCfNrgUd6JLo2xm4SlE7Df2OPk3/gw0PkPk+W6h4UTv8hdMDUIQKLlwK7bGk2F
         EOnt1lTDygJKVAx9q8ZTUXDEjFFICXb6VTf9YUMxwfr0LKW+GI8t+vSY+jpH1DVMdHHP
         wOlTPQ6tdeL9o8nxIDeHy9xZEUd7gmukIGS2Waj4POKWVT5DGY2YhzvRyWxaT1OMCo+J
         AEBLhlp/9VsLvD2BV0UVYjhhKILhEr++zrpvyg2UHAfLBQ1L0s0E0FrUTiCeigKyJoBW
         mTZZv18KOTmStc2hNYJzT0cddWRc+ISJmZRh5BrCJKTQvABsnVI4HDhVS9Pdwx0Lo5ny
         FwDw==
X-Gm-Message-State: AOJu0YxnPyKUdIhhPmBANPUOknQoCapVgCBqCcry8LGNPPnNye3n4O+I
        xVeeSJ5PnGrpZm7rmgk+Gd6lM6hnaxMgxC22qmQDSzyp
X-Google-Smtp-Source: AGHT+IHjxLHrbFVWHHz1UpDOcxGnHlHtypDnIRIFnoRa58o7N6BLTb9cS6ooZ698m1EJq0bwrHtneQ==
X-Received: by 2002:a17:90b:3846:b0:285:9408:2fb8 with SMTP id nl6-20020a17090b384600b0028594082fb8mr15411756pjb.43.1701207634922;
        Tue, 28 Nov 2023 13:40:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:fc3a:13ce:3ee3:339f])
        by smtp.gmail.com with ESMTPSA id ie24-20020a17090b401800b002609cadc56esm9634285pjb.11.2023.11.28.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:40:34 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        linux-usb@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v2 3/5] r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
Date:   Tue, 28 Nov 2023 13:38:12 -0800
Message-ID: <20231128133811.net.v2.3.Ib839d9adc704a04f99743f070d6c8e39dec6a1aa@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in
r8156b_wait_loading_flash().

Fixes: 195aae321c82 ("r8152: support new chips")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 5a9c5b790508..b7bbebf09d85 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5521,6 +5521,8 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 		int i;
 
 		for (i = 0; i < 100; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			if (ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL) & GPHY_PATCH_DONE)
 				break;
 			usleep_range(1000, 2000);
-- 
2.43.0.rc1.413.gea7ed67945-goog

