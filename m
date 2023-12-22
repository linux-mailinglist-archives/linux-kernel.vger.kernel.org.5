Return-Path: <linux-kernel+bounces-9379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56581C4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90D62880AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD76FBC;
	Fri, 22 Dec 2023 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulf31DKf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1E6120;
	Fri, 22 Dec 2023 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd8e2988ddso775647a12.3;
        Thu, 21 Dec 2023 21:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703224252; x=1703829052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRvRZykoJN1NoOnmO83DscFYZk386QocmmGOF7bdSo4=;
        b=Ulf31DKf22AAHNMuGX3ZcNKvSsQN9jhOZiPNcaKBkVKFw/q04X2ir0gh6/5IAyCaiG
         qn9P2vMzDWiEXEH3TFnFG41Omn6SuUV1zoPHjBNU4sJGXkKPCcOnUoVAWotZbL6Ec4B7
         Ew1h/YHCDHes2KFGVOnDvPH/0SJ8zLvCkAwq0D7fpfVSQikAv8IREbSy/Me45yJ2Uw6w
         QMaHilLrKdK8l1a8x+b+LoObFYKc3HPZUrOW6mJ1sVbZrQl8S+EIfay6gZ9+MLez4vXX
         AT1khKVWYVDgmZ/uXwGMyo2BM5R54tu7ohXvzn3pQsWb9gkZdRJFiJddo1nzeDK69Mdm
         IUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703224252; x=1703829052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRvRZykoJN1NoOnmO83DscFYZk386QocmmGOF7bdSo4=;
        b=b8x9FyXK8+jCU39wQ1G5dJElZyxg4DUY25Qqu6YFoCxneoBwaJD2OKvH0d5BdbZRgZ
         KaSrCAOKysdfS7Id4/thRH4MKF0wNRn6e7C4SWhduVIEM0vrSyhB1Jn0uUZ6YoAoPENm
         Iv1XtABmWEzhoHA2L616Exl5FKtUSVaDAHNBim3/kcX98oi+rj+i9ehMNLMR4vst7yD6
         F5rzcRBJlHKZYLwnivsrv3qvXBZQ6xJLTMyF6ZtJ8uG92QiznyNFPv8Djvl80vAbuwzH
         v+jo5spJLOGUgTH6VHOCjLnYmxPewTBo1dIzicfA4Rb8pOtrMO7MHQdpcaJT2gK2Edqp
         OXXQ==
X-Gm-Message-State: AOJu0YzhBJwq4TchJVyARvthgJHhduTxpk0aoVdZ15WxWF2yLGFoQIUH
	i00qU7I6J5pjpEx6RCP9Yts=
X-Google-Smtp-Source: AGHT+IFi32YovJZtv8sUPvSWvhc0jwApw94pEtvhvqvOcLHW6vipl+8TUyuOSkDSjSYyW5i6DeS8zA==
X-Received: by 2002:a05:6a21:a5a1:b0:194:eabe:cc23 with SMTP id gd33-20020a056a21a5a100b00194eabecc23mr595681pzc.98.1703224251881;
        Thu, 21 Dec 2023 21:50:51 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001bb750189desm2567135pls.255.2023.12.21.21.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:50:51 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	mcgrof@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH v2] [media] xc4000: Fix atomicity violation in xc4000_get_frequency
Date: Fri, 22 Dec 2023 13:50:30 +0800
Message-Id: <20231222055030.5237-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xc4000_get_frequency():
	*freq = priv->freq_hz + priv->freq_offset;
The code accesses priv->freq_hz and priv->freq_offset without holding any
lock.

In xc4000_set_params():
	// Code that updates priv->freq_hz and priv->freq_offset
	...

xc4000_get_frequency() and xc4000_set_params() may execute concurrently,
risking inconsistent reads of priv->freq_hz and priv->freq_offset. Since
these related data may update during reading, it can result in incorrect
frequency calculation, leading to atomicity violations.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 6.2.

To address this issue, it is proposed to add a mutex lock pair in
xc4000_get_frequency() to ensure atomicity. With this patch applied, our
tool no longer reports the possible bug, with the kernel configuration
allyesconfig for x86_64. Due to the lack of associated hardware, we cannot
test the patch in runtime testing, and just verify it according to the
code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 4c07e32884ab6 ("[media] xc4000: Fix get_frequency()")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* In this patch v2, we've added some information of the static analysis
tool used, as per the researcher guidelines. Also, we've added a cc in the
signed-off-by area, according to the stable-kernel-rules.
  Thank Greg KH for helpful advice.
---
 drivers/media/tuners/xc4000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index 57ded9ff3f04..29bc63021c5a 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1515,10 +1515,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1529,8 +1529,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
-- 
2.34.1


