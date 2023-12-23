Return-Path: <linux-kernel+bounces-10197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA181D123
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A211F26630
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9228E16402;
	Sat, 23 Dec 2023 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ab3UWTbc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9A11718
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35fd04ede25so9893425ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296798; x=1703901598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7kA13qzzRRivJTH6xVTb3Xz2KZfH2aJFCGhcmqO778=;
        b=ab3UWTbch7MGX9TL/UrEaEdZLHKY41WFEsQp1JIK467Br7Jfr+ThUd4zVEnHwEHAr4
         fPMbP0Qfa5N3CH1adHfg3oQHCh5N1kqU4aUwzUjr5I3NJC7CDLxBagoG8/bU71bExY7O
         nR4nSBCNEw8O+GI18HVPGyGnWmDs9/xIbKUzSmzy1W5G4EjUMdoxXFp8Dz9hXLvlVy16
         OccHwx8GvAvJAFOGaehVV69phyNgnBI2+ugdAhh37PaNJ+TUinFshDgixRxvcL401pAF
         E0ey3yQwoZljviTC25n21vW3AO5QtnlHYVSKENDJXjL0BW6tq2HsCAD5tQeYZuBAyybp
         YI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296798; x=1703901598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7kA13qzzRRivJTH6xVTb3Xz2KZfH2aJFCGhcmqO778=;
        b=QYSYyAg4R6WHWzjNOWY4m+rZKSbpDf07mPgfQrQdIX9XtmSa9FoxSqnfK+lvDZq+hL
         pS/LK2OLoSsvQSbJq3NJiYRpTUPJfms6Gxsusgs+7gqqT4Xze29EGHwxkKyvMaWU4j6C
         cNosrZE/ZU224a7LUA5rF5rc435ILLlxJCAvbqObUEBOyjkh0SV5g7YCK1sevCbbFx5t
         iiVLBVfeu1FcLX62xtbUGO24H8qXIQsx4BhLlLVakZMVQN2Npiv8zJ5NqbyXrPESpSZN
         GAELmqeN552F+txpcacWD/Z6Ki3j6+c11hof5WgSItCWPDXcFl+RPsDp1wp3YIfeV1/u
         gawg==
X-Gm-Message-State: AOJu0YzgVG2R4fzETqMt+3z3NcJZaXE/6iKk8O5LhhV5oYdONl5K6q4j
	lDlC/Cb3vbedeRZr2XN5vzGRYVBQeiE2Ag==
X-Google-Smtp-Source: AGHT+IHJrmdVcS/p38eP6ADGP1VB31bRc8vMArDnQ57xjTcyZrF7UZsSbZpO3rutzFv05+ryVFS8nQ==
X-Received: by 2002:a05:6e02:370b:b0:35f:b06f:9c99 with SMTP id ck11-20020a056e02370b00b0035fb06f9c99mr3010001ilb.64.1703296797838;
        Fri, 22 Dec 2023 17:59:57 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:57 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 14/20] Staging: rtl8192e: Rename function rtllib_WMM_Info()
Date: Fri, 22 Dec 2023 17:59:36 -0800
Message-Id: <20231223015942.418263-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_WMM_Info to rtllib_wmm_info to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index f3de04b98803..7cd7ffcda58e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -82,7 +82,7 @@ static void rtllib_mfie_grate(struct rtllib_device *ieee, u8 **tag_p)
 	*tag_p = tag;
 }
 
-static void rtllib_WMM_Info(struct rtllib_device *ieee, u8 **tag_p)
+static void rtllib_wmm_info(struct rtllib_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
@@ -888,7 +888,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 	if (wmm_info_len) {
 		tag = skb_put(skb, wmm_info_len);
-		rtllib_WMM_Info(ieee, &tag);
+		rtllib_wmm_info(ieee, &tag);
 	}
 
 	if (wps_ie_len && ieee->wps_ie)
-- 
2.39.2


