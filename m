Return-Path: <linux-kernel+bounces-121301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5A88E506
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F7F1C24B53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC1148313;
	Wed, 27 Mar 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBeOP6YQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58654148311
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543376; cv=none; b=rxEYETsUsCQArICGb7OBQGlHW8i5M30NL30u7v7e7/UXj23joqYhCzyxfdhBLi/HpW5Y3yYt8zte2NxyGa01KHQ0MjlU1dB5TWM/EXbQ0vDlZ/VcymFNiu7I8M6dpIbXcdsToyTUxjsmKkhwAaljrKDLnN+l3eINmgj3nO4BNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543376; c=relaxed/simple;
	bh=RVE008LGGmmk5WXgZGxtm6p/ays+12n/AyoNVnX9umo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r12+FCod5LnEl+TBJGKsAVpKp+MCJGoo16Em2HD7/UxHvRJALW1iI+49ET6ZFA78l0lKGdsl4jBvD1EgWfMqsxSyNJVUrzpYuJSpVs0KYwFzzxIlxP15MNgsemm1sNmjZpwhnqqcGSngLEchLKglknaOMlH0cn2lnVJvCmuM3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBeOP6YQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a47385a4379so152379566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543371; x=1712148171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vBka3ABZcniwH/u8QWX2xHT7esEXtapMcD7AcTvpic=;
        b=nBeOP6YQwW711m5i5jDQY0Hd3rG0tK7i7IpNf/zCNRa7dmLz1sVHpCTTzOcmLaWZaR
         fv7WFaUXVxb+E9GYEjNzNthLgqFJkLL54ZTi2/++avtlP5wq0ugb/JINai447NPiJYfw
         JR6TDwwsPXJ49P3uX+ryFkaTJb96KGrFD+lfJuF2/HhSM7XnY/EicWxVpk/mcYpuhW4b
         fpNl5RU6lEgTiWU7nUEPt4GbRXLnGygkmeKelOuW4zRJqdHsJAec6qkpLwmYzWRAjrYT
         gS0U/Y0+0Zq4GbYDVIiOsgUCTAvTquTPdHpXTP/Ma5LWv3FJwMr79AL1rKObI4l5jMN+
         g6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543371; x=1712148171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vBka3ABZcniwH/u8QWX2xHT7esEXtapMcD7AcTvpic=;
        b=uy7hPnDX+FYBuOSAf0d2RzuUUXc3C3brK7ln5Eilib/NZImnIDrVfYJ2qCzRnu/XS5
         kDwBVZ6208NxrZTPIWwRCnNav02VXTI9IkbASsoMIIXnjc32vm0Kit9UmolzacCdqRQT
         Y/vwGd6hU12WVGo2qN7K6GCsdCRLVLG2DvsLDFRNk0mfdHx0LSmlcOW5G6y5X95UThBl
         pRUYos+hydb0yIzQ4x5W7K31eCkMRd4E61IOUiREoGhHe3uhdP2iNaXteDZQ5FWSfopw
         Kjp30YRpLW7AmjLwLJI04MvWZRPPToGTa0J0JELLxx10d1mQVihESZ3Xl7YRfRTR6kdp
         8gfw==
X-Forwarded-Encrypted: i=1; AJvYcCVa6Syz/LKA9yHhbtXyu89NAJh4aH4vY5gObDGubvzvsJju8UWqC8ShtVJ7s8xQYZMAgO+cJGVFBHtbKQYbMEeZA1wl11COEZg7EKyg
X-Gm-Message-State: AOJu0YyjKbPpjqdgoNMxCsPpMmylz6jlPyTSM6wQuEIsqEkER1LxAoDD
	7UU9Pekz706l0iJzlOWEhkCAtYZ+oazxAxo1mlSxeRhKXfpP9RJCTatEr0j1J5c=
X-Google-Smtp-Source: AGHT+IG5vuCEMnJybNEU3pw6Dfhrha9UVjffnJEN9pSayVDfDg6+G0gg3OeqyhGazXN+XfbDGEL4yA==
X-Received: by 2002:a17:906:5645:b0:a47:34b5:fa6e with SMTP id v5-20020a170906564500b00a4734b5fa6emr3936509ejr.2.1711543370618;
        Wed, 27 Mar 2024 05:42:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:42:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:40:57 +0100
Subject: [PATCH 04/22] bluetooth: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-4-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RVE008LGGmmk5WXgZGxtm6p/ays+12n/AyoNVnX9umo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPdBdOoV7iseHu8Ha4ifJV+o69aPjmkC0Glb
 hZvw0OYKhSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT3QAKCRDBN2bmhouD
 1wI+D/9dbQLSRFm34TU4Qv7YYw/ixrbQYbzdht3LbG49prmr+l9PRN+lDKM5C7rVEcSei80vRnM
 TiW6KxYh0V1FcMmWftM5R3iPFwUdsjSJJ8STF9/qxCFrtRu4JF2jLy20hTeoVbp18elVq5cPQX7
 x0ZT+2U/6ejc+Tj67MUtextCGgzfAnxyzk869i8eMn5+xHxfOheEJYs56sRxZveNqcH02H3SJzS
 lVHZpxQrf3FRGgcwHAPt3T3Xdw8Z16tpAtE2x8gC688DaS1Xf+F0yjXhNYUD3TZ2Nf2LOIirHft
 RqrMloYSPBljyoR9aLzb+/TS3YpVgQlAvKN5d6tmlJ0nE9har9+fKbx2BcRrLp/6GDENjqsOo/l
 8CB/SP4BTOX5vsL5yzZ+pY00Qmxt0ejqUXPkWtmcx1XbG9w2k8k24TXnlZCPdLXrLhnZ2jI9LT+
 zBfzzDbBRNwOCPfTHDN6HNuuxYCdwPAnpCXF+I0jmGk74U4igIav9OArAmrq3hKZBqbWqOZI0BN
 vbbrFOmyQQ3Nr/FfhrtNyG373ZzkyCTApUHwmnIEwpxTiKH0m+OVNyP38BY9vsn1/ZkBfOPZZyU
 LMQHmHackK+l1II6lBOJVnPTDqc4EvqiFx/LJsVwQvunku2hC9omSwT9D4Wuv363XinjYsbSqRE
 G6BGGHfVkJ9lWYw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/bluetooth/virtio_bt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 2ac70b560c46..463b49ca2492 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -417,7 +417,6 @@ static const unsigned int virtbt_features[] = {
 
 static struct virtio_driver virtbt_driver = {
 	.driver.name         = KBUILD_MODNAME,
-	.driver.owner        = THIS_MODULE,
 	.feature_table       = virtbt_features,
 	.feature_table_size  = ARRAY_SIZE(virtbt_features),
 	.id_table            = virtbt_table,

-- 
2.34.1


