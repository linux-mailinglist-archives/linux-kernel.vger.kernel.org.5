Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFB759DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGSSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGSSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:42:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB427F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so6941414f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689792125; x=1692384125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrjkymWQEytm3ZEsWHkhp23Z4KQxMO3ORXG0AjMGsDw=;
        b=TckggQyziPAn3xmiAQXv2PciXO8X0PSzmy1GiTSSOloJ7PmzNRhVBvXIi+OhxGxCOt
         V1WYDpZ63YvfAhahRBeXrP/iloLgg+25SIJTIhmNG2J8MvnsroBwF+jgYI9wtWAzwfaQ
         BM4ZD6Ti9JGApvDzpH9eRgomPW6sjk0GEvRQRsSh8tCPs+symP4f95Fseaqp1vFEAGgT
         jEEeMuH+Hm4ORkGTHZ1C0n2ESPtJRIZsm1sPTInc2Ej+mN1VcxuOAbaCM9VaDoQnvP5A
         ATVIwPoHgYMF/aYMu27RntJ17ZmOaqkccb5GfY8l+0P7Ve7MMHydJg8sjrpmc59lCHOc
         PvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792125; x=1692384125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrjkymWQEytm3ZEsWHkhp23Z4KQxMO3ORXG0AjMGsDw=;
        b=P6GLXlEMnZvM/F3qhPyd8UkCoIGKbr9sNCTcuXdDTQqNwe3BoWQUydxSnDl1k6uLvS
         6o/84479tXddopm8WlPwGNIebNQGaMdj+dCGcrw9ouxFn0wGhsINqH5YIic1gP1FOoAp
         +0t1cK2htGauLmV0L/2FQrs1HVato8z/DUOlOc+56DMd44fWZRMjjtCVBchFVx2eUrZN
         qVRbNZXB63ArX/2lYmCwstClP7UnyBlglG+n2vkBgPjtlOQtMnueyaM1Ddh5871+3WCK
         dVLlIQ7QCDT2Gc9e+75c4IYoY0Af/mubhKp4YCY0MSVmIxzu8AzzzYLx7dFT1jmueBB5
         /sPw==
X-Gm-Message-State: ABy/qLYVJBifnZR46joUvnXeIKP5Itg/ByV4ssml3LnZga3zoSM3QhNt
        /bz81qKp9JZxGVNlde7sHY87ygOTikGoKhPjdugMQg==
X-Google-Smtp-Source: APBJJlHbdMsb7I2HjGqQtfegpmV8gfoG0PItgVLH8qX6gTM3nRUo4n++u3Rie849H2AllpORTMgs0Q==
X-Received: by 2002:a5d:4561:0:b0:316:e325:fd92 with SMTP id a1-20020a5d4561000000b00316e325fd92mr531092wrc.55.1689792124801;
        Wed, 19 Jul 2023 11:42:04 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n18-20020adffe12000000b003143be36d99sm5948877wrr.58.2023.07.19.11.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:42:04 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, linux@roeck-us.net, jdelvare@suse.com
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v3 1/3] peci: cpu: Add Intel Sapphire Rapids support
Date:   Wed, 19 Jul 2023 20:41:52 +0200
Message-ID: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for detection of Intel Sapphire Rapids processor based on
CPU family & model.

Sapphire Rapids Xeon processors with the family set to 6 and the
model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
is "spr".

Tested the patch series with AST2600 BMC with 4S Intel Sapphire Rapids
processors & verified by reading cpu & dimm temperature.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V3:
- Move spr entry at end of struct peci_cpu_device_ids
- Mention test with the patch.
Changes in V2:
- Refactored from previous patchset as seperate patch based on subsystem.
---
 drivers/peci/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index de4a7b3e5966..bd990acd92b8 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -323,6 +323,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.model	= INTEL_FAM6_ICELAKE_D,
 		.data	= "icxd",
 	},
+	{ /* Sapphire Rapids Xeon */
+		.family	= 6,
+		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
+		.data	= "spr",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(peci, peci_cpu_device_ids);

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

