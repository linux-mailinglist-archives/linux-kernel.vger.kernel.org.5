Return-Path: <linux-kernel+bounces-406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC18140A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A80D1F22DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F18D27E;
	Fri, 15 Dec 2023 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrz9wEKi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E68D266
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-425c6157762so1883211cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702610979; x=1703215779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/xfwvK3tMuaBxwp2WhVM1G1Tt3nsJ10bTSRDiKNOns=;
        b=Hrz9wEKiTZcuixJGWWz0VwY1bEGs9HIFZInUYqOhvwE32jR/YlQrZkcG8Zn3oShqG8
         a7cpmuk/vR8uaTx5e8NYSEicCNf9C6CzYYLdvxuh36adKhJc3Ah9CdoTJqVUWKjNVz+K
         rNgC9+B8DnAacAfaDZb98T3/AGOeW6dHNreVaV2keHS5uJPe0uEqVs3q4ZwUZLRTXVLe
         aF0Ricu28/5Tkfb6zk/jeRko7IoeqaL+Rg5OjHNsb8zbiduljo1882gispjEjnSSifkd
         SMhQe3/v29nWc0ac5nyCwf4KMmQMXiKbHGMCrRq1IZ6dBAyH+j8/78rwg+zkUCpc/W0i
         LwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610979; x=1703215779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/xfwvK3tMuaBxwp2WhVM1G1Tt3nsJ10bTSRDiKNOns=;
        b=AAN41G9n/53ND3jm6AHyLe50xFp8O8BUrX+Mc3YN3o2rB8sZjs9pq6QXcHCALmVWyC
         aH/7bNpj/SrYCbJuePqhTsVzSWCIrNV1lXtjxlgyYZ+l1G4gAstFGy8ZbaqHfv38kHPe
         RODd1op3mn5me3RJHG5AgpehFd0hoyj2bwbcdtKelwkwBF/8qyLb7yAa9RSITwJtGqAY
         cecp3UXPIxDtAx4bpKacF8pfnHvoT4FcdX8+8OzwcgHboBkwOusS7l2+eILxVsuKCxSg
         mb+xr5FOjAWgbmIQ4e1uem5IMxI5LbH5DTm790RtCSY1bzBhAAfxnMoO70O9iuSEUbJ/
         7dEQ==
X-Gm-Message-State: AOJu0Yx+Xx/A/QKIWjb1o9RJK9UoI6soP2NYzm3oKAUgV62tdOUv+e4T
	9U30TbcW5bVbsT815bQ4r+sWtBIfRbJGGg==
X-Google-Smtp-Source: AGHT+IEv1o7rVooQvXq9j/N2ugeieTK0xz0y3K5QtayIgEVsXCo3GQtTCZTsFxPIqBQuCLca0n9siA==
X-Received: by 2002:ac8:59c4:0:b0:425:7326:e9b8 with SMTP id f4-20020ac859c4000000b004257326e9b8mr16756106qtf.68.1702610979353;
        Thu, 14 Dec 2023 19:29:39 -0800 (PST)
Received: from c853c274fc8e.taild933d.ts.net ([97.109.250.36])
        by smtp.gmail.com with ESMTPSA id c2-20020ac853c2000000b004258641a372sm6345597qtq.45.2023.12.14.19.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 19:29:38 -0800 (PST)
From: Nathan DSilva <expitau@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net,
	kamrankhadijadj@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	expitau@gmail.com
Subject: [PATCH] staging: rtl8192e: Add blank line after declarations
Date: Fri, 15 Dec 2023 03:28:52 +0000
Message-ID: <20231215032852.501316-1-expitau@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found using checkpatch, removes one warning about line breaks after
declarations.

This is my first patch, feedback is welcome. I am submitting this as a test
before moving to other subsystems to (hopefully) make more meaningful
contributions.

Signed-off-by: Nathan DSilva <expitau@gmail.com>
---
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

