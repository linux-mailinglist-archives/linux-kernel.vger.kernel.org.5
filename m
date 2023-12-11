Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8C80D199
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbjLKQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:27:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F495
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:27:24 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3868309a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312044; x=1702916844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7C5pYYujTe8Y+gPKU6VkmtNi28zjItVjWkNm9TwHU4=;
        b=jNQXb4Z1f6rNpgvoFjGalO0xWPI15k9EXI9mxMd7ly5z/oAe9GpYWc7OIRR/ZVILvu
         ghdzj4KXJ0Z7+UOWrPX1E9djQ5G5d/cVKl6RXf88bbLZt9o0ZIT6ppXd6k3cmUFKFcDA
         v3fXuXaywQ+hoF/20hjJxmexRkpuPSoDg1ICn//TPYhLzvjvl6CHCKmHQKmKSrAKw34Y
         jtJN6Wy80vQ2+rTltzVoP+02AbTdyf24MEK/z4SSDBgqoHcXHpSJqU+FznMcPcfGvFxT
         Dd71phrRB4+k5rm9GKax381OtmPdzbPJ0v0Cs8d4luZrsUpIPcg1Ks6KcKQxHrx9rq0e
         3WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312044; x=1702916844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7C5pYYujTe8Y+gPKU6VkmtNi28zjItVjWkNm9TwHU4=;
        b=ZfOkRu6fu9GNLM0jr2qKZ7AZN6u8CZLuB18lLAGWWrGQOe2z/zfowxt/Ua5dPMBiK6
         wBRk44HBIQHu549I7vmpGx9Fo/z816wkA0W6FeJB0B5lOE7zAzSRWg213MA11Mo4mJVD
         N6o3uIZr1CGfpGzW9bvYfrko0/a4FyOsXFMNllZJKBTKD12FgK2VIW6kJCOBlVN+HVcM
         BJQwblUzYMOXrETG7cESoa51MWojRYYG3ZJ4+ET9OHGh5LCrhUB+j2OQdAgf19qCGEYI
         ZP1OZAsrl2FhOp91+RU/54l1W5n9dIFnrB+60Je+xjl0qTSxousZ5Fm0zdPsX1P0Hvph
         NZjA==
X-Gm-Message-State: AOJu0YyToJugd4NCOSaf5defIp3h/E2l20UtA2ppo9z/o5CCcFMCWQpx
        UD8EnZrrHdALWNUXllR74IhZ1dcCiJ3wnH7V
X-Google-Smtp-Source: AGHT+IHUejwNY3e0pVC+q46cvQMgp8ftTZdY40phiMnL32w87X9ox3VmjLoxhqYi+6fl+IZ9hTsZ9Q==
X-Received: by 2002:a17:90a:4094:b0:286:d491:4be8 with SMTP id l20-20020a17090a409400b00286d4914be8mr3522073pjg.87.1702312043878;
        Mon, 11 Dec 2023 08:27:23 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id me17-20020a17090b17d100b0028a01156d24sm7050052pjb.49.2023.12.11.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:27:23 -0800 (PST)
From:   Piro Yang <piroyangg@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Piro Yang <piroyangg@gmail.com>, linux-staging@lists.linux.dev,
        Linux Outreachy <outreachy@lists.linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2]staging:vme_user:fix the issue of using the wrong error code
Date:   Tue, 12 Dec 2023 00:27:17 +0800
Message-Id: <20231211162717.105915-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the error code of ENOSYS indicates Invalid system call number, but there is not system call

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..9bc2d35405af 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 
 	if (!bridge->slave_set) {
 		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.25.1

