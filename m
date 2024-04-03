Return-Path: <linux-kernel+bounces-129936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1889723D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EB92879BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F2714A603;
	Wed,  3 Apr 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwtBmwBO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1A149DF8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153834; cv=none; b=CChNk40edBiSkzLbLXew3ke7nAGURoNOYY0yemFEqBZhygwLZy6LJtRwsoytVMgfdIOEF642SmlR4Su+GX+iPPOxShEbnbXbEscgXHAc0WfbbBYOyNBwFclzRcXCdV8blSHhQKNviUmNARhumlUmNC0cc9PtrcwXlizfF7VgElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153834; c=relaxed/simple;
	bh=wmPmmXdT8FMwSksDvwRdXeWX/na11P5Z6Ye1jHKblRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwBchYvQfCa5OphELojrGE0xegp1c4kOBp6NFYzFYm7hLIB1Dk5HlKeac0vd0niO5wg0L62mR7v4WaHRZQkTDtTldGbz+SlJNxsuo2xymtrZrBE5Pn2bPln5FjzPaolEUNX3l2p5LqVH7XzcdD933w/Pe5vT7xZYaJHEqbyHx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IwtBmwBO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7592213a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153830; x=1712758630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVQ0U9D/KVAqjXU1brwZZN7jtSQawCJDB5Go47IF4+I=;
        b=IwtBmwBO117VXudqqJ/CGTyT3tMnh1S4Cmci1jmCMBVlhBCfh6TaClIPaH9pcwoXXP
         LzTTPOyPHY4Z3AbeezPDirFexKe2mvFbnQlB6VLJySTF4fyxEN9czBtDdxbQlHA3bDjO
         6kI+aJWzcVd6mjEnUMXzKcWNG9W1ukwb2ccJeyZxPsW8rJ4oAg5PMA8NN0CY3tJZsQtT
         KFlymaBeoxtNx56wHJdig1EWEDjZ6W3H9Kal0gb5Mf7n4+nmEGgFSAIXHph+RN1XnFbB
         /vc+x7Azk2hPmYBszXz33hhFl7ytaQOIbm1YbqxG+Wmt9gxcOPUZxuaT54+4JxQPv8wd
         xKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153830; x=1712758630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVQ0U9D/KVAqjXU1brwZZN7jtSQawCJDB5Go47IF4+I=;
        b=i18kIPX+isK6ORit8ZsfM2zLZEYmJky68qLQN1BwhHFiUfg1TPxzBdgSOjyDIENp/T
         gPHYLJwA1HlvgCnpfT5Bsf5x86/LRpdDjXAN4L3YQLOI/1ez6j8nAdQeHnsn50K4mFQK
         xqrGKG0E+qIS5i8gTd48LU1eVPXaE1/NP5y6OabWcR7c2xk2xm32IXvBv4dStPgqt3A3
         mIhnSKfk724cjAi1SF9QswqaZaRaXtoaVx5s2Z8aHFdlBLSJttNI1psWfXWuDjNw3/ej
         mDqGv4lb77n4Ds7xXO3wBQq6ip9cCw0ENhx01NpXKPz0kNDjBCjzDEx5fmALsoDUwNs5
         Vgeg==
X-Forwarded-Encrypted: i=1; AJvYcCVYOCqNc66agE7Th7wEMNWVWp8mzjC1GQ7LryDzNLThpDviHToG/IzE/aKh7i/22T9FJUZ1pk2IPgBE4Ukp79qiVZoJ/IBV1tmyMH2e
X-Gm-Message-State: AOJu0YwXBbCIHZFgvcETXX9tW/7N2o0K7JjThkk3DJlx39VE7jnlYqzH
	pKbjwkh0GfxpdOMQ2s3OSmzN46XNrYFTqKw0H8yetVOUvqM6OzorLAevnCid81M=
X-Google-Smtp-Source: AGHT+IEq+cedMg/HdXeWUJ46ccGlTECKF+cYAqgFSpQRqCCTL8vGS1xn+Q24HJJd08R2KNhYaMPkLg==
X-Received: by 2002:a17:907:97c9:b0:a4e:5088:a959 with SMTP id js9-20020a17090797c900b00a4e5088a959mr11602611ejc.17.1712153829813;
        Wed, 03 Apr 2024 07:17:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:51 +0200
Subject: [PATCH v2 2/7] Bluetooth: btmtksdio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-2-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=694;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wmPmmXdT8FMwSksDvwRdXeWX/na11P5Z6Ye1jHKblRU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTaZN41kIdbagqJ8fbnOuBWNq6NcKpm+jnmw
 SokJxjA9ZeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k2gAKCRDBN2bmhouD
 18TqD/4xMdeO7N8l/RfcqlLT8jwGJJpLGtyHMHJVuEX5WDCMPUL0LKwWqGI48sSlBaPNDp5uZ7b
 bpD9xkZtpsFLxeTOAUVR428mbr1ejpNQ8Q/B0ilOg4L002xiikkzLaPKrypNOZVk1Y5sePzi1iu
 VsPrAXo1vFpQ3URnX3Ph9o8esjfPfJqguU835edg0Cf+IgTZFV5ODNGBbDI/tG9YMnwU+4s9FZ5
 FNwTrT7xfi9yInPMbu7qB5/ZVEctiydQWu+0VLjjQ28nokYCbGH/8a67X/gN9G7DkGK0ha6osSB
 G68+oLRWdpykxGXgj9+lggR//ZlHdTJE2ekdyWaVt85iAKmW7n4ixZOPl8LBJrtD1eqQwLAaMni
 ZlxNpG9q+LCoSx7JaB881EeKwS/0zDyX0FWC8n5qYiDpZ28rYjQ5AbPKmaRGGrS0UnqdaY+Hf30
 Tj34ZUSYc+RPw3DS2VGPQ81b/Sz83YgKING3NORDXWg8LBqFaENZ7oMI2zIg0tZnLOTj5hNNNSa
 HmY0qMwWOie2pjXpnyq9yctaaIe0lrpx4MjiUFWnjSKE1JbKfpfGWXMsp7TckdmnNk9zaXcC3at
 +qanW5E0+QlG0Phx+ZW8Brc4TV+mr8Rwe1bYb/o0X01nQ27LdryWzFmxacAc78gKZPIqwQiKU+l
 dXRLBJZzLsoAzjw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the patch in mmc tree.
---
 drivers/bluetooth/btmtksdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..8ded9ef8089a 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1519,7 +1519,6 @@ static struct sdio_driver btmtksdio_driver = {
 	.remove		= btmtksdio_remove,
 	.id_table	= btmtksdio_table,
 	.drv = {
-		.owner = THIS_MODULE,
 		.pm = BTMTKSDIO_PM_OPS,
 	}
 };

-- 
2.34.1


