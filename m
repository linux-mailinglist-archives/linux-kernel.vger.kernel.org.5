Return-Path: <linux-kernel+bounces-17177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DE824934
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C151F2497A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF562C6BD;
	Thu,  4 Jan 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="scGTid8T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126132C694
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35fff22678eso2957615ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704397376; x=1705002176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLVjvsKzWbuu1Tn6vfa7DAnWzdMErwoBxrG3TwM6ilc=;
        b=scGTid8TC9aU85cSvQWjhr6iMX92QpCxJd5CcTAEise3S4nqV7VS3tV1S8XsEC5LHf
         9Ykh9FF3W3gD4HQA+1mFenYHP8ttY8i70H8IJEUIxubTCq5F1HN+yx2u7PP15ziLiG3N
         DCqfO1aB4uEU8tTZTBRcXKRBNSvqQkjfA2bfiXoW10vMpLlzL73Hny8YjBgWS4z2ABs1
         5IfUU34xU8UAtkQLuQqiUe/MHnznUiY4JDPd6jkoDx4Edkl3M2m5PoS8v+SQpzSC0EkM
         ymmNFblI7ZH8gvvquStOyiYr6HH1rIFposkHIq8jlwjXWZC8shPNpmjNraRfpTa/YN2N
         w1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397376; x=1705002176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLVjvsKzWbuu1Tn6vfa7DAnWzdMErwoBxrG3TwM6ilc=;
        b=vdjlQ9fjv8+iZ4I6miOxo9xKFL4PRSq1bNLF0MGYXss+lDgS/12/+5RBuHjxhdmzVW
         QGoQy+sfJDo86mD/1JveGgs+OXffD9SmGj5cwpasMbszGpY2ZmTNHKguP5MIWgMQoZ6N
         0h7y3G+FVxWQMQ+cGPUV9xsoqfRwzXMulYWVDfShs2V8SVmdMuviY0GzdmFAYrqWdO8I
         VYrqO+BngDV9ODZINOTh0T/RtxaqPt3gPMGl9KLY4tUudadrkTBfTBMzUoBzJhWGadjx
         s79LJUbDjnH2/P6cAj13AMM+2irVR+euZifzZ4xfzhZTAEMuCqLPoUp2lXEJLKrx7LR3
         dYiA==
X-Gm-Message-State: AOJu0YyN08mo4v+ZS+O8SiNKp0oOodIYaGfm4Uur+GQeDzNcgHTVWibH
	s7qAAU9+Ihl6VMJy/oUNNZRMIDjPTTn9Uw==
X-Google-Smtp-Source: AGHT+IFm+qeZXnh4PvWyj6eeezVL805LTax37/sq68iQqd8SUNlSbsETWbuY1iXc3g3AU1sH94b8XA==
X-Received: by 2002:a05:6e02:1be9:b0:35f:e306:cc2d with SMTP id y9-20020a056e021be900b0035fe306cc2dmr1172109ilv.32.1704397376337;
        Thu, 04 Jan 2024 11:42:56 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o10-20020a92daca000000b0035d0da89a0asm19606ilq.6.2024.01.04.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:42:55 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 04 Jan 2024 11:42:47 -0800
Subject: [PATCH v3 1/3] riscv: Fix module loading free order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-module_loading_fix-v3-1-a71f8de6ce0f@rivosinc.com>
References: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
In-Reply-To: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704397374; l=1064;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ChQMN8HXWHXJl0z5+9ukmO+5sTC3VuwHdA0xAgdz31A=;
 b=Nc7YMdNtkiogT9SuSOwkwklZUSWSzuGSMVWI6Jj/7Ki7kHxfugbk8U/yTQtvOO8OlVcnpSpoY
 O5QMhR5H1UfAHoQ8EspkwAbM3BL/hJ40b6H9Oys/ELv92VYszOq6yck
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


