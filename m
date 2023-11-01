Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A50C7DDECE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjKAJzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:55:40 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202FF3;
        Wed,  1 Nov 2023 02:55:36 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507a0907896so9425349e87.2;
        Wed, 01 Nov 2023 02:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698832534; x=1699437334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLokDDeUmqYRRJWiE6rl7SGUQtXK/4RB+bpLxyFfC4Y=;
        b=dc5aeUZ8Alxs+4WtBYAuF1MrwtaZW6j2a2cEMYjjU+86P8LAlJec8wmNkrEaBD0Lnf
         ok+DFIJxoMnZ9PnT6IT2kSCv4w6xzk1N0vCzsrkfw10MDS8JBral9P6h9gj80nkWlQh8
         cr+hv3zB5qT2Hh2liwq9eH1Y2oqlQM7HQdMI1MIwM/IBtEbc0abhuxlA1tAA4yMri8D3
         txyyL8RMFdPpv9WZTyMc9g3fh0Re/jEiqgKX5cN1wQs7QeH81g0Xi4a/zOfI6Ilz3nkr
         1pmuKkY21kEiZVUDsS68idBSG9MGmByHAeC0i5N2xAr16X8dNkZ1lS7tNzcCpoE0XuMI
         6N3g==
X-Gm-Message-State: AOJu0Yxk9z1QRR8tgkNiCusYr9bRxdJD1j7DCheB83kwfGs7kwX2cX77
        d7a6SEpFlkyElC3aLvYDLqwAVyeI6CrkNQ==
X-Google-Smtp-Source: AGHT+IG9dIQGWQj/99HHkunl3VNNLt6J/GTKRcX+Vc0XmliTPanSMBlSHaGQwMaxqaA0wqC+H4+DVA==
X-Received: by 2002:a05:6512:ba7:b0:509:2b82:385c with SMTP id b39-20020a0565120ba700b005092b82385cmr5894208lfv.61.1698832534082;
        Wed, 01 Nov 2023 02:55:34 -0700 (PDT)
Received: from redmibookpro.tendawifi.com ([217.155.96.227])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d5092000000b0032db8f7f378sm3723707wrt.71.2023.11.01.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:55:33 -0700 (PDT)
From:   Tom Waldron <tom@baremetal.dev>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Tom Waldron <tom@baremetal.dev>
Subject: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for MT7922
Date:   Wed,  1 Nov 2023 09:55:33 +0000
Message-ID: <20231101095533.45258-1-tom@baremetal.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
Change tested on Redmi Book Pro 15 2023 (Fedora 38).

Signed-off-by: Tom Waldron <tom@baremetal.dev>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 3dda84a93..ba805cb02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -21,6 +21,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
 		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(0x0b48, 0x7922),
+		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
 	{ },
 };
 
-- 
2.41.0

