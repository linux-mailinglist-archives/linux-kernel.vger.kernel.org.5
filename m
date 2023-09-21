Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9E7A913C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIUDVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIUDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DCDF5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so367347b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266488; x=1695871288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StW5zsKeSvz+DEv2OOBJ7Wx1dEbg+TZgl1CucyYuVng=;
        b=UnjYMHp00+X3tG9+vxrJmUsmL+a7yBW/Tr10zGmWrI//w+VABfMLtwLc0pPIPbr49n
         cbYZE07LrU+7G9S0AbOeTi3GtOmlRFzkPwCtDYjJpPafcF6s0Kv3dXX6VlxQFQkeT811
         eXLWzFNB+x8lLdxvG2Zctq/7VpTG9zM4mTbjy+mkmWsTIuPOB9kX1tn64/VJRxItHJov
         NeXWVNQJNFzFfWYA9ZEMLLZ/ZVc7munghXwOHp1BBg/kr1BP/TPiQXUvflpo5SwkdIBt
         9pGDxUfwlRogsbe/PgpbdPFntWyeIqlr37nIQoKqTSoHPppxH9NAxs2q3+EtTFZgP6uK
         f3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266488; x=1695871288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StW5zsKeSvz+DEv2OOBJ7Wx1dEbg+TZgl1CucyYuVng=;
        b=A/GNNqrQcedJmghdoQ8dvt1NokGjnNTeVh8TFTK16oxlqUzXeco2XsbEmFw9b+nBhJ
         09u3FvZra9smVg9PKKTvfHtMDVGn78ZWh+qD7aQRQtQR0PDGq7Nkl7SvgLZhBnPSecbk
         tp/MXtN9dPXo57Z/T5QxUIj9yiSMv1ziDSSydMIkCT2ONm7qAry4b1oHTKZtfw4zuFFj
         hquMe7ur0/HQzLI4PsX0PaLZ4e+ZaNmxsacvxBqquvVYCj1I+ylOFQzFlH3vPuTG9oTH
         4+XwKUlTa2ALDMoHcTtmvpUfDT+L9sJOMo2ldBNrAumELerhrrBvyeAKfk8HUZL39VaB
         LskQ==
X-Gm-Message-State: AOJu0Yxp1gHqSqtpd90rLBd9VsOYJuBkU2t5BcJogLr/r0j//eG90a6P
        oH7CZazjC8M6EhecZaBpBqcOg/gESDX8v0FHGO0=
X-Google-Smtp-Source: AGHT+IFOT40v/uD29kHC/ebiDvSyvsTMBnwVUwjtjyjzT5dTl1h815XNxDrPhOQmNYU+Bax3F8yvYA==
X-Received: by 2002:a05:6a00:1347:b0:68e:3fe6:2c82 with SMTP id k7-20020a056a00134700b0068e3fe62c82mr4404882pfu.34.1695266488559;
        Wed, 20 Sep 2023 20:21:28 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:28 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/11] Staging: rtl8192e: Rename variable pPendingBa
Date:   Wed, 20 Sep 2023 20:25:07 -0700
Message-ID: <20230921032515.96152-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pPendingBa to pending_ba to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a12966cadbca..5642e7788e42 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -26,11 +26,11 @@ static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pB
 static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs)
 {
 	struct ba_record *admitted_ba = &pTxTs->TxAdmittedBARecord;
-	struct ba_record *pPendingBa = &pTxTs->TxPendingBARecord;
+	struct ba_record *pending_ba = &pTxTs->TxPendingBARecord;
 	u8 bSendDELBA = false;
 
-	if (pPendingBa->b_valid) {
-		deactivate_ba_entry(ieee, pPendingBa);
+	if (pending_ba->b_valid) {
+		deactivate_ba_entry(ieee, pending_ba);
 		bSendDELBA = true;
 	}
 
-- 
2.39.2

