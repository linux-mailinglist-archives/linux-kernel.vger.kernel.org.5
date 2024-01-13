Return-Path: <linux-kernel+bounces-25182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C582C933
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68BD286078
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F16F9E6;
	Sat, 13 Jan 2024 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn4fGlpp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429AF9C4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d48a8ed85bso16563865ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705115653; x=1705720453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NUMTfusbjMtqPi6IDNiXVOWQ+2nlpqZ2I2bHgG4mGo=;
        b=Dn4fGlppAMIEbUerYZ5Mt21ICY1Zh9urGKpq5V2i6GCk4IguLItwvnAZ741g3SqTJn
         ZMBOgweI90lpL0GFToCr6xt6VPtQG9vk7bL2NgCmk7O9Jj9S9O74/yNLEBKBNN0XEMVe
         10axpZFXmWEMqzWc5yjO6oR0v51tz+YabQOGPgLCdFcOndgi35EJNS4+yajrNgxj8W2h
         h83hy1V4obWI1NBhPyoIoHofLqjTTMY6CNt/1rAinlgYei57Yy6zECECJIzl/fC1izji
         sSfOncP2xb5PDK9I/eybkz6lcAQCvGMJ5aS67QO8lF8QnarprJYNkViWKj1zGTSZJ053
         C+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705115653; x=1705720453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NUMTfusbjMtqPi6IDNiXVOWQ+2nlpqZ2I2bHgG4mGo=;
        b=Ujy+01rZKPDdzKOltRTvfFTOp//p07zd9hDl1PvHwZwAw0w66OornmwAx7EMcqxYXf
         oDHQo1zXM7xSbAWCZ7oFpEwz7XKZDpl2Ox0b3VGtABPmPG4tH6hPG0SuYKIIG8xgHkjU
         BBBEfOWXLH0qmBZIK4UGLP59Acrl0bXiW9oErndW3WZixTjKdeV56knczoggP3J0McLv
         Mj0htA4I2HuzJYIuENkiYzGQhqKHLvxsfkQ39d00vmFSaZQLK26C8Dks0ckvZD9AExjj
         xAJAS+Vjz0F6/jIYnq65z7n7iP6f3zLLpc7RnAlzxdqjJSRNZubFDnYyVm3SSv92JJY6
         zarA==
X-Gm-Message-State: AOJu0YxAza6etlBmutRGK4JWeF2Qr+IBEHytDGpiEfhHqAf6cHEyc3pg
	eWZDvlmTmMEXT2N8yWlNMbKaUM58ZXA=
X-Google-Smtp-Source: AGHT+IH+C8oWEp9tOTt5u+uQMVgQHh77cRgy64XqLPO7iln5MmtKlsSnZrWyQ19vZT8zQE6w0tiNmA==
X-Received: by 2002:a17:902:c194:b0:1d4:be1e:f197 with SMTP id d20-20020a170902c19400b001d4be1ef197mr3958350pld.1.1705115652897;
        Fri, 12 Jan 2024 19:14:12 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001d3c3d486bfsm3912551plc.163.2024.01.12.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 19:14:12 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: lkml@sdf.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] lib/sort: Optimize the number of swaps and comparisons
Date: Sat, 13 Jan 2024 11:13:50 +0800
Message-Id: <20240113031352.2395118-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series aims to optimize the heapsort algorithm, specifically
targeting a reduction in the number of swaps and comparisons required.

Thanks,
Kuan-Wei Chiu

Kuan-Wei Chiu (2):
  lib/sort: Optimize heapsort for equal elements in sift-down path
  lib/sort: Optimize heapsort with double-pop variation

 lib/sort.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.25.1


