Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FC77BE73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjHNQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjHNQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21FE63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99d6d5054bcso843107566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032031; x=1692636831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZg6bgAj65DnkDj7TlelvOaycLC9ME/S7RGeUkwXOdo=;
        b=tRheFokMwqg76HypcUfHQ0Ob1hrgMIk+gAagnXy11StvcQM0T7/gtQw1YjW4hvQ6LY
         TJqmdGnYlCPhrY8gUsySmYJixPENhxZS9NIlXEEHvcVSDkFE2FOyP5DTktAkNgZdGM8T
         p5/XmZxznAeNwqGcRA8omblVxYRmdevUqw2hK9iIt+f8Z/5IZ2EfJ/ZpqDv1OKIp416b
         JRXsAMa1vWpmMVIOj5yvycwdWYegRfZEId1+rKyWNAmywFZXWSlNWCeVeYEYfE2Njz+l
         0oB95YkP9ZsSR/fkxU5R5ZwxeePQGtBAc3eelz9WH1+VYpItcDxxKKqQE6gXeWR7YE/6
         nKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032031; x=1692636831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZg6bgAj65DnkDj7TlelvOaycLC9ME/S7RGeUkwXOdo=;
        b=gzXdlRb+GpTjOUMP8Thy9tiI8Lc9PN9ncl7a6T3DjFk1q7Ltsb+sn7b1n7pl+PCofJ
         AliYXmbHwHOcdylIhQChovAGpN3P1DtOsoyT4Zft1WA2rmkK6JmGRJK4tIHaMshiQyT/
         GgBXM3ZTTBcetC/+5miq196EqEWbC1rVd6Wq/Kf9yXW4BeSOkCEKyROuSnF8/jtkQ5nj
         DCZ879dD5o/OKnpISL1fxRiI3h0ggUEJPEgUukeEBxHcT2v18KgOmzIgOZ24G2ZYUtpd
         NEGJ4jP/rhBpXwwjtMCM0u21LRghdtpOevGoonFzQsE467w+5VnELO6WheEstky+8QWv
         qzgQ==
X-Gm-Message-State: AOJu0YytAHrd+5bTRFRixIaKHEbV8P5oEZgn+AyBozs5M3hFUmkVTRPN
        STvK7ZdTS9i0Fg0JyEjBBUnMfg==
X-Google-Smtp-Source: AGHT+IE8+I24qRigx6ejW+EEP2gfYcXjDMBUmVN6BV6OMVia7qKVbIRasB7o9Om/XVUycooUZt+D2A==
X-Received: by 2002:a17:907:7f15:b0:991:d414:d889 with SMTP id qf21-20020a1709077f1500b00991d414d889mr15596087ejc.15.1692032031015;
        Mon, 14 Aug 2023 09:53:51 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
Date:   Mon, 14 Aug 2023 17:52:44 +0100
Message-Id: <20230814165252.93422-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diederik de Haas <didi.debian@cknow.org>

Fix typo where "driver" was meant instead of "drive".
While at it, also capitalize "OTP".

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5c5d7414f78c..7ab12fc1044c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -247,7 +247,7 @@ config NVMEM_ROCKCHIP_EFUSE
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
+	  This is a simple driver to dump specified values of Rockchip SoC
 	  from eFuse, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
@@ -258,8 +258,8 @@ config NVMEM_ROCKCHIP_OTP
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This is a simple drive to dump specified values of Rockchip SoC
-	  from otp, such as cpu-leakage.
+	  This is a simple driver to dump specified values of Rockchip SoC
+	  from OTP, such as cpu-leakage.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_otp.
-- 
2.25.1

