Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA187B5E44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbjJCAeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJCAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:34:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D7A1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:34:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-694ed84c981so261992b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293272; x=1696898072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Gu5AeGEBG3UAx8tqJHnnJONEDjYZ4KhZYReyw4USQ=;
        b=isx/OnyS4noW4BuudGRYLVM+u086Ph44GReOCp/Y0qQ46Ez+AZ8paNJMArZ3a+nOgF
         CYwVw6WumUPY2wcdm9OQGxghFjtUY7QyGN+wmyqcPcWRrMJRVmhrR1iALsyBOi7Sr8kK
         Be1ouFFRcHVQrFmTqXXLFuZHRBKC8lW0L3QX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293272; x=1696898072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Gu5AeGEBG3UAx8tqJHnnJONEDjYZ4KhZYReyw4USQ=;
        b=MxgAYE95keRtyLBXYdrr5jO8J258oCJR1yc4uAC46jovzKtfvfpdediLpAnNTYfNLh
         NDU6MQAU140dQaMBp9uQRyA47yCN+pwer4jY2BU9TMvZAFxsxNrICqiVxBqa9f6TWAFE
         GVFYHL3Moe96lHzLX8kAr9OC58RpdIYVlRGPBfPly4ba7r8OPnB/yLCkL50HVZ/5i5Ou
         yX/ap3BwlF3GgWiUTj3hTydF5qB8z3tRAR00aOwHLSFmjmsQ0o3BPwFw8FEZlamPG170
         OxL6RHEXS8GM9D5p2BCRdnw/YO93ByuZRqtKtVZcQUD78KGRRlbAYHSHvHuItibLoB8F
         CRjQ==
X-Gm-Message-State: AOJu0Yx47hZ9hFvxxM0fB22wyoTuLXqebv3qKWfwAFrNSbLEchWDjiBq
        b5+9ZqioEzCTyUoYO51V+wWWjQ==
X-Google-Smtp-Source: AGHT+IGvXWxh0/ki0D/u+K73heFmTNq1LtY5KXiNcaoOMuKywOlbtvVWKFfjxlyMg48n/3EW54eZxg==
X-Received: by 2002:a05:6a20:5655:b0:133:b3a9:90d with SMTP id is21-20020a056a20565500b00133b3a9090dmr9920050pzc.36.1696293272344;
        Mon, 02 Oct 2023 17:34:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068a13b0b300sm101368pfb.11.2023.10.02.17.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:34:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 1/4] platform/chrome: cros_ec_typec: Use semi-colons instead of commas
Date:   Mon,  2 Oct 2023 17:34:25 -0700
Message-ID: <20231003003429.1378109-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
References: <20231003003429.1378109-1-swboyd@chromium.org>
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

These should be semi-colons so that one statement is per line.

Cc:  Prashant Malani <pmalani@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d0b4d3fc40ed..82e7d08b52c7 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -271,9 +271,9 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	struct typec_altmode *amode;
 
 	/* All PD capable CrOS devices are assumed to support DP altmode. */
-	desc.svid = USB_TYPEC_DP_SID,
-	desc.mode = USB_TYPEC_DP_MODE,
-	desc.vdo = DP_PORT_VDO,
+	desc.svid = USB_TYPEC_DP_SID;
+	desc.mode = USB_TYPEC_DP_MODE;
+	desc.vdo = DP_PORT_VDO;
 	amode = typec_port_register_altmode(port->port, &desc);
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
@@ -287,8 +287,8 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	 * here for now.
 	 */
 	memset(&desc, 0, sizeof(desc));
-	desc.svid = USB_TYPEC_TBT_SID,
-	desc.mode = TYPEC_ANY_MODE,
+	desc.svid = USB_TYPEC_TBT_SID;
+	desc.mode = TYPEC_ANY_MODE;
 	amode = typec_port_register_altmode(port->port, &desc);
 	if (IS_ERR(amode))
 		return PTR_ERR(amode);
-- 
https://chromeos.dev

