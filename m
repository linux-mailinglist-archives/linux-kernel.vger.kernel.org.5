Return-Path: <linux-kernel+bounces-27546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47C82F1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E55A2862AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7271C6BC;
	Tue, 16 Jan 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtmo38Y+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D621C6A1;
	Tue, 16 Jan 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso29156145e9.3;
        Tue, 16 Jan 2024 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705420493; x=1706025293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=097AIZDFnth5ZFT/ZvzM3lDqkfx5bsjxaBNjsvF0f24=;
        b=Jtmo38Y+yEH3xxoBYEpykcA+deLoyQkBoQh+85NKJTCfR9lOZMDo6Jel0nKAxAIi99
         uknJzpXgmnGLB8aNfqEL/xFrzZ+amvwAZaKK/LUzvXWJDCxSS3Ol1tFGiBzfX6yCfGJw
         EEtKxgEvtl2QdtqOWN3OfKK0k3kLEwcTLMQ7JqqwXcA+PdDKGZAENLYChZo7De5/v6TZ
         rNj6QLLCJ1Zx/LvY+mmciXwr3xlscbl2fsh/3lpn2CIvul1/56zrfRjfyrQcOjgeKs1n
         otqHIFtunq0KQ0OVoHowEYMOWUS2rKhZVY0ZcDi6BXvPoldTHGped4zKtTJtMZyvELOP
         YC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420493; x=1706025293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=097AIZDFnth5ZFT/ZvzM3lDqkfx5bsjxaBNjsvF0f24=;
        b=m2pU75i/Ro1daatB4/LXkm4Hk6b9/wmLVCATI+fWQJJXxME9JP3Nl5qmVjqr5pnvS8
         8LlD4cNw+bH7chduapLKx2L/MNZA078xPJ0dvF/oTeN88VxGPuXq4fNmDaenZ6cH7I5U
         gEbhFRAAvaCb8gk0O1pVBDhwegVxkBS01PTIQhTnGQh60okyQhDlIPCL1chDsM2LrbHp
         pbUQ6GIIMugMbF3CNK4q6zl8IkXxz/9AVpoyrWEHEpv5OfClqO2sGy4pWluZH9lI9nCg
         X0rfUxUgXSVu3XJGFkY/vhEF0KSSRLn+j6g/LxlVq0J30TP9G347JiI3MlpjElL5uOvG
         NsJw==
X-Gm-Message-State: AOJu0YwAAEtIG1qiAvNKHLW782cZxGO9HyWc7kc0V5ZLm6SKQiyF5U36
	0msv08mZsx8k5ucm8+jC4qc=
X-Google-Smtp-Source: AGHT+IHfHURJWF9KvXkLVT6B9aCIpy4k+92SQCv/WP+ixPjOX/LueXlRtXJdGBdNb5AgNn93MHzAkQ==
X-Received: by 2002:a05:600c:1885:b0:40e:50d7:6902 with SMTP id x5-20020a05600c188500b0040e50d76902mr2588898wmp.64.1705420493390;
        Tue, 16 Jan 2024 07:54:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id je6-20020a05600c1f8600b0040d8d11bf63sm19811106wmb.41.2024.01.16.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:54:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: ath9k:  remove redundant assignment to variable ret
Date: Tue, 16 Jan 2024 15:54:52 +0000
Message-Id: <20240116155452.2315351-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable ret is being assigned a value but it isn't being
read afterwards. The assignment is redundant and so ret can be
removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'ret' is used in the
enclosing expression, the value is never actually read from
'ret' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index f15684379b03..d519b676a109 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -369,12 +369,11 @@ static void ath_tid_drain(struct ath_softc *sc, struct ath_txq *txq,
 	struct list_head bf_head;
 	struct ath_tx_status ts;
 	struct ath_frame_info *fi;
-	int ret;
 
 	memset(&ts, 0, sizeof(ts));
 	INIT_LIST_HEAD(&bf_head);
 
-	while ((ret = ath_tid_dequeue(tid, &skb)) == 0) {
+	while (ath_tid_dequeue(tid, &skb) == 0) {
 		fi = get_frame_info(skb);
 		bf = fi->bf;
 
-- 
2.39.2


