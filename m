Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7977F5C88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKWKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjKWKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:38:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B6D4E;
        Thu, 23 Nov 2023 02:38:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so999424a12.0;
        Thu, 23 Nov 2023 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700735892; x=1701340692; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/10f0Z5slGSAKwMhtMcE4JVOhjTmJuQd6yxBSQebl1Q=;
        b=BN/4y5wMFp8+XUVwUz0orNEfc7B4Y9xcjHRLVhX9M2kFzhghbf+ClVdoNsqrGFtg7r
         kIn7xC1JF38EXzJ0m5YyQ1/7M2IS+6J/PzRHxjILVxnVgMTc00jh+tOcbaQz6HZ4uegD
         iNo7pz4eNR6MXgW4k2oaBiRfPXWgiJ1X/pLJ5/ZIRmWmWK14hBfz4F/1aGAimo+TavWX
         m/OcmON1gCEjdfKOR84F3jLt5GqQ9L/G7P92LqILqJ0U+PPqe2OrNGRE4xyuiqFowsMS
         c/e+5REXwGQgOF7F4pHfnFaa71AbLaNUm27EKqt9hXRGikU5NB59hxyBlpPqrsPbcjTQ
         ARGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735892; x=1701340692;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/10f0Z5slGSAKwMhtMcE4JVOhjTmJuQd6yxBSQebl1Q=;
        b=hX+6eVvHcSsDriYP7IqnvUM1EV3zeSXEgP+UY2d8dpil2FkMQJXYFcEPFezQvJdb+X
         u9WtrVfE6NTf6XpiP5f+hwAbe9hFsIIYHjMIdx4y99fE41BDAVU6xHlg4qZofCdHOA+2
         WuvHlQeVKwAbpmQjVKZ7vGZQH3hPNr/0vuZ2/kpv++7BIvw7ltCDnc05rxyYk4/O44/c
         XcVV9VRjSdQxtw9ETd/1CIt/EWS9FnMT+059g/Uk0VFoyKz6+bs+SnWAMyoSthfkSnk2
         kUp5QNAuR3hxAe9uFz85JYfawT5aP/XbDYOjJccQH1dy+Z7/hI5ShlVc18UTwIEQBeLW
         qi9A==
X-Gm-Message-State: AOJu0YxaW/PTLxV3jW5wjRtIQo6Rt/p7I3HKgbzPsAGEamm4iBySUQqI
        YSE2mBbgyKk0wkmR1nBQs16HD54Mwug=
X-Google-Smtp-Source: AGHT+IHlzD3nvSyI/45B5PJ+YhvgKPsItsZOGvtSg8j3cEuomylmjSj4riDSySJf9GaOj2wfNWEA0g==
X-Received: by 2002:a17:906:104c:b0:9fe:380e:9055 with SMTP id j12-20020a170906104c00b009fe380e9055mr3146320ejj.8.1700735891528;
        Thu, 23 Nov 2023 02:38:11 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d183:a5d9:39a9:cd13])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906184800b009fca9484a62sm594511eje.200.2023.11.23.02.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:38:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] exynos-gsc: remove unused improper CONFIG definition
Date:   Thu, 23 Nov 2023 11:38:08 +0100
Message-Id: <20231123103808.17848-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
that are introduced in a Kconfig file.

In the driver code, there is a define for CONFIG_VB2_GSC_DMA_CONTIG, but
this is not used anywhere in the code.

Just remove this unused definition.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/media/platform/samsung/exynos-gsc/gsc-core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/samsung/exynos-gsc/gsc-core.h b/drivers/media/platform/samsung/exynos-gsc/gsc-core.h
index 1ea5fa1bf3c8..b9777e07fb6d 100644
--- a/drivers/media/platform/samsung/exynos-gsc/gsc-core.h
+++ b/drivers/media/platform/samsung/exynos-gsc/gsc-core.h
@@ -26,7 +26,6 @@
 
 #include "gsc-regs.h"
 
-#define CONFIG_VB2_GSC_DMA_CONTIG	1
 #define GSC_MODULE_NAME			"exynos-gsc"
 
 #define GSC_SHUTDOWN_TIMEOUT		((100*HZ)/1000)
-- 
2.17.1

