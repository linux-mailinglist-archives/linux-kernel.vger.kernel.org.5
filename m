Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF076254C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGYWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGYWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:01 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA97BC;
        Tue, 25 Jul 2023 15:01:00 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-565db4666d7so3761602eaf.0;
        Tue, 25 Jul 2023 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322459; x=1690927259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUZnk3BJHa8i4G+I5FHI1a5ZCFbsEeNLgSVmJzgYbxk=;
        b=XVK1FzTn/TccXCjpTjt4Pf6a69wnwkxxmHdsFbn42YM2M4vBpG1M4prm2pxLW7iMwb
         uZQbixtobzfmh9gLPJ+pgLfuyfWnGX2TiVWggmdqsfsxE/zrHdbRUbvWB3USqA3bEtMI
         PjPLe32eJNSaKLmxx4YIeiF2PLzzAHnp7WVo/wPq34UgfQvRjJ34u9jeGQgz1s2qmIvF
         g9c55G8A1MynG6olwvA77cUcjqSdyAgtw/DVD81YZGnjmZgw9wySkd5jHjom/NPTD9CB
         w2KU9o+XcURSi03JKAtuk1kts/CReVvTu6TU2tIFkYWvpDhaKbMAKw5EdrM9yFDW4cSL
         fjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322459; x=1690927259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUZnk3BJHa8i4G+I5FHI1a5ZCFbsEeNLgSVmJzgYbxk=;
        b=UqzTTOJ+IWgBLKsd6Bhm25yfFxoI3b9eAw+7HgWnmaYY/1SMI95fhAwoWSRZutG1Wr
         v9bvUGsz8DIjAv2IGo3b84NKHt+nGBwXw6C0gXa2ZSBETUmFGT7/6dkls1ioQq2xLt9L
         cnvKcmcQ5MNAXEPZ4pm8PmMKJdvGSrOoNuHYngOKaaMNUns8wviGb9JTCuOu9KGgBbqP
         jAyJ06Z3GlwL69TMe+RikjyJKzfZHZhaVZYCqiVVBK2TICltF80TH1e8uDLyuwxpPJRX
         Q3CsJFE/rVm7t6krd8NNXE6PnGfu3suqNw7znyoTk+V2Zcz6fdtltghWFbJrb+tEZZab
         Xihg==
X-Gm-Message-State: ABy/qLaBvn0FsSAA/W6zK3BtZhMT4xYge6df/VozL5nhuayi7ZuAzqIP
        g52g3PYGAKe/ZlCC3tNdS3M=
X-Google-Smtp-Source: APBJJlFHbPlurwcX03fBvkaEqCG30OPkMJnrFKVl1kvNbFWF5Iu6L7x7GY8nuxej+cWPcjRmow0TZQ==
X-Received: by 2002:a4a:3c17:0:b0:565:bbc0:2e36 with SMTP id d23-20020a4a3c17000000b00565bbc02e36mr98675ooa.3.1690322459704;
        Tue, 25 Jul 2023 15:00:59 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:00:59 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 1/5] hp-bioscfg: Fix memory leaks in string_elements_from_package()
Date:   Tue, 25 Jul 2023 17:00:52 -0500
Message-Id: <20230725220056.25560-2-jorge.lopez2@hp.com>
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

Address memory leaks in hp_populate_string_elements_from_package()
and uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index 1b62e372fb9e..e0ecdfca4def 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -133,7 +133,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 	char *str_value = NULL;
 	int value_len;
 	int ret = 0;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
@@ -171,6 +171,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 		if (expected_string_types[eloc] != string_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_string_types[eloc], elem, string_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -232,6 +233,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 					str_value,
 					sizeof(string_data->common.prerequisites[reqs]));
 				kfree(str_value);
+				str_value = NULL;
 			}
 			break;
 
@@ -250,6 +252,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 		}
 
 		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_string_package:
-- 
2.34.1

