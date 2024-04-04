Return-Path: <linux-kernel+bounces-131307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17BC8985FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C61C236D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81B839F8;
	Thu,  4 Apr 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RMvN4s6u"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E28286B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229828; cv=none; b=e66sPbip4MLTQC3g9skvyC63ItSkb8ec7vM9IC8aOmobnOZ2VZHqE2sFonRqeMq4sgStububp8sYCKQxegU/W31ZJZoRZTU9tB6zs3AEBsNZEkxfapwRVypYPABWfw129SRUnp4aBcIcKRCt81tmSjxLSw2G+QChtsTUqCrN5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229828; c=relaxed/simple;
	bh=KedSSz3/IrCa1VpTRibBfxMxza6Zzrin2mfQ1u9MHtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XP84qdHx3XZN+i6Katb+GpgjDyl1fsXaQajW6v0hBrINzOsLui9Z9d3IyII3Xwa6BN74IlbTeXagZyGkG09Jh/oIDdqTn0mDsEva3szSz4NTns0UfEyln+nS4OZsfNLaBXGhIP41+LlRZ29t0EdzdOYSxZbEY/v2OdPP5d3GBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RMvN4s6u; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46a7208eedso125488566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712229825; x=1712834625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkYU619QNOAcumaNgRtOFKm08inQ9YEczozqDufhPwE=;
        b=RMvN4s6u/eGVLoA6ghv5c+8SE26TvwTwC89IipK9evb6MvNRO3UGbXpQ0ncxE3jAkK
         1yLAYUm+LmLyznpCo8mh1R4vG7dkIyAN/zZ9tFpTSQiX4HObYNEx/Gu2KvsK4HLBLb2a
         O+45dDbRDGGqz5f9/7Ntn2Z1Oo86Eo12WR+lNdmYU8kNdLvvHFb4XGTnCsJvMLTfrraK
         8/75r7Gku+IJor6Nh6ViQXBhVEB9yz2PUquMBcbdw/ewsSj+vBdIurlWEHTOFla7Q8pq
         tgl6JHzPJm3EWZYICLa3l8RBu1aIZ5a6oq7gF6D/lQo9l8lp1L1ACWSaEjLTx59hqTT2
         rPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229825; x=1712834625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkYU619QNOAcumaNgRtOFKm08inQ9YEczozqDufhPwE=;
        b=hxAX8W8+vmihueuHFoh68EeiFuzfCld3VzEMBz2w62V2iLmhZ/OQsqUMGZowNgt3N0
         jDmLpAIT1rvHFBxDUCZMG1SdF9T1QY5X+fI3RAF/eGNHWOpItJSA6P7H9+1cirVgHpJE
         hPEktcIP0n9bipwKKE0YqVPpdv48R8Fv7/c0UY7CFupOUf/XgUydGTtR3l7XBCrKOtLd
         A2GqO5tsieHvD5Msj6CABMmvXj95LH8yFxk6PzXCLHQ8FnBi3FW3hD+FR2VnPrkZvfmu
         LbvizCyLj3cby4mTOKLBYVqOfoFnzqLhOtc4+4g1XG+4bKFw+MxwXbqtWZ0thNSWvsLG
         eOeA==
X-Forwarded-Encrypted: i=1; AJvYcCWvRLewLLtbefLiW4nLeOWSWrAPrBELKPtzFhB7ypHxwMaOyRB55KRvr9JIkXM/IGE1ySe9EhKpdsw/bULmxujKUV1FptZRnuY00RGQ
X-Gm-Message-State: AOJu0YzWdNkC3r+Abda5flO/6S9y58EoWWS2AXcSddIEgJ0W0h1vOVCR
	88XwaWCWQIMKuwNE7oJvktlXZppN2nmpOkBdRIumO86ftTORlp5EZf4P7Q2NhQQ=
X-Google-Smtp-Source: AGHT+IFK8jr37Yvi1onGXTMfiS4hACEokH0HQITqdKdAKcYVNNcSynsV9ZUFQOqjrDeb97MoSUaPgQ==
X-Received: by 2002:a17:906:30d9:b0:a47:52ff:194d with SMTP id b25-20020a17090630d900b00a4752ff194dmr1338735ejb.35.1712229825255;
        Thu, 04 Apr 2024 04:23:45 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id os26-20020a170906af7a00b00a465b72a1f3sm8943302ejb.85.2024.04.04.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:23:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] sparc: Use swap() to fix Coccinelle warning
Date: Thu,  4 Apr 2024 13:23:14 +0200
Message-ID: <20240404112313.11898-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

	WARNING opportunity for swap()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/sparc/include/asm/floppy_64.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 6efeb24b0a92..83decacd0a2d 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -704,9 +704,7 @@ static unsigned long __init sun_floppy_init(void)
 			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
 			ns87303_modify(config, FCR, 0, FCR_LDE);
 
-			config = sun_floppy_types[0];
-			sun_floppy_types[0] = sun_floppy_types[1];
-			sun_floppy_types[1] = config;
+			swap(sun_floppy_types[0], sun_floppy_types[1]);
 
 			if (sun_pci_broken_drive != -1) {
 				sun_pci_broken_drive = 1 - sun_pci_broken_drive;
-- 
2.44.0


