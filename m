Return-Path: <linux-kernel+bounces-146985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44A8A6DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE091F21629
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D1412EBE3;
	Tue, 16 Apr 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKfID6Sw"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93412CD91;
	Tue, 16 Apr 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277152; cv=none; b=Dl6L+sFE6OU0uyIh5/y17oDEQtTBrv8MbKJwEkdspdv4Kt8WR3q9P4BjDbNp7IGtM5/k18jkruLRjtS3GN0H3y53wnyqvu3puTsfCInGRVobQtYzD8z7o6IK6vJKD1anroo93aeL+E8E8mz8T3g6bgTb3iQDlFHKQBylrbrjsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277152; c=relaxed/simple;
	bh=vRb+ue/V9JDo67dbhPPpncMA8E3/2L+FmhinMOuC1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTJIwW2EkLoPkifrd0cioRbZU334SSStbmzEGml01GymlcLh54KhH7kvjqg6JB5Otuxc9XsG1Jm+V2Mv4EVTlbWbhyCUbC+Qk/2Gd1pHdgEBNhZ4YCLmzYlREouH6HJITkEEQkxNtUJk7wpDXv8UOLvbh011SE/pZtzpyoapA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKfID6Sw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343b7c015a8so3602899f8f.1;
        Tue, 16 Apr 2024 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277149; x=1713881949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/ArCWcFafLJYyEXSyGqpam6u82hUHVqqiMQyagnXnQ=;
        b=UKfID6SwkEHdAaEtxlZsf5hzAYR62WoyiXjBwLYQ28NX2gJWza5UGMbzFmhiD0sG9Z
         q+Fu7UcsLAdMlNAe/dgeT/tlfmrWxvF5O/3IZ0fZp8ZwISe3lTTro203JSa7UUyMSTP1
         lqb/6RcW91uWqqZR64RLzIjjM0jWUNMcJjGFXY3DhKK5s1oTVy4YTX58YpzPYBJVkZ3p
         xpE4jzpl30VPDf+4W2j2Yf1UxIXUzegJ9lsMcrnbQJdJrDjoQoKxR1ZOeY46fuCxPNA6
         xuQX9yApaqLeux9Xm5hEwcz+pPNMSNA4hikF6PIdnQHxXtmYz9GbBPkNhA77Y5N9CWIi
         TdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277149; x=1713881949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ArCWcFafLJYyEXSyGqpam6u82hUHVqqiMQyagnXnQ=;
        b=twr+IiX9l7TTizo5CUBJAQTcn1JqmepC1Ort1q3Jmj1p30rlhoVVJwvFyQlfoN81P5
         ZtFpVtAEPi/YkkDWyZJUPtWlZystoWdms7wzTZFJ4ir0UwJ0xV7EfKgZuUFGs/YBPpKc
         WDWPZ7eCsTTp9AYTKogqm/2wdy0wgqmLy7lmb8BqlyTvD3O7ufmGWatt7VJzGZ1hVvQp
         n/5/A5Eur0+Ttk+vMGzVrk1F7uE2T6DcvDMW5cI2r8/5wH00OEI+cnw41b14pq0nA4XN
         pJFPslzVYH5ptODznaChvsy42cP8fmz/7nJK3621AkQVsF1S3q9OShEnudLXyGI3mT05
         BPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWgi6P0qsFmBzqbbWIwBojwIfntJEEZcxbgz08w0wJQ9tEnlJkSfEIgwQtdaxqZroW6AttMv6cjpKcXbnqkDBApl9KLFXOm+vOD+X4lG5vMZl1/nWsBuSdEbma++ZLYBxxQTQkZnch+I4=
X-Gm-Message-State: AOJu0Yxt/jgWdlS8BhWQQ6e0viuhQJhUoJ96k8GTP8+DAosDDCBCwyu+
	HYHhTYX6VQjTO7kKoatsxQphCjFuhuBnbUaWSoO9ZB9R5VPKLVXN
X-Google-Smtp-Source: AGHT+IHJz5sxsuV1eimfS0+jaV5gGH6pl77Hu43z6tsxDHLD9U5Q6NH/A9ZEbetHtvSiqh/AsFNfZA==
X-Received: by 2002:a05:6000:178d:b0:341:ab37:6a25 with SMTP id e13-20020a056000178d00b00341ab376a25mr11748105wrg.43.1713277148332;
        Tue, 16 Apr 2024 07:19:08 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:07 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Alvium improvements
Date: Tue, 16 Apr 2024 16:19:00 +0200
Message-Id: <20240416141905.454253-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series containing improvements for the Alvium camera driver.
Specifically:

Patches:
 - 1 Fix fix alvium_get_fw_version()
 - 2 Rename acquisition frame rate enable define into a short define
 - 3 Alvium camera by default is in free running mode. Datasheet say that
     acquisition frame rate reg can only be used if frame start trigger
     mode is set to off. Enable r/w aquisition frame rate and turn off trigger mode.
 - 4 Implement enum_frame_size
 - 5 Use the right V4L2_CID for the analogue gain

Thanks & Regards,
Tommaso

Tommaso Merciai (5):
  media: i2c: alvium: fix alvium_get_fw_version()
  media: i2c: alvium: rename acquisition frame rate enable reg
  media: i2c: alvium: enable acquisition frame rate
  media: i2c: alvium: implement enum_frame_size
  media: i2c: alvium: Move V4L2_CID_GAIN to V4L2_CID_ANALOG_GAIN

 drivers/media/i2c/alvium-csi2.c | 62 +++++++++++++++++++++++++--------
 drivers/media/i2c/alvium-csi2.h | 17 ++++++---
 2 files changed, 59 insertions(+), 20 deletions(-)

-- 
2.34.1


