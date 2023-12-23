Return-Path: <linux-kernel+bounces-10186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C681D116
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12411F26565
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B564689;
	Sat, 23 Dec 2023 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Pbu+gxJz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302551113
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so127582339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296788; x=1703901588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqmGALmfQVkTxvHATe/0a3Ev0Lr0lTuyhbxTn9L9dQU=;
        b=Pbu+gxJzm32xQhxbYHb/sQ4zZgXF5v/aF0UdWyOguWaMvxrZPioBw+jdfPtbjo79Xu
         lWI/tmtrhJ84YxcshL8NEcN8CSBx6ie9qtC4wLNqJ7wiq87292QFOxWMDCxia1KV53fJ
         G4FN1tMxQzSfYQE2nKvygoxMrfYhjd6KQZBhjbWSbwEQhYHRsqLH2YMIsXdudFpXCbtz
         XQAUNDFjpiie7QknJQJUgzS58VIVnHnEO3idYAfJmM1M9/Ua2Da4BQRic4z0yF6o/8b3
         XoO7p6DWmiXO0NiWgt/GAXAYkgdJ58hv7WMHFzhbo+Ch7jxhMMT+5aQWpo4E+JTfjfwS
         UfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296788; x=1703901588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqmGALmfQVkTxvHATe/0a3Ev0Lr0lTuyhbxTn9L9dQU=;
        b=oIn3+OR58cjO0m+cMpR4P1TfH8T+ZIlxOvX4OQYs906oSe6hhPCWmUUnesKmWwUKee
         w8dCUaMBwGFcnd1SdR6uTdRBe53h6Dwu5PCzL6S1UN/AZ1beqmZEO1Dew83fWykU7Nbv
         3EjB/DK0jNHgQrhMZsFFpegxgGxfyjUoul+emfDglgj25S8hxNZuENIMXvOgwVbv5CXW
         DSTD2oDsy2SXy6kgxmeLdPvTO871RDjOUC8mYwhtGU5mMT6bV5jKlHUub8gxjj9UejH9
         Y7eU5RkKOiVnSalPDFfdqcEDwMefgBX0ev/w0bB+FJhfTOpTNEalfifyaS9bm08zcmdE
         u9tw==
X-Gm-Message-State: AOJu0YxrfqmG904Cgw0tU12TavzSfnJSmFSVQ8JZGupaUnN+mwvlfLvm
	JWqA0zpCqWWVdxO1YIDEiAaDfCduf0ojvw==
X-Google-Smtp-Source: AGHT+IGD8u4BhnPYDDNlhLY8nlTXK8tfMq4LjOnrLoQMzup6+RsbjjF/OEbk5ve4O/FBmhhLit0Few==
X-Received: by 2002:a05:6e02:1c8c:b0:35f:d91f:baf1 with SMTP id w12-20020a056e021c8c00b0035fd91fbaf1mr2755492ill.93.1703296788317;
        Fri, 22 Dec 2023 17:59:48 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:47 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/20] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_association_req()
Date: Fri, 22 Dec 2023 17:59:25 -0800
Message-Id: <20231223015942.418263-4-tdavies@darkphysics.net>
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

Remove parentheses to fix checkpatch Warning:
Unnecessary parentheses around hdr->info_element[0].id

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 8b689e828864..960cc86ac23b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -917,7 +917,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 
 	kfree(ieee->assocreq_ies);
 	ieee->assocreq_ies = NULL;
-	ies = &(hdr->info_element[0].id);
+	ies = &hdr->info_element[0].id;
 	ieee->assocreq_ies_len = (skb->data + skb->len) - ies;
 	ieee->assocreq_ies = kmemdup(ies, ieee->assocreq_ies_len, GFP_ATOMIC);
 	if (!ieee->assocreq_ies)
-- 
2.39.2


