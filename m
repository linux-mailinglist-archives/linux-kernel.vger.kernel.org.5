Return-Path: <linux-kernel+bounces-15972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD90823679
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD74B2852A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A821D55F;
	Wed,  3 Jan 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NBk189ic"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261B1D522
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3eb299e2eso52717895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313324; x=1704918124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLVjvsKzWbuu1Tn6vfa7DAnWzdMErwoBxrG3TwM6ilc=;
        b=NBk189icOCbpjEiyIHfGUJaUW2XTJ7RuibADJ2XFiRXBXMJ75ORsfQWil8q13vlI9I
         0Mrxg1/oAolHp5QCv3RNgjRPbNzNxVwU8tGaucOOnjcrQ+ds5QC8CaJmfgnAhI7Wmqkl
         5me2OFIYC050i4/7ySoGGNKcrW1bINZm55c1t1BzRjat2z37/EMyR3mwVe9Zb0NPfTU+
         NUx0gCPLWEHDe5AHdhm+YHl1ADcdYDTnD/0W7LyqONYxiVwxZ7NaJuqXeWubB5C3KGR8
         0GJIQN08NCMHxzk7QZneELB1lvdMd/7VMmeHm/MYHPS5IxJcPdaK3GDrJr04uPMaxKUw
         1j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313324; x=1704918124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLVjvsKzWbuu1Tn6vfa7DAnWzdMErwoBxrG3TwM6ilc=;
        b=cYrkOg2wcmusn0rD3IgsM5v3qRB/4nD3drB8LMrqZNJ9o5+dsRn+wHVhPhq38RonQt
         e6wsn1VN7ogizMDS95/BHLIdD/UT9GA/gvxn642ybSVONREPI8V3hUsCHJgTz37SEVs5
         FhZ+WLL7I+uz+VF+l8JequzFocdZjZngmURC70HsKCRSkSTrb+I5VxOEXSjsAPtCniE5
         mt6c8IM8rwlOEqu/FIsE14c6S3zWc65ydrtQNzm3V9yZpi1rztW/DTLMvC86HbrF/xRZ
         Ryv0LTPjwaY24IYNptnX90SvA6j2deZn1sM73SxujO4oE1XTpflJ3tl1rSosVfgskUb3
         T7pw==
X-Gm-Message-State: AOJu0YwI61Q/b6p0AnhihvpXwJD9m4yl4R+Eu2o4IQSaQJwGcNnnkJFl
	Jl9AqAgFq0ZJhKJ/qOxfhSojw7OZ6jNqvQ==
X-Google-Smtp-Source: AGHT+IHTSHatXOKK2rJLaTQuI7ebBUzqUQe4BzYMpC03oBwA/JUbZVZY+uhrsIRUZgibxJ4Y3J1btw==
X-Received: by 2002:a17:902:e544:b0:1d2:fa24:2266 with SMTP id n4-20020a170902e54400b001d2fa242266mr10957069plf.6.1704313324207;
        Wed, 03 Jan 2024 12:22:04 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3fa5acf71sm24278739plh.12.2024.01.03.12.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:22:03 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 03 Jan 2024 12:22:00 -0800
Subject: [PATCH v2 1/4] riscv: Fix module loading free order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-module_loading_fix-v2-1-292b160552c9@rivosinc.com>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
In-Reply-To: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313322; l=1064;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ChQMN8HXWHXJl0z5+9ukmO+5sTC3VuwHdA0xAgdz31A=;
 b=eGXoLh3RaVKJ+iWJ01D8+xrpOG2nvatttc/x3QBl+mQVjpXaGPIZMjUPquFofeleKnCdAjlgc
 stOmeal7/ylCU+9I0MA0q1qU3cXe7vaOsm6yfJVVzZ1gEdWsFVIIwEn
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Reverse order of kfree calls to resolve use-after-free error.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202312132019.iYGTwW0L-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202312120044.wTI1Uyaa-lkp@intel.com/
---
 arch/riscv/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index aac019ed63b1..21c7a773a8ef 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -723,8 +723,8 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 
 			if (!bucket) {
 				kfree(entry);
-				kfree(rel_head);
 				kfree(rel_head->rel_entry);
+				kfree(rel_head);
 				return -ENOMEM;
 			}
 

-- 
2.43.0


