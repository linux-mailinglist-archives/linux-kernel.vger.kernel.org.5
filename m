Return-Path: <linux-kernel+bounces-120448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D04788D79D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21899298035
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174A36136;
	Wed, 27 Mar 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTLI4d3Q"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C82E63B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525494; cv=none; b=t/EreOAJUXvq4hk/grh7E9oSNSGEVbM4hX31C38ZniAs55kMGhWJd3EbYpVE+scdinEpHJmyhJOm+7ud8676qktA/3GgPA1ql/hD2PL3ZlqBBVp3d65vA33H4fBh64wFhkmpOLeYPOk/Jpy+Qm2I+hD37+nzpQr8iYeYj1ysMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525494; c=relaxed/simple;
	bh=6br28ve/FXqsWx1ZCvxz0Tu83LXxj9nH9sMbL0OwpKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vm/Pn5KNuVw0Yzg7M1DAJOkojMADbG0THm3Zq48sFK9VAnuG7b0zYO9CWQU4Xffcg6YNajj0Y+MN++AlWye4j6o3c/aOaHChfG/fkKBUiyPZv1VzmWHqY85MMVARXJw2Ov56BPHZWz7hyaQiBp66iNXioFyMzkwSess7BoqReJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTLI4d3Q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a468226e135so760574166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525491; x=1712130291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9V0L1ZLhaNkMq1FhYv9Atk2X7ZenOQI6rYFcqjZS6M=;
        b=YTLI4d3QEk4pFPa8EA2wK7cNZ86PyOVN62RuJO9YluRbYn9fYnJuI9k1tLgEm6dTYL
         uA6g5grnUKj1N4gTac4GOD0E2ty62HxDlEER3OWrDfP/iXNChDvqE/zVapVZ1t8JscFN
         z7h0Y1Wk2D32AzeQrCY9401KWz3TgvLRMUbNaZ4OwTenqDwLAuHkLxH513UPpUQgMdHI
         aWRoZGfq9ERUeNJsOmigdgJipodeukRZBLRDHg1R5v3w+oVBvGN8jWZDyiyHyG5Lz4FY
         lGFyEESr8JMw3HmwfM+be7ItfZKKAx1gehWcp/KrLNFW3x0RTW0yS3Es/jf+Crqtt+9m
         X6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525491; x=1712130291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9V0L1ZLhaNkMq1FhYv9Atk2X7ZenOQI6rYFcqjZS6M=;
        b=T1I+sulkbQgLv0XdU2Cg0YvwG05xbSIYFrehf+yHpxX9LHhDj72RCYjHqqMQoeJoJq
         VflZdI0C30Bx9joRFAZiXrFmH3AtmH85FnMwqHSwzqdN8dYXu9eMumkTG7oKx8eZTY7X
         1kncH/5ftdMiNzmpMrjF6/6LQaeJXSAX/G6J4H0nNPnDSyN6NSAcJW4RD0zUbsFcIeTp
         aTcuL0JsXPH+nS33ZEdGquoVoHFauaSMiWpCY6uIDIEyE6sQjXmXG33S5OiBFwI8Xs9Y
         H6x6qYSEAVxPdpeXXNVgdEWYYwjzTNGEGWas0V91R38vDtnf3TESxrLaIeYPSSekbZtw
         Ze6w==
X-Forwarded-Encrypted: i=1; AJvYcCWnY382fNIMOemdKHxQj/UHY+DmINmx5d2BEOmANtDUCe7uftCEeBwh5vQm77rjYGshtUwLnqTWZBhBFU4qcCToav22rJfWDKDAW+ys
X-Gm-Message-State: AOJu0YzbaE4ddGmRK+E8yUJU39hy0NapWHLOlSQ1hjmktPTco685syyr
	lrpwOHTW9g231CvRJQTxwnBru+uhlVuYa5ti6bP3ubHROvLC26vKJiTrGbI8PIM=
X-Google-Smtp-Source: AGHT+IGFKbQOUtMB5KvpSaLmV6b8D0XGCUe2Bj/zrPy14ymo+p+EVPOM+Ze3N2aCDFRRCRoTYoi5BA==
X-Received: by 2002:a17:906:3859:b0:a47:4fe1:cf99 with SMTP id w25-20020a170906385900b00a474fe1cf99mr3541736ejc.21.1711525490747;
        Wed, 27 Mar 2024 00:44:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:44:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:49 +0100
Subject: [PATCH 02/19] Input: atlas: - drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-2-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6br28ve/FXqsWx1ZCvxz0Tu83LXxj9nH9sMbL0OwpKA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85MbO9/c8V7YBW1fVBeuTl0P+qXpTG2lnMRR
 bIGYG/Xm36JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOTAAKCRDBN2bmhouD
 19rjD/9C/YrJEyaKFgPxEbaV0HglMD9ietYj10qKT4zl0cuRemTgRiX+JeEiFs89LSUVXmeZYa8
 q9LTQauGW9TAfk83KaxRRxgGuoOQj8azBW+UPLWSNcUpr75WpH4pnyZeT9BD5H1DqAVPXU8jn5f
 wiCGyXHMpD8KA8UcoV5eLhA17n4xZkkJ6W9RBvu2AYSjJy28hYENIBT0AdmSQgWnbSgMWXTG6H9
 eDZxX0P6hX3/il3u/d+Zc5+B4/S9H0tmMvu4riiLz6IATzn9lr/CwtZmtLpfxadMF9anXuytUcG
 1h8wFQlWjNYIXjLqNTJ+6JQoKlqLINzIEXIPvoGSed9spBmO5X1jbuTvaiEKTBfXWHPTFHw7L5c
 ywaP1ukunboXRf8ltoverlAl6XUAioo9JtCzrEaAkiQCV8qAhJIsMfYhlK6VkgaB7SCYDY18fxg
 6MOnBn9jIH7gInLSsUhQ3L1jkOYdRwRq2jya6MHpx7tNZqZ0E4Ip6893YM3l7oZc36m6a6usJqB
 OtIzS96gFL5ksn69uU26PePp/jMQrpaLhNi5qTnSk0N3NP87ZjCYoYFKXMg5JXL6QojfkzMGhbw
 iCZhnS/A8lMeWnLrCLtpc8p5pGyjCdqCRfQ8rtu65+pQCSkM71fR+zhpKFeeRA6VtwVPjSdlR+O
 GsT2fQHAtcC4y1Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/input/misc/atlas_btns.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 3c9bbd04e143..5b9be2957746 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 static struct acpi_driver atlas_acpi_driver = {
 	.name	= ACPI_ATLAS_NAME,
 	.class	= ACPI_ATLAS_CLASS,
-	.owner	= THIS_MODULE,
 	.ids	= atlas_device_ids,
 	.ops	= {
 		.add	= atlas_acpi_button_add,

-- 
2.34.1


