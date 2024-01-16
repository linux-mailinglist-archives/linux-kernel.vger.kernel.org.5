Return-Path: <linux-kernel+bounces-27261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D443982ECE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738321F23E95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A006175A0;
	Tue, 16 Jan 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myp1Ce+T"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D717587;
	Tue, 16 Jan 2024 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso110309891fa.0;
        Tue, 16 Jan 2024 02:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705401784; x=1706006584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfb4RoudfQugFRmfeMeDSM2YfXd1GIbwx2udaC5gOPk=;
        b=Myp1Ce+Tr2LgOmQf5YGHUy8fDzbwmDwl4iKT+y9gzvmhf1E3F0vLjtfY/lGK21SvlV
         JJxEethfTO/HRsKbLujsIwGNbWFEYEKvtPQY6mXiraBHDKQyf1GCeNt2dW8SQFvEbV4w
         60B3NlQt9xQAtbXFA8q9PIOPYwvbQ7Kp+nn3RRzn730bZCFOrtQitPdv8nocvge4t0Jb
         DXJ6wT462nXbcbr+9Y7jKKV6CBxM2ky77eW1yLyv35EJ8DVdHv/IlJZyC2opKjDs/kSN
         LS0w5noem3RoV9I0liObdu21BZofiP3nn6D6hPjHT4He5H+ntGSv1EAagdNtFOIBxCtm
         G7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401784; x=1706006584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfb4RoudfQugFRmfeMeDSM2YfXd1GIbwx2udaC5gOPk=;
        b=VyCZv+h5LIzY6fnvXcv05Zb1s8L0m24lf4TdTveN3TGtWcFBn2oHQJlkSd0kA8rh9Y
         7ZNa6Yry3MG/QFQv9SYp7/yQr8R85t1UaAMN3GIsOR1ispZCvFvUR7xaHuTprDpzAyzT
         x7Yr65IKRFvSToSJ6XSs4u6BmKa9L/rW7+Map5bw0dLFyoV01w6RlfDOozKmZmXASyh3
         ojlxz9LyH711fL5XUsXCotKYlUl/wNJiNisRYxmSgyxsO3FUs0xJq6qnrc0musztAHyX
         iWZT4tKVYnIGkr+1RatYN8IUfgUYtHsb3vdGOZm8HCZcdsrjwSC7AioKhun5xPKJx95O
         llwg==
X-Gm-Message-State: AOJu0YxRUY8/3nDdakA/K/D/H7Ot4Kb/8WaMb2vlpyxM8IAWHJvcJICS
	sE7aWG1a8y4hk99JwUn+65o=
X-Google-Smtp-Source: AGHT+IHowwn5ZThXbNkBYKcVPqiC7oLj8hR9b21xtUg5ndnPAylsxeJvvpFnrfWbZk/Uk6g5kL/wwQ==
X-Received: by 2002:a2e:8481:0:b0:2cd:7ac4:f9b5 with SMTP id b1-20020a2e8481000000b002cd7ac4f9b5mr3207747ljh.14.1705401783529;
        Tue, 16 Jan 2024 02:43:03 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g8-20020adff408000000b00337bf461385sm79894wro.26.2024.01.16.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 02:43:03 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: pcbc: remove redundant assignment to nbytes
Date: Tue, 16 Jan 2024 10:43:02 +0000
Message-Id: <20240116104302.2241325-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The assignment to nbytes is redundant, the while loop needs
to just refer to the value in walk.nbytes and the value of
nbytes is being re-assigned inside the loop on both paths
of the following if-statement.  Remove redundant assignment.

Cleans up clang scan build warning:
warning: Although the value stored to 'nbytes' is used in
the enclosing expression, the value is never actually read
from 'nbytes' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 crypto/pcbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/pcbc.c b/crypto/pcbc.c
index 7030f59e46b6..ab469ba50c13 100644
--- a/crypto/pcbc.c
+++ b/crypto/pcbc.c
@@ -71,7 +71,7 @@ static int crypto_pcbc_encrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		if (walk.src.virt.addr == walk.dst.virt.addr)
 			nbytes = crypto_pcbc_encrypt_inplace(req, &walk,
 							     cipher);
@@ -138,7 +138,7 @@ static int crypto_pcbc_decrypt(struct skcipher_request *req)
 
 	err = skcipher_walk_virt(&walk, req, false);
 
-	while ((nbytes = walk.nbytes)) {
+	while (walk.nbytes) {
 		if (walk.src.virt.addr == walk.dst.virt.addr)
 			nbytes = crypto_pcbc_decrypt_inplace(req, &walk,
 							     cipher);
-- 
2.39.2


