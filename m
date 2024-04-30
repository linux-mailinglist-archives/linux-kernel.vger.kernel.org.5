Return-Path: <linux-kernel+bounces-163890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12228B755D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1954EB21BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0D140E26;
	Tue, 30 Apr 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCryqmqu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E112D758;
	Tue, 30 Apr 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478759; cv=none; b=HBTJM2qrmVVbvZjs4YB3+G+JlNPITa/aTiUdzkkg5U0DLSQ8sD1BTgLxoGgCmhDT2ADcsoB2Jhu6o1E4q8dCnuljEhV9vwUsffziC7EKaTtsaflyjDEqHFuT4ZAScLl3/D/oHd2SZjmyMKkzAdqmUjOs/lsiKxVdvaPjq5dFJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478759; c=relaxed/simple;
	bh=tnuyjcpQVNyMCFZIY0ylT1N+8NqvFw7TtTCwnHPldU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+qm6SLuqRWHB5Z7RWHqszdU+h8vmj0UsLqH9SVex9A0LCPXWfw939YNdPiEuxl8T/IjeVutAj9SqTXJhabLk3UuGzrQx2FCkFmY9qFFtxErH/3bOncpX45qjlSgJe98/xG3pLhRQFgTu1pU9sLEckRdcvkruS6+QgfnPPLEU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCryqmqu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso34884155e9.1;
        Tue, 30 Apr 2024 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478757; x=1715083557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9IvzhHN84puUIqzRaEK8QdNvvnVmt/rg0fAQUr5Bqs=;
        b=GCryqmquhVkynnDHrAOP+wjpfHIO7zqI+9YHxcL/lCsUM6pURrRGzG4MC1xQuXOQmO
         CJsP93gaVJiK+2xiB+NI20na6BrpCuc3R0TsAWlR9jO61TvEfsnicf4/vFhO6VQFBxmm
         yZbqqFQG97LKo1Oue1Mgu1b5dNyhy3mmKy/LCOyNUhZ92C3m9zsKEgEsx6gEsRhVopKX
         0MfdrdjG1FCu2ljZTiwxzlfYZ4jGBfs53+cJOGtrQrtdrAnzBPSCAFAC8Oqzl1slFjvT
         odsUGNhl4WgK+lkx2Bo4ovXZlr3ShgpURNvEeJtwpQ6k9/Taa0iol6gNuQn828TLD/h+
         u1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478757; x=1715083557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9IvzhHN84puUIqzRaEK8QdNvvnVmt/rg0fAQUr5Bqs=;
        b=cZZQYB1KFaVdNWbLM70LiniaNO8WJ9qfNhR3MbaAtJptScSBm6t7/ah2W6r9Q89THY
         FmCDslVOf+aPitvAxjgks37KgtkchTNYEvJxZ2YuZ+VIRHYhlBY22irGKKxFIe9O0rdZ
         iPJuaMrwijHNJmUwvRogDirswdafGjlLuh7BH1GBiVsZGLVmdF2lOPLRJG/GkufEI8+2
         nFhMdDSDiIVSlbwkjeayNbcNIE7qW+5a4y80nHFODpEoQN3rTD0AwUMtKQOTXeYxeo3p
         KrMqk4qWfMS1CQyGb5ptMMBaz1cPyM9DeYQfZGLMp5skbjUTAsU2HbW5WZPBgSY8jan4
         mIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSjhQIN6rl9h0qoa75hPDkXz60Qi/5isc6X5iXq4GqxU+szgsuUH73C0Lysf9RHKBpxbt74mI6wW8l8PXoqo9xRGkHiCHygzTZRCZVJ+6C6yE0e/dsCS67pC/ALGTaHXasihg2pJVv
X-Gm-Message-State: AOJu0YxuI13ebByND4lXjDLhBvKJkGaAwcpFlLS2k2loWktctefDPHhI
	OePKJ943RkBRn6B/pZgfzAP+SulDJ7ReaKk+ZhtYvigw045NaCK7
X-Google-Smtp-Source: AGHT+IFJimAmOWTm/cM5LrYCg9GTBY0JnEXu0rgDu6K1goOrbcWRWMygHBUDIyvFsDZymEQxIiTrYQ==
X-Received: by 2002:a05:600c:1d98:b0:41b:a670:a9f1 with SMTP id p24-20020a05600c1d9800b0041ba670a9f1mr8921046wms.7.1714478756637;
        Tue, 30 Apr 2024 05:05:56 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:05:56 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iio: temperature: mcp9600: set channel2 member
Date: Tue, 30 Apr 2024 14:05:31 +0200
Message-Id: <20240430120535.46097-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430120535.46097-1-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set channel2 member of channel 0 to IIO_MOD_TEMP_OBJECT and set modified
member to 1.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 7a3eef5d5e75..e277edb4ae4b 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -26,6 +26,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.address = MCP9600_HOT_JUNCTION,
+		.channel2 = IIO_MOD_TEMP_OBJECT,
+		.modified = 1,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 	},
-- 
2.39.2


