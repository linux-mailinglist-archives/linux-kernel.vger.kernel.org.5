Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212537BF204
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442093AbjJJEqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:46:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B3A4;
        Mon,  9 Oct 2023 21:46:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4286812b3a.1;
        Mon, 09 Oct 2023 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696913178; x=1697517978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMzsmultxcJBZ59DUiTXhAR91Uf7krnixxKWDljZ8V4=;
        b=Ljp1uNdZ6+3qyf2lcrljoqXT0AshthD2+Vpqv7MVRJNq/u6dIoM/0BXtXmmUIZQ2mc
         UCoiFIpguRhH/WHo+CoyuxfeEVXdNIujK0qao2buYuYOGD1jVQUK4IoWSjtczo0IVwD8
         dr+595nTJ8wKAIYL7P27dToBWVMiHrFq19ODK8ehkBm33tcHNUJYLRtJ1AxHOUQZWe7L
         3OSVm9Zxeik2Jxdtq9AsmntcYGv7cbB7WLgvRaG+LCoZZ7T7JONmVKvr34rinULvXxNc
         a9NQrtdTOOt1/J/xvXXQBuO5yw95Ia6zgTmzxNUnZ8aQAQtETKXRDJiu6J8VCqJlvQXx
         jCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696913178; x=1697517978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMzsmultxcJBZ59DUiTXhAR91Uf7krnixxKWDljZ8V4=;
        b=QgIzejfL3jjm3fKTyqsRzyE3BqWRA6S8yXQLi9ry5rd2fEqNscpf+U9nPRoJRPuRVV
         Kv7WzVvKYShp04+EYy6S/JDwYSIERPyQSILuYG3TYZGcVRY9uRpjXYMKdCCOgpr466be
         EWDoQIoi8aFVxMDL9sfScHMYbDrhJ9sO4yAE6kRyYqsHjN2jYIIfdXrELLvdlHX+4cbJ
         3ck4vrySir1/Y6o4G/rPZRhdN3iIz1sXKKLhYdSbk2U8OtdKVPyCHtqQEkZM3DZTEDR0
         Vg9tHlBxvPBc4sVXJauYEiHXKSboZqnFOlphY02mSK03B2MB9WjiJX7oZ2oF4koFhlTa
         ndAg==
X-Gm-Message-State: AOJu0YxvoSKJ0TYZMv51f9VeD6F79/59D0ewYs7Zhz/RpFmf36mcmgtS
        qR6E+G/9IeuYjKKhvmkvLu4eU1OCR9d8gA==
X-Google-Smtp-Source: AGHT+IG8t8ONvbb1bVyv+UnSfSwDPzqumpR9chpG72UHchXMyy04zLrOKfW38mzbmyFT1uAAHUW3Tw==
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33cb with SMTP id wl27-20020a056a216d9b00b0014b802333cbmr22313088pzb.11.1696913178285;
        Mon, 09 Oct 2023 21:46:18 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b001b9c5e07bc3sm10554765plg.238.2023.10.09.21.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 21:46:18 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] drivers: net: wwan: wwan_core.c: resolved spelling mistake
Date:   Tue, 10 Oct 2023 09:46:08 +0500
Message-Id: <20231010044608.33016-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

resolved typing mistake from devce to device

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 87df60916960..12c3ff91a239 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
 
 static const struct {
 	const char * const name;	/* Port type name */
-	const char * const devsuf;	/* Port devce name suffix */
+	const char * const devsuf;	/* Port device name suffix */
 } wwan_port_types[WWAN_PORT_MAX + 1] = {
 	[WWAN_PORT_AT] = {
 		.name = "AT",
-- 
2.27.0

