Return-Path: <linux-kernel+bounces-34010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C68372B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA615B317E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F95F575;
	Mon, 22 Jan 2024 18:46:36 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A25F550;
	Mon, 22 Jan 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949195; cv=none; b=tE4OMwnySGoaY4BfpRDikTG0MsWviFTT6KsLDNjDsO5UTFHtWq8VGQyv9l+tsXKOevMvXhZwzbqLey2LuAA9eAo+UXCOHW8GWB6Rp2PekEAVuu4bi6dyEMoGqNl9otvCrxYjdv5KBmxn1ykeJvVeTYcx3+ZLWrATD6n2Lw+cwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949195; c=relaxed/simple;
	bh=sDGGLOkBUwUK/3aeiPPS2IGDWdcuFqi49un44PPUlZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8qlWkNXz7Rrv+0OzAd8fyOMdMbqFJyR3NICEZQm8dD+8C1DmhzgZPabeABaD1UBuhkMLxRnQ8jjTWnXjiqJ5iUfVaMu7o4oZtNwmXJxzQGjldu4sWgx9UrVGY7+IyVqMmbORbQvQlqR61cqSHXeFy5IwXc8JtCF+NiQVFjkSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so3773661a12.2;
        Mon, 22 Jan 2024 10:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949192; x=1706553992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyXhSwOKSmfVLvqBMZ4A0Et3TQy4D/4oFIQvvopgsT8=;
        b=Q2PEDVRTO1HkKgRscuEJaaZ2S0AqBjbLYIw7EblXFHWGYJchFQkBj8FwOyXsM/ta13
         /i08JkYOYxOJR83RVF4bupwiiXS8ZP72Ka0nUI9HjqZbd5X5roeUcY/1EclqDc/ljqch
         lhbj3km8VBlPOqTzJxQYJuTjo0wkzzydSbBMnSNR7W8fNqYRLdzRMB/hnuFhXVGpgW0v
         jd4quoKQHaOyfnqTBPao+46imS/vUCGpLmLg4Ir/qo0hOOFOXn2kjZg9GMrfTW6Okii8
         v2CFIQItB2SqACOZI5RUkg+fywuWfblMwTYxJJTng278fIy7HqY49YWjdC2JWwyGMWb5
         7Ziw==
X-Gm-Message-State: AOJu0YyjzywLp+rWWuwrb2Y3MoSzR63JDohUQEICYvXaaOLM00pLJXuD
	jy129CBTUbWTh3ltPrhlQk+pf2dk0OeIAZLS3UDbFOZ61qIUEmq8
X-Google-Smtp-Source: AGHT+IEbJnZWQY7SbKhO3jsNlHC+fqQl3oymqq8t539GG0DIyleK10sIDQfBfUAX7otRnA9pPg8Yew==
X-Received: by 2002:a17:907:9507:b0:a30:6987:636d with SMTP id ew7-20020a170907950700b00a306987636dmr721665ejc.95.1705949192408;
        Mon, 22 Jan 2024 10:46:32 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906399900b00a29db9e8c84sm13639442eje.220.2024.01.22.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 11/22] net: fill in MODULE_DESCRIPTION()s for litex
Date: Mon, 22 Jan 2024 10:45:32 -0800
Message-Id: <20240122184543.2501493-12-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the LiteX Liteeth Ethernet device.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 5182fe737c37..ff54fbe41bcc 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -318,4 +318,5 @@ static struct platform_driver liteeth_driver = {
 module_platform_driver(liteeth_driver);
 
 MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_DESCRIPTION("LiteX Liteeth Ethernet driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


