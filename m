Return-Path: <linux-kernel+bounces-24759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6E82C1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF661C21C53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3B6DD1A;
	Fri, 12 Jan 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvzGNpBb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9546A345
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so9382425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705070110; x=1705674910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y95Jfas4yPMpMpOy2M2wHIojPX+ZKuNke1Ebmh6JQsU=;
        b=nvzGNpBb/QggawV0OZUTjf9VYCxKeVJAa+RE7Fls9OnS6P+uI1mV/o3Pr7kaSmlfhd
         cEksUFnc5LSafqYTs1zCj8+TaC12GxoqVxNCRg/em+0URqlvaScO9UbjUQJZUSm52xZN
         7e4A6Fuu8H98dbv+G8NmdI6psx1qHl1ObdSOP9c0k/3scSsajY1Yo3y5w33Q8/nJBmYK
         2q+8Fd+YLkJHQn1fFE69kjZo80xW8sHs1VIGhi1/s4o1c421w1TkBh/sZx7IqiqdUFRf
         yAhXHz02KVI6deJbztdmvP3lgqcek/arBdZ/5vs8LjhlzQ4t90GmFI4SaS0OGb+mnKaT
         caCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070110; x=1705674910;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y95Jfas4yPMpMpOy2M2wHIojPX+ZKuNke1Ebmh6JQsU=;
        b=ghWvnRm+tAAqQdzGvmdrl6+G6+yn3lrXTxcSsMoPJrug5KQdbaIVtVI5hfoEZWBQXo
         7LhfQlRGUtbZ7fQKp5hlZdRnDF1doH2LZ+tmLR/UXx2IR59rb1XuoskW0YMueMYLkdPQ
         qRBReXddVNsAeDUxnFdjrw96PdeWYwNk6OaXeMNt+XS1cBLrj6Ao1QYLRLZd9TPM1YLh
         4wwJbxi3jsfzhGvLgG27xt2Swif7ihyB/QWRyqOcoYDglKXc52koIHnWri5uMOCO9XJ7
         L9eb3aL/Q/OuuFFs20obN7BjGnv+yiPzGqvVqfDKhLSgO8eyZf4CvCBxTWuqgvKqMCup
         Dybw==
X-Gm-Message-State: AOJu0YyiN39DC3ZUeBxpgv/xISohFl/jKlCt19Fmjj493KcZXsuPbxcV
	H//ws9jZ8BNzB6umY50p1Wfx331ui7jGzg==
X-Google-Smtp-Source: AGHT+IF5Ymenj6Zi2wDPf9weDy1XyZvZJoiZKVlmUQZsJUDWY62gba1DbI8h7VfF0Hw5vd0BEhf7ZQ==
X-Received: by 2002:a1c:7c08:0:b0:40e:55bb:a0b8 with SMTP id x8-20020a1c7c08000000b0040e55bba0b8mr787274wmc.157.1705070110611;
        Fri, 12 Jan 2024 06:35:10 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040e6726befcsm2090812wms.10.2024.01.12.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:35:10 -0800 (PST)
Date: Fri, 12 Jan 2024 17:35:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vicki Pfau <vi@endrift.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] HID: hid-steam: Fix cleanup in probe()
Message-ID: <1fd87904-dabf-4879-bb89-72d13ebfc91e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305898fb-6bd4-4749-806c-05ec51bbeb80@moroto.mountain>
X-Mailer: git-send-email haha only kidding

There are a number of issues in this code.  First of all if
steam_create_client_hid() fails then it leads to an error pointer
dereference when we call hid_destroy_device(steam->client_hdev).

Also there are a number of leaks.  hid_hw_stop() is not called if
hid_hw_open() fails for example.  And it doesn't call steam_unregister()
or hid_hw_close().

Fixes: 691ead124a0c ("HID: hid-steam: Clean up locking")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is just from static analysis and code review.  I haven't tested
it.  I only included the fixes tag for the error pointer dereference.

 drivers/hid/hid-steam.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 59df6ead7b54..b08a5ab58528 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1128,14 +1128,14 @@ static int steam_probe(struct hid_device *hdev,
 	 */
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDRAW);
 	if (ret)
-		goto hid_hw_start_fail;
+		goto err_cancel_work;
 
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev,
 			"%s:hid_hw_open\n",
 			__func__);
-		goto hid_hw_open_fail;
+		goto err_hw_stop;
 	}
 
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
@@ -1151,33 +1151,37 @@ static int steam_probe(struct hid_device *hdev,
 			hid_err(hdev,
 				"%s:steam_register failed with error %d\n",
 				__func__, ret);
-			goto input_register_fail;
+			goto err_hw_close;
 		}
 	}
 
 	steam->client_hdev = steam_create_client_hid(hdev);
 	if (IS_ERR(steam->client_hdev)) {
 		ret = PTR_ERR(steam->client_hdev);
-		goto client_hdev_fail;
+		goto err_stream_unregister;
 	}
 	steam->client_hdev->driver_data = steam;
 
 	ret = hid_add_device(steam->client_hdev);
 	if (ret)
-		goto client_hdev_add_fail;
+		goto err_destroy;
 
 	return 0;
 
-client_hdev_add_fail:
-	hid_hw_stop(hdev);
-client_hdev_fail:
+err_destroy:
 	hid_destroy_device(steam->client_hdev);
-input_register_fail:
-hid_hw_open_fail:
-hid_hw_start_fail:
+err_stream_unregister:
+	if (steam->connected)
+		steam_unregister(steam);
+err_hw_close:
+	hid_hw_close(hdev);
+err_hw_stop:
+	hid_hw_stop(hdev);
+err_cancel_work:
 	cancel_work_sync(&steam->work_connect);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->rumble_work);
+
 	return ret;
 }
 
-- 
2.43.0


