Return-Path: <linux-kernel+bounces-5567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FD818C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64767B23798
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE333714F;
	Tue, 19 Dec 2023 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKUPop6n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3437142
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso1496576b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703003671; x=1703608471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTbe0FFkiWpC+TW0jPOJbtW/DMOk6SlTqa5fmcQzYNc=;
        b=AKUPop6nE+15DM/I0uEQApQ6zpzF0Ufda4NZ9rQI7ZiiN2vf6qpLGnHF+LVgwh+vWV
         TrpyjahuyscLMo7kK07Js1GwWuZFLs+wZyZK/KGuybj1kxoA7drgttISmEZZlVsZvFRq
         poGv04RJMQTD4yTWWPd4oZoRrnH0WbF339HIHQZsEDzS/xlf9cscQxfFLsY1lNUDpihk
         4Iuq2MtLbMMXvtvpUkA0x3gbKtrnfb2qQT+ZsPlR2k56eJ3rqC15BaQu1I6INAGqHLnw
         dxwFwZDnvNN9r3Jjipr4kTzSp0TbTNCoGoDpkzXcFJ8QTDczlzPDEOEYBWcOSRX/EaSN
         vhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703003671; x=1703608471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTbe0FFkiWpC+TW0jPOJbtW/DMOk6SlTqa5fmcQzYNc=;
        b=IfqI/w7JDSStX0ZLRoYpZwcTTGp/8BUq7DAJYg1dtMYb3F5eRzbswiOdBTcDpCR3/K
         4VDVj5+KmfR2JIJy/AvO5+M3oFpD/0UeFCQZ00gJ0iBONKyKxFpMQl3ig4PpeT+TEoGD
         YSbRRx674s1om/1gPKIyzUaH1qOdbngtv+Ds7NXMsc0FINebanp+hjhgfaxw0LQFAYh0
         GVjW+7diGsQ5ws58UN2KB7f9k9cnq/G5oCeKIZZFQjp69bWQklqtCp+Wo9NM59G6DWMd
         MkSRbNTbl2i2f5N2iaHuksDZhziR87HCW9Shbcuu3mm31g/Sz+7HZll4wsbKvp9qbfPS
         MdTw==
X-Gm-Message-State: AOJu0Yw2lLkT0HsneSnbHUpuZEe/yTqXT5wDqkvDRSTOK6APqq89rAOO
	2+A2oOs73deLqDviN6ajVr64khk+Ars=
X-Google-Smtp-Source: AGHT+IFby3sDY/fW2pan071Ch5YMA1tZy5GS/12pC3aFAT/8648QVZ7U1Wryd5SoCYIo2/SN0J3ttg==
X-Received: by 2002:a05:6a20:9149:b0:18c:a9d3:4f96 with SMTP id x9-20020a056a20914900b0018ca9d34f96mr10624117pzc.32.1703003671264;
        Tue, 19 Dec 2023 08:34:31 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00178900b006ce789d8022sm20232551pfg.59.2023.12.19.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:34:30 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH] crash_core: optimize crash_exclude_mem_range()
Date: Wed, 20 Dec 2023 00:34:18 +0800
Message-ID: <20231219163418.108591-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because memory ranges in mem->ranges are stored in ascending order, when we
detect `p_end < start`, we can break the for loop early, as the subsequent
memory ranges must also be outside the range we are looking for.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
Hi Andrew,

Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
crash_exclude_mem_range()" can be ignored, use this patch instead.

 kernel/crash_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9a219a918638..d425c4a106cd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (p_start > end || p_end < start)
+		if (p_start > end)
 			continue;
 
+		if (p_end < start)
+			break;
+
 		/* Truncate any area outside of range */
 		if (p_start < start)
 			p_start = start;
-- 
2.43.0


