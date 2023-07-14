Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD2753C12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjGNNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjGNNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5835A0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso3347656e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342690; x=1691934690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBRkWVB0g8Qm8dyh6//o7Lwn4Q/uU6uVP9gh0M6sy3E=;
        b=Zi6m+bT1LbXG3N25RVbGeYgxQ56d0Diy7az6zxJQxnUUTzeZKdpCWT7EexnOSqVO+I
         +PKvpO1facfQ0DHxNSVICdVH0UOesiAUkHlDUZswzriCZh1MMZx/VLuA+BCG61YXZLrU
         qTHBjc4AL/ao7lyeiEBPpYloHZuoBCM2m9O++P2qXnW+DUKvV+5JucEo/jSwIb5LxQx4
         SU3zMn1ha3oYgC/JpSKD/tAt11u5tdVyN4IVUubZIoGsZXkuOtkX+k5EKBjc0EbViE5i
         K0Yrj5PdZkNkSOTb5GUB6KiGXpSu34fIpNmT36pS4yJC7egfxF1UMZPNwacDKqkQfDzi
         f/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342690; x=1691934690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBRkWVB0g8Qm8dyh6//o7Lwn4Q/uU6uVP9gh0M6sy3E=;
        b=S6jtE1z+vbusSjI2At85/r45/vIL3n1WpygA9ua9QtFdXF/hE7mBkAnKqipaPdaDlA
         FmS133Z5Red6bo5gtGNaFUKelqZ03oWh/SH2cULyN2i6CD4j4MeBacszfpUiK0W7Y0Ld
         KTBo4Zy/djJTUD9NKpymzQQC4PCMkR2zOLxysOyK0Ma8ghQ6iY9ZTk76DKK0wCnZL11g
         TF8j/1iaTvnjjspdRryFd4I1UB69ooisjj+jB2WB87k9QrcaGV8PWFkH0TozoIYRn6np
         9DkngzNoESvLVYqr/Rgeg0P7hCJDKPn//r6ei4tUTBKuaPrx2l61CJdTIBwZqb+w2aNL
         Zrqw==
X-Gm-Message-State: ABy/qLYPtSQXeozVmN1Z7O23BTpZdzYyEuxMGPr2lpAL4X50T4SPNiLR
        0V7Pn2Dq3+CYJ18OQnBf7e+sSw==
X-Google-Smtp-Source: APBJJlEuLw1IGzH4fZS1r8RK5XTuiItRrFc/00qhHzD6ekUP9PRWebDQk9UN1vFtpSECd0OXh3o4nA==
X-Received: by 2002:a2e:9c97:0:b0:2b6:dec9:2812 with SMTP id x23-20020a2e9c97000000b002b6dec92812mr4342904lji.33.1689342689670;
        Fri, 14 Jul 2023 06:51:29 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:29 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 1/8] hwmon: (pmbus/mp2975) Fix whitespace error
Date:   Fri, 14 Jul 2023 15:51:09 +0200
Message-ID: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Fix whitespace error reported by checkpatch.pl

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 2109b0458a8b..130cfde52e42 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -600,7 +600,7 @@ mp2975_vout_ov_scale_get(struct i2c_client *client, struct mp2975_data *data,
 	if (ret < 0)
 		return ret;
 	thres_dev = ret & MP2975_PRT_THRES_DIV_OV_EN ? MP2975_PROT_DEV_OV_ON :
-	                                               MP2975_PROT_DEV_OV_OFF;
+						       MP2975_PROT_DEV_OV_OFF;
 
 	/* Select the gain of remote sense amplifier. */
 	ret = i2c_smbus_read_word_data(client, PMBUS_VOUT_SCALE_LOOP);

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

