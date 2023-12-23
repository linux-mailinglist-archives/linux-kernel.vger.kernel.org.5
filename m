Return-Path: <linux-kernel+bounces-10187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D981D118
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B77B259FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958D6125;
	Sat, 23 Dec 2023 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Qxn4ooKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DD186F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fa08df8afso9748355ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296789; x=1703901589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+laPmH1xo9FtQlmwlnX0zePEIJhHvMoJwKvv4M3oYI=;
        b=Qxn4ooKK46f2ZP/uC2OHgIecp3bmGHk1rWsFEYuGMbmOzGqhpKrYmtqhlybWy+WLe8
         WyDFbObHS3LQcFFy/1Bg9DScreVMAgg9zQuF7a7JMk7rE2Tvv0kJraHlx9HIQ3usyT7F
         BXhRfLqbYuTkcW9whYSI6jtVsSplGnJmzTBnW7GSatDeSLU3j1SHCGNlDFyq2py9Z5WU
         uTAw7oaSJr14p/QH3YWfVuP3DfGVt7fdDV44hdMOlYl2sOL6PnbxtOGLsjkjgL4F7SZr
         qYjNadNH4PJ5iIWrx6AZJJ2m75xFAjLOERHYhVhtbHr2SuM5kOAEsLFUMMek1HcUV0BY
         bHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296789; x=1703901589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+laPmH1xo9FtQlmwlnX0zePEIJhHvMoJwKvv4M3oYI=;
        b=kgB1SLU9kizSvrhMAuZ93qpYSRA0JEcbhlZISBhawUnAQ91zOZ2XO0qFkoAkGtUjqf
         Z4xHC76kiv3SnwSuDy2Fk09Aa8NYrUcvn7mSs1rIe5gnKeB6LjwYIMV192h7VnGIPERO
         FyHtMU5bQZOn7HhLp/ntwRr9+P8CbTXHBXChToWV83wUujV9G9GgpR3NnuihRCg7mk1l
         ZlmO+cET9jJdS+j5WHFhUKSK6gqMLbkx/K96NWwCsfxeUW+GGtZ2R3hQW+nNDrnWWt7x
         JZu5R7HPgyHvZHgcfxwxFX8MBfDWYXrQ35fFl6WXjloR/1SvzbaVuQ1qwLYovMRE6dal
         7l0w==
X-Gm-Message-State: AOJu0YxU1OEuf2o/KFk2vw3X2jAUtCblV+Gu2a3DkYxucjHz5ade+mrQ
	L8Sbb3oF3ldSTO4+nGBD0ZZ4M3k6jI0EFQ==
X-Google-Smtp-Source: AGHT+IGm84GR8emsXUGb2esKVSA9YTosSbT2uAZXLgYPcIC967Mb8nCry7y70aqDjsKXETwGUUVYFw==
X-Received: by 2002:a05:6e02:1be5:b0:35d:59a2:1281 with SMTP id y5-20020a056e021be500b0035d59a21281mr2977068ilv.45.1703296789322;
        Fri, 22 Dec 2023 17:59:49 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:48 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/20] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_rx_assoc_resp()
Date: Fri, 22 Dec 2023 17:59:26 -0800
Message-Id: <20231223015942.418263-5-tdavies@darkphysics.net>
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
Unnecessary parentheses around resp->info_element[0].id

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 960cc86ac23b..208079c542ea 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1619,7 +1619,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 			kfree(ieee->assocresp_ies);
 			ieee->assocresp_ies = NULL;
-			ies = &(assoc_resp->info_element[0].id);
+			ies = &assoc_resp->info_element[0].id;
 			ieee->assocresp_ies_len = (skb->data + skb->len) - ies;
 			ieee->assocresp_ies = kmemdup(ies,
 						      ieee->assocresp_ies_len,
-- 
2.39.2


