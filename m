Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851A378BF75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjH2Hon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjH2HoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:44:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACC139;
        Tue, 29 Aug 2023 00:44:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26d0d376ec7so2603526a91.2;
        Tue, 29 Aug 2023 00:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693295046; x=1693899846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Zu/yfA83IhqeqQ5zzKooKbLInF8Rrcaq2xg/TxNWM=;
        b=PbIWLDstVbjSSFlL28D5cnwPog6QaNBxJ7N05T/+XG7KeWdbtiZEoqfWZupELYxZSF
         QGYo7SS88h+9O+Xz7k09D0/uScUO1p4h6by/VkfGf/1My9UTxgLeYl3Cg3HD3eDZhmpy
         z55Vu7OUvkGgBlVJgTYzUJsJnQgDn0IVbqH7yfgejxGN4YTT3oEEKDxO0Fe9QoAd+Dcj
         FyyaBGXwrW5PRP9KABi6MV5yTODSNLTA1lGoenxGLrSPt040ogh0bbUDOv6loKITifeR
         NWwgOpciNa83tGFp2fO4MFtxKU6HX8DcSrGDcxMY4Vh+2OgqvuPrUEvmmkl9x80w/TsQ
         eRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295046; x=1693899846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/Zu/yfA83IhqeqQ5zzKooKbLInF8Rrcaq2xg/TxNWM=;
        b=QAuv1DgkSR1xvjxH0F2SNswfWzat2Z+5ix+s3XGpccCqEwXPwGUDjyJhdGrmVojGK3
         gmWEOT4Tfe3GUY2n3uZ7RVIC9xzr/qwoZu10/+pGlErGHwmIIXCRvDAV3hDoBDQmiuLe
         9p6XmRrleggZlVqP93B13CXzCROAv4l85saKA8CaxLA/wv1LxEUM9RJdbBPLgX8WIWIG
         OYM8ob+xxF4Snkm5phV6bzg/agN0jul4/0s84ERt5tQCUOJpl63WpVfDpJ+aTWzjXnOr
         OVIDTx5RpbQFHPSnEsZZHFIhG+zcGWSFzr2sIn8AELSHsCXF8nhdWx8WoGX279csUTEQ
         cm1A==
X-Gm-Message-State: AOJu0Yx8GB3Ld7fjhXbUVpgV2rQpiKZHB+NdmzkMjimx+zlcWXMDTgqP
        vxTH72DSzvMLYVDVFLKnAIA8nufuma6Dqvut
X-Google-Smtp-Source: AGHT+IH4lr8hvVKQ7vOqr2mGYE3+fzg2CuBlkpV5CUz+MqPc/gFlYKiUAar7jIDKizcHGlghWKraWw==
X-Received: by 2002:a17:90b:19c3:b0:268:14d7:bc34 with SMTP id nm3-20020a17090b19c300b0026814d7bc34mr25659398pjb.20.1693295045487;
        Tue, 29 Aug 2023 00:44:05 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-191.hinet-ip.hinet.net. [220.133.92.191])
        by smtp.googlemail.com with ESMTPSA id 4-20020a17090a190400b002680dfd368dsm8849398pjg.51.2023.08.29.00.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:44:05 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     Jes.Sorensen@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: mark TOTOLINK N150UA V5/N150UA-B as tested
Date:   Tue, 29 Aug 2023 15:43:58 +0800
Message-ID: <20230829074358.14795-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
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

TOTOLINK N150UA V5/N150UA-B (VID=0x0bda, PID=0x2005) works fine with
the rtl8xxxu driver, so mark as tested.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5d102a1246a3..d1bb605e8b54 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7500,6 +7500,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		case 0x8179:
 		case 0xb711:
 		case 0xf192:
+		case 0x2005:
 			untested = 0;
 			break;
 		}
-- 
2.42.0

