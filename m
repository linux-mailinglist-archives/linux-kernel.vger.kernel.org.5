Return-Path: <linux-kernel+bounces-16985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7B8246DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E97C28317E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6C25571;
	Thu,  4 Jan 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Juuz7xeK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB62556D;
	Thu,  4 Jan 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso955074e87.1;
        Thu, 04 Jan 2024 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704388039; x=1704992839; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUPzHOnfF3iea/GuFmKJkEyxB16BB6l3SJBZkhRVK1U=;
        b=Juuz7xeKWaK/RfLtDlPHVIMZz+oHr8YDuBPVf5Ks54TkfanJ/j3yPGVknvlQSGIAVR
         2K+GDcejho/uRC7XjBgupKhkU+7admHPZwIFvSXAMS8E0XGt9eD6MpyVP2vZo9MnPcLu
         Ly8siHbZCn9vKmatUIWsCJsIZNDONacddqwMCg6CjAlsJWbHCvrNb6W9TRifTYJk/Uxf
         omD52+XaFL2vC8DmB+gWUJfsPHyJrBEQ/4jRzsnzqvTNZro/ZTUEOdEgK0QtlG7FxmRt
         tcWCIugPt3qPbnDFqf8iMAjLMyMWXECRk4BvSYW5GCjfQjgFELfyN0wDHNIGD44wwYzr
         uZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704388039; x=1704992839;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUPzHOnfF3iea/GuFmKJkEyxB16BB6l3SJBZkhRVK1U=;
        b=s4QMZNAwPbhCr4vLRcd8A+ztpj37DaQG8yBQMRVR3VMJJFTEDwzNKCQBaZoHC9zPdJ
         Ncgd20QxW+MqU4E4AlHSsX2dR/FnvnknFRnvM1ppmoHYva3Ch13UNnxCFxqVM0ISWRrG
         es612hyvEAXSbgDPYqBJ3WT5pMeu12j3ozVOGo+wMEttb517Qj244B/wp5jxEIM7lqr1
         XoINPH+Z34zGf81NJCqDj2kKC9D4c55gYLPTCr2TEckWDmh21OZeg59oEdUqoBisM1Ao
         ZShn7QHvUX0bZFudfwF01B38qLHTK7Wll4KMc9/eGH7KajdQxgHcz1FPmaS140O0/Xih
         t59A==
X-Gm-Message-State: AOJu0YzwQIJNZQx5usKiz+BMy3TNgMN7M7QYA1raQkfHwNidPueVS5zC
	g4tQQ/qcm0z88hzN9gsBiTY=
X-Google-Smtp-Source: AGHT+IEnt/+N2u90wK9ceSSUrk8ig+m7VpFGqLCI4F+9HsEKK64haRTzaqA0g/ZbEfveDAVR/ho3lA==
X-Received: by 2002:ac2:4c18:0:b0:50e:8f00:f182 with SMTP id t24-20020ac24c18000000b0050e8f00f182mr521046lfq.115.1704388038677;
        Thu, 04 Jan 2024 09:07:18 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1f94-8caf-c195-798f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1f94:8caf:c195:798f])
        by smtp.gmail.com with ESMTPSA id hg2-20020a170906f34200b00a26b361ec0esm12820005ejb.118.2024.01.04.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:07:18 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 04 Jan 2024 18:07:12 +0100
Subject: [PATCH] usb: typec: tipd: fix use of device-specific init function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-dev_spec_init-v1-1-1a57e7fd8cc8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL/llmUC/x3MTQqAIBBA4avIrBNUjH6uEiGhY83GREMC8e5Jy
 2/xXoWMiTDDyiokLJTpDh1yYGCvI5zIyXWDEkoLKTR3WEyOaA0Ferh2fp6kVMtoHfQmJvT0/r9
 tb+0DXGz/Dl8AAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Roger Quadros <rogerq@kernel.org>, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704388037; l=1124;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Hbb/poJIkVKNkLIjP1N6v5qai0RdKXdnO+ikZ9Ptu9E=;
 b=HB5CR8Sel1fxfT3bpyhVa9d7eOorpKu2tyGnP1jubGB/mBJ2hpNeE39T2GB5nyFn2LoVQ4Bq4
 5272QhLogkgDEn01bBgbusUxniysU5mvNwgcx9GgKnPjevpbbmk4sRJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The current implementation supports device-pecific callbacks for the
init function with a function pointer. The patch that introduced this
feature did not update one call to the tps25750 init function to turn it
into a call with the new pointer in the resume function.

Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a956eb976906..8a7cdfee27a1 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1495,7 +1495,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		return ret;
 
 	if (ret == TPS_MODE_PTCH) {
-		ret = tps25750_init(tps);
+		ret = tps->data->init(tps);
 		if (ret)
 			return ret;
 	}

---
base-commit: e7d3b9f28654dbfce7e09f8028210489adaf6a33
change-id: 20240104-dev_spec_init-4df8711295cd

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


