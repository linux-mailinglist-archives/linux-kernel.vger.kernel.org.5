Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D107F8583
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjKXVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:31:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4819BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5491de618b2so688475a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861483; x=1701466283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dob4ueyHhx+j/dqC0hM3DyfpnYphHI049VubfpO8Pec=;
        b=LhPUbYMwqqksET4UFhw6IoqcKNIBfEFPPKOPBQ9fkG5JIYKBn96BO2k2+egCXBffOs
         4r70s5aK5I+ur1pV/Jg7usjMcblHY5zNRBXWPL1QWaptMeqgFmcHPdNKuyax7eEvRfYS
         RczymEq6mw3e8EbpbZ4sxIDxuSjUBkVH55YMiqRuqHa5yvx1DfTSPl8t1PwdLv+zF9lS
         iZFSD6BlOZEbYfIe1s+Avl+JnukQxkPlpwxF394b3pg9lkrMKMyJn0g/BPR2putt1Msk
         U3PEklq7Jrr5ydIZ39wzB82NH/wHWnQNFFqdUmhF99qg2bhzsMR1WbbR2PsHEnRgBGgo
         9tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861483; x=1701466283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dob4ueyHhx+j/dqC0hM3DyfpnYphHI049VubfpO8Pec=;
        b=xMrW41bwieMvjyOu2TmcAfjafGYxRsOS42w9JF+o/oJ9T78N0Hp21PHUHdLur/fVlY
         75YUCQIpfrlY09HAlbfPH7v2W3Ou1oQCQ3uhc3qpJQVdWMoUvut5+F1a5AcgrreOhoY4
         4ZgZLLk01J6z7WtWPlgiwwwgKWTBNl9FAeQ7+j31g+WQICeVwxS6DJmqYV87A4mFLVhW
         Lzuu2qE6SzDspql8ixbyYFL0+hQUPOWhinxCnDQ+WIdI72sO66cHyqI+K8NqNig71zUK
         IdnMg7Jbc453WT+CRdHGO4Ctqa5TPL2BJBbdt71Luq0aY0Nns7moUnm10y/qg5aZqvSA
         X/aA==
X-Gm-Message-State: AOJu0Yz8GapR7Tq8pYOQaKmaKVO0l7xmWxiAcyWQCzKZgoQvGrk56z2H
        CRbHQjkKWC0663TAmhjwmqk=
X-Google-Smtp-Source: AGHT+IE+QY80vtVsrteuoXEgHjoIDKq5TSlxlerFbuFhWGXd4HlAsRT1ffDgjkTb8zvZWldBQgXRiQ==
X-Received: by 2002:a17:906:3948:b0:a01:ee03:37ec with SMTP id g8-20020a170906394800b00a01ee0337ecmr2983066eje.3.1700861483322;
        Fri, 24 Nov 2023 13:31:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id lo20-20020a170906fa1400b00a041474d13esm2492176ejb.127.2023.11.24.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:31:23 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:31:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8192e: Remove unused function
 HTConstructInfoElement()
Message-ID: <ed49162367b03a848895638adcdfe3594d4219b3.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function HTConstructInfoElement().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ----------------
 drivers/staging/rtl8192e/rtllib.h         |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index da4cf6f25794..00273d709f3c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -328,22 +328,6 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	}
 }
 
-void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
-			    u8 *len, u8 IsEncrypt)
-{
-	struct ht_info_ele *pHTInfoEle = (struct ht_info_ele *)posHTInfo;
-
-	if (!posHTInfo || !pHTInfoEle) {
-		netdev_warn(ieee->dev,
-			    "%s(): posHTInfo and pHTInfoEle are null\n",
-			    __func__);
-		return;
-	}
-
-	memset(posHTInfo, 0, *len);
-	*len = 0;
-}
-
 void HTConstructRT2RTAggElement(struct rtllib_device *ieee, u8 *posRT2RTAgg,
 				u8 *len)
 {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b7f4d7e2ea26..04433c79b3a7 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1760,8 +1760,6 @@ void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
-void HTConstructInfoElement(struct rtllib_device *ieee,
-			    u8 *posHTInfo, u8 *len, u8 isEncrypt);
 void HTConstructRT2RTAggElement(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void HTOnAssocRsp(struct rtllib_device *ieee);
-- 
2.42.0

