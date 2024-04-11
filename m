Return-Path: <linux-kernel+bounces-141598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3059A8A2084
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7B2283F46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454ED2942D;
	Thu, 11 Apr 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ImPLbIuQ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0D25575
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868918; cv=none; b=YJpZjGKK59IE/j6IpXsocgJ6IwkNfHPrdPx3e8+Qvz29OL4eElCBt2Jh6Xzu/W0eUcjeNmWOIhOGTNIwXVDW+24YiFNGLz/BDpmx0lSF5hnUY35wAKCqdR5yJM9QZc6H+2YvYVKjAPj/j1z4FBpt9/J2+IKP8Gk4QJb32empYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868918; c=relaxed/simple;
	bh=k9VBLg1H9CzivP0CT3EcHbPvxlP9ags2QLYALoadN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evMucOcrw7Lx1EcbDnqRH1fU1mHcujA/vep4mMT/W4KLiJSbCtiWqmi2W6ssvi29Rr3hMFl4n5o9GWFyvVUv56QXvPlzPHv6Z877HxYcFFdJlliU3U7iy8EBeoLA8x2XYusPgPBhnVznedz9S5QUlip+2AvwEPoneB2znjiHnY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ImPLbIuQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51a1c8d931so24672266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712868915; x=1713473715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGeIUkWiU2G7D7Pkgh73ZiOzseLlkdctPoHzYVgSQ10=;
        b=ImPLbIuQ08Be1mWjv3m6YXNHZ479EJ0RQOI9iQj5a1TVbRcC4wp3NbLzS8wPorFB0M
         qki/z24xH8Obc03X5Z+2h3IDSZzRunAU+NeJ8Hlw+UyKHyGRtp1VgNnhWbTwfPMqQ0Xl
         vAs23ol/9iWsqkJF+Pm1Vafod6F+nRXx8IwkbglvDFR4EqTXnMT0GYZ5FPlCPSS/80X8
         PM8v+4FDK+tIKKO8zd7JKAEizwpseyEKI/1OQXhcyvPnaGgn/N2h34LBAhyr8KjBadAP
         /Q5J8qASFG+WunGUyJJiElC/p5hGxAWITkSJ664tyigaV/mHoQ31GlYUaB2M9QgFbw1h
         paHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868915; x=1713473715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGeIUkWiU2G7D7Pkgh73ZiOzseLlkdctPoHzYVgSQ10=;
        b=CL9rc+Z+MoHrsGQdbyY/4CBiPfn82g+6aVAMLfAbfGzwvp0/FcEW5deHpnTqXVsUtt
         YoKrhakRGHPiTxVYkwtC1q2L6jcvWbCCZfdW8fxLH5ybFlP9bZooivtMycoUCCD+75G4
         pvrpNlsAJ1cdIArkn7lJLc8+KsU0fbNcDlV3W0Dxm/PQdo+1KZVvnBv2p3TyV2M3jPcQ
         Y3aO53lKHLXsTxdcWv3tmxI8CcRk9URBhDGDLDeEsXv3XElRpGaL71pFaEH0A5YMw9MU
         5w81DDkKU2BwGXm6555Mwr4DB8IuhpYO6lYomLzA2/z/QqjfdusERVkbO86T6T/JtnwK
         upUA==
X-Forwarded-Encrypted: i=1; AJvYcCVpOMhTwzJupKKzqad2z3RJA2a2LngqnEso0fSEWKAGVTFArQIVlrRVuLXj5MSVEfKm06d2l9TBMTmZyb02ZcbgHGAY198S3GMdfSfW
X-Gm-Message-State: AOJu0YyhxVy2x56HEXZfnkmXKf1wYN4jPFigOBqKh/9fUsOMopzrDtHB
	HjTMd/pjnMl/tHH6NsLgjURdXGNJJhvsGYWTjEKLgG9zaTIMkLYFt70woddjKihQ2qenMRDJQqd
	vfqA=
X-Google-Smtp-Source: AGHT+IGwc97UXhoPZ6M3Kgu7iGdB98KgV5PyUpA28YHAnjcOxwHKPtp8UV7sfm2xKhMn9v2qab9rJg==
X-Received: by 2002:a17:907:7da1:b0:a51:db9e:4cce with SMTP id oz33-20020a1709077da100b00a51db9e4ccemr585965ejc.3.1712868915426;
        Thu, 11 Apr 2024 13:55:15 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id nb17-20020a1709071c9100b00a4e6582edf8sm1063406ejc.102.2024.04.11.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:55:15 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] rust: helpers: Fix grammar in comment
Date: Thu, 11 Apr 2024 22:54:28 +0200
Message-ID: <20240411205428.537700-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/directly the bindings/the bindings directly/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 rust/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..4c8b7b92a4f4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -4,7 +4,7 @@
  * cannot be called either. This file explicitly creates functions ("helpers")
  * that wrap those so that they can be called from Rust.
  *
- * Even though Rust kernel modules should never use directly the bindings, some
+ * Even though Rust kernel modules should never use the bindings directly, some
  * of these helpers need to be exported because Rust generics and inlined
  * functions may not get their code generated in the crate where they are
  * defined. Other helpers, called from non-inline functions, may not be
-- 
2.44.0


