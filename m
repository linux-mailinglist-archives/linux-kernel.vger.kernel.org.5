Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E57C92C3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjJNEj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNEj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:39:56 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF80C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4b9e09521so1805258a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 21:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1697258395; x=1697863195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVgUkrbypDA+3DDbFbDipwVPwWv7bmjtPwc2Y/SU16c=;
        b=EbN4btHrYFK7ZabmxRqjN8M3JI2xII9rYcIGiaHgrXYUnbHjIUNaayNUyaWWe0eTQB
         BeFgEohFfFVWu04Um26tEbVf2zzNrYgBjPprcI27d2Z+EmZmGWqCRjx9vj7SW1kgrSQp
         jp49TDD2Jij6pssoe/k65p7li34Fu8NpvF3nwNgIq5LQ+0LOlJYtQCr1QJjLoyEognkM
         lKnwd0jjDsXLeHRC5g2ALLuI19IbVbThMOLafp3xp091CSRFGsNs4R5re66X9UnYnFwR
         clV9jWuiEKHbzZbNGH0HHDCJPWBxxdrZQse4/iFQ1q2ovAsluGHaUTS4EYu2NE2blnTU
         dg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697258395; x=1697863195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVgUkrbypDA+3DDbFbDipwVPwWv7bmjtPwc2Y/SU16c=;
        b=Fi8ciqCI4DhDAlfFO+JAygsa9NiKw4hYSUuQ/rjf2hsmrYv44DhJDW8fV0aVs3dkTD
         fUWIXRc4SN/Rp9+nPx+5AChjcIbLMfz3y9yYaMalQ0hFO+rXbnNqgajpy33Wqm59m+Cy
         KFDHg3Heac/Zlc/zdNpn/timvXrKrRfKwpbXprjgk2u+XWT3uwDBvlnciRwFztN/hQ3i
         1k5WaKO1lZgXjpd5You3a+IzkLOguHbKPEBUzK6deE6ZOtAjgRWGsvyr/73afdGWUOHU
         yNN41Q9U5RH3+4Z5wXRn9TSMredXOzhodQyoshyltNzTGdpHqigfMSTc9dljYYblhPEa
         4P9A==
X-Gm-Message-State: AOJu0YzMbUZieihjDpmObXXMlzHILvn12h3CeDZsea465YndxxH4og+f
        l0MWGtU5gea/9ur6iT80XFkNPfniUbmUtFTA0gE=
X-Google-Smtp-Source: AGHT+IFcvg5VtOWiIvnM7eGTb7Y2fK1HiILGBSER3lfrwYe/HbiNk0U3pK96XC2jCUpAohP5tAcKaw==
X-Received: by 2002:a05:6358:590a:b0:14c:92ea:b4ff with SMTP id g10-20020a056358590a00b0014c92eab4ffmr32476293rwf.6.1697258394916;
        Fri, 13 Oct 2023 21:39:54 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm14271926pfm.109.2023.10.13.21.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:39:54 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/4] Staging: rtl8192e: Rename variable pBa
Date:   Fri, 13 Oct 2023 21:44:32 -0700
Message-ID: <20231014044435.11947-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014044435.11947-1-tdavies@darkphysics.net>
References: <20231014044435.11947-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pBa to ba to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index ec8edfecdb73..a2a0573c3444 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -43,11 +43,11 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
 
 static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *ts)
 {
-	struct ba_record *pBa = &ts->rx_admitted_ba_record;
+	struct ba_record *ba = &ts->rx_admitted_ba_record;
 	u8			bSendDELBA = false;
 
-	if (pBa->b_valid) {
-		deactivate_ba_entry(ieee, pBa);
+	if (ba->b_valid) {
+		deactivate_ba_entry(ieee, ba);
 		bSendDELBA = true;
 	}
 
-- 
2.39.2

