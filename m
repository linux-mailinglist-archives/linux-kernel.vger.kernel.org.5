Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12427D92AE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbjJ0Iww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjJ0Iwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76F10F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1442254a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396752; x=1699001552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKuSlWZJl3O7Q/rDrs5s3l3ygimrMHL5aH8Nsn2+Hyo=;
        b=S4kMxLJQoKJuemz+ELsbMibH5l3iSeLX/uCelon0gdMiG49gsZhy12vw9T3Z/akUk6
         1fXuDAkfieVLQckMPRKVOISbOeZpk1O+Zpn9LyWPAvA30Dcvqx6TOHrJMZ78yBRk4HFO
         2hL0fGI2Pk11P4b74y3MOdWh+Un0xV9oKpBF6j0fk7T3GFNy4AfRxcy3c8wYSp1E34vB
         moxTOBG87OZNkqtXL6ZqyHJI1QTINGEe7Ub4Nf2G3lQksvek+5b9ebjwqPG6iL4Fjape
         YGVROcxIkFwu1IuSu5uLVd8x1w5e029Ph6KIFSYQx3GM1qYHlfgxdo5X9Gf2Ex/YC7QL
         Y+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396752; x=1699001552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKuSlWZJl3O7Q/rDrs5s3l3ygimrMHL5aH8Nsn2+Hyo=;
        b=w9U3ITSpFEVj4rVZTQOg786ojxkEJUda3hfSn8EwxonX9p6zNZYCh6azbVNq3SOviB
         ZIN5YiTKIHTwJ/Mu4ZSD6qzAtzCDjYUPUul5OddvY8SocP5WVH1qmZd5jOa7n7c0fkXL
         kV8wA8GzyTjoyYopw8fByQz9eNhObCy3Jg1SD3ipwBz7JJsSPyK+xRuLsroRwzzbrH/5
         +b4T9AGO6tnx10s02FjcHbhS2jqYSoHnmT1dFHusMG5Uwi0DjvsPExg12hSOGTV5vFpe
         ueFYB3ce4/khkphwF9uovXB5gnuxDlmTuKhetYHk6XSTDoTuNr9GelgGB3TX3326BWZw
         VaYQ==
X-Gm-Message-State: AOJu0Ywy0KWnkSvjCdBWw4ubmx8Pzze6j44q6LorONaHUq6ycPAFWLun
        6z70L/RdUm6/Pk5PFMiDQVg=
X-Google-Smtp-Source: AGHT+IFyueIHgkj+fPyPmoXNrGh7gOLatMYsx4WF2Mux494x2OFAi7kBv7DUv719hqOL3d7GXlnQ5g==
X-Received: by 2002:a05:6a21:7185:b0:16b:9f9b:5764 with SMTP id wq5-20020a056a21718500b0016b9f9b5764mr2406402pzb.54.1698396751949;
        Fri, 27 Oct 2023 01:52:31 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:31 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 07/10] staging: vt6655: Type encoding info dropped from function name "CARDbyGetPktType"
Date:   Fri, 27 Oct 2023 14:21:56 +0530
Message-Id: <387aa7f3e3c21cab541442d772cec0048f3463ba.1698396278.git.opensource206@gmail.com>
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

function name "CARDbyGetPktType" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c | 4 ++--
 drivers/staging/vt6655/card.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index c58a25032a03..7d632d1057c0 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -265,7 +265,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
 		iowrite8(priv->cw_max_min, priv->port_offset + MAC_REG_CWMAXMIN0);
 	}
 
-	priv->packet_type = CARDbyGetPktType(priv);
+	priv->packet_type = card_get_pkt_type(priv);
 
 	CARDvSetRSPINF(priv, bb_type);
 
@@ -684,7 +684,7 @@ bool CARDbIsOFDMinBasicRate(struct vnt_private *priv)
 	return false;
 }
 
-unsigned char CARDbyGetPktType(struct vnt_private *priv)
+unsigned char card_get_pkt_type(struct vnt_private *priv)
 {
 	if (priv->byBBType == BB_TYPE_11A || priv->byBBType == BB_TYPE_11B)
 		return (unsigned char)priv->byBBType;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 8c0d06da952f..6564682bcd56 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -49,7 +49,7 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 u64 vt6655_get_current_tsf(struct vnt_private *priv);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
 u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
-unsigned char CARDbyGetPktType(struct vnt_private *priv);
+unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
 void CARDbRadioPowerOff(struct vnt_private *priv);
-- 
2.34.1

