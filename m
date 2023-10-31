Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF37DC60E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjJaFnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjJaFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:43:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB60FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da37522a363so475669276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730998; x=1699335798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/fqNuzQYQazb2cxHMITyfFuFwOyOR7YqTCdq7dtzbk=;
        b=mLzCYMkz/wgx6zeU8wZM33Sz3wUVhLjeeoGyxEnfs7TAYH/S9P5jGFlbE4/gioJ3BP
         v372R7yeGm4x8v6Yv+mHyfZ+o8rLqCPWUa2Y5IVz4aDrWI/4csQqVAkocQJDaRtFWYoH
         ZeJ2EUKtuYjVu0ekn9uvXjGELDg4/NDwvwVIbpJqd/eT7D+UleMmBVYQKuYCZ6yDtXHI
         8pUtOdFmNK5deynB4XsmWJZMAQxXeHmRbfEQVT38Csuiz5joVL5Xf7qf5DVPeZWGWHQp
         kQ66yAx8Vo2S4Q546WMZVDG/IBDXtdBs9aZKul2pxc4QzO+TvBahovpDLBsWeR8aB3Ib
         48qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730998; x=1699335798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/fqNuzQYQazb2cxHMITyfFuFwOyOR7YqTCdq7dtzbk=;
        b=DeyVo1s4I9jgNFnYvqjtC5Rf/Wj63TAzUTLIkJRsK4gh6iy690SDEOAlAZbTGIH+VO
         xFPeIaCwttvVr8eoOTC4PswaHab25UxJbFk/a2zEneSRRdpygAq2EKPoU5Ip/Mjutidz
         2HUssdKq3iv5S9ioPPq8XynhKq/1SN83rdLZl6Mpx6lYpW6MtBGjF+VyjMi1L6HCRA5w
         eRFUVQTJ2wJy65kfo6Wy/dAQhwNXDgTFJfG8OrvQ+h6tbiLSvNtBZesuPuZEMqPOScgj
         yD4JK3JIUBN/96t0VIpsGs4PZpZ7NwxlMrNAcWZuv9x76dxsFacs2xwN9gsrXsqNDwkj
         hvaw==
X-Gm-Message-State: AOJu0Yy+I9rV9JtjsNJUtWT4oDYNLSXBgSx2Wgx4+L0K0Ds8gpMUmX26
        agsBdw7ZOnnbJD4gzxbSGmgj1Xu20yw=
X-Google-Smtp-Source: AGHT+IHDsDazw2uQJ+MBPbaAvd5OLst4nxkyeJrht3pxyxUHOxto0rV3E/BaeQ8ahh1dFBG3cuyNaQ==
X-Received: by 2002:a17:903:2341:b0:1cc:449b:41e3 with SMTP id c1-20020a170903234100b001cc449b41e3mr4936574plh.59.1698730487444;
        Mon, 30 Oct 2023 22:34:47 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:47 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 03/11] staging: vt6655: Type encoding info dropped from function name "CARDqGetTSFOffset"
Date:   Tue, 31 Oct 2023 11:04:26 +0530
Message-Id: <b6b86bd65669cae59ca10171ecee8aa4a13c4a26.1698730318.git.opensource206@gmail.com>
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

function name "CARDqGetTSFOffset" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 6 +++---
 drivers/staging/vt6655/card.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index e0af14eb7cd4..1edf65e2adcf 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -10,7 +10,7 @@
  *      CARDvUpdateBasicTopRate - Update BasicTopRate
  *      CARDbAddBasicRate - Add to BasicRateSet
  *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
- *      CARDqGetTSFOffset - Calculate TSFOffset
+ *      card_get_tsf_offset - Calculate TSFOffset
  *      vt6655_get_current_tsf - Read Current NIC TSF counter
  *      CARDqGetNextTBTT - Calculate Next Beacon TSF counter
  *      CARDvSetFirstNextTBTT - Set NIC Beacon time
@@ -296,7 +296,7 @@ bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 	local_tsf = vt6655_get_current_tsf(priv);
 
 	if (bss_timestamp != local_tsf) {
-		tsf_offset = CARDqGetTSFOffset(rx_rate, bss_timestamp,
+		tsf_offset = card_get_tsf_offset(rx_rate, bss_timestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
 		tsf_offset =  le64_to_cpu(tsf_offset);
@@ -708,7 +708,7 @@ unsigned char card_get_pkt_type(struct vnt_private *priv)
  *
  * Return Value: TSF Offset value
  */
-u64 CARDqGetTSFOffset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2)
+u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2)
 {
 	unsigned short wRxBcnTSFOffst;
 
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index cda969b06fce..df1b9a7c1f21 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -48,7 +48,7 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
 u64 vt6655_get_current_tsf(struct vnt_private *priv);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
-u64 CARDqGetTSFOffset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
+u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
-- 
2.34.1

