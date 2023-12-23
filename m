Return-Path: <linux-kernel+bounces-10185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F2781D117
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462171F26557
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93D469E;
	Sat, 23 Dec 2023 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YroGFd7G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D05814
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35fe456b94cso3093775ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296787; x=1703901587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwGDDgTKCqE/SRFB8yFUCtVd+D/7s93vO8AaImjZvSM=;
        b=YroGFd7GEf3WO7mtsCKDBk8pNvQx2Awd3zo+0XJ21qyyvJGALU+hLKFAligDPIO4ls
         n5lV65xSiJ+TUfKRzvIC+EmBnXy/4pLn0i3xdrKh+xj/u0Np7ycU/NyLuH9iG+y5wiqk
         KeN0VhupouuSvPGJ5TqmlWWwvAvfVifKI89HLs3ANtHJENduflag7RBTZK1tii5Oox/Q
         29hFoQT5kE2+nxscgSDQkfdaGI6K90uHNFNERtMB3Sta9YfRr6273r1ef2MX5nBalTw/
         5fW5X7AGn6uioL1VWzVvs8939Kkxugv4vZsRkQ1qVQM9qSccHBo51MmXcfAO2ryGMNes
         2u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296787; x=1703901587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwGDDgTKCqE/SRFB8yFUCtVd+D/7s93vO8AaImjZvSM=;
        b=p81dir3egNrelgxS+OUSAvELxyo9kVewoCkcAfcUZhyNdaQAF7NGA4D8unufFVZ/uE
         +vLeb4DeZ/JpAc+wH8Uub9u6yZ1bpXgIxr+ay94zDG9inXyeKIs1+L9blj4CPwnRLYzO
         guELzHbAN7ZxSgKcMOYijWZY15xJoyTUfbXi1DsapoyJNyo1YNci1yCR8h3BXtR3QHsu
         2ncmdJ0h0QIeZCVd3MUzZz5Lb5V4p4xzyWUJUjew+o01nMs/zuYanwnJvoxUsypkmCdn
         51JymWrGozf/5w3vJFmVh9JP+3clnj6PHcUF+fenh3k+mgnsUjv/J5e0pOkNKLuVhLf1
         j0uA==
X-Gm-Message-State: AOJu0Yy2PFUJVVZ9oew6MGcCZ6pjaUETsmmV8vtA47jjUJn2bSTleO9r
	Ax6r3AZ9vwgtbpz/BAVM9VJMO8LKOOHMcg==
X-Google-Smtp-Source: AGHT+IGU+bU6RpIM/OOcpaNDG6iNUJDjSy2tTUC8B5bDjod7aaglkBuT5fVifB7W30s5vMpOx0QRQg==
X-Received: by 2002:a05:6e02:148d:b0:35f:df71:423c with SMTP id n13-20020a056e02148d00b0035fdf71423cmr2134241ilk.59.1703296787380;
        Fri, 22 Dec 2023 17:59:47 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:46 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/20] Staging: rtl8192e: Remove unnecessary parenthesis in rtllib_softmac_new_net()
Date: Fri, 22 Dec 2023 17:59:24 -0800
Message-Id: <20231223015942.418263-3-tdavies@darkphysics.net>
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
Unnecessary parentheses around ieee->current_network

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2c46906be38f..8b689e828864 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1219,7 +1219,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				if ((ieee->current_network.qos_data.supported == 1) &&
 				    ieee->current_network.bssht.bd_support_ht)
 					HTResetSelfAndSavePeerSetting(ieee,
-						 &(ieee->current_network));
+						 &ieee->current_network);
 				else
 					ieee->ht_info->current_ht_support = false;
 
-- 
2.39.2


