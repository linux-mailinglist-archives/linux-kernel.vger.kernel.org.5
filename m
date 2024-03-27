Return-Path: <linux-kernel+bounces-120457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962688D7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD64C1C253B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A3524A3;
	Wed, 27 Mar 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dovV9BZq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB74F1E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525528; cv=none; b=O1tFMnX5tLmfIqpsI+IDPMphSF8O9/jkwGs7bN9lb7JbEToJ6qEwSqmvS9KULv4OD+adJk1K9r9WEYhlrLVPE29E1iGtJLs5NE2Se55pTx+Zu5kX0CF9HU70nWj4WMFvWVhGYjZn35Ftz2BayW8sUkIN3s8JLo2Tv24lZ/uVk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525528; c=relaxed/simple;
	bh=fNSLfPDJxvqzAJQHrbVhzvU7cCoozexEWJo8bYlcjeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUog7oh6h5KGVTzCRpX9wt1puSIu6e97T0ZEbeFLCN2R6DuI/kv23L93KyHTc7CzK+ZGM259x4PLzWaKdwHY74BPC/TBP3Gzh7aE7uyvTuMX5Tvgy9ciTxMgw/P+ngg53kdahuGvK1KyS6YNBRa3vQJyFg4VWMWC5Si8fWpf7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dovV9BZq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e0b2d5b3aso6646466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525525; x=1712130325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vv564JitDc+m3bwVY53Vc2L9rcayUx+g3EXkDyYeLek=;
        b=dovV9BZqPtE6pc+caheeyrfwjLMkYX5aCytrwgpbeTDKbPHnXvtKWsgwZsC5nPaHoh
         bIAbWdSaj0nym7NLgkoMMZQrSHXxxTJ5zdYbpF+xjMMVKqDuXmaVFzNoWIJlEKr0HiXx
         uomqkzL+DZFI6H4hhB0iHmovC5ebkvuGNjKzhOKJ888TuRMMbtBMKEb0HVwrKvnLA5uT
         r96Ut0w6rcqzvnuxjeGDBOEnx5XHviYxIvdLd5RkMo7mYM3TmxWvo2zY36h3nzNeIV/f
         DP8NQx9zEj5m9RTHVHYwf5U5O7T6o+7XmWhdbDLmVky+bCVcYcD0N7wwQJ27M28XetPN
         dY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525525; x=1712130325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv564JitDc+m3bwVY53Vc2L9rcayUx+g3EXkDyYeLek=;
        b=swPt0dsgH6PwQIQW59wmNshiH6ATOKzhrUA+XIIEk9t8dzZCWE3KSMDCQ5QqGEJbyM
         LhyJGocLcKK2FQQd2pkVaIgoFGYrDdaLknFJP/6UrkYSS5C0eWHURaEK8MMQgUd7TIbS
         9sCOYTwtTZi9uXDXfKvaPUmrKlLbRbLNg0gCfi4pfa976yLwQHofFUFalabPxSkW+W+c
         Y+EjxyaDMElrxBPgNShEWoo5Ss93oH+GwnL7GWTYHRDjXJiQmWexY8hmuvGVMeLqJ9Vt
         87jfqWHGVJTXRADa43mgNffafk+fdI5166qXyshEOAujuWebG2PrYSbyp9EyiAwmAOyi
         MqHg==
X-Forwarded-Encrypted: i=1; AJvYcCVJKLEa//vUWatglcFCJlIKC8ohHCEIEKbQjLKuhgja/taivUpunPYSpNFoTmJpf3n93Xv56g3GBzRELqdrUX17t0TMqt0aAITz1QTj
X-Gm-Message-State: AOJu0Yz/gUvuJQqS9WtavLOFH3N4UqUeOi+65VZz7/Za0bAgMOJ4Gw0Q
	DFVdZqXb7WFK0n5pL1tP3xyHOQLEUKbb42h4d8oMflZgbB/A/HgU3xCaw7FbPg0=
X-Google-Smtp-Source: AGHT+IGsYWPKpHC4XVfxYs0S1B5uDe0mNzlz9NNZ3aJWZfPENKcVMpeznfBuVBr0YCZ09qhBbW7UTw==
X-Received: by 2002:a17:906:a18d:b0:a4a:3b20:87e9 with SMTP id s13-20020a170906a18d00b00a4a3b2087e9mr272492ejy.41.1711525525004;
        Wed, 27 Mar 2024 00:45:25 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:58 +0100
Subject: [PATCH 11/19] platform/x86/lg-laptop: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-11-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=630;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fNSLfPDJxvqzAJQHrbVhzvU7cCoozexEWJo8bYlcjeQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85UAd3MCxLaH71C3PUTAKtVVS3LD9ZEi+Bd4
 zSjNVNu0DOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOVAAKCRDBN2bmhouD
 1ySED/9q+c5LahbfTxRZfj5CLqGz5NQDTHVVT3t/8W3nBwVR4c3lsdoVunHZl71EdPYHE4VFF21
 auFpplM1n5StC4sokoRL4st33AA4FeuHkvBtYM4kU1CdCHsg9S9oEuLPY194KZiqUIV20fIfsS9
 lGU62GuBgdTd4oItrcF+h90dZaxx8Eu5CeEXr0t71OgZnOq4D26VGIB/2OAV7DfMCY/t5Kmvprz
 8nRRvwfWqyHL0kn8hQIhtcS+pVMO5KTl/he8YLqFRZ9MhKC6hAYS4Ft8vGbGIeJn6M61p20YSm6
 lw4KoQJ16GlchnLTjw2sa2A2tU/PQPUbodhteAmWMIN0NrGow0PmPK0O17paStaiIPeL0OrL+Iq
 kH0enrLV0UeMSBjSNWCoQMYhrxjXQf7VDLo3gmcA9e4SXMvYFu86kE9aBscXOwG4DussxQDmcer
 OUe936UdjLPfXx4C80cLi8Tq3mxpWJROSMULkah1E+Hk3cV/QAawsMOMjl6AefrmPa5K6EZrvbX
 etfCRbMyL+JMxIKA+XXVCzPzYbTTzQQETTYfGgQ8/qlDXqF7NT9UzpdC1ZZQ562xQ8Aaau2T17I
 4HZzgbFVAhJOi9y9M8ND1kaUxoM0OK/axI+Bxu4Zs2aOF/LDdMe+0K6bsBMnskdc5FeXC+U+HnH
 QkXB6QwsobOD3Ag==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/lg-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index ad3c39e9e9f5..36e88b9d59ea 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -790,7 +790,6 @@ static struct acpi_driver acpi_driver = {
 		.remove = acpi_remove,
 		.notify = acpi_notify,
 		},
-	.owner = THIS_MODULE,
 };
 
 static int __init acpi_init(void)

-- 
2.34.1


