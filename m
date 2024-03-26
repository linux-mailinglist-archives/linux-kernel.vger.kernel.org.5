Return-Path: <linux-kernel+bounces-119712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9B88CC51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2521A1F846AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904B13CC5A;
	Tue, 26 Mar 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB8V3YYh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BC13CC57
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478855; cv=none; b=AJk0pmAwmEBz0PxA5Y8PaA/jRsHXu6nb4fJewNXYXJGVzehaUzeH3DelO716y6bTNQmpbGbpba9LzOcWfiDryNOO7mBgvumRYMAXhdU+S1tqMD6Ow86AMuyryaGJFhTNjpX+cMp5GEAOE2BKmkSittaC1FKaUz7P10VUm0w11/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478855; c=relaxed/simple;
	bh=2t+HSzUts0lI6uWkIeviONst3D9MJ2COv0YlBAQl66Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUuNMB3yPUmXIA/lnjJM0cIuv3uXfbFvXLlES7pfhVZU00nRv9MElASXcqUTCIxycRhZ07LAkxu6PoSu94uQlLFvRvtsg1WVfkjuraKai5G+RZKFPVheFkofuXp5k0H+nDKGcanFXa0NF658vxYJ6z1HVSK2f5j0OWJDtccWrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB8V3YYh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5157af37806so7003819e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478851; x=1712083651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nhxx724yaPCU1qTaAWx0rFWTQnMWYRyaiWZKelBeQM=;
        b=EB8V3YYhzYj+6n924K4ERBgZNrhzY2HIHFTtXwEPZh4sOcNAwVEQrsn6ZklD8v1N1N
         NvTsKRcDLDj1FG20rIf3SOY3lsrEWgAxBpq6swL+BbzKRunwySoIVNw6FehhBXMDMrMj
         W4TfY+m7WubF+EvvZURkxbb5Y7ZFpNIQlXddRfjQ9VaVsd5giAP8StXfWh52GaNKfnX4
         KY8tiw4EjTHAej1uZvRN4odLiuJ3InlWJfmaUxlOZQfZCXUeUdLEoTONIgZj9mOMhVEX
         s55X2e4PGizL4YfMlJskDLlCT74Cx+xZzx8WpaFJL1eEVtwKB1Qm1BdGSXrnF+u+GewI
         DEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478851; x=1712083651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nhxx724yaPCU1qTaAWx0rFWTQnMWYRyaiWZKelBeQM=;
        b=dmsTCtGc8nqpVEklX+JmqQ6wRwDsImkEH/QaP7AeA5F8DnwL24TKqibYQi6Qydte0i
         0x1HRysYTJgJ41ciRJBF/LvVO0j9obKCVhvj8DF4+w+cfRTdVauDDB4lz0BgLnXlu0xE
         Jt6qvT3J7DM5RqPdp4h9rIKpIVbQW0Vw4UISVMoeOOuhXBqFqrqslSuGiJoHc11pgmmY
         sbJoCu2oB14/oP9R6JqtjuGGRezcMmRByWymEQ0R9sflHoi6Ph6Ws9kR4LBUuH/pkJn2
         6vzVOfnpZmUmftgchXoDUCdKWJ6aofKKynsj7OQpyZpiJMVCG6ckAMQb/dRV2id5qmda
         kjvA==
X-Gm-Message-State: AOJu0Yy3pL05xkBzJoojMIPNwpwWKXQ198TgwFZ7FtRfhw0EILdPPS48
	mjjoDBp1w7WFiOGHwBU69FnZ1wRn83KXKVHa4d+ujAg8dGOtJn9fPg7US6iq
X-Google-Smtp-Source: AGHT+IEUiTuE7u76o63pf4XH4Aj5Sk7oCIXNDwZwyz5yefVdtlv3zt9t7+rwk3K6KVq/fbKy8pjXwA==
X-Received: by 2002:a19:e05e:0:b0:513:cd70:8d90 with SMTP id g30-20020a19e05e000000b00513cd708d90mr2526296lfj.42.1711478850869;
        Tue, 26 Mar 2024 11:47:30 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id v12-20020ac258ec000000b00515bbc2feedsm115718lfo.102.2024.03.26.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:47:30 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 8/8] kernel: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:47:27 +0300
Message-Id: <20240326184727.8858-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/latencytop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 781249098cb6..08fe9ce35ec3 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -261,7 +261,7 @@ static int lstats_show(struct seq_file *m, void *v)
 
 				seq_printf(m, " %ps", (void *)bt);
 			}
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 	return 0;
-- 
2.39.2


