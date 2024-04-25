Return-Path: <linux-kernel+bounces-158502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62B8B2155
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A710EB24674
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7212C477;
	Thu, 25 Apr 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOzBsD2J"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C612BF1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046677; cv=none; b=mnnY1oQ3H1cjShfcnWazZZ4mHkBAHuryhaX7aiFkItYMJZlSKdJ34vmfP99g/6+dKdZWXIXUUpR5WI0QoVyJGskpy+TYlCKkIiczrarxJaMMzGSGKs9RFd+eUpbtMYULlZEZ6aou4rmb4j9bDKpdqIbjm0HzX7XAmnyZtVDdpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046677; c=relaxed/simple;
	bh=LIxvUo8B52UW+FUtyckKlDOxVWs+4s1TDbE/HoKC42k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPyu/GzxmHdHGdq86asZ5UPlMnygwoWM+D4VsqXOvqc5vpnNNMkirbWJ3f+/av1hPqfjCxz1sEfNSoAszXYYhCLVCf1ccMmniB3yYJNwGeHFy3m5+hX5SPHeUB1CDbmDoJHEbMMjgSuckyohxzJhofryXOe9YX1w+elopZEWKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOzBsD2J; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-345c686ba9bso549171f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714046674; x=1714651474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sbCECdJGjeZfGqEfdofY2INvouE2vkCUF5Dyf7luaA=;
        b=FOzBsD2JCPirsRTJhXM3rj5GafOMYDRXFDyfGzDVQ5GiwQfiKJuw7S9BG3IxQnoT6b
         8hJgbnRtSmuWffhhrWyIu01dnQ2MqoU0GSfyVWJPx7KRXoBAQq6L3Tkthh6zKNCWLFrJ
         lw3pn0pF7/4vny8dnKlYBRxWEutHGpvvhgUTCDTL+VXby2rpI7yBq6DkMcHoHbcG2yhm
         UpnpGGkq3FLPGcK2eUtiPXG6FHqudFD4yuT9YnmnCkZjwpRdIBgi7dGktmTLN2IpaQEi
         Tk/Q4cEtVo+T2e8xdwP1LEz6H4Ln0aJrDRWrYY7PDF+avznnyTXSStjhtpZfHu3MDVFu
         R9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046674; x=1714651474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sbCECdJGjeZfGqEfdofY2INvouE2vkCUF5Dyf7luaA=;
        b=RGBw7n/TLsoVzkKnUVh7twKxayeX4cDmKMXKUp7nmsZpa2YZGaE0Ub/YZmPhe4+X+x
         3ptb1/Uha80FIA90okdREp5KYUnMWAewrcgYSJNs+ZcH6hlFh6dMCe7FU9C5H1GwkEat
         G1a5zcQpvjUd90PULxWxg7jhcOWuvSgiGYjX8+UFhiaMdj5+G8Ho8KFyNTerpWT+tUl6
         YCp7uDo5VkzJNTUV1UBWgPAc5Ttm9m2t6MBa4RKTigfb6F3v0eJfmn4hRrxiQsOWbCXy
         Q1p4WI7KWp04v0WUZHD574mIn2ol5xKRrhszulXzHl6t2h1myzNsqRMsT+LpMrbZMBWV
         e/Og==
X-Gm-Message-State: AOJu0YxiUvkuuDn6EW+7Pn/jW9XdYQldQZzEKI1c/BgzSY/AMlJnowBD
	C+jXNwMdDMIHxLwn74vXzh2wss5cIzO7GCLLyT2wa3s3JHnbhr/lguUDuLuVM9MkMJGiIL7txB+
	zNfry72pBMbMX0IqLfpxVAuOOLjWn5ueUp/POpK6N3nZN9DdEBS+Ub4zP5tpT53eaeMKo5YTkgw
	BfqA+m5aJRSkHm1DmwUKCvNnV7b0gN4Q==
X-Google-Smtp-Source: AGHT+IEifglC5aNUwqI5yhOdJHBnVeUq3+nUuLwStermb7SBFhtGBttpJxDDl8ZWkxM+c5lqjtV9mwiu
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fd06:0:b0:346:ac36:9e49 with SMTP id
 e6-20020adffd06000000b00346ac369e49mr14189wrr.12.1714046674007; Thu, 25 Apr
 2024 05:04:34 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:04:19 +0200
In-Reply-To: <20240425120416.2041037-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425120416.2041037-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=ardb@kernel.org;
 h=from:subject; bh=vkA+u9LN7+M2HsoLmktuyPNgmAZxryq/utHLnCKXETs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3L7fDdjRGzjs/xenpzblFClb7+3HWPv+1j4K4TvVhfG
 mxl3jaho5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEUZyR4ePZHztUzHzkKqtj
 dxT+vnFis85zw9PC33h+rl1/JUi0+Cgjw7K20p2pTcd82n478SydK8fM/6WF4a6bcs5tqyBjj8y nbAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425120416.2041037-8-ardb+git@google.com>
Subject: [PATCH v2 2/4] x86/xen/pvh: Move startup code into .ref.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The Xen PVH startup code does not need to live in .head.text, given that
its entry point is not at a fixed offset, and is communicated to the
host/VMM via an ELF note.

So move it out of .head.text into another code section. To avoid
spurious warnings about references to .init code, move it into .ref.text
rather than .text. (Note that the ELF note itself is not .init and so
moving this code into .init.text would result in warnings as well)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..0cf6008e834b 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -20,7 +20,7 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
-	__HEAD
+	__REF
 
 /*
  * Entry point for PVH guests.
-- 
2.44.0.769.g3c40516874-goog


