Return-Path: <linux-kernel+bounces-10184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30981D115
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1700AB23D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364191370;
	Sat, 23 Dec 2023 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mOiqZyJp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C887803
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35fe994dab5so1562745ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296786; x=1703901586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQy2sloRPBS+5sAQ/YWqlyAxRk9/nFXvBjKhePgocQQ=;
        b=mOiqZyJpCVTdrW1CbsE59qgub93tPbglc8ZNwMrRHAexZaDKp9zOPVSuyAsxPuokrM
         tGbcQdsBQmT2Gfs0ummbKIlyx1wu6Z9xNj0nsD8NgGP0U63gCqJ6FchonqmVwH+D3Lff
         sT+Pw62ieoxmARND4xcnCv24owihIsLE+ZVJ2m7yKXAIz7nWmYrGSKNYM+4iEtEgqnbZ
         HUN93O1J/76EClXG+GdBG+BisAeN4SEZU3AYpJfVi64reEIiH95pwu4bsUqPzkF6MtUn
         rkgvUG0zVmWPaBRkIKBAPznZyF7LLhoGMNRo1IXjOEWhEC10wmA8aY69VZ8yDHTUssDv
         HSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296786; x=1703901586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQy2sloRPBS+5sAQ/YWqlyAxRk9/nFXvBjKhePgocQQ=;
        b=iGbp88U3wkLzdKVSd8dEtvrLLN9Lp8ik2Bw6w1XRVJp75JtL/5Th7pPyjoQImPXqHe
         nZt8FxBlTTNjm88lluwM7c3hGviOaLjAlqSNA1uFo09fyoVlxO/36TB/U+Pzb2Z9Q61L
         0QcurscmzI8hccmUw2cUA5RFf7DxcguJ8OkU/r3JvfCDEmnl8QMGcjmsSV5VYx+ES6pX
         lSfkPZZeiWbeMJ8Ws5kkK114u81gH2+Q0NbRhvHXtsWL8Cdd5cAEdzovyJWR0th7D6lB
         WI5xysH93z3JHiZHxRReu3zFOo+w+a6/GUC2sqv5EI0YYTek1Jo2C3ezKJUJO1SSBDxA
         dPEw==
X-Gm-Message-State: AOJu0YwpaRRl33xBPmKcMGFfl880e6plqz2xCh9gSlM/pNpgumJyJ5JE
	F4SCsGnUl9GYZcA4bASprWJx1mAEIMciqw==
X-Google-Smtp-Source: AGHT+IFQyLpqVpmR9kVWJbrOmb5xX3iPD7O+ccWEvcCW8fzlF2R+aXIa3ArbcU7Kb29zxd9UnRuEUQ==
X-Received: by 2002:a92:cda9:0:b0:35d:6227:4f03 with SMTP id g9-20020a92cda9000000b0035d62274f03mr2780374ild.7.1703296786409;
        Fri, 22 Dec 2023 17:59:46 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:45 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/20] Staging: rtl8192e: Remove unnecessary braces from MgntQuery_MgntFrameTxRate()
Date: Fri, 22 Dec 2023 17:59:23 -0800
Message-Id: <20231223015942.418263-2-tdavies@darkphysics.net>
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

Remove braces from if statement to fix checkpatch WARNING:
'braces {} are not necessary for single statement blocks'

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9c94c5ceccd5..2c46906be38f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -172,9 +172,8 @@ static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 	else
 		rate = ieee->basic_rate & 0x7f;
 
-	if (rate == 0) {
+	if (rate == 0)
 		rate = 0x02;
-	}
 
 	return rate;
 }
-- 
2.39.2


