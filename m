Return-Path: <linux-kernel+bounces-60507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D408505D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5479A1F2149A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63A5D485;
	Sat, 10 Feb 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WguAaLdT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E45C5E4;
	Sat, 10 Feb 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587976; cv=none; b=dHZFQS1Uy+t8GUPFKHuow2OGto8CAxBxAuXtz74/woD2DNowrjyqPG7yYw/7c4K33fWI1dI/GC375LFBU5sQPzptI08/YtzF61lGrSbYTWr33SzqaIFb/TSAH1kX/RhZWZ6C95ubSW6kRjvdlLn2qByERzep5W4KYwAGSnQPG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587976; c=relaxed/simple;
	bh=b7UI/H5haSYY1vo/GUoMk7Utc7xc6MpgPatIr62cEcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sARe1l+lUPHz89ZkuWt43wETIeSnrxldbrDsMfQRCEaDDkZ4fh2in2HfNBuv6HhN1sbzdakzEjmtRrCV3d2xWoRWjeMdOnr2/RaW9Ld5X/LwVxeUP44cVaTDbbQIXktVwdA7ZDXJ3OMC6AGUNwH6ibLr/6uAdkKKvzl/PJEnWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WguAaLdT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b2fba3176so1123596f8f.0;
        Sat, 10 Feb 2024 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707587973; x=1708192773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osp7CCpj7xgHrHOQxTuGeNk/XLl6ck22QWyA4VLv4zc=;
        b=WguAaLdTOrLqsUKNljomO/L5TPQPAMxhD1Qn4dIiF+fo43KFd0RWakU08XMur+GTPB
         S+3tg64RN9PiKa7SfRGREPoypk0+BX6yWsGpl1XeO2WJ0bIyV+h4suFG7Vs/IOq5IVEL
         +t5ez8vaIhgHbWd+l3taNozZghgZ5DCmk9MDgmutVboJVp3fVIn22VZJHN4MeGdN8c/Z
         3DMEjD4x7Y+ud9MxFpyQJqr249FU+2UTx/f3/+pRzYAQFGg2o9RkDpqB4vueB7+KK1EE
         74wmLGT50RZqSFbXh4D7tX9GmEr68HiUL6dkOCp+S8ndqfMVSKjYx7oW3hu0EVWlCWQB
         srRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707587973; x=1708192773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osp7CCpj7xgHrHOQxTuGeNk/XLl6ck22QWyA4VLv4zc=;
        b=WJwN17bSv25u++gVT6qD9W9ojXIZLrua6/e0huzYNsyuXruyDbO88BQfLECLSJ/PEc
         yEl85J+60m69Ikm18JgyzMoV23HOdf23ujIMUr2eB3P+vIvkVEBLcLId8YuJpC2lAURK
         rgz24YJxr6s68SImqPW/j0dy52khDLc1v6Ye3zYAeEWjfxTFGk+gcJcX5oyzwHH0iYnN
         SmJ8hWz7P+e9OjBVTDK5HqwLFU4MnVOO963bncMl92fIlsKGESOEtmk2SX+Au3chXF/q
         ZAhZ95BfzFml0zQpW7xgiIg0Qpche0C9Ja9FOhi/OpRIdpoAxHfHHKOQ/eFLJANk3cp6
         ICsA==
X-Gm-Message-State: AOJu0Yz7n6ASlbiN1sSvw2XOP3tzLyrIoHB5C2SKIQteRfNXH2E6wPXg
	SuPxW/5351H16zbyia4p7JFVYLY5v4PasDHgwyifCXf1pH4SQoUfMaCAO/0j
X-Google-Smtp-Source: AGHT+IEdkdta0chUIAUDRqSlkSJYm/DXkfJPA8v3QcSfH3jyQfdUdEg4lMfDi7Wuix67XAHqUTPRLQ==
X-Received: by 2002:adf:d1e6:0:b0:33b:48ee:8a35 with SMTP id g6-20020adfd1e6000000b0033b48ee8a35mr2678618wrd.3.1707587972392;
        Sat, 10 Feb 2024 09:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgu95Gn/n8kkt3GoVsgFbuSIh4J+bkSjnCqbNoE51DN7PD+XasngHdQF/bmPfkgJM/P03tEslVdFii3kuqvi865El7LljteQALZowQ5BlS40I8tees5Iw1APEbazoxFUuXYgdzjHbzCXaJO7Q/FiGxukgtUNHbjSFJ1BOu2xXFSuA79XklPRbFAQxzH650lyfI
Received: from xeon.. ([188.163.112.73])
        by smtp.gmail.com with ESMTPSA id y1-20020adffa41000000b0033b67f6ec80sm2379920wrr.80.2024.02.10.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:59:32 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] thermal: thermal-generic-adc: add temp sensor function
Date: Sat, 10 Feb 2024 19:59:21 +0200
Message-Id: <20240210175922.137704-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing thermal-generic-adc states to be an adc-based thermal
sensor, which is not entirely true. It provides a thermal sensor
cell, but it does not provide an IIO sensor cell, which would
benefit devices that use adc sensors to detect temperature and
need a custom calibration table.

Svyatoslav Ryhel (1):
  thermal: thermal-generic-adc: add temperature sensor function

 drivers/thermal/thermal-generic-adc.c | 57 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

-- 
2.40.1


