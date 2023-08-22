Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DE783B60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjHVIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjHVIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:02:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC70191
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:02:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdf4752c3cso23576665ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692691346; x=1693296146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHuVqZQ6eWzWGlZ3K43xXY3+GR5axkEe+E8WbhwDchs=;
        b=aNpu76vCZhA/BQGp5D9JvSshleIwRjcI0bMuCHgAKG+hB2+6j9iuUEQ8IOrqQ7UGXH
         mR7HYX3NOcBmt+JvV6JwS4OkqezRJoeLi78y/SIKUTuyz3l+e0BewAaA01aIRgMhYNY0
         +w0jj7a2ilWT2KdIXqCivGboFkul7STHaQfDAjPgjmv8CxeGolCmeYVi31bYWoK1wz2n
         awxKIRn6vsGZ0rcOjtmBGVkIV/mmeRdKQyRZvzMXxj69bWzyQQw8b/NxzwocJi7IXdTy
         kio/MXFC5O//lHnNIbpn4DMeWmXLvuOJV4aT7iqW9UO0EtM4qwN+BZs8RjBY7p2WwDiZ
         JeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691346; x=1693296146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHuVqZQ6eWzWGlZ3K43xXY3+GR5axkEe+E8WbhwDchs=;
        b=XotGbOhYlDfBIFs9x0yC4WH0RJm03F0GlMYZtin7OTM3M7utFe3vc9wCggAoRpl/FF
         gSK5bbSJ+I5aYARCIqOEHsaMOp23n8kRWNeD88KhhGnVxcicyxkezeo8vi5eqQUq877b
         w0gnEbsU62LDxTmo1CQGJfwg9JaATGgmLTfg64tIbCBn7tIKz6wcDgZxaTOI+Sww6bPY
         h483n7+fntME8K/0z1PXK2WL6ZUysmvp4VOGKWP3018NabNR6BLYjgvF3O0wH8Jcl3ye
         jnGu4vyV0D/mI1bp60/+rH4vXNrGDkGshx+64ZvIJRckYCp6MSDGPavkygRdumHZ+ywO
         5cZw==
X-Gm-Message-State: AOJu0Yz8ZQcuzpkluxTJtxbCkb0oqtXONaZoJb+zSIvUQG+zH9BWdS72
        w51mwGL5FQmh9JiFBmXkmRRZpSFZHH4sPA==
X-Google-Smtp-Source: AGHT+IF1C0krg/CMZNxa0h4RWEEaL/o1F/F9Blg+aKZTbZ19HcNAA0bakcIF1eMWrK16YWy+ksG//Q==
X-Received: by 2002:a17:902:7890:b0:1bd:d14a:7e14 with SMTP id q16-20020a170902789000b001bdd14a7e14mr6195774pll.65.1692691346525;
        Tue, 22 Aug 2023 01:02:26 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001a1b66af22fsm8418789plg.62.2023.08.22.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:02:26 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: greybus: fix alignment of open parenthesis
Date:   Tue, 22 Aug 2023 13:32:13 +0530
Message-Id: <20230822080213.6757-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Fixed all CHECK: Alignment should match open parenthesis
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/greybus/fw-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
index 57bebf24636b..0fb15a60412f 100644
--- a/drivers/staging/greybus/fw-core.c
+++ b/drivers/staging/greybus/fw-core.c
@@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
 			}

 			connection = gb_connection_create(bundle, cport_id,
-						gb_fw_mgmt_request_handler);
+							  gb_fw_mgmt_request_handler);
 			if (IS_ERR(connection)) {
 				ret = PTR_ERR(connection);
 				dev_err(&bundle->dev,
@@ -110,7 +110,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
 			}

 			connection = gb_connection_create(bundle, cport_id,
-						gb_fw_download_request_handler);
+							  gb_fw_download_request_handler);
 			if (IS_ERR(connection)) {
 				dev_err(&bundle->dev, "failed to create download connection (%ld)\n",
 					PTR_ERR(connection));
--
2.30.2

