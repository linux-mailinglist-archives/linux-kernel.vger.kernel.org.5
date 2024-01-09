Return-Path: <linux-kernel+bounces-20942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DD8287A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8620E1F2413C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6A39FE2;
	Tue,  9 Jan 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU0Hq/KU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9123A1BE;
	Tue,  9 Jan 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d480c6342dso24015175ad.2;
        Tue, 09 Jan 2024 06:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808960; x=1705413760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeblHmwN9pMBuk+p5V39Iz6mrE8Ji3WN3I80/xgaRZA=;
        b=QU0Hq/KUFv/58O7t7dvcp4AaD8vU8oMskuLEMo3Ob/92Yhm0mbyERtSD9Wrnzen4z9
         4BDom1rXbyOqn4Tp1Xbl/r1410UPbhqwGYlVUicWQduyC7pGRCXbrXpExGvI6Vuqk5Mr
         V+jfvdM/Ovmt7Kc8HodqIHM8oHf/5PGnN6a95qnH4ZO9nPa+UgGRMnDGiQ9Z4Vl2SczJ
         4tru9Fvopbtt4o9Lmx11y9DyBrYr+3YLb0O4e7Kqv55n9k7hKekRPgOs6HOHHUfA2a2w
         supvB9fkm5nO/A7K7aqZD3CgM5EGIsNPfGLkURv8AckPmzOTBTWzi/MeKmuTMkQnzUO9
         SwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808960; x=1705413760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeblHmwN9pMBuk+p5V39Iz6mrE8Ji3WN3I80/xgaRZA=;
        b=n6LIlbajcNmIjx7cOGhsRqlzeBxcsINL05VXxd3m7oh+vKrozi66eANjXDDH8rULTu
         xyRwReSALYm9VySTIAtbhr3WT2y5fZNaWPNabZfuwi+62eIe4ZbFHSbNKuvJjBVmswwb
         98KkqWozlI0RySXILfSRmIXimgug1Drsdbct4W1v8Ci3b+6duoU+Zsn4H/nPucnScWNR
         GBC2SL8cA4I+6a6eUw5zT3mKm03KdCJ0BITsWf7TQQxv6fJQKXF8aPdLYLPe87KJ3FgV
         oH7kCTapkM/qPSmcIiasWFpriPojIiNd4i+nDf/XmmMtxoDpEyzqhLDt5s1A5LHn5nue
         LOUA==
X-Gm-Message-State: AOJu0YzQ/H9XZ1pmHr0ffX81ix4UWDwzpoMAnSc1nR/0X9xQ4swyvs2Z
	eQbp3JGcKHIxw2l8C2s3JcP1UYkWOeQYGQ==
X-Google-Smtp-Source: AGHT+IHBDWLORChFjXZPYBbKRCGK8Jf31h3Au9A4i9AWNdWX3Y37lUAQI77DJ7nEI2qe7E29Lh1TQQ==
X-Received: by 2002:a17:902:b70b:b0:1d4:be53:ac54 with SMTP id d11-20020a170902b70b00b001d4be53ac54mr4782299pls.79.1704808959579;
        Tue, 09 Jan 2024 06:02:39 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:02:39 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/5] gpio: uapi: documentation improvements
Date: Tue,  9 Jan 2024 22:02:16 +0800
Message-Id: <20240109140221.77725-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of minor clarifications and formatting tidy ups for
the GPIO uAPI kernel doc.

The series is intended as a companion to my character device
uAPI documentation series, but makes sense on its own too.

The patches are self contained and trivial so not much to add here.

Cheers,
Kent.

Kent Gibson (5):
  gpio: uapi: improve description of fd fields
  gpio: uapi: clarify hte references
  gpio: uapi: drop trailing period from one sentence descriptions
  gpio: uapi: document possible values of gpioevent_data.id
  gpio: uapi: clarify using v2 rather than v1

 include/uapi/linux/gpio.h | 52 ++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.39.2


