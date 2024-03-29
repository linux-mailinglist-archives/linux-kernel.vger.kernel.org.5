Return-Path: <linux-kernel+bounces-125226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF7892273
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192FF28CDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3313A3E8;
	Fri, 29 Mar 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLpFC7Yt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D560136E07
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732235; cv=none; b=KvUbk6dEqHuE9PY26RL04pE2NmoGrs8r9OOGj6oxMnaFh5EttivXmEC/7aU3xIKbdvpYowWVDragw4stBmsHrsGdNfaVoV17O8Btx/qi+haT5gkGjkirGRB3yF0q/FVJwjG+0xds/ydjXuReZCInznZSnHgAlSIXwerPgjHbFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732235; c=relaxed/simple;
	bh=j8245kNmaqBdGD54O9qpNwjQ/vWPCZt5nPTvELzjL/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDr1HPkM9c3Z4Q0iSUZ3HiGv5BWwiVgG4ZEYBikeEZr9/puYK++14soHAZ+s17e9pip9vIKyTH/dmBQ39Vh3YwlnIlVBeOSf+1NDOyCEqmBD+FrhRE57/LOu00s95El68efOAtE6NoI/STrYbZrJLekFqflbVjzmR6YL3CoinSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLpFC7Yt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-341c9926f98so1311476f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732232; x=1712337032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JyWn95xLCs1iHXcpGVAjRQMK08lG3ym0K6wct33L3E=;
        b=tLpFC7YtKxuP4E9ehr4QyL4D8irBYg6EMy5hBtoyHwJtj2jBU+mK8bFcZn9M81ylVY
         RQWZbtqakPbm0KxA90bxDnDsJvu1v93hI+na4k8oAkUJP0fO/Kcl93wFpOWye6szD33l
         fl7yItegzx+gBTlPfHarzlUJMtqZ2aPAuCoAv1DTNacJFz25iyX7IYOyVlMt2yLgyMca
         CmUsc7m27Qgrg5JMMk1qmMX+3DdKz1zIgyKpCB9hkOmWVjYWfyP5ps23ewXHepVOAR62
         lsyndx67fugh7e7pfLdqHPFqe9Td21FBoqTnbCi6ToLOaiM4QO/Vr0kprwqL/xC/UsfN
         c9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732232; x=1712337032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JyWn95xLCs1iHXcpGVAjRQMK08lG3ym0K6wct33L3E=;
        b=w9IViUwMWNmiRORUCm/ZywBPN7Fl/qmyf9LCLC+kAHqxiIWvWNJNehjTxZndgBlHDI
         qxmfn6lWQW8TIxXMCevqmohVFMXfoNquWEJlZSXc1YDdstKr+IlPFjZHmbktd1OMgTF6
         X928EFNWan6M2bMGOu/IG9YW9vOEGsxSW6eun7pvkhx1NkRq4k/VYQq0ye1VXJtF9fkR
         ypED9jM8T6E4CmAyGwfABdxkwB3+oqFBs9W9A6mYWz+PEFU2lvCHmfwX15EOEID1FF89
         cfPFnzEHl9pfp8kF3bmWNAamZUW7QJx3mcSHAp8fzyz4FD8fXcvH4io3QuLEk3rvjuGi
         qiyw==
X-Forwarded-Encrypted: i=1; AJvYcCU433Qqxsvm2jmpa/4rJrcMlMGWtEr12yzkzJg43a62Ev6VR9hnGbJvgujIdmr74JTV9z5Q7AtIyrVYH2e+evfWSou6Sh3vDWnqKz7U
X-Gm-Message-State: AOJu0YyVG9THh8EIXpu7poQscgjJVncOIFbG91GtPQn+Uuh+J8mY0L4A
	I8e6cKFwBspysvqL+glsS/L9KYaYzvSPMigeo2/IcI7KXFF8Zs/Ah9xm8zf8+3A=
X-Google-Smtp-Source: AGHT+IFW9DruHBuveqwhg+ktCb+5HkBVxgytJ4thp6p1EHASXSQYVUlK+ranP095Y2tSt5loVpZ6xQ==
X-Received: by 2002:adf:f306:0:b0:33d:269e:132a with SMTP id i6-20020adff306000000b0033d269e132amr1766876wro.15.1711732232518;
        Fri, 29 Mar 2024 10:10:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] wifi: ti: wl1251: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:17 +0100
Message-Id: <20240329171019.63836-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver's initialization functions do not perform any custom code,
except printing messages.  Printing messages on modules
loading/unloading is discouraged because it pollutes the dmesg
regardless whether user actually has this device.  Core kernel code
already gives tools to investigate whether module was loaded or not.

Drop the printing messages which allows to replace open-coded
module_sdio_driver().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ti/wl1251/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index 4e5b351f80f0..c705081249d6 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -323,25 +323,7 @@ static struct sdio_driver wl1251_sdio_driver = {
 	.remove		= wl1251_sdio_remove,
 	.drv.pm		= &wl1251_sdio_pm_ops,
 };
-
-static int __init wl1251_sdio_init(void)
-{
-	int err;
-
-	err = sdio_register_driver(&wl1251_sdio_driver);
-	if (err)
-		wl1251_error("failed to register sdio driver: %d", err);
-	return err;
-}
-
-static void __exit wl1251_sdio_exit(void)
-{
-	sdio_unregister_driver(&wl1251_sdio_driver);
-	wl1251_notice("unloaded");
-}
-
-module_init(wl1251_sdio_init);
-module_exit(wl1251_sdio_exit);
+module_sdio_driver(wl1251_sdio_driver);
 
 MODULE_DESCRIPTION("TI WL1251 SDIO helpers");
 MODULE_LICENSE("GPL");
-- 
2.34.1


