Return-Path: <linux-kernel+bounces-19947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD682773D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1664F284AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98A56752;
	Mon,  8 Jan 2024 18:17:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0272856748;
	Mon,  8 Jan 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2486457a12.2;
        Mon, 08 Jan 2024 10:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737820; x=1705342620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rf/NCrc1F2s0LBofEVa1llAtMUjM0UeNT18pgu/CASY=;
        b=APG+DM4f33ID0YrUj/f1dCT2MOI+c2kH3GY1IVAkBUA8yRIG16pxmiujKycNdhHC5/
         M5tJPujDKgXlvfET1TSonJdeI/N+wS43pyn8Ya82OkQAj3KUv0f5Q8gODK41TnRtFtzF
         WxNHCuUhZy81+M/Eaa3F4P5rPwH9B3sw1TcqiKQQw7Ds32dr3D9m2qr1bWEqM9xa7/0w
         8Rc5mx0pVQLlMXVf3X4iPz1R1VqvBsMQRMU6FgEb7GpITITJi7iXibyugg4LRd6PDDU6
         w16xr+6YepYsCKjiQlqw3qck+R+N87PEXEBnDaK2T2eH7gL93BQNlD2Jubf/XlgIcYv0
         IzBA==
X-Gm-Message-State: AOJu0YxARFUQzHurl0ez46JxKxwPO4FRcvMV3leHtk/yZSfZTgItZfbP
	Nf/2VKd2JNNixIyTz3eneCo=
X-Google-Smtp-Source: AGHT+IHMkKCBj+JUMkPQv7KilhAvpPsR18CNJ6TgsZtYM2O+vVcHll17SILkWxsNPN24yfyEgRDN+w==
X-Received: by 2002:a50:bb03:0:b0:556:efca:aae1 with SMTP id y3-20020a50bb03000000b00556efcaaae1mr1582894ede.124.1704737820239;
        Mon, 08 Jan 2024 10:17:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id e20-20020a50fb94000000b0055306f10c28sm95377edq.28.2024.01.08.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 08/10] net: fill in MODULE_DESCRIPTION()s for ds26522 module
Date: Mon,  8 Jan 2024 10:16:08 -0800
Message-Id: <20240108181610.2697017-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to Slic Maxim ds26522 card driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wan/slic_ds26522.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/slic_ds26522.c b/drivers/net/wan/slic_ds26522.c
index 8a51cfcff99e..cbb99fc5ea9f 100644
--- a/drivers/net/wan/slic_ds26522.c
+++ b/drivers/net/wan/slic_ds26522.c
@@ -28,6 +28,7 @@
 
 static struct spi_device *g_spi;
 
+MODULE_DESCRIPTION("Slic Maxim DS26522 driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Zhao Qiang<B45475@freescale.com>");
 
-- 
2.39.3


