Return-Path: <linux-kernel+bounces-163891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDD8B7561
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401F72830AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A71145326;
	Tue, 30 Apr 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7JkBQY7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A313DDA1;
	Tue, 30 Apr 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478763; cv=none; b=PyBKGs4ENrY6NUeeg+6Q9hSl5y1cbCVvHGDMvUOuanbVeqkVf/Ky0mx+rg/xb1TqGjlmBKY2vpEZpgWPfeRtK+2gIGuLUtQLb4zigmfkVoNj4MKZNEYbc/eufardevvA1lga+Tr+wdFotWQbApOMY/fXOSOz3lLYQ1nU0DT1zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478763; c=relaxed/simple;
	bh=2JxZ46VcZWvbyPVPb1cyk2/6uf/4Aaz91vZxN6diARc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQgOIHh0H7woJyGTT/OKNE5ef2p+tDa5I69QdE+OCzyV2Mi044JGq33eNDBycsS0z/KEW2tbnAWogLL5xq+vok3eCUId+igKEJL0yDvJZlwBCegIs+kskkg12bN2JxfxYXbZ5+YYVrECohmAyIIZEXyYSf6QvXu3O1HuIqTaofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7JkBQY7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51c077cfc09so6575732e87.2;
        Tue, 30 Apr 2024 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478758; x=1715083558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3BgglTbE282Y2tGBI8He/8kJHXPAXkHQuRLmbZ/HRs=;
        b=U7JkBQY74oqDn3BEEhek1ktuSrYOJz/2yS7KNAvUsEoQbtNWhijF6AZ+3TjrZmdHSL
         XnwLfW2Fb5Zqz1lt/9UJCFbKm04keXaXn92lLvktqU+UMFpmsiXhW+pgxmG3a/ag+Cb6
         pJ8YiNMI1ejTQ3CgGFRxXMCk/Lu3MK8ECTpBddI7xxD2AFr3ozJro9heQzqlINatEHlE
         QgDOAPG/SXnlHUxkfJmod+eo1k84l/5fh2ieuxa43hnDfA8t74tvMjiNiyFtXnqD0VJC
         IhyE747ku07lmigJaW8uJRxVJw5r6ml1vEBvGwSc6D+dTffIzcvEUp+1JrkvX9wAG7q4
         T0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478758; x=1715083558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3BgglTbE282Y2tGBI8He/8kJHXPAXkHQuRLmbZ/HRs=;
        b=qamNMNQl6msR6gTeJOv3WE0hh8WpHDojdyhQU4MLv92aMSue6Lywqemn4C72FuifBp
         a+Ml1dI8BAxMNWdoLNysD5YPl68VmsGI3h0LN2ONiWumLF8C6YYF3Y1+2f1CmJo6O/+L
         pdpTjGvLlRiQGqySES6nhPz7GUDWitiGQtcQCuo6twzh574CDyNhlAFhSxm/NJu2nNaY
         RSRzllOulVXWneg58BN7A1cZegX4hTpIN5VvgU3jAZIvuDWYQEyODloPY7VhKf4t42Ju
         Z5ZWgZGOdFv/C6c52B5ZYTBOKY1D0Wo4RVVEmDnL42+9qPTgosEONADvoyqM6QlRCYm2
         7rzg==
X-Forwarded-Encrypted: i=1; AJvYcCVFs3CS4AQ9e5bd79H0lhuAjAcFyTOWxGM0We8xCVO5qgg4EKYE5ut7rrRLsFixW5WdvmrPgWc53LKqiqEU0ubDP14PFDKnWa8lFAd3ZW3kL+3RPn5X2tXDks6CGaAXfbEaUJtLqjBg
X-Gm-Message-State: AOJu0YyQPMHCn/+on1Nr46293hoq3Y6mKP33/HD+fV/7XEMfCauy0WKq
	Y+OucBbHVLS0aAmolblvpjTKvjGXn1MQgP0Y62RGyjXtMV0/IQKQ2NT/gA==
X-Google-Smtp-Source: AGHT+IGphn33MZVh9pKlfqfYP5sg5WD/OrJnrosO9Za7cgxUkmGC6HupzhUC2qyZ3fGy4E0cTANOQw==
X-Received: by 2002:ac2:4e90:0:b0:51d:998e:e0c1 with SMTP id o16-20020ac24e90000000b0051d998ee0c1mr4087282lfr.13.1714478757704;
        Tue, 30 Apr 2024 05:05:57 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:05:57 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: temperature: mcp9600: Share scale by all channels
Date: Tue, 30 Apr 2024 14:05:32 +0200
Message-Id: <20240430120535.46097-3-dima.fedrau@gmail.com>
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

Move bit IIO_CHAN_INFO_SCALE from info_mask_separate to
info_mask_shared_by_all since temperature format is the same for all
channels.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index e277edb4ae4b..74e0782fb073 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -28,16 +28,16 @@ static const struct iio_chan_spec mcp9600_channels[] = {
 		.address = MCP9600_HOT_JUNCTION,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.modified = 1,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
 	},
 	{
 		.type = IIO_TEMP,
 		.address = MCP9600_COLD_JUNCTION,
 		.channel2 = IIO_MOD_TEMP_AMBIENT,
 		.modified = 1,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
-- 
2.39.2


