Return-Path: <linux-kernel+bounces-39199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1883CC64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A091C22F02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264B1386C6;
	Thu, 25 Jan 2024 19:35:02 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B911350CA;
	Thu, 25 Jan 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211302; cv=none; b=G/YPcEJsoWHJe3/ylH1iDJo1ZWlhGSPB2OUjnAUWGieaplk/JdQt2rozwmXDR4qtDMNYP3LAnrEYE6VuGO87CA5fS0tdR6p23Oat2vgXOn6UcB6nwFAXtHoEAAzIc+OwJUEmON0+YHKYNoeKgIqRz4bfOwbYsDr1Qot7Yv+4/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211302; c=relaxed/simple;
	bh=atqq0jcXQT2lcsEadxM4os6jxHol0jtIEHXIZnxLtU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCSpFqpz5DU4K4F8gqMxPH3a5gAd5kPSc7vtbk+X+CC9BtSnsHgu9bs+rMsr6xesO0mRCJ1CDRbEN2ct4O6Sdsq/jfetURtthk4FJrugwhoDqGuW1ncpqkPl98fY1UolzK3IUre2AjZRKnH9u1oCkb0OMmqrB1Z46BkmkRdNQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso9202091a12.3;
        Thu, 25 Jan 2024 11:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211299; x=1706816099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJO1tmEeetjzc75SScsWZSP0VzkIx/i6WWUOPZCsvqA=;
        b=jjQG1wmTaBk7iy8noSF36/ffhmzfvgo/56WKolXiutzpWtvBY0dC8LUHWTdHi63Ku6
         HSu7ZrmdjLUzsmTABZqg3Z/f17tLECRbXPiTNyqM3S/totfuthndkfj2nHPD+CAjLJdY
         SHAEj7jd8oOPkmVAv3/H+W8RZMLAriGIhNE4fVwmqvTja//P7ZhNq/suwQuHbmx0wW2p
         3vH/NX5NhlHzHXysYhbqH7ouuzXTJJJRaqrumvncvnhk9UhSbQSoAs8Y/ufPyEc4Sm7Q
         xol7suMEBdOYoM4K03kNYCsjMtavLbRDbZ/Yr9i2yQHsPtRCBOZsj3QBsZFPFqV9P00T
         8i9g==
X-Gm-Message-State: AOJu0YwS3ui5mF15V55IL9J1vzezW8T7BtP4EFzo4t6SQIn0Cx4rzgEa
	l2foEHJ9Z++tvQHBJx/NOE9OF0m7c1l6Qs3e+P5leSEfkPIqh8dG
X-Google-Smtp-Source: AGHT+IEYHtVzEGiZWEripTjpYxecfWqyW+1f5xMZVzMhJ6VnhJxwMK+BnR3RnBY3nHDOb+HKIdLRfw==
X-Received: by 2002:a50:9e6b:0:b0:55c:22c3:c990 with SMTP id z98-20020a509e6b000000b0055c22c3c990mr42415ede.68.1706211299190;
        Thu, 25 Jan 2024 11:34:59 -0800 (PST)
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm2904475edu.83.2024.01.25.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:34:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 01/10] net: fill in MODULE_DESCRIPTION()s for encx24j600
Date: Thu, 25 Jan 2024 11:34:11 -0800
Message-Id: <20240125193420.533604-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Microchip ENCX24J600 helpers driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index 5693784eec5b..2e0fe16a4082 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -513,4 +513,5 @@ int devm_regmap_init_encx24j600(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init_encx24j600);
 
+MODULE_DESCRIPTION("Microchip ENCX24J600 helpers");
 MODULE_LICENSE("GPL");
-- 
2.39.3


