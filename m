Return-Path: <linux-kernel+bounces-25572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A782D2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD32816BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798017F6;
	Mon, 15 Jan 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyj7uimZ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D546BF;
	Mon, 15 Jan 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso5467457a12.2;
        Sun, 14 Jan 2024 16:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279823; x=1705884623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub9tHuBOLopgebfbkbwN/PTiEyrZi756Wca/FmKuvAc=;
        b=Gyj7uimZ78FlwUQB4Yps6xZH1P1VBheXajUsRptvd+Vi+eFZ7kvZpv89HluoqwESt1
         j1bb9trpah6Rw9VDrWQ0i67IqsG62LNp83u4/qAhIxH57wZuW3chpdffvrzzNgSNdQ5W
         hPoScJgZK59XjcPHpuIgqcbrX2JngbzvkL1bfBN0FiQG4Pa22Q2lRC4SxrSCIf6LwBjH
         HP3Nm85riPXoN7DShCv/qPVzRgNqRcZPEdjCFkOWzcABSxSgpl83NXvhjM2cLJPHwfnU
         BFrPjSQw5AQ9wjSG0zuVU8IU+U6V3I3FUFokmiwsu1PJChIrhKg6/hCkKn7kicq+lJGZ
         gCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279823; x=1705884623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub9tHuBOLopgebfbkbwN/PTiEyrZi756Wca/FmKuvAc=;
        b=ghzvQ++pl6rmAA+ZV9EcFEsWQoXqcrIQM0VHG3+hGca4XjS1LItke/ZasYF6BV2GDz
         7ydnIISIRAggxgCZPCMV7PjyhZhyxO+6mrFY4uuGHVSd/hAA2BfjmJM64gHIEoUS2ojS
         Z074KcxPhIxHzMZFqw2qaclTmok+lFBkDnwIvuCa7vsBzOL1lqsMRZJ8x5goYkCdguV/
         nhRduwBNGbJoxDYx5WXC2j4532edzIx9KjXbn6BgUIOg7fwV+iJMF0bNBuB4NecoKsVi
         mOcIjlUoa+ZLcnrpQFWfLYb08DBvQZz7iLWyKIVro5ZIA6hL2ReN3fjEqK70arnEkc1/
         nvmQ==
X-Gm-Message-State: AOJu0YxKEurPqUNkxXV1AQpKujydqn1N8UhqAceWOPCZOiV6ag0xaMJ/
	WZuqjjODHZkwiBLAhhxUyTvr1oGUlA3wzQ==
X-Google-Smtp-Source: AGHT+IGseLMXKhWLBUojJXb7wJXqWDNudH9a6HbzGocmaTP7IA2BkZlI+U55w8xqjAhTbVdENbpQtA==
X-Received: by 2002:a05:6a20:e11b:b0:19a:4073:e178 with SMTP id kr27-20020a056a20e11b00b0019a4073e178mr5829117pzb.25.1705279822938;
        Sun, 14 Jan 2024 16:50:22 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:50:22 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 7/9] Documentation: gpio: capitalize GPIO in index title
Date: Mon, 15 Jan 2024 08:48:45 +0800
Message-Id: <20240115004847.22369-8-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capitalise the title of the GPIO documentation page to match other
subsystems.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index 3ac3aa15fa8b..3f6d5a76702b 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ====
-gpio
+GPIO
 ====
 
 .. toctree::
-- 
2.39.2


