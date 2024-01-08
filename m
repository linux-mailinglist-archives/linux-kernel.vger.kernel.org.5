Return-Path: <linux-kernel+bounces-19943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFDC82772B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1DB1C222C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29B55C09;
	Mon,  8 Jan 2024 18:16:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B955C13;
	Mon,  8 Jan 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so1804183a12.0;
        Mon, 08 Jan 2024 10:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737807; x=1705342607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcgHL1lt6FI61KfPmNoIrtx5NT6TPTmQcPiBJNYpJUM=;
        b=GSuPskwdekCKwiBdNFhpSWaaaf7bWXAUp4e8ujkOsAEz6X2Zql7J17ARfOHvY/4Ltk
         Wi58BQ8li6vuVhwAl+WytBl2/vto7tjtZNgqXpKx4YdZfWqIMaGuUui6OgViocMWV/c9
         fRXRG/pTiqng3BAXJQ4g6SDmMqIJadWuFtyc+PVVORaoNtnJ8zLT8QsPMDI4Ujk2po+y
         zaSCWEcEPX9miIfbiQX7yw8NSOiRGwSLWkrviQBwIJUur+y+wTLyLgdqraJB6CS25z1f
         hwoxgYBeGtrJGEQVICuBbS8lFWEaiJTvqg5b9MEgXt+4b3lZeLcMzSgOLYNYNT3ENnSh
         bcEA==
X-Gm-Message-State: AOJu0YyUzkIdHLQuBPiMhu8oJb60fVpYZazKCHCl6KRe5m2dhpsNMd+T
	rV0WHsSoAfwuPNbA25lTSsw=
X-Google-Smtp-Source: AGHT+IHbfT4CsXWd342hsUibDjIDhlEYVgg9HE+/oQA9bt+IxwH9ZqoaTg73sWMt4MJytpgZf6OKNA==
X-Received: by 2002:a50:aadd:0:b0:553:635b:bcbb with SMTP id r29-20020a50aadd000000b00553635bbcbbmr2465179edc.57.1704737807038;
        Mon, 08 Jan 2024 10:16:47 -0800 (PST)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7cd88000000b0055751515a84sm95481edv.51.2024.01.08.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:46 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: netdev@vger.kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 04/10] net: fill in MODULE_DESCRIPTION()s for NFC
Date: Mon,  8 Jan 2024 10:16:04 -0800
Message-Id: <20240108181610.2697017-5-leitao@debian.org>
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
Add descriptions to all NFC Controller Interface (NCI) modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/digital_core.c | 1 +
 net/nfc/nci/core.c     | 1 +
 net/nfc/nci/spi.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index d63d2e5dc60c..dae378f1d52b 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -858,4 +858,5 @@ void nfc_digital_unregister_device(struct nfc_digital_dev *ddev)
 }
 EXPORT_SYMBOL(nfc_digital_unregister_device);
 
+MODULE_DESCRIPTION("NFC Digital protocol stack");
 MODULE_LICENSE("GPL");
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..97348cedb16b 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1577,4 +1577,5 @@ static void nci_cmd_work(struct work_struct *work)
 	}
 }
 
+MODULE_DESCRIPTION("NFC Controller Interface");
 MODULE_LICENSE("GPL");
diff --git a/net/nfc/nci/spi.c b/net/nfc/nci/spi.c
index b68150c971d0..6a93533c480e 100644
--- a/net/nfc/nci/spi.c
+++ b/net/nfc/nci/spi.c
@@ -319,4 +319,5 @@ struct sk_buff *nci_spi_read(struct nci_spi *nspi)
 }
 EXPORT_SYMBOL_GPL(nci_spi_read);
 
+MODULE_DESCRIPTION("NFC Controller Interface (NCI) SPI link layer");
 MODULE_LICENSE("GPL");
-- 
2.39.3


