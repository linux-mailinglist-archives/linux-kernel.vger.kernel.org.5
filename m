Return-Path: <linux-kernel+bounces-147320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615988A727C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922981C2106F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAAC133422;
	Tue, 16 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRV08+ow"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4742058;
	Tue, 16 Apr 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289036; cv=none; b=WfIalDJc1k7ceUnB7z3uPjMMWXIoDIgUTYkbBviT0L6VVCY4ZyBOxL1ZLZxLPmKtv2xkkXWC+Z44GU9xMJhji34jc2p0udVf/6pmeRBmtJ9ff2NV9ba0D9KkKAGvbVIPzz5c05W3OTTSPXO1j6KqzFZck+29miCpZZGufNL+3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289036; c=relaxed/simple;
	bh=vlf65S5Zjhh3Eax5m1JDMKTSPqRK6yW4L+tVTaDRf4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0LwzvQTEq8tssazL8SE9K+LBdsX6c4UElSB3HaZWAgBD/IRO3AlaHvKqVjXtp9IXQTO9P72T/KrlKyTrXhRbV3OoSZb8OKnVoltUuVFEx9LZd10P9PTprduazf8cD5mYG12a+aGvqqgSaFefpB4lqc7KkrmKclF6MNp4Us37vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRV08+ow; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-618769020bcso50569687b3.3;
        Tue, 16 Apr 2024 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289034; x=1713893834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEWp1yQiPG32wuIRE4i5gatwKrEB8wtcf9vjeF98l+E=;
        b=YRV08+owdkNdh15g/EhcVL9k+93vdjW2kMVanLjjkOmNKU8dNgeJCmJdf7Wt8bF4di
         QUUV4p2UMvSHOkD6T2fI5CsOAZX8VIGoY1py9BSUusjpYphERSMQHcLyYfRoVglu9tfF
         +I+dTmuv+ZQCu0RyKhhkF1yjpduyeiR8X4rKbIfkdG9YgC9uOqloA0eGmiWt+1y3eu/4
         aoTQvNemXZKKrJGkkqBJQNLMI5vN1c7OW7s3WCvE4HnIkZ8FMN68s51ltQtYMZcGnKBm
         gJJHxL5e5xmTz+vA+S55ABkx2ervUCkcvJKKSoIucxRKAkyZBV18dQwU15+UnFy9v9eo
         91kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289034; x=1713893834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEWp1yQiPG32wuIRE4i5gatwKrEB8wtcf9vjeF98l+E=;
        b=J+iN+jlAVfFZ6f0DcDU+bZ7GhoBUQos5WDxh+1kb9OkNplFJsvu9+bj4VIS5kTa9MS
         lADG0+CgaQT+SilZMybjv+exDNpv5CmYE91tXL6TTWLvcpP+hNYNErzR3/UFODJAVWGc
         oa6i/mHU4eytRC3OlpEa8WXc7tYCOLEaXcPc+xZZHUoez1uHnIkJ4cD07fFJLtivGhfV
         YsA22xQ1zKGCZngZrI3pmrzu0Jlq5dZnTMm8UQPWTCl5cBTfZ1MTebk3xsQM4ghvZpxH
         vNUvtxbraPH6krLQxEU7Dk/JWgixh8FYZqFQul2ahqm6zdalU/5mmxMhaeHVT4VkHKnP
         wEqA==
X-Forwarded-Encrypted: i=1; AJvYcCX3jVlQ1KfHMCV87J9eyrGMm/P2JqaHeGSBMkssiWmEFAsKERsfAZ2MXvIm6riaQ2d0v1NLkldfYiEXpE7H7bkaI2HfQgj1xzM+PYENA/OipymS7YgDJ6+lVp1mbCpIEF+frox9zkVXPQ==
X-Gm-Message-State: AOJu0YyiDkWudHtTh2pjjcmdpsBUx5QMC3MvhFknFKW5Bk5v4JmQMK4I
	zoPkhzWsrzvy+0OzyiONHVnbpTHrub+kg8/dgZ61aMikzXsPMqL/
X-Google-Smtp-Source: AGHT+IFY7YY+aRjq9R8uzfcNgU7OCvXwhGHjMtMR78VoG4uemIhB1nJHmuqZIhgYdS3Sj709Wf7Rag==
X-Received: by 2002:a0d:d48c:0:b0:61a:d3c8:4895 with SMTP id w134-20020a0dd48c000000b0061ad3c84895mr5699089ywd.15.1713289033659;
        Tue, 16 Apr 2024 10:37:13 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id a134-20020a0dd88c000000b00614605317dfsm2615988ywe.50.2024.04.16.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:37:12 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] MIPS: SGI-IP27: micro-optimize arch_init_irq()
Date: Tue, 16 Apr 2024 10:37:09 -0700
Message-Id: <20240416173711.613750-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups for arch_init_irq()

This is a follow-up for [1].

Here:
 - drop unused 'i' variable, as reported by kernel robot [2];
 - fix typos in commit message;
 - add 2nd patch to handle WARN_ON() better.


[1] https://lore.kernel.org/lkml/20240413184913.69268-1-yury.norov@gmail.com/
[2] https://lore.kernel.org/oe-kbuild-all/202404161933.izfqZ32k-lkp@intel.com/

Yury Norov (2):
  MIPS: SGI-IP27: micro-optimize arch_init_irq()
  MIPS: SGI-IP27: use WARN_ON() output

 arch/mips/sgi-ip27/ip27-irq.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.40.1


