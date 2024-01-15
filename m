Return-Path: <linux-kernel+bounces-25573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5482D2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109F81F209AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4D1FAB;
	Mon, 15 Jan 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI47bTdg"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDF17E1;
	Mon, 15 Jan 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0a64d94d1so1018254a34.3;
        Sun, 14 Jan 2024 16:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279838; x=1705884638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztYy0pG5mb/EUI1krEp4S/p84wNzOo5hR+tihGh7i4s=;
        b=fI47bTdg2z5P/ltzoEk0O79OgILimADacLnLNLJZ1/vZmqel++2SzOKLJc0z3xIgYc
         mn4SmVMDr7kFcGiGfTJFq0OMXmZL5FhHZbpPF/T6bgYPnJ0iYkC/JkWQnlgvEMtgHCGU
         1+vlcqV2hm+KE9JQVbvmF1/S4HPJmP3kpp2qnmFWYnPZGyf4Io7L9qInqfG+nB7dZAZg
         8c4KXwotq2sRps94y3lrHMtKiYuJdYc132R0aWQXRLWTZ0Q/UIpTFLxpfrt6QpvFDxT8
         tYht2n/dICwHub8IIbrPL8uRJbkECfz1r8GUI8+b95I/HXFUq4nxBBcNVm/qvk3fNoPD
         fjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279838; x=1705884638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztYy0pG5mb/EUI1krEp4S/p84wNzOo5hR+tihGh7i4s=;
        b=lN7qxxi5olOvL+HMAQ1N2rbia/tsWs0aEcs5oQ19jctYng3G/3cXsUdaGHvb+cdrZw
         NKPv4ErFJTjEB8rY7y+F0FDVCv1GMBEKH9BILNFaPtydxCzBoI+oMz11BrQfVKmPnLDD
         fKaVl79U0J1O5kbEIng4t5LhMoX25iS5FQyj+svIKXAMBYxbLfERaD5ULuP/ydPNpnhC
         U1KGfwOZNzTHaU97z6ZStGc3nh3+tv/Hz8I15gNWfE9/9rFmoVN82ntItK5c3IfMdr9s
         1cGltdtV2agjo1i/+SVXWjrOKh7wlKnt3BFnDbHeKm45kfEQj+q8aDaA+cuuBLFgsEBA
         qC9Q==
X-Gm-Message-State: AOJu0YxiB944/qSKDzXGn0KbC5lZMZ08HpVkS7EflSvpaoPOBt5SAjcP
	02/obIdd5iaXfykSLz1yc9dvQU2T2+eW1Q==
X-Google-Smtp-Source: AGHT+IH7WSB22r8uoRQvcq4B6pj5YoOyXfaHdex0itxKWmpW2sku/C5pcVcaaHBnbyZkJAvcVnWICg==
X-Received: by 2002:a05:6830:1e4f:b0:6db:f6c5:e8d9 with SMTP id e15-20020a0568301e4f00b006dbf6c5e8d9mr4141813otj.17.1705279838372;
        Sun, 14 Jan 2024 16:50:38 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:50:38 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 8/9] Documentation: gpio: document gpio-mockup as obsoleted by gpio-sim
Date: Mon, 15 Jan 2024 08:48:46 +0800
Message-Id: <20240115004847.22369-9-warthog618@gmail.com>
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

Update the gpio-mockup documentation to note that is has been
obsoleted by the gpio-sim.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/gpio-mockup.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
index 493071da1738..d6e7438a7550 100644
--- a/Documentation/admin-guide/gpio/gpio-mockup.rst
+++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
@@ -3,6 +3,14 @@
 GPIO Testing Driver
 ===================
 
+.. note::
+
+   This module has been obsoleted by the more flexible gpio-sim.rst.
+   New developments should use that API and existing developments are
+   encouraged to migrate as soon as possible.
+   This module will continue to be maintained but no new features will be
+   added.
+
 The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
 chips for testing purposes. The lines exposed by these chips can be accessed
 using the standard GPIO character device interface as well as manipulated
-- 
2.39.2


