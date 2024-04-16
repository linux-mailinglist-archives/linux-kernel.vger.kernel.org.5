Return-Path: <linux-kernel+bounces-146117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF148A60EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404151C20C58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812920317;
	Tue, 16 Apr 2024 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGwSVlBU"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D61170F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234059; cv=none; b=KBnpswyc8h+GY76PoiFrvN4bYdcb7iR+oN5OedyjxDB0R2t1AaCKNWI/yCWH9kBPKqRhCvx8LGGCmdYepnYKjpWr0I+bK+EAmUKFF91XS7fP2yIW1/pJyU/c5LhdnpHq/uYSXLnOdIcWh/HbV/rbYRDNhfWR+zT5R/8AkgJJVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234059; c=relaxed/simple;
	bh=FEyCX9wXX7I+ebE4NBge8ISHoFDJTvUbCdS4OCDrmww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuTjyCO44jkF50qh4sIkaC9RXhqU3AfoRpfDgc/0czyxo1U3j6eu+m3FvROXRrdDUslvY9MZabIyeckuxMQxidfdYYYX7s1FlTwYdFFzk0xeB/HlJ4Dsm58HWIw0S282Z11aUQL+YDTg3VojfmHGDfWOWA1TrmjojNI+EXDSeVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGwSVlBU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso42483611fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713234056; x=1713838856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEN6gNaEJq5cDx0aVqzfzS7okuKcQO2J6EAa15VU8ZU=;
        b=qGwSVlBUe8GqiMHwN3I+yXMuSv3ByV+oqE1VUWT4KxlyZTvSDxrnHXlX/KXJn8CtsB
         TdRNCGuTt61HtgaWuuYpNOSF+Xdcg06fNnLEXACGwwNw+TznjkVYNZfgkUoFqWMufTvZ
         hZk3sC9vMDSLc2OLvkB4mxFfP9KVERJGomprWeuQ9zyOI0ExSU7szpuStSbp3iCnMB8t
         T+rYad+Ecth3BeW0VxoRu+oYg/GUXmqxkPLu1V2+XxPMmeMTH871XY4Ppa1mCbo5Lflm
         thQRiDDkZWP1jyAvA+RY/zTgF6KVBXfpr0lVndZJ0KX8GZ3wgJRIM/SIMQgLRGvaFYmJ
         4EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713234056; x=1713838856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEN6gNaEJq5cDx0aVqzfzS7okuKcQO2J6EAa15VU8ZU=;
        b=Ncu9O0INUOAFqS7hnnChYbEvaGN4hXZkSVTd9SMfOdinU2rmtVWeTY/f8sZobhWKh+
         CI5WwZl+LC2H3YKiCfns8FxPRuJGwY0CPkxE5bh1N+z4YvET1NwqENhLvYLQvPqMxghR
         ieD6ps83mJzjOGoxzjQuRyCNvJSfMC6YY1XK+33cEvGrJy6+U5Gwk/hARHyZAGWgQfoZ
         T5F+tLID6KU+bqTL9jrT1XGDsIHI7ptRztA3+HlluX7fW6rHbNgNQFh0YIdT1H5sHxcE
         sfoC/RtAgeFseugM9HgBrdS7acDTE4N91N73DaQKZrsAAbCTQl6w4deOI5P8N7/OS5yZ
         xLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw8IKu2AG6oQf9MGK2kL1u5f3xUiGA1cWmoipSIS6DS0EdOZdi+k1kW2xb7Pt9+PluUYd5notzvu4QvvmW9VPz8d/Nx0InV6oS9ZjI
X-Gm-Message-State: AOJu0Yw23Zea2dv5hucYGIKquzqUMGivGOu1TAUUT84T4mM3YHXpsGAm
	P8OURVn29lPpizaxui/ac/dlUdpovOf5/R6RMIHOHSnQDwhCgwifizsKybmpRn8=
X-Google-Smtp-Source: AGHT+IFL7IrVBHPTv1LgRZ4ESfzG16wzd1vNSfA94Y8QxyLSBT8T51y2c97hwR2jkhlTVWWF3wOgQg==
X-Received: by 2002:a05:6512:3e22:b0:519:2828:c284 with SMTP id i34-20020a0565123e2200b005192828c284mr57429lfv.65.1713234055797;
        Mon, 15 Apr 2024 19:20:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0051925dd92dbsm27716lfb.214.2024.04.15.19.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 19:20:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 05:20:52 +0300
Subject: [PATCH 3/8] usb: typec: ucsi: glink: check message data sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-ucsi-glink-altmode-v1-3-890db00877ac@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FEyCX9wXX7I+ebE4NBge8ISHoFDJTvUbCdS4OCDrmww=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmHeCDyDUMWBWYk0gH++Zypzj2AuGdC1dtEEyG1
 i8J+qSX6X6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZh3ggwAKCRCLPIo+Aiko
 1UnmB/9C6LgvEN5vlv4FV4KyUXh/Qm3xcNhF7b9Qee/PBlum0vNEv/px1OSKHvpwdUOqw9Ns5UL
 YfMIP8DhSpJ6gX7UGEMBQ0jDqmaBXcPZsW9nAy9mM5TH3v/Q+0FdeOXqlqTutkW6atyzrGPTa4u
 uFtUAr1gGHZZ3Bo69LwFh0qvqMNC9UaVjFpaA4Xj21Zs9AH/rK7HyDq5hVwzN7C4fGBNTGCW2oX
 WXCP8V6z0lThViLk9OxTNwfJBj4BVUYYmWTNgoTCMLpwkJRQxysh/t8SJDi0qJefzuVJcKKfvnQ
 8gYiClPwaqnJub6o4pQf9cAPF8zEVKgkArSFTE/NDFgxUeaT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The driver gets data from the DSP firmware. Sanitize data size before
reading corresponding message structures.

Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index f7546bb488c3..6be9d89d4a28 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -223,9 +223,16 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.connector_status = pmic_glink_ucsi_connector_status,
 };
 
-static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
+static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, size_t len)
 {
-	const struct ucsi_read_buf_resp_msg *resp = data;
+	const struct ucsi_read_buf_resp_msg *resp;
+
+	if (len != sizeof (*resp)) {
+		dev_err_ratelimited(ucsi->dev, "Unexpected read response struct size %zd\n", len);
+		return;
+	}
+
+	resp = data;
 
 	if (resp->ret_code)
 		return;
@@ -234,9 +241,16 @@ static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *d
 	complete(&ucsi->read_ack);
 }
 
-static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
+static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *data, size_t len)
 {
-	const struct ucsi_write_buf_resp_msg *resp = data;
+	const struct ucsi_write_buf_resp_msg *resp;
+
+	if (len != sizeof (*resp)) {
+		dev_err_ratelimited(ucsi->dev, "Unexpected write ack struct size %zd\n", len);
+		return;
+	}
+
+	resp = data;
 
 	if (resp->ret_code)
 		return;

-- 
2.39.2


