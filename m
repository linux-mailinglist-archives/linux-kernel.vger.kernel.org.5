Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42C2762553
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGYWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjGYWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:05 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2C10F7;
        Tue, 25 Jul 2023 15:01:04 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56597d949b1so3705463eaf.1;
        Tue, 25 Jul 2023 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322464; x=1690927264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlHDiRN/74XK66bPeSMdSDzuItYNuBd/sWX4Lk9V5K4=;
        b=KsOoW0/UYyCasvjpUcBWZGybkq77ggoF64/KVTROZHUg7t4UsJHRhNJhFDaCaJHmT+
         mbS2cKxdL+VcKh1Tkgg9OAO4+b1/os+zBgduv1/4TCNUbID9oNrwl+BKKshjntdAP0wX
         jmF6tom/PS4EXxGSdIoRPFb4IBGV5OHOfY+IntfdGIbWMCIHTyTBLzILazAiEfdn2Uv+
         GQPmw1muwn0GzkhnKYuBo+31b0r1DfuN8V/UDbgSbS0N9Aie9eQK4nxd48ACx2UmZ+5p
         Tm/A6x99m4ZyuNJK2RZXRhvA2BiCT6kX6foiUMx9oJgFJWDqb9UmFlgZfl4ZcpVmtcHI
         ocQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322464; x=1690927264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlHDiRN/74XK66bPeSMdSDzuItYNuBd/sWX4Lk9V5K4=;
        b=XyTB/fz5SjrEKH9/LIoI7BiYvS5MKj5EEHUa5I+Ke7SO7JohLUAJGmT2HCOpn+d5gz
         HmI259XD/jsmj4Ov8SVqg3v4rNgBf/H5sw9ce0OQ1eKh+upZGUv068nPdkOHspphq80r
         vK88zASILZ8uGol5f6pejgIzUIyZULiQKlzknrHTCiRLey1ffKzPGbJ9IFUkMVqA7ufq
         SHbBL1HsJ6ntQLsYCHxAcdR3TMNHruiUQ+9Dlk/1zwVRfD4fGjHqPaYD6MWqnAbRb8g8
         /JW7TcLzs1BVeXo5RFlaj79QRHgwaBWeGlaVtVjz9BLtMLN2wap6seNCaEt+Ec5Z1S09
         g4/Q==
X-Gm-Message-State: ABy/qLbypEYva8Dmcaff0xjeKTrpl7vT0MkA735sFe04vfSu7m3N6S8V
        9+/+/gOuqLfKWiwHFLwkde0=
X-Google-Smtp-Source: APBJJlFlASPlPNtudufA2pchYAMlHntVETCvEJzLhbTM7Wk4vs2JCz22sHcADZZ/gWVfMi3xK6HMeg==
X-Received: by 2002:a4a:344a:0:b0:566:f763:8fb7 with SMTP id n10-20020a4a344a000000b00566f7638fb7mr88949oof.2.1690322464072;
        Tue, 25 Jul 2023 15:01:04 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:01:03 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 4/5] hp-bioscfg: Fix memory leaks in enumeration_elements_from_package()
Date:   Tue, 25 Jul 2023 17:00:55 -0500
Message-Id: <20230725220056.25560-5-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725220056.25560-1-jorge.lopez2@hp.com>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address memory leaks in hp_populate_enumeration_elements_from_package()
and uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index b1b241f0205a..7f77963cd7fa 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -129,7 +129,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 	char *str_value = NULL;
 	int value_len;
 	u32 size = 0;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem = 0;
 	int reqs;
 	int pos_values;
@@ -164,6 +164,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		if (expected_enum_types[eloc] != enum_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_enum_types[eloc], elem, enum_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -224,6 +225,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					sizeof(enum_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -275,6 +277,9 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 					strscpy(enum_data->possible_values[pos_values],
 						str_value,
 						sizeof(enum_data->possible_values[pos_values]));
+
+				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 		default:
@@ -283,6 +288,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 		}
 
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_enumeration_package:
-- 
2.34.1

