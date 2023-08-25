Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE0787E02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbjHYCv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbjHYCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:51:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9822100
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a410316a2so442136b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692931865; x=1693536665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4EGzm9bw0XByI1m8+dZAvw1r82ELdr/2MKF8VZnDhM=;
        b=L/peUxfv5ek1T9o7T4v/BvKO3klCtt5UyahYL2j2G6cWn+PuHUyKzkMFohwOPvt6cE
         hvdVtBIHC04XCH9bmcBvDAvr3SKql2+OHyX7CrprdBHGfQvQRTGxgHxTEkjtj3+3hzv3
         /KSYrOS8DSJLx9HIpLQJVR1l6cNPvJIAwjjt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931865; x=1693536665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4EGzm9bw0XByI1m8+dZAvw1r82ELdr/2MKF8VZnDhM=;
        b=UNCYn533UOBf9f/GiMiYQKgXjk5DMVT7jELHg7cbSvZA5fUK4uGWXy4M+Pzhg8m8yu
         Ml3hA2d4/UkyRHdl6eIlWXUCox4POJq+mgLK7848XtX+Zb7bapR3imOdvgEUCLwFutKr
         Mza4H8PpL85nbGfpOJu7NwXPFVuTIH/2Uz5FGgXfJPa6UFPgjM9+bDrQmVG7KR1wZc9F
         gva2+BOy3LasEsYjNQpbHv3lxawD8hjQWNsSbhi8/YO+xtheVUUaQkhlGFsGT13t7/z4
         4G/maEM7/Z/kGlmwjWF3M1hMai6lotGUErQaNrVBW5NuCPzqIx6PXa+LpYIJhznknA3S
         E8bA==
X-Gm-Message-State: AOJu0YzH/NpyuuAXjFChdWAYUlgBJe18SmloVJaBEBcu9ud7EKuZYzGQ
        Pv7u3QqynrFvCBT39RtieMzlIq59SYBMhiDo1nk=
X-Google-Smtp-Source: AGHT+IGNvt6/DD1lGIo+aVfNdQV4LtnbDVTQ3+AyPfWDl8BKFxGOBCCuVYRHGLggtterkcO3Ny3whg==
X-Received: by 2002:a05:6a20:2449:b0:13f:3d25:d83 with SMTP id t9-20020a056a20244900b0013f3d250d83mr18540213pzc.19.1692931864876;
        Thu, 24 Aug 2023 19:51:04 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:51:03 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 3/9] media: cros-ec-cec: Support multiple ports in set/get host commands
Date:   Fri, 25 Aug 2023 12:43:56 +1000
Message-ID: <20230825024735.1443836-4-rekanorman@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
References: <20230825024735.1443836-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the top four bits of the cmd field to specify the port number.
The reason for doing this as opposed to adding a separate uint8_t field
is it avoids the need to add new versions of these commands. The change
is backwards compatible since these bits were previously always zero, so
the default behaviour is to always operate on port 0.

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

(no changes since v1)

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 include/linux/platform_data/cros_ec_commands.h   | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index d76a25ae0cf1..e969031e1e0e 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -118,6 +118,7 @@ static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_LOGICAL_ADDRESS,
+		.port = port->port_num,
 		.val = logical_addr,
 	};
 	int ret;
@@ -162,6 +163,7 @@ static int cros_ec_cec_adap_enable(struct cec_adapter *adap, bool enable)
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
 	struct ec_params_cec_set params = {
 		.cmd = CEC_CMD_ENABLE,
+		.port = port->port_num,
 		.val = enable,
 	};
 	int ret;
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index cb2ddd10a613..e8bb05db360f 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4457,13 +4457,15 @@ struct ec_params_cec_write {
 /**
  * struct ec_params_cec_set - CEC parameters set
  * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @port: CEC port to set the parameter on
  * @val: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
  *	or 1 to enable CEC functionality, in case cmd is
  *	CEC_CMD_LOGICAL_ADDRESS, this field encodes the requested logical
  *	address between 0 and 15 or 0xff to unregister
  */
 struct ec_params_cec_set {
-	uint8_t cmd; /* enum cec_command */
+	uint8_t cmd : 4; /* enum cec_command */
+	uint8_t port : 4;
 	uint8_t val;
 } __ec_align1;
 
@@ -4473,9 +4475,11 @@ struct ec_params_cec_set {
 /**
  * struct ec_params_cec_get - CEC parameters get
  * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @port: CEC port to get the parameter on
  */
 struct ec_params_cec_get {
-	uint8_t cmd; /* enum cec_command */
+	uint8_t cmd : 4; /* enum cec_command */
+	uint8_t port : 4;
 } __ec_align1;
 
 /**
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

