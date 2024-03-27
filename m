Return-Path: <linux-kernel+bounces-120453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940E788D7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B792F1C2503A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099A4879B;
	Wed, 27 Mar 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fG6NYZw/"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC63C087
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525517; cv=none; b=uQtPb9uewkJmtHzQbx7YSpwky/wdz8huOfPJljjxyalPlwSnw0mFTxqxvnfzc5k0eo4Gmu0IhwBKuyxCrNiG4Z8A7+JPxYMue8v6urOGY7XhyaidHI5qwSmSHrW32y9MaaemaYQh4RkfxWsfkzo9P6/gNRJkWrcHIO53tLtiUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525517; c=relaxed/simple;
	bh=iF0xdrHMFuoUwhEuhxHTNnxQyh6y1oAkbIqX1Vs8DNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZB1+PN47E8sFH8IS8kAY/iEP+as1WlnczAqs8xlXrFRCrJTnZAIXwaAea2R4u+/iXBAq6TwZTZHpqPgyoKeKXgEvoEUDW96iBdsMNEvloO5tKyao6JXCsHL9Rew6mBa7y5GhTctDQ3CVhXRahwrcmB9C+JyhmtZKPVewcrp+1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fG6NYZw/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so4044833a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525513; x=1712130313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5NKCQzn/2QzDffTEW07IH16QG8HTI+pkQvUskitTsE=;
        b=fG6NYZw/0MqGsujBBaXsuowfaiXHshIZy855zznlzNtbSR0YqSp0NvVGBvTjmSzx7B
         yOGGmkSCcevH37+QHMLZ70STtmzdHAgZNqrGs6uiLiPDAf5Hh1anCcFH1Ef2GaCoS26p
         YTZZFucB/I+kEDN08m9djJNKH2r5FpMvkLnYU9EOAGG0K0HxAOkgbH2xldD+6OjNjewM
         Et8IgTPJgO8omnUc31/fI7f084kbNcffi1nQbmKYYyt5JPxHBX+o/o1uv0C0i2nSggH0
         Yv7ntlIJYJ5eOVtfcliq1mADvZH6fx4kBhsn+XfBLIM2Wu5oupQ9e+ZvV/euyAj4KaJU
         hN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525513; x=1712130313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5NKCQzn/2QzDffTEW07IH16QG8HTI+pkQvUskitTsE=;
        b=mXZXYNRcuTXia2j544VSTm0y4ptKlscNISKBGH8qGuDnqLXGpqKFjIFuggeIdQO+0B
         mA8NTQwf4YjnSbq7opvz4U308ljDLCFzfBGnmDYeFHef1yuNOxJg9y56AWClt/ZhFzxb
         WivUQpRMmTHe4iz28KaJ3HfJpkkApPen9Oob36CEkXtjnKKUoFPjeDBeU8q0yMJ00N8L
         XiLORXpAPICV7bERQGcNoOYoGzTcU7wRSRPVT2PNbAmIvFss6K4YtgGJapobvYeud0bU
         kw4XwLfr/HKJDVTKUGXYDAXxFG/qrlgwLM4DmzFPWslrZ2tbrOP+XDfB71ZOatjF5hUG
         CIQA==
X-Forwarded-Encrypted: i=1; AJvYcCUUZhAeituXEa3Pek8CyqpxfHwoD9gc76342mKBL2H6Ou+ZPwBHB22P1IBUE0z+wW1Sd4qprnqWzwFFs5bqGjDRsAOpA3qElMNJ8o81
X-Gm-Message-State: AOJu0Yw6ta/tr5XN/95Mc8OzFCWi0PLW79JgZWd8/Ms7luxVFqPH9boh
	wNqKQD9M+88JF6fPN/cA3NN8senoBrEN2o+UXHeDTQKoqtK0ZL8Ohb6DnCgvWeg=
X-Google-Smtp-Source: AGHT+IHOr3eNKIkj6WAmG3XR2hyM8YRV8aLodZiJZXz+ySkbbVia28u3tOdyC5gJA5IhmTLTWUKo0w==
X-Received: by 2002:a17:907:20b2:b0:a46:617e:d3a7 with SMTP id pw18-20020a17090720b200b00a46617ed3a7mr3514861ejb.60.1711525513563;
        Wed, 27 Mar 2024 00:45:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:54 +0100
Subject: [PATCH 07/19] platform/x86/dell: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-7-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=621;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iF0xdrHMFuoUwhEuhxHTNnxQyh6y1oAkbIqX1Vs8DNA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85QjVUHx+uIE5kwIa9dA5xJiTvxpZRF8W2xE
 sSfv1aXx66JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUAAKCRDBN2bmhouD
 1z96D/oCHhbLWPXTc5ahtfn3iMCFQN4Yia4pPaHg9gaCgX8S+aw83Zl8BdnGoYL19V/oCASSv9G
 eHgmKnlJf9IMBKdXtfMtGRLU8LOo8Vb8kEstQ4FU4OGMlMuiGixztmLBbsqmwJxxYNj5/e+DtGt
 MZ8IA2eUXrDSwZgYhgD5HxJfvOi5Fb9e4QFyMrs1dENelbbdbvNXE8+k1FHYslXNMRfCxvWlIoW
 ROe519F6aJ0KVsnWTAKjA1pmeGBnI/XTmP1dEChPfICl70+UcbezHYm/lxC5rkFmX+Hsg6U3P0K
 CpmYEYNjEXjIgDPN37vfXL4OdVUBToF3R9R+M2CaopV+uLVIfV/wZyjMBi08TQMIBPOjLNHWEUI
 rzjo8OqzjzuT2skUOBZE4ZybD3Zu6srVgn55Eq5cBan/vtp6xMLqf62nquw06N9/2HshM3Pxhtn
 PFzrmu2cJ2jKI9OiBchbzg9SbLMw6vU37rTO57NT9XYuUZ4WIxzNlfkY1D1oaxyZ5un2gG+IxBJ
 S+XXQW6E2iK5FfNW7Wd3V98YBTUJg5g4CZCQNFyXGQ7tidMI5qGyVnbOw8xIjlHcfqmNxYTjeZH
 AfIwab4tDsnmi2zou5mWV1JM2K/dsyQd9uAR7Yk3oyTyS+8VbgeT3J74NRSHEIfzsVkyCdWpqbU
 6gfA4Re855JqLdw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/dell/dell-rbtn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index c8fcb537fd65..a415c432d4c3 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -295,7 +295,6 @@ static struct acpi_driver rbtn_driver = {
 		.remove = rbtn_remove,
 		.notify = rbtn_notify,
 	},
-	.owner = THIS_MODULE,
 };
 
 

-- 
2.34.1


