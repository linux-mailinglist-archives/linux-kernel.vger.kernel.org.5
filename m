Return-Path: <linux-kernel+bounces-125241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 119548922A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20DE288BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46113B591;
	Fri, 29 Mar 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0cSKsOs"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0629D02
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733097; cv=none; b=QI6+n2OKNTqecKfCv/Faiu/Iw6iiq5uGV+ZrooyMuwWeonNq3TC5m3XAqnQ1US32Qg18TNHlh58ozH1dyvGnj8aDwgfMbV4XunIt9kS3D6EjW0uk/apgvSTbFNdHVgDE9KKqgD08vT3uMtx0qE50FNQ94vggMomlDJkfJv5xmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733097; c=relaxed/simple;
	bh=r//ZqddB0cZEwt61oNE494z55PwC93sH8F/mKwPOy34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXmJYC9WrkiYFHXS5jVpgYEWXu1nak9/r/2XamVFHTb0v2vF/I9BM+9Pc7rIWmv6Vy4L/tnCWL731hmVC6yEdsKNtB748+NhdJlpyNpt1DIZsjJM50dqYgYeRQBqHTM6HMmDhG6vldYQTfDFifIasTfpdPWZH95RjywzJQN9uF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0cSKsOs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41552f1fcd9so3588815e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733094; x=1712337894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmTGzTEc4RD6Zxwx1L0++p3dHui3Vg8IltbV355Uuu0=;
        b=V0cSKsOs6+oOf2c4Wy0S3JuRPRtkHRvAFrKqSSepjroKHXXJpAAZk8DyQCW6OWNqh0
         6nC0BHY1Qn7R8S7P3u0GEYv1/bZjAhYuno4L59NWPzFlQjPJgeDEzaaty3tXnmuIK/TJ
         327fcR/bPz71dr8Nbb+XCl+99ecdrLc3RjKis6ZZOIhajDZIspOZdt10vczfGvDl9dES
         s+nbAT3P79nIn7N0jyJQb15eJubA9hYuVdlMLO0IUgmeKTbvXQEppMblR3dgV0G5pVFR
         CCatynrqRemTfR1cSmGL2BIgEPPggLsTP+x3jEL4dwyTnoKzBVliq+jJTvTwAEbbripk
         fGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733094; x=1712337894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmTGzTEc4RD6Zxwx1L0++p3dHui3Vg8IltbV355Uuu0=;
        b=RTKbtJ4Iwvph9JgxjM4d79rCJ0Hrl47NM0PJutK62AFTMvZaFl2mG3pZCnRiGl39Rc
         TxTi3Qnir3eeE6i6stxTCguO6mzTOrxW37E/ftXOkOGFy6UkYQSEeLTwgN+KVNq3ugba
         K4IQz0ShFiKJuwRouZOC6ZMzZ7LrPW0UTFK2MNP1pSprRap4fjCoDYIQAL/wg6fF8NfQ
         sMSw5kLnGni6DnFwbtw5LjGeT27nS8JM82E5SlgV95uVge2JHFQ1z9asP4WjpWwB+fER
         mTUNkC/6ixKV9iH/XkD8shkHTS/lifqrmIsuNJD63+w/iZMUA+cxpk3csQ0dBOkjnlyY
         IFFg==
X-Forwarded-Encrypted: i=1; AJvYcCVmxW9zLbvZVqsM0o8Ky18tirk7hs+ty08hzKXRUxvdMa47g5pZhRiuZUI6OgsHF2P28vAFufZVxKlM6dOwstsbIMK4/SvdoftPXHWS
X-Gm-Message-State: AOJu0YyNxvA20jskyQ1s5ouCcMh53A4l52NDe0oLM5dJNhQUlFAIVP8/
	AhGsJgw/Lt50tWVF57K74Bo+YF6JsFOuNh5qS4KZlYQS1rVzDwsWB8TnZbOZqPA=
X-Google-Smtp-Source: AGHT+IFKK8ZeHTH9ZbUBZLceILsm4M2liDcUbBqYMiyRy1FT3yEJ7TWMDJlzYPnYqROltzOu2fo1TQ==
X-Received: by 2002:a05:600c:558c:b0:415:55a8:e1a6 with SMTP id jp12-20020a05600c558c00b0041555a8e1a6mr168011wmb.4.1711733094429;
        Fri, 29 Mar 2024 10:24:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:34 +0100
Subject: [PATCH 4/7] wifi: ath10k: sdio: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-4-e4010b11ccaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=r//ZqddB0cZEwt61oNE494z55PwC93sH8F/mKwPOy34=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlaeTXWKNpgBui4m7Ij+L4ew0r+t6wYjZAdR
 BVOx+DRMMmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WgAKCRDBN2bmhouD
 1zNTD/9CEupDb49ITSPMOkC5RRoFX4Hxx04rWRsvxy7+D2Zzx1UQsGwz8tEr1QQIcS05RUsYRi7
 CTe7t0E7tUIJ0868rvcjYWISK9r1Wb3GsXOzE+vi4+8IdUDZawBJYmWVJWncC5EQ6X6aipNgMoV
 A3A1aeweQ2SRW/j4tSrw+AJfoHPVXBzDmCtGvSJAcut5TS82DDlyqYQ41yCvxP2Eq7e/0TLUOZe
 0DW7xlHa+k3LjO/PFHfqtU5AG7yhxUA0QvrLxnnHlfLKyEXKKfVaeWjRE403Ecm34IRNUDA/GIw
 L9tt9166WoHjxHr+P89YUcg7YUlIxmKqluZSuzl1cz/xvV9bYRGcA3PlqgoXnoe/q17Vs0cgmP/
 KvJv27nVcY9eAq+5WNeqyNwCQSSxboZmrpTkiVSvg1LhBAFqaE+Qn6PL1mbF3HNsUF0kB64Iyac
 rBLJZTLfe2qknwXfWl+xv/04Oyu1xMWWo0W2pyPIStmyNyTNyNtCCJYXVg+Nw2vQezrdv/adQax
 rKT45h+gEFfmekPRqx3rfWwqMXB9qqTOf6z9jIoG4TNYXnZn/HxufuJ7qiThb+JNRtbODqQASOg
 XyXbyNFhXbjlMGgvbFRsqfqdvxqiWFYYWRGVDVVi41ly8n+uw5VFCDvfsd4eh+Fk7g7mpO/K2k4
 nqGuoZDWh7MoGcA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/ath/ath10k/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 1acb9fba9a8e..cddd9e3010ee 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2667,7 +2667,6 @@ static struct sdio_driver ath10k_sdio_driver = {
 	.probe = ath10k_sdio_probe,
 	.remove = ath10k_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.pm = ATH10K_SDIO_PM_OPS,
 	},
 };

-- 
2.34.1


