Return-Path: <linux-kernel+bounces-60505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD68505D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB781F214DB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3E5D484;
	Sat, 10 Feb 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXVP28SW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C75CDF1;
	Sat, 10 Feb 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587760; cv=none; b=bzDgRw77dVRDM4PGsqKDOyoeSY7fgSvIglc6SEnrWQtlQSs87hEQg1Ly3pCw7fOjKiHcnnjMG3Zn5NR6iFK+pCwLFdjxCNoxLk5DlaaXzNzfWL0x6frV4tEFgcnIADy+IQF/oGgXg+M64aDnGz+lwbov2HMWKvQYfZFYB/so530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587760; c=relaxed/simple;
	bh=u+7NmBnx7wH39lDV/QvY1A9HOsQG32pArbsSP22zwec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2dNRciyHYpIi7pAJcrk1x9KODxaFMfNohsAjTHjJtRMCfvv0yaXWVr4DYY/xDLlg5hJN89L+l7b2260mX1ITRXKvOg0e0i69pn45NAzyn7I9ta37rus8t0SKbzAnGenvluq/lvsPWe0LGWYyVFs/h9e/JyQ0yioC+fEQSkzJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXVP28SW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3864258438so352548766b.0;
        Sat, 10 Feb 2024 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707587757; x=1708192557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGl/GGw9IkMItqM3WVNXW4B82dz0+RIREKY5/bo02o8=;
        b=iXVP28SWaLVyGMwNu3H5bnReBAFabZYMyViLJA7Woq6iL155bWT/bcmvK9aZ2JSP+1
         bS/01hqA2KhtWRAWlDk+wWPhWUghYOrTFU6xUa/Uys84CX03sxRJoJyES0RExQ06kneD
         ZY49QGe9aAlarwOVWyxBBBXyQOVd3dlHbd3BMaRwOP8RSXGFoOu/ig8YJi/3ntZZb5iX
         O3xjj2oaZCBmKC4fCQLUa8BrDG8QnraVE3PdkAR7ZzT/W/GTNmvulorHPWO2ZrQwOuGD
         HcHQs4taI1ZJ8osDDNZcxvRj1pgHDFLzlREBox6j8qtibAsvcJ5q0WVVUvcZgUkR/s3n
         BoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707587757; x=1708192557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGl/GGw9IkMItqM3WVNXW4B82dz0+RIREKY5/bo02o8=;
        b=jeqXfEvlgsr+GFsNGq1aQ0zpPBPsESI9LmY/rQJgrtjiCz5HYrqhGKHQ/usTWpj629
         LExFyHSBVb1t+nvXzS9kIwjlJxlzLpUX7jnxwVvCnn5uNf5YC7wTJ75TAA1pyI69gMOk
         aYpDsds5zbDSQMNiLVS6RXGnpOItpIJKqcU8wBTLHTwIhM4M9qodfjlwlWdbcFb1QOzw
         H8LPh2P/ceemrOV9c35nKEJthPcjIvnFjlOtmjl5QjrUgetKL0XOSACf09A1Sj+r6rIk
         4EVj90llZ8IQntOmVfRYlQbuqrAqvZEG62hcuDsDevan9Uae51gLFQ6bh5o2yth/8aLZ
         /uRA==
X-Gm-Message-State: AOJu0YxWPiCws1ZF9YTobG7MGKJPz91DtpmOHSb87/U9AdXgSaWotZ0F
	sW1LJ70ffKqPAZph7Dmbd/jQYQPdqw/2ao8qrOQ018AtRboo9l1EoVz7Dw1n
X-Google-Smtp-Source: AGHT+IFKO4R1HV7yLsuVzOXHsjlEqpu0OFuWCZOguiK0dQtbZj+0ddQalNBp+4TOuaIIn8I5hUrBww==
X-Received: by 2002:a17:907:9485:b0:a3c:2e4f:f93a with SMTP id dm5-20020a170907948500b00a3c2e4ff93amr2196961ejc.1.1707587756932;
        Sat, 10 Feb 2024 09:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcAYoY8iTDchTe3mVW04xgbQtzwYeiOSHh/0ZGRCucEdyoViHT0vMqB4EcKJi6lT2y33BhKK2fME41UrqxYgSaBPy7pHQJuQMBTKhBRniqoRsBtofToDzKpDYqMTexIQACeh3d07u+tQk+c6ZLivywOXbny5geAgGFQBf/oI5JbHrmsqZtuT6Eu7Od4XAASBzvnQBUHANV/26FYX6fWSBcMNs=
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id go43-20020a1709070dab00b00a385535a02asm2001053ejc.171.2024.02.10.09.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:55:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Richard Leitner <richard.leitner@linux.dev>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] input: touchcreen: tsc2007: make interrupt optional
Date: Sat, 10 Feb 2024 19:55:29 +0200
Message-Id: <20240210175530.137361-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case tsc2007 is used as an ADC sensor there will be no interrupt
provided at all, so set up an interrupt only if one is present and
remove associated warning.

Svyatoslav Ryhel (1):
  input: touchcreen: tsc2007: make interrupt optional

 drivers/input/touchscreen/tsc2007_core.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.40.1


