Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B07EC8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKOQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKOQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:41:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6784A6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:41:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so990372366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700066513; x=1700671313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XNxDiyKp4W5O/tS6HH2qR36VGTSLe28AYygQ5DVa2g=;
        b=ScFampvyqMKdTpIkP99SBJJlSscRNhXcTQDUSOxfSIFeWQzX3W58gYN6dE1kXzpGy8
         JQCK3MtItbbi9Z7xb5olTc0Uxh/tcH4VbJyWsSVzHKeGB0kdqbaPgPEczq6abNrMfsfW
         F0aTOGWXqF0cngb+hX2GgMVP7bzzuZYwnl6nl4oUwkImlDRch6nFRNo96uTiwr9k8YXl
         ZZfrrnXRKaaz0ruEhOekBvEzhnMvGmwbN/N51Wc/gOrojrLCSsm92QC9ewP/5yULEsAF
         +SPIielqNtIf3+c9h+DvMit9vfsMo9W4cmKxawf2RG4IB9Mf12B4x0RY5z6u9GK9qyQM
         x+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066513; x=1700671313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XNxDiyKp4W5O/tS6HH2qR36VGTSLe28AYygQ5DVa2g=;
        b=HcYFvO7aYakc+nvtOO0Db1Qw27MFw1iPngDqQtMmm9W2kwQbISPo6ChEkzWED3xBjt
         uloO4eKUOnHSdqlHterQJnMGu/LMjCOknu4l4bENQ3PAkACWEdve46AuVmnV4zhHdeaV
         XaT5XPBVlV7/LAeiXlO/PiO3j1zSYJK9wtIQALnE5MVkpCnaBhYogbcuuvww2u3USHHL
         o+nrH7Zbb8skgzsB4NTijJyKyxkPUGBq1ORoYEOUPeJlLK+8Tqg/Z3oUjtYvNo7xn5vO
         +Y3FJNrChml2G5xsVb2G11B0aSpAM+7hxRZOwyz2J/RfcWqEoK17ETZdC+XSFHRqo+YJ
         i74Q==
X-Gm-Message-State: AOJu0YySXQ02iAZskPYaGFBKrZRqUiWBV4/b9jTvN5noK41vVxofh1Nm
        x0TAwQVIamAVCqAHo+SVCAn2P8zJRR76uubvbTI=
X-Google-Smtp-Source: AGHT+IG3jR5IuczZHrF1wkzd4fyrB79VWdV6Vvw9D4CrZC6aBvALUsFLoA3fWz134e/kITNQrHY6bA==
X-Received: by 2002:a17:907:3dac:b0:9e6:59d5:7bb2 with SMTP id he44-20020a1709073dac00b009e659d57bb2mr14900957ejc.18.1700066513210;
        Wed, 15 Nov 2023 08:41:53 -0800 (PST)
Received: from sleipner.berto.se (p4fca249c.dip0.t-ipconnect.de. [79.202.36.156])
        by smtp.googlemail.com with ESMTPSA id lx20-20020a170906af1400b009e5f5efac10sm7203451ejb.208.2023.11.15.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:41:52 -0800 (PST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] MAINTAINERS: Add missing bindings for max96712
Date:   Wed, 15 Nov 2023 17:41:27 +0100
Message-ID: <20231115164127.2790596-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation to the entry in the MAINTAINERS file.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c9f868e13b6..ea14bd4198a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13014,6 +13014,7 @@ MAX96712 QUAD GMSL2 DESERIALIZER DRIVER
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
 F:	drivers/staging/media/max96712/max96712.c
 
 MAX9860 MONO AUDIO VOICE CODEC DRIVER
-- 
2.42.1

