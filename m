Return-Path: <linux-kernel+bounces-52401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB3849795
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D867A1C221FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C317541;
	Mon,  5 Feb 2024 10:14:42 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7B1A28C;
	Mon,  5 Feb 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128076; cv=none; b=k0XO7fu7MhoQOJRSVaCtP4mYUbRj4am82sz+5+wH0rpBqwMoPCMDyTNm5rHqpsWUV8DkIkK2T4ChXN5WrsTmmnQAjqyxg+eujIBJpqDa8Bg+PvmLO0IRvrG2QH0QZfXGj0POepC36m8CWWSyk/OOXo47D0JYztaHc1MRXU4pRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128076; c=relaxed/simple;
	bh=ZIYJJskWurszPGjPRZpJUtbt1AXZlUpfp0K0t1yduDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adCxvRevfQcIs3mKhAutpD4yjudAVta9F4SjJOrNF/MMcLPHqScBWpgPz9SYXOoAQ+duB2s5QR0SVYVvDZmCsHbIbN6RxmDPW+DyWkjAjCTxyfBHpthNkBoGbDD471snIyFSYfotyMz3WQAF6t7vdhEh6HbpSQfZTe2FWEa/HCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30e445602cso1087303466b.0;
        Mon, 05 Feb 2024 02:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128073; x=1707732873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PeYGuM2VzWmaP8pGOHtb0MhEd16/0MAF4k7QK8QyX8=;
        b=wr/DUL+gM7VPlDpXzFIqwyqpk8yj1m0OuAtKboE/cTIv7RstrIJIyNXtydsxVbCcsI
         ymPN6MbPFbqNJBB1Un0diUNf8oBYeByKQf7be1mRLWOYH8Vz3Q0XSBsDc7X6cZFwJSen
         a17rpgkFunhDF6RGGu3jqaJ2EORyFUZzk27TbGTB1zFxtqjYNT5SM2i4MTDS6XM56bi5
         LLaiKvjPR9i1iy5VkA7VyWCvoAUiwXC/gVJGdla6wSGyUKIe9CyUm3k+F4c4nqWG0hY7
         3sw5qpBdZGv3+/Zy9ykaMOrtCGnC/qGSEpcZdCY3Wth6Pclz+DNJzzfxJJlsWXUlhR5g
         wJzQ==
X-Gm-Message-State: AOJu0YwcRTkNGB87kIBQZw49bss2OzfAGKBKTcWnu1UbPlDBTfHopt2o
	POL2CYEpURQAwP2xE0r4ksLprXSqyUmLmT5oxgOCEYF4qoP2ZRrm
X-Google-Smtp-Source: AGHT+IGp/q6ODH5E6Ch/Wlt0NoRVdlvJcqDIrBmgOnVUMB/s6PiYNmqy8b2AdrdyMvD4Zh6jqcMzpA==
X-Received: by 2002:a17:906:d294:b0:a31:818c:ffe0 with SMTP id ay20-20020a170906d29400b00a31818cffe0mr5367795ejb.19.1707128072891;
        Mon, 05 Feb 2024 02:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1/Hf9JcK7520ELfEV8WEoNlXaxktXn81qmsp9wHZXj+RW9fZxcLg5rBwEUcK6ULP4bohHlkeWjYAkDFs5cj+9X1hH0mqYhdM1T06vXNRtjk8MPo/7MOaNq6WyCAdk52vm+KVWW5WVtrdhaGR3SDORRNfTt/DN2UzGncM3VlQZA0mSXtaQCicxdIMyFW6zIDHNyaN3dUNqZhzZkMyfe3Mu2jK77VXAuAZfxPJe1T4EPAERSOHGaaaTHuSEKCUSBkLfIbrOifjkNkKRfaRwzzw1+rGapQ==
Received: from localhost (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id cu4-20020a170906ba8400b00a3550c56127sm4166553ejd.9.2024.02.05.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 10/10] net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
Date: Mon,  5 Feb 2024 02:13:59 -0800
Message-Id: <20240205101400.1480521-11-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the DSA loopback fixed PHY module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
index 237066d30704..fd412ae4e84b 100644
--- a/drivers/net/dsa/dsa_loop_bdinfo.c
+++ b/drivers/net/dsa/dsa_loop_bdinfo.c
@@ -32,4 +32,5 @@ static int __init dsa_loop_bdinfo_init(void)
 }
 arch_initcall(dsa_loop_bdinfo_init)
 
+MODULE_DESCRIPTION("DSA loopback fixed PHY library");
 MODULE_LICENSE("GPL");
-- 
2.39.3


