Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F27CB6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJPXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJPXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:01:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD6109
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:08 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7d9d357faso64365857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697497267; x=1698102067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM4Q1Vnc/0W8axRuOl3n1yPV7eDUAdwd9TGgc08N9CQ=;
        b=nA09UmMA8NxRixh9HHVDlGk+Vvr+3ClVidWXzg3hqMGJXELFQInlSDx1GM+l7n9NDE
         6eZtpXKPaNYnFN8DxQpImgQgAIXonEhdNC6cH+zt44VfKqYSyketTIqDC2XHn1sCRaGz
         Wm9lQR73XdgXV7OYWxQEDvK6ZekJY3/+7I1dFH715b2MUmuaXyViz+XhweGzVPEY9cqD
         oxuvu9MEqRGZMed79zWDmYn+mcPx71PMmI1FQ4AcDQRFBHeruTk9VIuProcunZnfVChS
         ceNIlnCWbhCEymn/F01WxwuHQGTKasiZJyZC2NmNCpi9UFWUsnEiRcOfqLA2yEvVIciZ
         fRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697497267; x=1698102067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM4Q1Vnc/0W8axRuOl3n1yPV7eDUAdwd9TGgc08N9CQ=;
        b=ZZogMPjqzjn6DP6kp7gmcVU8gojJo8Zt3SmeovAZVGtbmvvdwG56H+m82zSWssT8UB
         Hxmif5d8edkmtO0YbhuVcRVjFFWDC6pIh1+CEOTF65+EU9cqAIFJ6EYscO0zfqtmgUrC
         bIM2OPGBOd21m/jc60R4SP7H6/yP40j1pUPqbuI4jOhn4/rP3Dc2TYe4dZl2GMahgTuW
         RQptgT/XsbyT/ERpvIkntwBzbA1zvOuMD4Ea616kveB4Z97TdrLysbAP5I95wK56eHWJ
         XatjMYc+V4kov97XT113gjpsgrZvjjda8t5RSJqoQNnuMcytbqXRJGVruRYSumQMqy/p
         8Q/A==
X-Gm-Message-State: AOJu0YylheP0utqB6NT4KZx63VyocnaIvGO+CE59L8GUGOtejyUFEyZm
        obfhw9kNUEgmBk5H2+3Q60s=
X-Google-Smtp-Source: AGHT+IHx5ZNSxjJc69qNKXiA+XlymW5cp6SvHC1eWLaSckCOeDlHLcJo7Li/Hc9AwtbuFR+56SLodw==
X-Received: by 2002:a81:8341:0:b0:59b:65d4:4d73 with SMTP id t62-20020a818341000000b0059b65d44d73mr558954ywf.27.1697497267371;
        Mon, 16 Oct 2023 16:01:07 -0700 (PDT)
Received: from gilbert-PC ([105.112.31.148])
        by smtp.gmail.com with ESMTPSA id s124-20020a817782000000b00565271801b6sm94387ywc.59.2023.10.16.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 16:01:06 -0700 (PDT)
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Subject: [PATCH 4/4] staging: vt6655: Rename variable byBBPreEDRSSI
Date:   Mon, 16 Oct 2023 23:58:57 +0100
Message-Id: <d525f5837bb343001447646fe17746370256694f.1697495598.git.gilbertadikankwu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697495597.git.gilbertadikankwu@gmail.com>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
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

Remove byte Type encoding "by" from variable name and replace camelcase
with snakecase.

Mute checkpatch error:

CHECK: Avoid CamelCase: <byBBPreEDRSSI>

Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
---
 drivers/staging/vt6655/device.h | 2 +-
 drivers/staging/vt6655/dpc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 6df1694d556b..2b5f9bf6aa5d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -253,7 +253,7 @@ struct vnt_private {
 	unsigned char bbvga[BB_VGA_LEVEL];
 	long                    dbm_threshold[BB_VGA_LEVEL];
 
-	unsigned char byBBPreEDRSSI;
+	unsigned char bb_pre_edrssi;
 	unsigned char byBBPreEDIndex;
 
 	unsigned long dwDiagRefCount;
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index c6ed3537f439..7ada188e2048 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -79,7 +79,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 
 	RFvRSSITodBm(priv, *rssi, &rx_dbm);
 
-	priv->byBBPreEDRSSI = (u8)rx_dbm + 1;
+	priv->bb_pre_edrssi = (u8)rx_dbm + 1;
 	priv->current_rssi = *rssi;
 
 	skb_pull(skb, 4);
-- 
2.34.1

