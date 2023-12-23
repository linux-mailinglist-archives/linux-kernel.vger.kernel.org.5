Return-Path: <linux-kernel+bounces-10193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993181D11F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD85A1F22FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72308DF60;
	Sat, 23 Dec 2023 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YAcZ+nPH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B7D28B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ba834684abso95835939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296794; x=1703901594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsFHzDa0Te8ALb5Wr+fprh+y2GTjxlZ6wlPnLscqJhM=;
        b=YAcZ+nPHvW38zQHCKj/n7a9oZQfIKh0zgnm0Z7aVHSJcO1fhxFB5baM6CdQIQto4Pk
         BKtPgo1BDeBMBAoNW5RI/KloDei1xQykf6wToX78fSLLXRB5nLEYmaYgfK3oI2g4rJJM
         VD/mU41jBRfOG3cy/zMcjtBfwcVLQXAV3J570USUnK8he6ZzeVr/kZT84wXXIdhFZQbk
         4KNcE386M6L+RXDWgElVbBIHVB63OwQ6B3L2mGwlTdNGugQlPsvOLl4PY0O+TW79o/4f
         /2+uVAUcw5SWWG3DI4cOIY2pw1fdUVcTtfxxhKqRbsnXYn+6oBj0KEX21HtQVU9Nn1gT
         qs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296794; x=1703901594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsFHzDa0Te8ALb5Wr+fprh+y2GTjxlZ6wlPnLscqJhM=;
        b=P+86LLXZ5oWZqUH+rr/Q44THfgGotgACuHmTu/D8IJT2Kg/XMH2bG31v9Q8Z6ix2v0
         xz5EwlC4cR/i/7SEY66gph3+JKgze2jHsMwngRLFQJRPFynj46lajp+z4oCC7gXmxJGb
         4C1rjgB98E569TMrEkEyCehnx984iTURG/ig68qnYaF6SlNR/e8eph4RCApAZ2H4mDA1
         9CwFH5Fkb2NzCug3xCefWQweULapDwSRIIZpmTpY5WLMe8+uS/qjntSIA7+p8GvICLib
         YC7A7SA45ZAu/yCn8zf4OL4cZhk6aA6hKDdeSyyi8AqmVLnGgpd3D62dwX0Wjrmp3Lsa
         iZOA==
X-Gm-Message-State: AOJu0YzUPqkCgZa2N4rEf/D//sb/Vcvb7iAJ1tIDH3cP7MyVHrA4uDIf
	jgBHxjBbOhVcNyiB7Rk7IidODQCKfg5AIQ==
X-Google-Smtp-Source: AGHT+IEu0RIc8Ky5HxhG5b3GTQZwhVWMUmU0ALvwf8jeBMRADTzqFgjNX6AFawTYsuMayrDyefHBUA==
X-Received: by 2002:a05:6e02:1707:b0:35f:e71f:4c60 with SMTP id u7-20020a056e02170700b0035fe71f4c60mr1969765ill.13.1703296794663;
        Fri, 22 Dec 2023 17:59:54 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:54 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/20] Staging: rtl8192e: Fixup statement broken across 2 lines in rtllib_softmac_xmit()
Date: Fri, 22 Dec 2023 17:59:32 -0800
Message-Id: <20231223015942.418263-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Join 2 lines to fix Warning: Lines should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 49ac73320fdb..5d14d7c0f8c8 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1838,8 +1838,7 @@ void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee)
 			else
 				kfree_skb(txb->fragments[i]);
 		} else {
-			ieee->softmac_data_hard_start_xmit(
-					txb->fragments[i],
+			ieee->softmac_data_hard_start_xmit(txb->fragments[i],
 					ieee->dev, ieee->rate);
 		}
 	}
-- 
2.39.2


