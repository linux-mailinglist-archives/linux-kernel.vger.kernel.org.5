Return-Path: <linux-kernel+bounces-1215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFB814BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C021C230D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE236B17;
	Fri, 15 Dec 2023 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHto/h8k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348AE364DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-77f320ca2d5so56893885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702654194; x=1703258994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b/9IA5Vs/lvs6yWAUrUkdCRzRrQb2WKDgnvhICKhEQ=;
        b=OHto/h8kGscuvh0/F+bqUqC9sDa6j8GGvmpTlzSVjj1loU4h5rNKvNsOiGCzsVOCi5
         Id2/y+sFW3P2RvWaHj4BdXdBzD0h30ImqXTSdRDOC4CMLmfOQEH2mgBy+M4O023d1fYk
         I2SGgbGxFVtBKHwp3eL+IedMWt03eK6Yk/VrMR+IPP4tNL73sZk4S6X6RvsVmi/E3B5P
         krJY1MOvYyxziZHNCDNQw7NJr5dhMgJKc2QFt27N7fdtModDP0h5o/JBs4ovg7BX0uM3
         om0jvYeQEAdCrOIsz6lTO/BnQb1NTjh4VWAeFlc5r0ZbJRHLu5QGB3tCwEbvduCsJIV1
         S7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702654194; x=1703258994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b/9IA5Vs/lvs6yWAUrUkdCRzRrQb2WKDgnvhICKhEQ=;
        b=l+1RGv7zRjHWpzwDUimjn7+V/6suDxwuEbysPxUrPzft4HbjRELZyncVnVnDtCjoLu
         k+oMlwv6/hrAAdfLoEI9PqEHc8psSV7MBXvTGRRQp3kV7ggCOr4/MRmSbwOm5G0rkFOK
         oaax5FP1TS4rOJkm20iLAwJbKp/46QiN6HvSrhMfUVnS8pdUfr4TAbxEMfvuQz1M3yab
         UkPdeanFoEIg02jcpK5BiV2hVVX25Xk3VMRWwRq/0gjfLgNi9PnJNTs435MAHobyQoYp
         SktgvWQxUQt6tnFSxC36Unpcn8o9R/vwshQoVEm7pPGfX8GFYFU1hR2/QIvwnsJstpOU
         muow==
X-Gm-Message-State: AOJu0YyZnsCf9cgJxOPXPFvtUhPTBq8CmDaCKk52u47RpR9yv/0WZD2x
	nf9Y22s71gTHNjavoa7eZ+o=
X-Google-Smtp-Source: AGHT+IHqU5Ny11JN/doGZNTf6XohQ4ee/XB5Uv/POVOpRJHfJ7LwaebSS8rGUOABIGPcrSxnPV3eSA==
X-Received: by 2002:a05:620a:3913:b0:77f:71dd:d64 with SMTP id qr19-20020a05620a391300b0077f71dd0d64mr14357439qkn.13.1702654193947;
        Fri, 15 Dec 2023 07:29:53 -0800 (PST)
Received: from c853c274fc8e.taild933d.ts.net ([97.109.250.36])
        by smtp.gmail.com with ESMTPSA id db14-20020a056214170e00b0067eebb03a09sm1296456qvb.143.2023.12.15.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:29:53 -0800 (PST)
From: Nathan DSilva <expitau@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net,
	error27@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	expitau@gmail.com
Subject: [PATCH v2] staging: rtl8192e: Add blank line after declarations
Date: Fri, 15 Dec 2023 15:29:18 +0000
Message-ID: <20231215152918.532037-1-expitau@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
References: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a warning about line breaks after declarations found by checkpatch.

Signed-off-by: Nathan DSilva <expitau@gmail.com>
---

Thank you very much for your response. I didn't realize you could select
multiple --to recipients, or that you could have comments not in the changelog.

 drivers/staging/rtl8192e/rtllib_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ecaa4dec3f94..397859c7f5b1 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -946,6 +946,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
 {
 	u8 type, stype;
 	u16 fc = le16_to_cpu(hdr->frame_control);
+
 	type = WLAN_FC_GET_TYPE(fc);
 	stype = WLAN_FC_GET_STYPE(fc);
 
-- 
2.43.0

