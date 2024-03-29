Return-Path: <linux-kernel+bounces-125239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A48922A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B193B21C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C887139D05;
	Fri, 29 Mar 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8fEDC27"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F17134724
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733094; cv=none; b=J+vBZH7aq0w1Rzs3ktCHMf2bV8GVgwJ/9XLGamnqj3DZegF1vv/TlGGYb6OMgO6oW4ChEICCyGtJcSF0+bq/p57LgsmFpdg1R2hm8ktxPNy8mp0Ta5tav/50EnbTLy31MPkym5n9+Lv7qOpsAS/zQHRCZEfemM89/Su1SxiTulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733094; c=relaxed/simple;
	bh=pEH88/Mvde7IOqLLQxygmayTZOYyn7iF1rcGpX9W2Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn2MHdgPOablaYEy7q+nH0U72dfqVVs8qdIn5qRymiFfnssrHNPRZFCiZZW9XJcbRFn5ru41xcWonWT3Awvnu3ED++9nCaZuVuMF/MeNCcpyox/oyAFlQjbm2/ry2oV+9ch7FVcj4QyScAQjcMO1sdqlAH7lVgqVLGzQCnsrZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8fEDC27; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4149521d76aso14728355e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733091; x=1712337891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhPv9uNzNlnN3t5bm/Vtd9WoPCFFzK8p2hzOyPKe7ys=;
        b=t8fEDC27dwszNVo/2Qq50EfcUK/fASUS1YhwF8F76V4Obs4EaV9hqSO2v5F9pWB+A9
         624/6Xc9ZYtSHQVwj7XFYv3O2x+8wBp+nX5goC7QtUThyACdqldl7rPBVnjzBSfXfsEm
         VLqVMDHhqof++hmnv60JksciVuKqDHBVb6zlAT1y5PzFqohOIRs3WvpaOe+Ao0pbH7oP
         8uZ18oK6DjmeXDwYsn41xbGJSIzTokn/Sul5QsFNF9M47g7X7y7iAjCR7f621e882PG/
         y9RGJScFtlCrBx+q729iUdKDwcfwOCKvpNiC6JzaApD+mxqOD4dTNL+5JiuAEULclBHX
         RkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733091; x=1712337891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhPv9uNzNlnN3t5bm/Vtd9WoPCFFzK8p2hzOyPKe7ys=;
        b=QKFNVjxFQsQU4FobAz26NuMf9TffLInH9of+JKvvfFbUq3xN00cInU+rFl4XoJxQt0
         IqziYQh+mk4s1x+aMmoyhiNUR9C7d+U6Xie32Zzrl1rc2ShVSeIx+LlUVSGvoM/gUZUQ
         5emc6U5RKUfGpjKj6r5eQwY3WZlOH7rm0IWiMKE/Gvl4xKOvTHWUgujbRDy+piPFUINE
         oOGYa2bR7XS6LKoieDWqxawwa5Zb3gf29nn9CuTNXycsNKc+mxQ+QAxY2+nIHjZWY82r
         DHfATatOWL5ubUeisMDIbdyeo7Cxi1j+zsAR4DYoiQiEj9AZOWODPPxPGgG17rq28W+n
         CGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQzo3KqLNtgWiw0alk2KK2IVyeX1a2Uol/uqBoZbYWfOKVin8Q9tJEBKr2mK911lWMSpe9Eu79j57T6lyNQgp+I1bMK20ZrSYfOfN0
X-Gm-Message-State: AOJu0YwxBg+6/b+O7RJ0LMUM7Beotp6OD+MqBDfvFnkh1Lv5t7gZl+KP
	dHsQqkHhts5poDq0yNmxgX0rXpFq97MzMt65dySYONRhlnh8F651twNavNGpnyY=
X-Google-Smtp-Source: AGHT+IHtYKNLRf0lt/+X8+eWcJn/VGUD97lyqseZN1lBqy+We9hdEYMyYTdeRsMpokaPE1hUiL48AQ==
X-Received: by 2002:a05:600c:548c:b0:414:860:bdc5 with SMTP id iv12-20020a05600c548c00b004140860bdc5mr1971848wmb.17.1711733090950;
        Fri, 29 Mar 2024 10:24:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:32 +0100
Subject: [PATCH 2/7] bluetooth: btmrvl_sdio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-2-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pEH88/Mvde7IOqLLQxygmayTZOYyn7iF1rcGpX9W2Dk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlY9jlnYndvqf4ycZsSLg8vHI3GcQCFdx8JA
 nKG7a+rQTOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WAAKCRDBN2bmhouD
 100+D/45p3tm81nQpqO6l6fT5LIfUPqYUD+5qLGAv/aTKvxeR1Yoiwfz7NpAwUBnyXCBk4XhFcP
 Ua4kpdZv5BN8cum+6JCjXVf9Ocd+zqHQMcA+E8ydJLFDnrze7mebC3CV4E0hXseHWx9BnrNMW/S
 ORtSDUSspE6eK7ZldHdULSpWDlil715pyv2mreTgfId7O/qp23/Uf6sGU2ggjBmG/7XShm2m2ls
 A5bbVqHvAeWn+LlnLq2kVcfTVA6RiqfISLgnjkP4CSLkMX8ei3mRaliwKRcp4NRdzCzZqUF59Bo
 tBJFmLTBeOjbIGtuT/Y2nQCmELTX42Vy1XCoge50qKd7hFCalX5HS5IF7qFCTEt9Ny0oxGIzmD6
 LNdGn94V8xmkCxuVZ54z2+chM0jF4rHQ3Vc+3ydZtoMPpd4h1zbDi6WzRniqsmV+36WgKeiQI5l
 9+XGDH365JVRpeKJvyCejPc+dSYivtHvch1qXIfl7oIczK2k8ywUCki7anHKIQy7AD0RQqhE51x
 ud6O7CvXO/c90RWS1v8TRMpt5Xb/X//3fK2naX9rxz8C1ytLivxTgDLPmRTy88SmEUP9NCgMVV3
 nElrYtsRKiQ4liVrALFnVJualZhP/pvvh6NcPC324SgjSwfwhHd+onfWNDrwHsw9bQn+qEF5uVH
 0/iiDkzzaO2uI4g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/bluetooth/btmrvl_sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index d76c799553aa..85b7f2bb4259 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1736,7 +1736,6 @@ static struct sdio_driver bt_mrvl_sdio = {
 	.probe		= btmrvl_sdio_probe,
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = btmrvl_sdio_coredump,
 		.pm = &btmrvl_sdio_pm_ops,
 	}

-- 
2.34.1


