Return-Path: <linux-kernel+bounces-126382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79A893657
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 00:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F9F1C20E18
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC81487C7;
	Sun, 31 Mar 2024 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="wFZ2urCp"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8C14532A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711923803; cv=none; b=RByfRAQKa1RUL/YY9NlPxj5ETJnSO952MqFw3V0Mix3vqHqNhzeD4jUocX85kmV9IvPiUGHO7Q9SzaK1cpsuvDtFKFXaoD14YXK1Mh2Z+2fNhRDpfoAfXoF9j9mhwtStl8VZ6BdpLo+q7qcTjjIt4+l7JlU8TWFz1N+5tT4IUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711923803; c=relaxed/simple;
	bh=on18O1z9+PUQlNoQwy6HRhqwRS0ZvFG4O79YPQO9v8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6LmCIozKEnfZ83FjHE+9dXRNbDH6GfwQAK4lRfp+xmAIoqMix9Ii7AXwnpB/N3cOLbO7FuDzToCDdHZ4w5wQQqYyY4oKP4PKKOVPFC4CvjO785jptMJpbvYn5BmUW3rTQwF1V1nDRpuHQQHFMROJXnkz/IFcV3ssI74imo9iq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=wFZ2urCp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e65dec03eso57681266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711923800; x=1712528600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKPH+CLwGsJH9bz8FRiNgEaC+n8LNksILCOtIEZn2HY=;
        b=wFZ2urCp38KJ2QkNudSLglPrjAZ02QvdHAtaLoPYySUJwvVahV4cnYFJPXD1GyndwQ
         A2z9qo4tjNh+WorMy7rahs2EUPVJ6ZO95Uie2gdUJ+hmseTycgr4TmPtip/qzwWuJIHy
         eq4xKib2po91DlPGNfgPue2iCe5ktJygiEmVMFeB3Afsu+BJUhk4uCkE/c8ksrSYJ+q9
         2HMDYzOEehrisTN9RsMbGxkGkx58zAy20zI9b6tqvIBmTNWiueluNhez0WHAF951gqMA
         vISgh0EYpZUigxtjmTvmJZQ55XoZP5J5QlC2MSQE7zPSNYi26tjm2o9Tc5CPLWUdZfFJ
         5ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711923800; x=1712528600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKPH+CLwGsJH9bz8FRiNgEaC+n8LNksILCOtIEZn2HY=;
        b=vnLGyqHSZUZih4cGO15v6gz2u9DlQKqLWWGZctxZMTq2Ij2xiafWM9bxOQ4+b/jmhX
         hURJpj3UDIC4bffk2Prz6+Rh5DhIC34LR1BSkWuHC5HGrJ4XPwkBD2pdzBq/JrzHscP1
         TVgVpHUgyJpuwjmsds3crMx9pKswnPMN8eeeN1RnFHovjX78PWPNxAMSsKxh0Xu5W2KZ
         qSzmlZYjpF+fnmclnx1Mjy0veefWWd5G4QTWp9Wj5esgWZ/tSkjE91JaehfMSCNhbH2A
         Wy8o9yBn65yTlPlAeMc9FOA+vVASYwqLK60olQx7HQzLhDT8nSJCyOiee4o2T7nxZSZ7
         tIQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ni3r8rtFB+4r9B5I3VfccdrDxjRafB7xkWJXIcH+yQU+Ey5D3RHYJPw2LZX8xHegqxuGtLIenM5TyC5RI1sphc6Itin0Tw8RehBO
X-Gm-Message-State: AOJu0Yx4dNWbhg8qMVoNf/rE0cAWE6xNVmXKDN+x+ktVK2LYj6I77AM3
	uaH9lYtPD87D73kIq5eMhDZ8zbn3mQc4zp+SorCnT6+tQ+/IlmzajrTaMgLsAUA=
X-Google-Smtp-Source: AGHT+IHPfg6yS1tcXFsGv8kKdk85BHF7ZxtGqSA9n3HWWN8GQVYrb/JPaBBAFDt2iJayUc54A1rx4g==
X-Received: by 2002:a17:906:3644:b0:a4e:d5d:8fd6 with SMTP id r4-20020a170906364400b00a4e0d5d8fd6mr4645709ejb.60.1711923799952;
        Sun, 31 Mar 2024 15:23:19 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id kf16-20020a17090776d000b00a46bf6d890bsm4664137ejc.91.2024.03.31.15.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 15:23:19 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] powerpc: Use str_plural() to fix Coccinelle warning
Date: Mon,  1 Apr 2024 00:22:50 +0200
Message-ID: <20240331222249.107467-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(tpc)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 01ed1263e1a9..4bd2f87616ba 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -405,7 +405,7 @@ static void __init cpu_init_thread_core_maps(int tpc)
 		cpumask_set_cpu(i, &threads_core_mask);
 
 	printk(KERN_INFO "CPU maps initialized for %d thread%s per core\n",
-	       tpc, tpc > 1 ? "s" : "");
+	       tpc, str_plural(tpc));
 	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
 }
 
-- 
2.44.0


