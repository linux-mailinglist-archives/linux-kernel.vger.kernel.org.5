Return-Path: <linux-kernel+bounces-137229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B804889DF34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644B11F2A307
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7613C9D8;
	Tue,  9 Apr 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vk+TOy4R"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319B13BC0B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676564; cv=none; b=V7a7RuCZ15vdJBdLzufj9haemmW2CcGHofnG8LQ0LmFvXobIP3shAGmuV71WPRkiL8u7gwYD7SN3PNhGxcZ8GCk0SbSBHTMdoAQmRLCk9PwfdKWwsphEB4lbGQXDUM7sgobO2ggghSRLseF/9AM2mVEpEk0v/4DUdKfMEZoA2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676564; c=relaxed/simple;
	bh=BNm8ROtwyDTiLNn0p6MCrlMzrWYQbz+nw3m8owL6V+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoB5jmvKBjc4KSmseAiK0XwbPqdlUfIfUgWOqk9Vco5Op0iI3bDcHYjZbCY4M8dloAVRJcV9KHzoFzmv6cb+gE677kwcOhi6Hjlglf99qyuyuDufZCvip3auXNEyGyt6oBZTGZ2NmttO55/g8q7LwvluhCZMW8RarzzPlwZrKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vk+TOy4R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d264d0e4so4554351e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676561; x=1713281361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFKPCK/kCcXWFoB49FvlrDe+DKAuZG+D+gWim+ikCqY=;
        b=vk+TOy4ROsaimM1gH/mpDCbKtfYy+g9QRuxCK+n9ay2UNcxoDQgWGjW7/cBqu1BGTx
         sOdF0s9Ao28CKZ0zW9MXojwj3ciiXDwYlIXL1xsMqtbmB0Oai6zehBal+r7mDVlyECTk
         /r0c5Q/G4/WdJTFlUqXwFLWnuTxK4sll6c72ETg6rDlHDgECPu6r2VliAXvmmBeXxPjl
         qt5w5E9PqiwwrRritesv8+eyAB03YSTGJK5lNMsy8ZSfQOzz1dY0OzTXZQJFEYkELEAy
         /hj8cae11fk9xr6sG1TqMNvdSCmZjiBh87+H8uWKiGuQC84jQPDzuIw14KzzN63o/g0o
         desA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676561; x=1713281361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFKPCK/kCcXWFoB49FvlrDe+DKAuZG+D+gWim+ikCqY=;
        b=BTXymY6rr5zVW1gj0Hs1d3r8VJLFZpcZlc9Lvg5STllGPiIHQIV/nte2P9YUIyVakb
         zUP2vgnoT7QOMVRE9dPXguA2k+waWLIXbsHZGl/GUbcABvLnh1wzzvQah9PEsp5/+5rd
         tQUHrS9Nur4dlv9BGUN6zvzFyrSrj7uWol0filNcS34/0v4qTbobKskWza01KBDuEUAC
         gxHpwO1tFWWuQ/NbvGcnTHy/TKQ1zhN0p3n8dy8qQFepmysW69y7JaMFWK1tepu+gkXY
         tNwaSLcOs2AMkMLNTm83KxseXCkEjnsbEPJPSFv04wcamAwTJNQOpctMv4vH7hMs0Hij
         V+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW2fbxlUmRsHnxHyjuZa8cAd/3GRcCYxdiVDLmzkACda4dTGZyAiqPYAl8YfXYVpnoT5wSORzAUgwOav3guOy5Vn4slGOgWulyJHhts
X-Gm-Message-State: AOJu0YzdI1ehfParQEEU0m8O+Yj2tgeaUDqnI6ipYQAc7Q8wBr39Zvrv
	hde1PyS+dcmGgrUs20YB261DkvH88SoUEJasxzkVqGMzfziVY3SzHtFSZ+aRhvk=
X-Google-Smtp-Source: AGHT+IGrN5NpwE63/zWrefF7zvceQfErmZ+uxtO0K+Lg3qtbyaNLSZqS/NwrpoaR8fhAE2ihAqZfKQ==
X-Received: by 2002:ac2:5333:0:b0:515:c0cb:3ca2 with SMTP id f19-20020ac25333000000b00515c0cb3ca2mr1064006lfh.16.1712676561626;
        Tue, 09 Apr 2024 08:29:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a16-20020ac25e70000000b005159412ab81sm1579990lfr.216.2024.04.09.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:29:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 09 Apr 2024 18:29:17 +0300
Subject: [PATCH v2 2/3] usb: typec: ucsi_glink: drop NO_PARTNER_PDOS quirk
 for sm8550 / sm8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-qcom-ucsi-fixes-bis-v2-2-6d3a09faec90@linaro.org>
References: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
In-Reply-To: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BNm8ROtwyDTiLNn0p6MCrlMzrWYQbz+nw3m8owL6V+Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmFV7N79gbDsQrhnblF1gIzFA8DE+OueeVX7arc
 QxngILwJl2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhVezQAKCRCLPIo+Aiko
 1YTxB/4wikeUBRV/sSCWxse4ontdcdTMuUnGlUlsd5NfDvVUE2jvv5jRtZdQsDnfyZNsmuTX2OR
 IgSIN8GZvCuflCgugL+gGdP6dP351w6MwoXNIMqCdpp360+3fK5FEIHzaR9ncRCf3TGbRTGQk6I
 p98t2sp81jLx2wOTwlj0WyPC+XMRbBUxPFprHuew4zieaoWH2IAFSJYfQt8JuZA/vIdN3jx92zZ
 /lxlTqFeD71oslhtZtfA92CB3DfPcP9eiwzwlhih71fYW8Ll8g9rOIlc7Jujh0hLkOKV7gqTx8r
 +LdtBFjNWbMtAmgK7CGBw6cWPxO7iM68kK808wdwE8X9kCOa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Qualcomm SM8550 (and via a fallback compat SM8650) firmware properly
handles the GET_PDOS command, it sends the CCI_BUSY notification,
and then follows with the CCI_COMMAND_COMPLETE event. Stop using the quirk
for those two platforms.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 9bd80a2218e4..9ffea20020e7 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -321,7 +321,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sc8280xp, },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
 	{}
 };
 

-- 
2.39.2


