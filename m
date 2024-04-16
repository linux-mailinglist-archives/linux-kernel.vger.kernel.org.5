Return-Path: <linux-kernel+bounces-146115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017688A60E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E78B21AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDC179AD;
	Tue, 16 Apr 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqPhXNsJ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65C107A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234058; cv=none; b=IJDaDkQixRb9/PZwpzVHtn0LoIVXlqHNGDaTf+aZRFJbIB5thgx4cretxGJeWBr2cVtaaIkKPK0YyOoz4FQvm+3wgbZilNx4CsjMCx5i1JhTOZWc7ogDr+CvBbu9xVLZvoyWClkCpYrSvB9bQkqZ/vHUH//C7wf37A5T8jTtI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234058; c=relaxed/simple;
	bh=bln5CYO6vQ5ETso/plaD6OhVP1kj5DATMhTuIWkFahI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp+AM+/lfr4DkQU1W8SdY7zNQvLGUqMQ47IW2DwH1Zeym1LPLtlu5YPxBdxAD6aIZ6kRUHg0gILigFBny7ybxm0IWOvyHw/r/+oNJUZGSwBnhPwBHfrRXUwrpX8+8W6qUQCS5m4sK5GggMTVJLGufNjav8LZGeHAAysjuuD6cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqPhXNsJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d0161e13so4763740e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713234055; x=1713838855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKVAbmtACrYJY5KlEwDa6TSGBQh+ZqsL8dIuknwyyFk=;
        b=lqPhXNsJzZgIPDmfmQsopZEEj2yomJLxtE1f8ecdoJZusnbazWm8AsO6sDQ2/Cpd4n
         /mTnx+C9Rie0FcSSW0/xP0dzo6+ZmaA8YiWrB9B8rSjURhEinPf2rALZ/v1cAH4slYsa
         tCEehKD7GIB/Jm71urLF6rJfOoVKoHdtyRq7OYVM4wtR4QVXGwKgPuqj3OBXAvrShuKX
         kb+njDP/Wa566ho3y3dNL2jd/zDum7qIfymZ4dvtG5HpfKD6b77cQwfcRUc+VEmKqpW0
         zyaMSU+b+idUVNTWujv80V1Bb8bmLmjlRKSnhN8nMthTUKJN3Cfc89E71RYrfcwiM66q
         7qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713234055; x=1713838855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKVAbmtACrYJY5KlEwDa6TSGBQh+ZqsL8dIuknwyyFk=;
        b=KqDYzWu8w+JQmWnShblFmlluZHk4Ilu/HjtmU8O745VFNcT4FJNKdD273MnANCwb9v
         DEJKRldNeQDcztsU4o0Xs4hPmE+j5GmomqCcK/KrlIKQLX9/JnDSpZxrDKGkN5TTMM8D
         IyH986yRQPDwpieuQatYMtW7B/tknq6QTjc5/JB3/iYwqW/62cVS8aXZWKNvdCd4g9i+
         awwJR5mODgrp5hyzMOMYr3VIL9MmV/9MQo79wrQHFGq4ZCPIlX9s9a/cGLYlWqiErA1m
         XPbhNJWEln/ZHQ322mCgK7NtnbmgEhUbLPGKd8zYBp4awncsObZ782bavz6DPAqYv+aY
         JsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/us/2bKC93lbMQly8uP8ceQf8Txk5hki5cSEUzEZjXql1U2XE4uHtI/gtDaPvtDN01S3RtkPL5gQ/VG9+jgF3kQv/AMaEN6RUjgon
X-Gm-Message-State: AOJu0YzygFLXEj+XACBRG5Wlec/QiFGZP8RHtPaVUUlGqJ5CCep6cxa3
	P+blG/tqz5ccJxbAO2P3TGzMnad9KSLAgQ9yjeCfdf+gSGYBuPXy858/N4c53sU=
X-Google-Smtp-Source: AGHT+IGR5VnTd32ybFeiDtNMe8qSkLBT4/ZrvIZEN4DmOvOuPHsnWIwOElz8WWzbN+5Zgycqafp5BA==
X-Received: by 2002:a05:6512:4805:b0:518:b58c:5234 with SMTP id eo5-20020a056512480500b00518b58c5234mr4839392lfb.33.1713234054894;
        Mon, 15 Apr 2024 19:20:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0051925dd92dbsm27716lfb.214.2024.04.15.19.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 19:20:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 05:20:51 +0300
Subject: [PATCH 2/8] usb: typec: altmode: add low level altmode
 configuration helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
In-Reply-To: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bln5CYO6vQ5ETso/plaD6OhVP1kj5DATMhTuIWkFahI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmHeCDGotF2VpWSvjEJ9OObzVO7tPWMtSWgBLNT
 CUCFBuOzTeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZh3ggwAKCRCLPIo+Aiko
 1YkQB/98zz+RFNpPS3kNEKTEDiKdaBjW5F40eDsVbpJ0BztJwrgCv7nmgpQiJe3pSHIsSR6iIyh
 SJVB7fCdSNnkF44FJQdSi1czYeQH8ay3wrrHnJh4TsbSLIb2XyPgRWP4sgKyO7z18hrNAv/Zzeg
 g5EKCO+UamTC9JK7v88KXus/FHSZJkg32MbUIVB567gF3nwPK6luS+3pYw51fkwmOAtQpLppReT
 wvrwJ1Ozomg3m7wj8xWdEX2mdWI9EArUgdrhLeMSQ7pMx6+vT3gh2GHRUfaiVXWsaThfOJhXLds
 L6wOmPbenqXkj8+6Vu3ipbos8GQ+PLsJ6J9gBVhLGXE6Ekld
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In some obscure cases (Qualcomm PMIC Glink) altmode is completely
handled by the firmware. Linux does not get proper partner altmode info.
Instead we get the notification once the altmode is negotiated and
entered (or left). However even in such a case the driver has to switch
board components (muxes, switches and retimers) according to the altmode
selected by the hardware.

We can not use existing typec_altmode_enter() / typec_altmode_exit() /
typec_altmode_notify() functions in such a case, since there is no
corresponding partner's altmode instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/bus.c           | 34 ++++++++++++++++++++++++++++++++++
 include/linux/usb/typec_altmode.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 6ea103e1abae..68f3908401c6 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -67,6 +67,40 @@ static int typec_altmode_set_state(struct typec_altmode *adev,
 	return typec_altmode_set_switches(port_altmode, conf, data);
 }
 
+/**
+ * typec_altmode_set_port - set the altmode configuration
+ * @conf: Alternate mode specific configuration value
+ * @dVata: Alternate mode specific data
+ *
+ * This function allows configuring muxes and retimer for the selected altmode.
+ * This function may only be used by the special case drivers, that handle
+ * the altmode negotiation by the alternative means and thus have no
+ * corresponding typec_altmode instance for the parnter.
+ */
+int typec_altmode_set_port(struct typec_altmode *adev,
+			   unsigned long conf, void *data)
+{
+	bool is_port;
+	struct altmode *altmode;
+	int ret;
+
+	if (!adev)
+		return 0;
+
+	altmode = to_altmode(adev);
+	is_port = is_typec_port(adev->dev.parent);
+
+	if (altmode->partner || !is_port)
+		return -EINVAL;
+
+	ret = typec_altmode_set_switches(altmode, conf, data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_altmode_set_port);
+
 /* -------------------------------------------------------------------------- */
 /* Common API */
 
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..d78a9618bedf 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -77,6 +77,9 @@ int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
 const struct typec_altmode *
 typec_altmode_get_partner(struct typec_altmode *altmode);
 
+int typec_altmode_set_port(struct typec_altmode *altmode, unsigned long conf,
+			   void *data);
+
 /**
  * struct typec_cable_ops - Cable alternate mode operations vector
  * @enter: Operations to be executed with Enter Mode Command

-- 
2.39.2


