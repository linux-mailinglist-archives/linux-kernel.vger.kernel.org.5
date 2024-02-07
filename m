Return-Path: <linux-kernel+bounces-56384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECB84C989
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C072F28AE6F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67CE1AAD3;
	Wed,  7 Feb 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuIGlB2b"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355F1D524;
	Wed,  7 Feb 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304933; cv=none; b=LTdKR1uy3b7l/lnPBqkLxQZbWibdQK3d4OlnnliyjdTUnHAp2448K6GPA339MGugceJgNiGP3HetCt+hXKcEMVhoqO0r+Ivp1gtmVVjPGYHaLkQtKN1bCscUM5bOiOBSQAvYKHIm8h89u9ACoP2vYB7de8UFAnVZeBra9SLlplc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304933; c=relaxed/simple;
	bh=lAFsxsdIlZPft8hnkICfi8w8bgkb6/ZUkvhhdX71gHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ktGD2/9I6B37FEa0UwkwCJH6Ax0S16ZrrrO2fdxVwIfUa+q3XceKpDsUsm1gQeykhP9w3tZLQP9UntSw9RZyYOLaRVxbMa1T6w4nC7nHCkwVUEQoCuBdGRc3L645gswMM23uhsEq173daMcs7C3DQfjNbzYERvD/dtb34NiWj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuIGlB2b; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so450309f8f.0;
        Wed, 07 Feb 2024 03:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304929; x=1707909729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fe6SZmmP/zqXcfKDaAFGsJGopV6aAaohrfdr91yiNs0=;
        b=ZuIGlB2bBkYvDbsImnw9WwowvZTdCarqxr5NOJTBiEYTewWZakWSH5MLOrJImsFIop
         rnk/l2EilFR+INRm6/0MS8cYHVbS8PM1mvP/F2slh408aI4+IsDefpPqN7rgWha+VRBz
         y2w7DOHPVBO73xkphkukdBS257/C0BsdPVAOpthy9QEn5NCiNGrNQSNPxFEHFWrjoWkY
         RIIZOjc+dc0fBVS8H4ncQf2+5e1QqJCKQUXCZVnXcFzI1b3Zn6pkXfP7WEIREwrTPxJO
         wA0mVI9IPCmYgCpy6PBPiL0IUjlUCWvo7Zn+nvWo1Z9SJ2n82HL07VVvyo4DgXnWdT6D
         6z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304929; x=1707909729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe6SZmmP/zqXcfKDaAFGsJGopV6aAaohrfdr91yiNs0=;
        b=h0ThpZfnKWo50c/qESVotuzRHlWf0Ie4iTi/zi6uUpsWYWy1WaDSBbjH1y6Kyv4Vug
         bEQ950dOn4TNMjMHUo3tcj9GH11MjpAeYWyL522toa4eGO+pxSaQnllpRlN0piuF7etu
         WCaFVzIZjZirviCibmoQT3TdlfDaGO6zek6SJJ6wwBrR8Hf2QnCZg9gXChqIChi1JnKG
         hpmGOUUJ/XQ4kEQWxBYtpQlDpNf4WiBJsPT8wkEvkTruAiPVWEekKmnq9bAs+/tRuHG0
         fbFczlQVskXonkiS4QqtIRtxGxU9bhP/TBXGaX7R9X/kydK5jym1yrezfSN24jdc5QTc
         tGsQ==
X-Gm-Message-State: AOJu0YyYB8sHm46SGOJJPD1cY25LnUZXIqGvUI7ZdttqnES4eUBXnsLT
	ItaKZkUC2GHFVrVEEv5i4PXOwHf+X4jDJBcDpaCRgFC5yeMpdcj5yCUzNtNbveg=
X-Google-Smtp-Source: AGHT+IGGPHCdSSr6e5ViKiCcz9bcuOkY7ZgebIUX/gxAFauciZn4jxk+qyvNU6k4pEfYGd8snIM0JA==
X-Received: by 2002:adf:b1c3:0:b0:33b:279a:5cb1 with SMTP id r3-20020adfb1c3000000b0033b279a5cb1mr3554011wra.11.1707304929441;
        Wed, 07 Feb 2024 03:22:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXid5VlkYlXypa1vZv6wwgKQJzGkoy1QHIVzTTa46oCuH2O6c7JisiUYKgsz8bhDDRGkqT28h2dW3Fg0dwGB9MjN9TaTua53IUbK0si/R2FE/owq+r9yFjATTpcHyZURbFa/5ODMsGVgSUqsaMUo7j0VAKO4fzgobxEl3WkxzunRpf+XawrgN70Upk7heW5iO9wzvJGuYUBQMMUY9sMMbWrbp7x4ecFxcddeVT7xZ/JlKuQdoB5Ys6UHUAzNRtfb7Mo
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d5601000000b0033b406bc689sm1262926wrv.75.2024.02.07.03.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:22:08 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: storage: freecom: Remove redundant assignment to variable offset
Date: Wed,  7 Feb 2024 11:22:08 +0000
Message-Id: <20240207112208.2443237-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable offset is being assigned a value that is not being read
afterwards, the assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/storage/freecom.c:537:2: warning: Value stored to 'offset'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/storage/freecom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
index 2b098b55c4cb..c3ce51c2dabd 100644
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -534,7 +534,6 @@ static void pdump(struct us_data *us, void *ibuffer, int length)
 	}
 	line[offset] = 0;
 	usb_stor_dbg(us, "%s\n", line);
-	offset = 0;
 }
 #endif
 
-- 
2.39.2


