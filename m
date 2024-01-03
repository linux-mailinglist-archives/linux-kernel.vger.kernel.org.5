Return-Path: <linux-kernel+bounces-15997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A518236CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8719B1C2457D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579E1D6A8;
	Wed,  3 Jan 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5EhMseM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470A1D69F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3fe03b6b7so23973185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315192; x=1704919992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdLU/U7TSYkmEg20IDPG1xvAMQzbpbdvIaAXCBEqQ4o=;
        b=X5EhMseMg9mA7yUzkxL4xRSciB8MH1PJmMjK7AcnkvDD+Rnt4CNl1Qs1IuPi6t7Xs8
         ishKituAjZjvunoZiKV17skgDAeQX+QFz4lhLL4hmg0FsbUM7NPXw1sf7buyEilNp6x+
         uEkolCMlGejrd78N8wAcu6LLcH52cL3ufktBZmwzh12Iucgz3WTqzFtyEjOhG/1d+pzd
         FB2piL7d1YasiICwGKPZZ9PhU83EFGICSX+4AnRTuo43zMeZQ/tpIoAv2U8hJAyQMvNt
         zrypNzRBR+hCNqdfv9LNLkN0O6y7HYBgg8BaBuDyJ7mAL6Q7owOMscSPiKukbCDzagmY
         bo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315192; x=1704919992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdLU/U7TSYkmEg20IDPG1xvAMQzbpbdvIaAXCBEqQ4o=;
        b=E5jKBcAmtYQdLQW7iZrqR+HjhOELVDm7kxgbfwslQG3YBnQ8QB9p9kINaKjDPunxNz
         jhPDPWlmKWFqSuydQ15tX4brgZAGNM43ozsc5o64vAcI7Ur6ekAVU5F4xNNGIOQIpo4e
         8OgKH8MJtiBlCuRgbMKroImPIlAN10jNCCWRVQ4cT8P+pE20B76taYxtdeTpal+c+5rv
         sHpnv6Af9JbD6Z1ffboOAF0SggDAjEPheU7T+5sTQY2ziDb8uj60cjoc7FCD/p0FRfBl
         woO5AbD41Mtk/WovD2oUzAQu+WzSVNhvYOzdTnJP3jAJFISXVQfMgmVDAhL0gFOeoseV
         uOew==
X-Gm-Message-State: AOJu0YzIWbrbrzeuM1hTq99akPUP0rJgvH6jqZ0hEFIb84S5hYS4lVOt
	S1aCGUzmu/Ray47wE7Tl4F8=
X-Google-Smtp-Source: AGHT+IFhXtslDqW3VNogcPWk2CedNHjbWf5n5N05FrZG2eZoZnnaT9sC1/euSV8v6JKmkXEkyWs6IA==
X-Received: by 2002:a17:903:2449:b0:1d4:bd3f:4d2e with SMTP id l9-20020a170903244900b001d4bd3f4d2emr9338233pls.0.1704315192430;
        Wed, 03 Jan 2024 12:53:12 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001d47d37d361sm13900434plr.154.2024.01.03.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:53:11 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] lib min_heap: Optimize number of calls to min_heapify()
Date: Thu,  4 Jan 2024 04:52:58 +0800
Message-Id: <20240103205259.2108410-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103205259.2108410-1-visitorckw@gmail.com>
References: <20240103205259.2108410-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the heap construction process by reducing unnecessary heapify
operations. Specifically, adjust the starting condition from n / 2 to
n / 2 - 1 in the loop that iterates over all non-leaf elements.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 44077837385f..18a581310eb3 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -70,7 +70,7 @@ void min_heapify_all(struct min_heap *heap,
 {
 	int i;
 
-	for (i = heap->nr / 2; i >= 0; i--)
+	for (i = heap->nr / 2 - 1; i >= 0; i--)
 		min_heapify(heap, i, func);
 }
 
-- 
2.25.1


