Return-Path: <linux-kernel+bounces-20946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9F8287B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B4028289C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76639AE4;
	Tue,  9 Jan 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjoP5gRj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5923985A;
	Tue,  9 Jan 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ec3db764so9591465ad.2;
        Tue, 09 Jan 2024 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809064; x=1705413864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vwiGVviPevkA4iifDdpPyAGQ7Bqosi9flSfILNptTg=;
        b=MjoP5gRjU1ULb1TTw3AAyPt4k23kBnq/N4klAygQ/BADI8tvxsvREPdHm9ex6aBfoj
         pG0y/BRp0wn+7XHb8wlEeMIVRaYnAEVWCuzxa86G9MYMnCv0tV5zgHHnRN+CKQYal+rd
         w3v2apFGfuwwH7lu57jPBFpOIJYqIgYThcUKkMvQ6HyDpPUfmbHAjOrMVqgXIvEdOCI5
         vlgGigB4DLGBdUJPODWeaHjLIP+gucTmzgeLh2tP7EcP6xeIgx3F2jDYY68rk/WhXwzG
         8WmPZ3lC4kCuXtwm4K/HUl07vjZptpyFv1+YZ0CKb/+m5yYsEOqykK+MqzJ8Ax13kx4d
         uwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809064; x=1705413864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vwiGVviPevkA4iifDdpPyAGQ7Bqosi9flSfILNptTg=;
        b=Frd9oIUflYuMAXVuJujFG0wzNgqu4i6+338L6JQdIF57wo8IiM2uhdPoPsD6iIiNtr
         FnjqCsDmnfFDmTo4MsecXyMUtFfhNxaREzknFDEUp+krezuBP/9z9ScbrjC4vIJmXWu1
         9G08iZW11oSvxQmya/LBoyeEIcUW8ZiCNb8+y6dTp4e6oIB72Pjx3N6ek6tu+40rQ2bF
         4A6vqQtDcuNNeTJh2vF0Rd9QIIsB94ZeCTiVYWNoJuCHyNFSyWlUiv5etcqKWwLX2yQ2
         xiiLB3FeUfHXoLPbLNYIDAq9pLC12DX1F9akj3cephB957/oQd/sFA7jVWwMIgQj+RBY
         Hkig==
X-Gm-Message-State: AOJu0Yw7z9FE28/VrHPsakGqLoGNUGt2P2/hH1PF/PdibRvrsFA3f7XK
	lD0ngPMCJwWo4r9XGH23xcIwC7tNaiF/jA==
X-Google-Smtp-Source: AGHT+IH25ChbMn//2u7wEzfQwYMW0kHIYkq+ZVd4Qm1mtNEY054HfgFJJwm2WHhhAnouNWou++e59w==
X-Received: by 2002:a17:902:eb90:b0:1d4:9225:9165 with SMTP id q16-20020a170902eb9000b001d492259165mr3115960plg.23.1704809064008;
        Tue, 09 Jan 2024 06:04:24 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001d538b6517asm1818362plb.230.2024.01.09.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:04:23 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 4/5] gpio: uapi: document possible values of gpioevent_data.id
Date: Tue,  9 Jan 2024 22:02:20 +0800
Message-Id: <20240109140221.77725-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109140221.77725-1-warthog618@gmail.com>
References: <20240109140221.77725-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify the possible values of event id, rather than requiring the
reader to infer.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 3ba8996e496c..e68a56969f36 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -490,7 +490,8 @@ struct gpioevent_request {
 /**
  * struct gpioevent_data - The actual event being pushed to userspace
  * @timestamp: best estimate of time of event occurrence, in nanoseconds
- * @id: event identifier
+ * @id: event identifier, one of %GPIOEVENT_EVENT_RISING_EDGE or
+ *  %GPIOEVENT_EVENT_FALLING_EDGE
  *
  * Note: This struct is part of ABI v1 and is deprecated.
  * Use &struct gpio_v2_line_event instead.
-- 
2.39.2


