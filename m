Return-Path: <linux-kernel+bounces-106325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239E87EC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA1EB217E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45BA524D9;
	Mon, 18 Mar 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBW4WXG6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3A524BD;
	Mon, 18 Mar 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776770; cv=none; b=ROimcP5qqfSmp73hMFirLaZvv/QMM908KGwGr+Po7kNKGPfO4qjTNqBsURe/VbAu+A6v/c3cw1XjyHfBXKj00RhLkUjuUMdo2LhyMZLuKnHJQ3VXZfHwV7ioMYoDy/n1q2aq6F6Dv/yC1WA3zMnQSwO0tDUbIeqOig738/hHRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776770; c=relaxed/simple;
	bh=ar1jQjI+S1OdBr0/unGAa4jqiE+Xac47nI/pjQallzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnKV3h7XBp4JuMM473qvkq08T6aPs12dAbK9KWYEdzZZw9JeTx62IRRpCFOc0uXOkOK4cE16UhIKWTHPxiDOCoPeIxz0A8VU0ow4g+xNxv2/UBl+b57R7ny8WtOJJb9l7Kf/iXl4pKrAv6wEfFUp4TUUjn6NNj9KTGyfV92NAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBW4WXG6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b22af648so4001264b3a.0;
        Mon, 18 Mar 2024 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710776768; x=1711381568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au1XNn4Xxv1+LKAPiFUCmltYBMC9khlBCRlLmLH/8EQ=;
        b=gBW4WXG6TNteDmOIK7GQd0BEK8RZ/1Xdrinfc/lKmAZHWFNtMUCiAX231i/1hiWKB4
         mDGta4ygHmSmkoL2djeO5ZFS8+KOHWJX2sGU3jIO3Dd1uw7jgOCe+Yopj61dO43GB9g8
         GfidSrmPKax48v8VnbtT+D7iGnWaOyVIdR5Spup+dNS5Mll0xghpke6Oa56L1VEcpPQR
         2uMRkZ1E6vGCm7TGDI9qWOvlATWf8hBSe/ffojFZ6K9ZzWxDKui2cyZ2RuJi5uE2gfrS
         r93Wv+kxoyfIuD75w+Tr0LUOfLuS8HnrU+yPKbiw7LggG/SbTLmpxIwOAmmYkc3tmQk/
         FLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776768; x=1711381568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au1XNn4Xxv1+LKAPiFUCmltYBMC9khlBCRlLmLH/8EQ=;
        b=MoacaGrim3k82YX5casFUrg12t3qit+wEgqwhOD5A4pNk0S1zgTnpmp3W3NIvaX0+j
         7Kp93U9iWbpfjnt/LjgrOxU+R5H7qsVCrzWQBOSpW3Zlo/aBt59EqoeR5jgpiqdC2xHf
         ctmeDaHlJhJ3L5mLknzHDr0g+wKE4VVQY6yQOK/khAK0c8316BomIejU1KW+/28u/rQZ
         56rswucKGcKomFaRuRqwXUdBssXVPdbULdn7hQAJXptxTt9d/Iyh4V6lN6uuqr7EuzLb
         gx1LED+yyY7BZlrCQ+fPwk3J1bjXqYKcDvaF7aoI9gEQyy/qY9RKWMzkc7xeM6P2Ar2m
         DTsA==
X-Forwarded-Encrypted: i=1; AJvYcCW63njD27GNf9ig6ZUNKW/ffUSR/Yiib36v58RTYiogyUcUc67DIHl4dv3YZZN1fh8v+r2D6SI38cK33R1M7o/tajtUzlqXzQegdyg=
X-Gm-Message-State: AOJu0YyZfLGu1++QXquw6P6gkVZ0Xt1Ln/74xyNT6XAgxvRJwNMN75QJ
	u+R+Wfr3hy6NvZL4qLoTt6hmCTgaMWOmvLqzXj8VWKc1pVKgJdaXlxbVJfuX+Aw=
X-Google-Smtp-Source: AGHT+IFkXmTXZ79CWpYHk2lrMt8zTXM6vQHAuuueVXNRwU/bwvW1RMm1bfAF3TPRpttHb+gyyn7NLA==
X-Received: by 2002:a05:6a21:3992:b0:1a3:63a3:2a56 with SMTP id ad18-20020a056a21399200b001a363a32a56mr5344565pzc.20.1710776767590;
        Mon, 18 Mar 2024 08:46:07 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:31f8:807c:8911:659b:1495])
        by smtp.gmail.com with ESMTPSA id u8-20020a6540c8000000b005e840ad9aaesm2400080pgp.30.2024.03.18.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:46:06 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v2 0/2] lm70 and lm70llp doc link fixes
Date: Mon, 18 Mar 2024 21:08:33 +0530
Message-ID: <20240318154540.90613-1-five231003@gmail.com>
X-Mailer: git-send-email 2.44.0.273.g4bc5b65358.dirty
In-Reply-To: <20240318130840.74589-1-five231003@gmail.com>
References: <20240318130840.74589-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix links from the documentation and in-code comments pointing to
datasheets.

Changes since v1:
- I forgot to fix the links in in-code comments in spi, so do that.
- New commit to address the same issues in hwmon/lm70 since the spi eval board
  is based on that.

Sorry for the noise from v1.

Kousik Sanagavarapu (2):
  spi: lm70llp: fix links in doc and comments
  hwmon: lm70: fix links in doc and comments

 Documentation/hwmon/lm70.rst      | 2 +-
 Documentation/spi/spi-lm70llp.rst | 4 ++--
 drivers/hwmon/lm70.c              | 4 ++--
 drivers/spi/spi-lm70llp.c         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.44.0.273.g4bc5b65358.dirty


