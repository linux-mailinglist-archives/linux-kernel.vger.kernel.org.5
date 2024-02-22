Return-Path: <linux-kernel+bounces-77224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9E860253
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C7E1C262A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8686E5FB;
	Thu, 22 Feb 2024 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9e9J/eQ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48D548E4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628958; cv=none; b=Xm2bxfAbGLJTbZFjxVuEbAQk0uV+upP2AJbXBkpEkgCV/3bt12MWsnF/B2ho7G/6+hg4M2NUa12Mdkx+IEa1BmqPvfw902ULwGJ88MP0/7ynvstnYDkqd4tAjs3Y+lnqrqbzN+ixZEMhEjsqGklf9CCNGAz7sqkWylHr3dg8I3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628958; c=relaxed/simple;
	bh=WbHoUINdvI+/EfoRmUSXGRsEKi+kuIuXKJxB7X2GgEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EB6eVRXIy5ZJOA/pYsePQsRfvgAJfMZXdQqJMVD3mofa8Agm2Kh/PNU35MSTVIf3dEuLljCk7wpWUfRsezhO9Io/8QnBTTEeRPJPrUwkg2j8nhtByUBc76Xbe0t+4I5Y7VIdy7ZfFpLaquPyaTn0IPnd7CWGhxgNu6E3IsCq4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9e9J/eQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so32864276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628955; x=1709233755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUYsRE8+tSPKyWViBth/a0r1Ckkz1G0ugYjkWT2KW0I=;
        b=S9e9J/eQcigEc8zHdVHcndZCj2dXG8BLaBrgtI089iuuba1qzciO+DxUWOnwWjGP4H
         CPnQHsETzRUF1Y5nyrCZsSBF19w+iXOBJ9Rfhy7ZYmqjPDIJt68OhE2v3Y+2Ze7enBST
         GjrCL8zanmljR5YFgeBaHiTfiYhOQbBlQVCR4fjFgpch9CbokHtFMk0xh8dk5XN2UM63
         A0HxYTnj4H5lyIF/G0ZV4r5KkGPv6efvuCm4QeElg5wIl64fj3VK7uUh06TuBHFVurCe
         EOS6G6e/RJbHWDEg1Ltzr3WdC3jpG8inu4LPhkLPwv7qtcIU0Iy45f0x9K/yiswnLuXZ
         rufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628955; x=1709233755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUYsRE8+tSPKyWViBth/a0r1Ckkz1G0ugYjkWT2KW0I=;
        b=JHo0Ju57skc7B0kVQhCOD9VvZcfLSV1qS9SC3kKA3rEnXDtf5srV7rxVg6mKcN3hds
         lXIjIKlW5/PPPueOPsGO1ZJdoRBmg6tDfoCs0ueKs3VmAZ9qVI6RA2IooyowD+Bj9tST
         wKFHx10trYoavO+5/zXgRd+cs0ZLbiPhJPxGCl1VYntlGrcXmp5Z0RJPS9U4bMDgKyt3
         1hXEJ0DwCYbGIEGeaAioDQpLuwk033h+W+UTFQTU4L84+yIFbCj9Tfmi4mJsRVrPHb8p
         DT67WpYrYDSpDvd88iyYmHsUJJv7/n9U31HFH+no03MY1u92jO7ke77QDfFzrbzKvW3z
         5W/w==
X-Forwarded-Encrypted: i=1; AJvYcCXHqL01D33o3gYACh0puTSwLwPtBqxBRe2R62zTuzz7Sw1TDy2eOG011ogq3XiBBFQn91kwPwDcfJGYlwY/viWDBkgsAViq9I+wWjx6
X-Gm-Message-State: AOJu0Ywa7c9nl59wS77I/dhAYEC9r17XLlRWVr1KnNuXXN94Umv8A1Tj
	GIityoy2zDQKAf0CoiK6X4xZlSsk0C5EnddMRtyWIKYD5SCsdP2IjH0EIrHBh1Jzqa6JIBH/AP0
	gPlvQvn1v5lOvZUf0EQ==
X-Google-Smtp-Source: AGHT+IGNUOZEq4h2q64sDVSpAxoKqvTsDClH9Jr8J8zrGhX1hRnuFcUuoek/5uwALBgmzAO3wKmtgeHhgPdv5I2J
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:abd0:0:b0:dc6:cafd:dce5 with SMTP
 id v74-20020a25abd0000000b00dc6cafddce5mr6172ybi.12.1708628955435; Thu, 22
 Feb 2024 11:09:15 -0800 (PST)
Date: Thu, 22 Feb 2024 19:09:11 +0000
In-Reply-To: <20240222190911.1903054-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222190911.1903054-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222190911.1903054-2-yosryahmed@google.com>
Subject: [PATCH mm-stable 2/2] x86/mm: always pass NULL as the first argument
 of switch_mm_irqs_off()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The first argument of switch_mm_irqs_off() is unused by the x86
implementation. Make sure that x86 code never passes a non-NULL value to
make this clear. Update the only non violating caller, switch_mm().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b67545baf6973..51f9f56941058 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -327,7 +327,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	unsigned long flags;
 
 	local_irq_save(flags);
-	switch_mm_irqs_off(prev, next, tsk);
+	switch_mm_irqs_off(NULL, next, tsk);
 	local_irq_restore(flags);
 }
 
-- 
2.44.0.rc1.240.g4c46232300-goog


