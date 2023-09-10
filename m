Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FE799F60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjIJSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:55:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB36119
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:55:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d80121cba8cso2305492276.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694372119; x=1694976919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwBCsDEe3pP4npvvDU6A0lOrTZauWrfElEBpix8kmtM=;
        b=OMYguLBSBJ+C+L+qcjSJGTjbps87AjomxbalSP8u1CAZoKXBIoH8AjXGZNxIz32UGl
         7yi5HgrOR86Kg53EB6dxUi7ENaXWWuzP6jTnEF35KskjN8kD0mMTdinv2OAkq2MCXFU+
         pBq+72PtOSeHLOBYfkE62oA7bm451i8Ut9RbSzubDZSjcENXuoUpTlJQYa2/bRDFt6rv
         3tDrxR31ueHfFmY7ncArH8BtBSN3d6UTF7FWRJUTTc82c+zScPZ4Jb54G+u9Mux1++D3
         XhGkd8AMGRS4Ab/pNXf1FeWe8TPWRDGB4bhV8VB9Ts4gFSAb6ZynNMet7qCvJlC1FWpW
         dOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694372119; x=1694976919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwBCsDEe3pP4npvvDU6A0lOrTZauWrfElEBpix8kmtM=;
        b=Yif91jpKTWUyEuFeVeXEVL4qQt7jX+PAP2h53RHfSsgINcijIBcrNirQSG5A4vcDMw
         hhOeWpA7L/nsrFWJLH9MuUIHb89xna+SDrEw6oj/e1UrUNXHt26rCQGN0I82BqvwgIYj
         oYkIXt1/dY/ZRi43uTmVcH8bQQIJcZyTAvwVQplkA/f2jqQpMORg1DXk+akjUo6T4cBJ
         BYPLqPmrtRbkvg64Zfwrt2XDeziEVLu0GrQf/9eLKy26ZwVNvk4SB3a8NNKVMvYp3yXJ
         TrlNfGKDCPyhhNkvUBWbGF1+UbX2/TEonG36Ezgv1WPYlBZVYN6lIcZC0llXW3G9cNIW
         xnlA==
X-Gm-Message-State: AOJu0YzSxQV0mMa5Xd6zRlqJw/WIW3sRPWWzs8QgTpq43WpUyJFnZIU+
        4HzPQL1wSH1YhXk5itG26pe8uAstwdZ/QA==
X-Google-Smtp-Source: AGHT+IFoIoYyT2lrFaLL52INI6UmFegsLyf8DKT+U3w+wu8iJBDe+eGKN96x1MNlK/e4b1OdQ+espg==
X-Received: by 2002:a25:abc7:0:b0:d80:1344:3cd7 with SMTP id v65-20020a25abc7000000b00d8013443cd7mr7138200ybi.4.1694372119454;
        Sun, 10 Sep 2023 11:55:19 -0700 (PDT)
Received: from walt-ROG-Strix.. (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id o9-20020a254109000000b00d74c9618c6fsm1345655yba.1.2023.09.10.11.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:55:19 -0700 (PDT)
From:   Walt Holman <waltholman09@gmail.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
Cc:     Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] Add DMI ID for MSI Bravo 15 B7ED
Date:   Sun, 10 Sep 2023 13:54:34 -0500
Message-Id: <20230910185433.13677-1-waltholman09@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Walt Holman <waltholman09@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 3ec15b46fa35..59aa2e9d3a79 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -262,6 +262,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

