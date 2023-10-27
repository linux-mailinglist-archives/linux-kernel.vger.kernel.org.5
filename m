Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9607D92AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjJ0Iw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbjJ0Iwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:37 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D021B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:34 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5869914484fso999885eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396754; x=1699001554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odtp1UBA19+ficrtQPWbxsKa6nO8M/UF+tBujmgQ4Mo=;
        b=YSYbBM3PUcovVCgkyhbUUzVf0s+/qobq3971lOiv9C0JxDPGdyBGOju1K7JOxr3uWo
         MLSSqGGWy0/P8huJl/1HQ0uTMO9hKb7ALOyV6XjG7YCe+QJS6TaAmZCg9lg6CXcv+LFf
         +YdISI/+BAI7xn8UQyIe8hkeb2QUqwOfBYMF4JGbF5kvIpfL2fVa1Cu9iUw1XqSytkt1
         doyacKSrk/3JMzdY6tty6CAnhNtcADCDmPi/CSWw/S0LxqZHbTq2XwukbXmjFt9xhMj2
         fAiRPkcVIGltPaeygSwJc4Zp2h6BsQMSxkn0rdtFtGDGM0jhVg8GLXFIZvT4jQaYjqR9
         18MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396754; x=1699001554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odtp1UBA19+ficrtQPWbxsKa6nO8M/UF+tBujmgQ4Mo=;
        b=xF4Xmpg7j18ZaHfoolF2bpkRnRByPP//dNdAJgmZOZ/+vJzrnZ+fP3HkBQFhcnSLaB
         1+kgLFbrvwRZ0OMz1GxOpujVGPNmFtvsLS7pr4l/qzXHqrOqQifFMkCD0KuuOYJNy0pq
         9M3GqLe0RbO77/tW5VG/gspvWUpcDPQAAh+LcG9ghKuzY0sidIGR0M6yBOy5UVwxwwry
         7KT8QG8xfOUqMgpXg1jrUsfmvp95r4Tc50zi8WJRkJHQvHMOJV8Nv0jVX/fMQhh4E0sW
         PFQ9QRe9tSjwYBK5FrlEOeaPaSO/VLtuyVwIjjDdoSrOc6MHOwz+6/7Q3amgIj0UWGP/
         /MtA==
X-Gm-Message-State: AOJu0Ywdu60AURrue/rJX9gdEXsyMFO0gUEtShdXprluTLoK1vUirXZG
        I3xYYio+ITmH4H4tMgezBnr7bQCgTPo=
X-Google-Smtp-Source: AGHT+IElPngMjVW0JTG2kjBPqUelLmUVA/04PHfBS5k0JGhHYPZWDZ5RsfjL2YcyLck+gCv2sxgv4Q==
X-Received: by 2002:a05:6358:881f:b0:169:81e:b6e0 with SMTP id hv31-20020a056358881f00b00169081eb6e0mr2832291rwb.24.1698396753849;
        Fri, 27 Oct 2023 01:52:33 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:33 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 08/10] staging: vt6655: Type encoding info dropped from function name "CARDvSetRSPINF"
Date:   Fri, 27 Oct 2023 14:21:57 +0530
Message-Id: <63ab11bce827d20cf30eafd874d96128a6e969f8.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698396278.git.opensource206@gmail.com>
References: <cover.1698396278.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function name "CARDvSetRSPINF" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 6 +++---
 drivers/staging/vt6655/card.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 7d632d1057c0..56beaf6de488 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -6,7 +6,7 @@
  * Purpose: Provide functions to setup NIC operation mode
  * Functions:
  *      s_vSafeResetTx - Rest Tx
- *      CARDvSetRSPINF - Set RSPINF
+ *      card_set_rspinf - Set RSPINF
  *      CARDvUpdateBasicTopRate - Update BasicTopRate
  *      CARDbAddBasicRate - Add to BasicRateSet
  *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
@@ -267,7 +267,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
 
 	priv->packet_type = card_get_pkt_type(priv);
 
-	CARDvSetRSPINF(priv, bb_type);
+	card_set_rspinf(priv, bb_type);
 
 	return true;
 }
@@ -536,7 +536,7 @@ static unsigned short CARDwGetOFDMControlRate(struct vnt_private *priv,
  *
  * Return Value: None.
  */
-void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
+void card_set_rspinf(struct vnt_private *priv, u8 bb_type)
 {
 	union vnt_phy_field_swap phy;
 	unsigned char byTxRate, byRsvTime;      /* For OFDM */
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 6564682bcd56..b36e276c699b 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -39,7 +39,7 @@
 
 struct vnt_private;
 
-void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type);
+void card_set_rspinf(struct vnt_private *priv, u8 bb_type);
 void CARDvUpdateBasicTopRate(struct vnt_private *priv);
 bool CARDbIsOFDMinBasicRate(struct vnt_private *priv);
 void CARDvSetFirstNextTBTT(struct vnt_private *priv,
-- 
2.34.1

