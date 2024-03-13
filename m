Return-Path: <linux-kernel+bounces-101188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A787A3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39050282FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EDD18EC3;
	Wed, 13 Mar 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLzn+NN7"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E3171BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316754; cv=none; b=fnQzEi0d4ucyptR/06ZyXh6viOQI6GFA2HQGfi2KPHu/y2n0rYVptDZ+DSsRx+JVy2QycrONWDCXyVNZk/HGVUHfU8JCmhopL/0Y8yrGgMLUf5s7mvQdCh5h6IG64I/uT4OuOFvqz0wjywCIeULM/ZT5fORLr1O7HKYzuLD8Xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316754; c=relaxed/simple;
	bh=+7Ej2BP0k7ldBgKJOfpYGxX+nF0FFpOlIi7UHETUd/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qd+7F5GfsmHRxL1s9/uUrsJ9y4KQwmxeF7UogDdJ0N06nPU4auxn2EUk4hAetF60Xy6xz/glBA45qWOMLMeB5DrHJoVc/TAnknAOIifU7tHarDUsnwajStehy05GtNsrae90239WMsxc4Ksv7ThEGZkEUnma0Sl+oeKrcGw4R+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLzn+NN7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso861757a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316751; x=1710921551; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peeFPy/uEL81N+OBdVyMrTvmLjgutzLSp/Beb98+4eE=;
        b=fLzn+NN7xh1YzAeptWwWzXneDeAkSaz7QSoQld9JR4JhtEOFH/gGfEFfUz5lAgEIxb
         WSlgB3WpOy/o9Cbl2hB7EXF08u0WD6jS5qVQl7/K6+KqY2vcCDpdrTTBzUBqjANjM4ro
         G/9EKBtAlg0fm4W5GVmBzfRD3qU7eSlRifcLxTKfXSC5Fs9Kv0wKbacm5PtAeekXRVTt
         SJkfZf08dDaLU4lFwNuvshR1DME4izvSlhK7GDQHemGJnPUzsdWIaPwCmSvmzerawxX6
         /Dg9AZx1vYq4ZCTd7iPSMerucFtkrRVXCoFl+tXXtcBZ0e1ySkRct9S26f5YPuABjf4P
         JFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316751; x=1710921551;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peeFPy/uEL81N+OBdVyMrTvmLjgutzLSp/Beb98+4eE=;
        b=mUuT+4iJL60hDnU9IcBwMqIioKd6l816xRXyafylVN2/rFREq3Hwl06OqopiEMCzx+
         o0NxtxEE6fRb3PDKsDerQ+xwmfIcDjFU9g2uqid0UUh/Xewb5aWrJNEUSurt5595fXKa
         8JyCSvSLug08Hhza3s6fWAJLYIGqc9i/XQprQYUyRTpsq/iY1X/tLhZbFTBAVRRS5ulH
         rmiTl/pp4Gxsq/ttHCznBfjAPn9juDl6kNp9tG066+KyfwLFx0zCAL8eCjh3LWlGJlAp
         ijFEnxV6b6PE0H5n45O4n9vUJZm9+63/76PKUP5Sy7UI18IaEORZWtfB/LFR0wJM7dY+
         Sfuw==
X-Forwarded-Encrypted: i=1; AJvYcCVOnTlNWIn2tFUJB93k5HSZtNqegdyai3VbiwHAbvaeZKPQ7VkXEnYWwghJpn7gcjAdEMlsexxIyQPg8OeLbTefxXpjOr5ndCmvRhF2
X-Gm-Message-State: AOJu0Yx85OuvAYGCBDNDU87KYY5ttf+RTTgdsWZOh2021iaYQ9FFGpqw
	0kq5q5SBqqO0/C2nM9Knfx8XG2Xd51mkmSHnwwrc378pbbgMm11o
X-Google-Smtp-Source: AGHT+IFrI+F/1jOCLg/FBidF9lJM9Z26wDPAnBS207q+xEfJIIZ+RFNjFqulN/jPKtm4IqZTn1Gu6g==
X-Received: by 2002:a17:906:fb8a:b0:a46:55ad:cd2f with SMTP id lr10-20020a170906fb8a00b00a4655adcd2fmr751863ejb.23.1710316750735;
        Wed, 13 Mar 2024 00:59:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gt20-20020a1709072d9400b00a46025483c7sm4327037ejc.72.2024.03.13.00.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 00:59:09 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/4] vmlinux.lds.h: fix a typo in comment
Date: Wed, 13 Mar 2024 07:58:36 +0000
Message-Id: <20240313075839.8321-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240313075839.8321-1-richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

One extra 'i' is used.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61d673d..514d3002ad8a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -3,7 +3,7 @@
  * linker scripts.
  *
  * A minimal linker scripts has following content:
- * [This is a sample, architectures may have special requiriements]
+ * [This is a sample, architectures may have special requirements]
  *
  * OUTPUT_FORMAT(...)
  * OUTPUT_ARCH(...)
-- 
2.34.1


