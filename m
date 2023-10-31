Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414EA7DC5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjJaFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7773DDF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c434c33ec0so40330545ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730493; x=1699335293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5XLM640bv+J0vNNG10yGetIJPvzUtgJiAwDN315ob0=;
        b=NChUJOMHarB6ZTiusBMMh93AdMtUYZ/MSw4s6SuElXUhJ+phIhzB90qqJHGEPaUZj7
         0mius9l35ezf/MK/4red65xIxmj4B9dW+WVYxWZFR6fBlJBc+ZM7X5WgTK14j0POlwIE
         jRxbuXwUzOxQDLVkczI5+YNggjPR7np2VI2bX5F9B8MVo7iofwKrl9n5GAtpH+2Iycml
         B3Bb2LinH1bE+pjF3rQygJKsuXRjt/1VV4cFR+5nCnNQytPoD080RqtU0XQ4J3oNPJ42
         0eKJ+uLGbvMcOqzOYu+6/7eKw32OFCBLgqkEIdjrxLO5jTT3C1ndJplwvYV0m6EV+izw
         r3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730493; x=1699335293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5XLM640bv+J0vNNG10yGetIJPvzUtgJiAwDN315ob0=;
        b=wfl5jbycRtCC8uZksj575twsNDq5dr6IF0NqC0lX9XL3C/nEEmn9RUSB5Wt8XJpPS/
         Owgiwphx2T8byCD2avToE2qQk8a3nuLLDXd7ZS6HRU5OCvQIXSUbMTxwhrr+nalnRd7w
         gJglD+kaDdBvVPC2dqsOTOCDHdKzPpvsyeZHilatwECLUcwMJTek1EkBu+jMLiYvmmYr
         UFui/6mjjzkJTeSYlAfADpzE43fI4e23sMiHCl8ekq0Zku6QFYu0vW/kwI/g4C7JcCwm
         hs1GojmbaZyufdqKO8I5DfOoBB5KgiQujqz73BmGlSXYSN2J7Idd8IyEdhlhicfa8G8B
         HTSQ==
X-Gm-Message-State: AOJu0YwavewgermpEp8eZMo967n5V2zAPoi5rTaup/MHwbIxilge397l
        /V9jf4/E2xyalTtyYrfthoM=
X-Google-Smtp-Source: AGHT+IFXqOC/pjhUca0vvLn2/xRT3KFmprpUEOA5nv5+MiueHmEpc8Z1GLdvCMlD4UhZq+kMmKXszg==
X-Received: by 2002:a17:902:f305:b0:1c4:44a0:5c03 with SMTP id c5-20020a170902f30500b001c444a05c03mr8231269ple.9.1698730493314;
        Mon, 30 Oct 2023 22:34:53 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:53 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 06/11] staging: vt6655: Type encoding info dropped from variable name "qwNextTBTT"
Date:   Tue, 31 Oct 2023 11:04:29 +0530
Message-Id: <6b1fe342f7577c46a980cdc1bee0c7f560f05d87.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "qwTSFOffset" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index c18cbf0aad75..e4b40125b094 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -323,19 +323,19 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 bool card_set_beacon_period(struct vnt_private *priv,
 			  unsigned short beacon_interval)
 {
-	u64 qwNextTBTT;
+	u64 next_tbtt;
 
-	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
+	next_tbtt = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, beacon_interval);
+	next_tbtt = CARDqGetNextTBTT(next_tbtt, beacon_interval);
 
 	/* set HW beacon interval */
 	iowrite16(beacon_interval, priv->port_offset + MAC_REG_BI);
 	priv->beacon_interval = beacon_interval;
 	/* Set NextTBTT */
-	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
-	iowrite32((u32)qwNextTBTT, priv->port_offset + MAC_REG_NEXTTBTT);
-	iowrite32((u32)(qwNextTBTT >> 32), priv->port_offset + MAC_REG_NEXTTBTT + 4);
+	next_tbtt =  le64_to_cpu(next_tbtt);
+	iowrite32((u32)next_tbtt, priv->port_offset + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(next_tbtt >> 32), priv->port_offset + MAC_REG_NEXTTBTT + 4);
 	vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 
 	return true;
@@ -795,15 +795,15 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short beacon_interval)
 {
 	void __iomem *iobase = priv->port_offset;
-	u64 qwNextTBTT;
+	u64 next_tbtt;
 
-	qwNextTBTT = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
+	next_tbtt = vt6655_get_current_tsf(priv); /* Get Local TSF counter */
 
-	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, beacon_interval);
+	next_tbtt = CARDqGetNextTBTT(next_tbtt, beacon_interval);
 	/* Set NextTBTT */
-	qwNextTBTT =  le64_to_cpu(qwNextTBTT);
-	iowrite32((u32)qwNextTBTT, iobase + MAC_REG_NEXTTBTT);
-	iowrite32((u32)(qwNextTBTT >> 32), iobase + MAC_REG_NEXTTBTT + 4);
+	next_tbtt =  le64_to_cpu(next_tbtt);
+	iowrite32((u32)next_tbtt, iobase + MAC_REG_NEXTTBTT);
+	iowrite32((u32)(next_tbtt >> 32), iobase + MAC_REG_NEXTTBTT + 4);
 	vt6655_mac_reg_bits_on(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 }
 
-- 
2.34.1

