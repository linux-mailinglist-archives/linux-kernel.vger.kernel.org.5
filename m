Return-Path: <linux-kernel+bounces-7720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1895A81AC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93BD2878A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D621185D;
	Thu, 21 Dec 2023 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgbhec6t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61B441C;
	Thu, 21 Dec 2023 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d940d14d69so212279b3a.1;
        Wed, 20 Dec 2023 17:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121690; x=1703726490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0+OiIGPu+HUKHHy83yKhozaVuLruzud+CSwPTxOtko=;
        b=hgbhec6tvgvwNiiyP5nKYCA6iNmD6dQGhr9/zh0FhG8eWSliw9VBPzfKxNxi7yBhJr
         b15+szLGoY7oGoedeG05KwiQEPwetJJMXfbwm2LtZ0esMx1nipPAoDKlXFLOakIhK/Oh
         OU/WcgmhyXr4IHCKOdCRWrF7kWDcl7c4aQjg7K2CBRcjePORavqbiO6ZBmSJETwfMZqR
         jX0eBV2gj5ZHYFasrqiMtvVLwYtGgJoT7HVpVmd7qv/jHT5k6YUC4pmnhyMy4IrfClat
         5aruZdTW+FYTVS9LCIahbfHm4FOGn5+5YU5y5idSGi7Ukfk/U9cDLtgSTods14WSASlf
         P5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121690; x=1703726490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0+OiIGPu+HUKHHy83yKhozaVuLruzud+CSwPTxOtko=;
        b=X2/UfVVMofnIUY873y92NtgNwxfskjmVBwQn+Bs8IBoO+pcSeLvFgA1RixubaeiChz
         0O53iT4bcM8b4NxgB3dp9BHuBskSrIuEMuUHMp5hRzPX58p4TsALBFDuBiuwC1Tlw2VK
         Vk77+7RBH9T7IvkzUZ26mBYRjwtjzROW10yQRNVvZuUzY6N3Bf9SoG3Fd3EdtFPI8tba
         LTHcnpM8rOmUY+sZ7yu13PgUEv1iYEjDi8R1+b1EWr7DFV4LToCqdbrwuFkQTbRbJlFi
         XqDpKdpqlhWDkgfvLUssZ+en54+pnIS3yqhwylOOuG61NInCHrYXIY/v3pj0lgcwcwPC
         MMSg==
X-Gm-Message-State: AOJu0Yz9MRCTxf38P4f1JJonfW/kHFmZhYbY9y/mtB3aB9Remuh7sNs/
	uov/qXf+7AtrgyD5v3CMsyaY8H64Qy4=
X-Google-Smtp-Source: AGHT+IHGKZ4b7MGMa++Om/ndy9Q7vwRGyDFcNcsiV5eXyjufAjLXNZQzsPMqzpAfpWk5LXbX3WcN4Q==
X-Received: by 2002:a62:b40f:0:b0:6d2:6b1f:b82 with SMTP id h15-20020a62b40f000000b006d26b1f0b82mr5942972pfn.67.1703121689794;
        Wed, 20 Dec 2023 17:21:29 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:21:29 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 2/5] gpiolib: cdev: include overflow.h
Date: Thu, 21 Dec 2023 09:20:37 +0800
Message-Id: <20231221012040.17763-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221012040.17763-1-warthog618@gmail.com>
References: <20231221012040.17763-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct_size() is used to calculate struct linereq size, so explicitly
include overflow.h.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9155c54acc1e..942fe115b726 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -20,6 +20,7 @@
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
 #include <linux/rbtree.h>
-- 
2.39.2


