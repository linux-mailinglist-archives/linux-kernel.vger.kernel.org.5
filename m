Return-Path: <linux-kernel+bounces-123529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39262890A60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0961F279E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C37313B5A1;
	Thu, 28 Mar 2024 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUBDeGl9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23C13B598;
	Thu, 28 Mar 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655720; cv=none; b=eRgDoysZsOz8pRmsneZvtyKuCECKflDZ4Y9TQ/5gcq/sn8xBMiG0FxjF0oUx65rbIrC+ffsSpHm7iRXwCDFJh7b8EenvakBSmFAgTMZ3WiRAOsiSHdK4BuYn1OpT3J/qDO+oQxg5zZguf2MB6RlGUXkI1TDvhb7/8nV9yVFciGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655720; c=relaxed/simple;
	bh=8H5op9oxVlU0msUtq5I4WSqtnbdnJghczRSI2SqtUaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3V5uP+xaYnPL0AfZdeCTFwrCYgZzL3Rc+xqyXZnOHn1Xof8nkSm+spYO/94aWVzrnUzpWL2xtqyYfDU2COVChrS5GEHZguRbOYmly9nfwIOa36Pc11sRKerc3gYJGgogWIl7ry6hTDithUIdvQHugqEuJtJmqGarwDarrTeR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUBDeGl9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82c529fso12721145ad.2;
        Thu, 28 Mar 2024 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655718; x=1712260518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzqUPsfXWj4binayeXTWXcfCoPWBBRiht8YRpbXdcMA=;
        b=FUBDeGl9A7jmubRkBgVcnyIBChMi26PnlOPx/hjHJ/Mwg/tfyOMh7bvFZjFpE0UYCT
         ZHhzlllWiC43WF87h1e6HXC+FNmq/N+I64RKBVrvGhCzTORfDXdxx5ULDAZ8B6x4NU0O
         BsCpp7uKTtZjvwe56Ja/5YH/7PFIl2TnruX+SdQDH5Z90cYemOiUMdah3jZhbdqII+Ik
         U2KJ14rdZTYjMYpuIE8PthCac3sV83w92HqV/yI4GV3pHfp6ooQE3USdRMY37YRyEn0L
         1KENrWbJaoD5M7ktUKfderZlbGMyNYCjDAxlyvvKNkHVO94TluyG3Ti2DEKWf45ee3zg
         tAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655718; x=1712260518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzqUPsfXWj4binayeXTWXcfCoPWBBRiht8YRpbXdcMA=;
        b=sXRKYaTuteajfrZxL5eW2BceANRBRYHVinBBO0jSAHlx0asCxh35dMWFB/o6qKd8I1
         /ga1r1pdcpihQkI7G9XGpmCD1QXxE5NVoQGjXPwdCabyxV/myNTg9WEt5ED1uSmiaTgo
         wtVYc2blaZClgQWqrkcJStPIuPmBx6QUJQ2IifGsTnPr8nw99JsADSoC6k8mkG7RBHXT
         eNyyJvWZeJnXux06lI7ngbDaRrtV226uM+MLm4u7vPTEg9V2Jn9Nc8x0xCXOCllOPJpm
         +OeYIJU5SaR2DkNZBeCLiwl135P9/iNFO542d5+5PIqGuGJNwqdHW0R8KnK09/rCMrJu
         kiNA==
X-Forwarded-Encrypted: i=1; AJvYcCWl82i6PKd0T0L31FhqG7RdyYAuG+OXFMzk6EGfjzx+wEc2Vp5iNh0dPYNU4Zeryo0fgW3TTxlnRGI3DXpKwEz+Dtk/Of++W2IBDZxNc2B8ijoSxLW7O5HUyWS6au2Gtx5cPpqJ
X-Gm-Message-State: AOJu0YzpKAA92gEgXa3Bg92LF9u7zWC/DMgxJPY/NgKPlBNkSkcWipey
	U+AJXnVr9/qBKEzk04bN7t4qEq6GWMUUfYO6CtqgJrG9q7nxR0ZHoBerG+8e
X-Google-Smtp-Source: AGHT+IFcH8y9aRYK8WAqYucQcxKLzTdOpTXagA/BsEXoq0kvwRHyM3jJoCzmityUgjvvuOTNcC1qnQ==
X-Received: by 2002:a17:902:e888:b0:1e0:b5d4:9fa3 with SMTP id w8-20020a170902e88800b001e0b5d49fa3mr634632plg.2.1711655718390;
        Thu, 28 Mar 2024 12:55:18 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:18 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/5] rust: phy: implement `Send` for `Registration`
Date: Thu, 28 Mar 2024 16:54:53 -0300
Message-Id: <20240328195457.225001-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

In preparation for requiring `Send` for `Module` implementations in the
next patch.

Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: netdev@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/net/phy.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 96e09c6e8530..265d0e1c1371 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -640,6 +640,10 @@ pub struct Registration {
     drivers: Pin<&'static mut [DriverVTable]>,
 }
 
+// SAFETY: The only action allowed in a `Registration` instance is dropping it, which is safe to do
+// from any thread because `phy_drivers_unregister` can be called from any thread context.
+unsafe impl Send for Registration {}
+
 impl Registration {
     /// Registers a PHY driver.
     pub fn register(
-- 
2.34.1


