Return-Path: <linux-kernel+bounces-123530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43E890A62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB94F1C2EE48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5C13B7AA;
	Thu, 28 Mar 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPWPu2UM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5013B791;
	Thu, 28 Mar 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655724; cv=none; b=I/hWT3f2q4eETqKllJBk+/0y+12HNeLjsMHw4CG3TJZ/ak0AZTjj7mQZaETluykr52HUiAyouF8S26Yt0OW/jw5R5mVzyJ2UR5lGsPLAOhgbk1MO9FcG/5OdXcrnZKGgEcw9V4ikm7TxEk+dDu545XjORx1l+G4bqDSk4C9IAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655724; c=relaxed/simple;
	bh=cjEsbiErL4GEiLgWPr00zMhV+ra7917lJ1keLF6jIuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3nlPS7Iay+xmHrqX3yqb+u0KovwtLLbBD3y6DKEfjRz+qKzII7DcQ37OR7V7dNBaA8LfPte7DbR0XR4FI4P+ucmq7h4qUN4d83xx7qZti/i0ii7yQXS2H9qZbWlJMUQnJxP8vFD4zPGW++rRp39z3NXsRQRCXaYymA8vOjlpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPWPu2UM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b22af648so1810277b3a.0;
        Thu, 28 Mar 2024 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655723; x=1712260523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3onkuNTqsbsPIhsygl1fro8dFk+/knTOJGgy1+clLaE=;
        b=gPWPu2UMrdNMHAZtDJp8iahagtqXaTKstTkTrUSr/k7+F9uI5F25MsM8vSdH6qfYUL
         Eh9r5I9feTiNtqtIGRU1fJqWBw5LzTucgGinku1zcC3CcT8wmhwFYB12t7DUQUFtNyUm
         DHtsxm7IShaBcJK+oryafg86T2pPdkHINxm/bB2QdLcP/X/XVFm2MWxXIRNtfskTp4Oz
         fJ4WzUXP9H/naottyJouNLOS7/C7BcmwTkWbXMUWr1c7bMTingRodQPVDNuoGqfGYY1C
         66FfVLkKNloKXHF5kOI1YFtrUzlmllB91L6GGtCi/nJ7IVH5/60/068ommHKvBQeCxZy
         jEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655723; x=1712260523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3onkuNTqsbsPIhsygl1fro8dFk+/knTOJGgy1+clLaE=;
        b=c70/XWa16ITaHO5BAmzJrjm61bAsWjn8/ZTH4lAcdSBycyDlG6avflqmYOMLL5LcR7
         csM/3esfC0wsHY3rqo/Gk68oXa1IqWwFM7BUlF23Q0T54Tj1MArdONovPnUdRkQfE7pi
         VZTgKahiD/T2MQYlCvT0HV1tzU5BoGuUAlX897qwlrbecK2qTWtOZm/828jP3K80oF5K
         ZzFEDfypqr0VZ6nd64ndBF70cmvOLMdVFpbmftqkn03Jt993yp9LRAr+gCw9/9qkw8kM
         rGXPvGLCB6mJ5ePdFWfeQdj+DLjZSbtxTM2b2csbaiclphUg+sc7sBdaqxV4yCdRCiA6
         NwVA==
X-Forwarded-Encrypted: i=1; AJvYcCUGvW1Gb0JZNIegFvAYTj+vhRU/UuainNVBj+7E1A4HgwgzGuT07HC0oSLF3vn2yJTRVpN6n4Yi2I8twe7iGQ7qteIm5KqYa4jnKkYw
X-Gm-Message-State: AOJu0Yzu+2+sDTdPIi+wOyNxI2oWiHgB1PxGyII2VpwFrEj893XXeaLQ
	COGJM3Eq9NPL7MJjVeOBZ+RqkQ2NedcHU1I6DJnoPVI6LDlFoZnhTXVWZ0Ev
X-Google-Smtp-Source: AGHT+IFHIFFoXRxFAQKTg7a2ng7z0GqOTb5sKGnRXt/T4T4naasjHmM5jKwJejoXUwY2joLDaGiA7w==
X-Received: by 2002:a17:902:f54a:b0:1e0:aca5:fd24 with SMTP id h10-20020a170902f54a00b001e0aca5fd24mr498128plf.24.1711655722792;
        Thu, 28 Mar 2024 12:55:22 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:22 -0700 (PDT)
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
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 2/5] rust: kernel: require `Send` for `Module` implementations
Date: Thu, 28 Mar 2024 16:54:54 -0300
Message-Id: <20240328195457.225001-3-wedsonaf@gmail.com>
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

The thread that calls the module initialisation code when a module is
loaded is not guaranteed [in fact, it is unlikely] to be the same one
that calls the module cleanup code on module unload, therefore, `Module`
implementations must be `Send` to account for them moving from one
thread to another implicitly.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5c641233e26d..9141a95efb25 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -62,7 +62,7 @@
 /// The top level entrypoint to implementing a kernel module.
 ///
 /// For any teardown or cleanup operations, your type may implement [`Drop`].
-pub trait Module: Sized + Sync {
+pub trait Module: Sized + Sync + Send {
     /// Called at module initialization time.
     ///
     /// Use this method to perform whatever setup or registration your module
-- 
2.34.1


