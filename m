Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B337A9144
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIUDWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjIUDVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D322FB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bf0decd032so365253a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266497; x=1695871297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J13TYH53baJjDyxjNG/I7LEG1MMKBZPbFBacTopiq18=;
        b=AFEn2g5JUloXMt7/9VyD7OCtS8qGmYRnx4EWi2RZFt1fhXdAxZE3NPGw56GXJRkCVc
         cgWL5717jOgxmwKhLPTcjqabxwJaX3O6Q5ByKpAP8cQHTRpb+IAM2dJ09pcSDhmLnoDY
         0VbTeLAu36DpEhIONTLqtMDeL2YHbu6CH8cRYt6RO/NyxTQ+EgGDRCEYyBdCRbYa+V67
         z5VzRIaJwQgp2DzeFI4nd6VeBOtBcSprHHcHKTaIENhJcWdTeew9aaQj2OpWwHbXaL8r
         EAR1d7TQjQAjAG24/5Q7U23w12iVkKJVQpWAl+8R1d2fQjPuAtTEw0/DzoaFhmyaR2o5
         E+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266497; x=1695871297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J13TYH53baJjDyxjNG/I7LEG1MMKBZPbFBacTopiq18=;
        b=TcgFmCUDyFpr5Lui5TPX5ca5oEyb/GBHdMbPz7C0G31pdwGSeh8PQY8wmVfSF4za1C
         9sufAuEkVSEH9bLDqR9VrkKfazl/KGlgZ9bApeu+3p9SfksEQVjuPtCcqkFV3Pd5tyOx
         rNpZ/V+sIPPzEs8KHeJl1hf+B4c/nmG9eB2FgW+WDDjxKG8dugPJPWD86P5/uElD8foH
         WIdk5JJ+F7So0LpPr18n5m9J9eDHbfydiHUHGg2azCL0KTpivHRmhgZH6a8l3CPDB+Nj
         9WgA8k/sIxam3unh6e2rWlJcTSU8iG+6JPgMRUt/I8xCCAnP36x0dKSB7Q2Iv+0umAW5
         HOPw==
X-Gm-Message-State: AOJu0YweWK2n+oFv0/9iaevbcyotD6vAtf9VCuGW8Sa99stukYgunZ4W
        gcogQWEsfjA+nup4MC29M1OarQ==
X-Google-Smtp-Source: AGHT+IE3VuH1+V0xhuaLDWp508K9FGyJ9OfrDdJCBCM4LXhXsSnassgBfeQ3SlC3wqUr+BWa+AefzQ==
X-Received: by 2002:a05:6830:ed5:b0:6b9:1ad8:18d8 with SMTP id dq21-20020a0568300ed500b006b91ad818d8mr4322857otb.27.1695266497397;
        Wed, 20 Sep 2023 20:21:37 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:37 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/11] Staging: rtl8192e: Rename variable StatusCode
Date:   Wed, 20 Sep 2023 20:25:15 -0700
Message-ID: <20230921032515.96152-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable StatusCode to status_code to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index b3a8a6959622..820b5ee2ded1 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -65,7 +65,7 @@ void rtllib_reset_ba_entry(struct ba_record *pBA)
 
 static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *pBA,
-				    u16 StatusCode, u8 type)
+				    u16 status_code, u8 type)
 {
 	struct sk_buff *skb = NULL;
 	struct ieee80211_hdr_3addr *BAReq = NULL;
@@ -101,7 +101,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 	*tag++ = pBA->dialog_token;
 
 	if (type == ACT_ADDBARSP) {
-		put_unaligned_le16(StatusCode, tag);
+		put_unaligned_le16(status_code, tag);
 		tag += 2;
 	}
 
@@ -187,11 +187,11 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-				 struct ba_record *pBA, u16 StatusCode)
+				 struct ba_record *pBA, u16 status_code)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP);
+	skb = rtllib_ADDBA(ieee, dst, pBA, status_code, ACT_ADDBARSP);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
-- 
2.39.2

