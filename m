Return-Path: <linux-kernel+bounces-120449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6F88D7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E481129AA38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E62D606;
	Wed, 27 Mar 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlUpVrww"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213C374C6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525504; cv=none; b=DAWlUQCubgR6tlWzkzorFjqeYxp2DKuSlVO6j4STDaqVLW24OTD6+PgQftGQYDEjid5cPpOtyb1vl/5dDoZBQ5rF6BcGnKaQO2JaDGwN6mVfSBEaxlACj9RI2X3K3n514RABHIVdlZ/PscND6n1P4Rxk92Ayte4YIJxmACQvd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525504; c=relaxed/simple;
	bh=+Un2P0nzvIRCaODwI+ffqbW0AiBsvCCnqQrhgdXVj6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0MJe+afq67DwrBsbAmRHXounb/3e8KhuW9irkVLKjz5kH5QvVYdD9tT3FLnyVuetRlwgoEwpUl2FKOgY1PGOiJ5G+ErhPiA5q5dVIzdq0hQKfPOSMS62XSk/95V18s2F2Fhwi4vm7Q4I2Pc+RJeaQcEyGdFj1fMAiNiilOmlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlUpVrww; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466fc8fcccso814437866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525500; x=1712130300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OdU6cwFEY5EvcOka3uCPEMzzs2RP9EnJiq3p2s4tME=;
        b=FlUpVrwwPet52hKPxRLMw41JqsRcCiAA+bp1xyLvgu/Rl+gb/AGXb+x53emDddfxMP
         V0cJskjmwlGBfsBuNfeOY+Zgpm6zn90JyWIe7E9LnyPV+rcGL03+OMsEAuxMq2HTfDT4
         7dRzbH8NGu4IijoSQ57zSdxChXr0LOVjs1Kol2MIg4Q0o17LKjZmANJUrMFpImNII7Kd
         lW3nbLHtE4w8HOko9hkhY0UgFAeZvSqJUiFJEf/3BmlKsIJa2KXVMCJrhQeJYKAizO1H
         HruNNMqHAjlEDshVUm5a5Xq1m06CzLYrnjI9/WMwH01p8142ib+CQEY9gJgS8WCUEWHw
         7I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525500; x=1712130300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OdU6cwFEY5EvcOka3uCPEMzzs2RP9EnJiq3p2s4tME=;
        b=tlTxghhx/bQ9Og+Coou64ZxN83bY2sDi5BOy9icgigjQoo9RUaaNxpZOKbN4O/NSjY
         ktsr9ct1EkKRAP4yEQlUg00dW7eQC2uHCl6u4RuybL+TaZ387DEy5mAPjPHFc9ua1aYb
         3FLgpd+w1m9+xzsR6dXxmfIko31AnTM+D5EManSfBOEyJgz18LhA4/K3S9eCyGP4jJZq
         jEv1q+2wqzMD3xWPbQl+rqb8wPdh0/SY9dpBSF/KbG2UjVyRiHMdEo7dNUYaYPdSja/W
         nowx1cugp/6gUCTSeEWvB4O7CeVGfN3D3HaQkPgs/OPuj9cymUR6r34F2J1IVWG4fCRn
         L4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlLXNed3Un0TJ/2pYwi+nU8Smof82SvAbvglH7q9GqDVc3PrMqR6iDZxT0aFcYRt66SsqjtJjHUTT80ylVfJkRlQ/uTev6luP0Mc7
X-Gm-Message-State: AOJu0YzlmEgGH+A1LGA/aP7jPNIrDN9sAARJr3AHs08P7hz1/EVD82bA
	o7PtCJIEojImQj1VcjNqPhCERj3CURAJKcFz8aQrVtJKAH6VNlbuXR5SBGJ1Els=
X-Google-Smtp-Source: AGHT+IFBbz1g63HkuYrVrAI53IUuyku9WmAe94pWXZD9/dvVcsawSLmRQIBA3JJOadT2vKO7ah8azA==
X-Received: by 2002:a17:906:2987:b0:a4a:3403:342e with SMTP id x7-20020a170906298700b00a4a3403342emr2196259eje.56.1711525500518;
        Wed, 27 Mar 2024 00:45:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:50 +0100
Subject: [PATCH 03/19] net: fjes: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-3-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=713;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+Un2P0nzvIRCaODwI+ffqbW0AiBsvCCnqQrhgdXVj6A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85NoJNHHO2Cf4FYUxAj0qJ8tdw1gmKrjrZO5
 vylSYcd58yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOTQAKCRDBN2bmhouD
 12a/D/9S1750SQRwMXdoQfbGs3hLrqOS/ioEhxhs0jn7yWZXROvspBAoONHEeb49Se2/yVdf3lr
 Lr7snDj0aU/+n3boPacnlFIoTILCmrWI3vTDsPUish/1308aTEuelLymEKPoV5GXJ2SdIdKUcfe
 3/yezIQgmo3IugkglTAZBPf3CHkLms12vcY6qcoJuVQJ86Jr7qlQwlTdvHbtz20ucL3ab6nT1Sy
 aUGY4brw/J9RumLkC9G/RJMs3SQRo7Qq9kb06Dih9EIzgYCCCCMWfJ4abxUEpSSPfuYl4+afotW
 wspDBcb2/h0o640YmFx/TS863sFNakWWIuHYU5/hk0iDIf5uGx3MJvVzzgs7+3iJNWNXxu7xzJB
 AIafnEjJfVfaroDZEQFjxnNPdOMU3GLNK9NoePaCR5zys4eqne4ukaiEXUUMcv58325Rehp1vMa
 2DAlVLdcuQIzhNFV4QHocD4zNDlyMN6B9TcUurGl7Y40CwJYy3iwY8NAEEfkRIfn+RMnCK5wdQa
 kLb8caTlWwcyJdfB5Qhd7USeu7tdBXWtdT5Ur36RwWEwBfLqJpe1V539P25++0SM6veZ+3vztmf
 33E6nWW3FRIt4y17vh92fWhL36mGiXCVWlWqFPQgtIXp9PEXHhhTMJuM+GbUtAwz7oep3jSCwNl
 405tBGR4pXmF/tw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/fjes/fjes_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 5fbe33a09bb0..324b34f3ac93 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -156,7 +156,6 @@ static void fjes_acpi_remove(struct acpi_device *device)
 static struct acpi_driver fjes_acpi_driver = {
 	.name = DRV_NAME,
 	.class = DRV_NAME,
-	.owner = THIS_MODULE,
 	.ids = fjes_acpi_ids,
 	.ops = {
 		.add = fjes_acpi_add,

-- 
2.34.1


