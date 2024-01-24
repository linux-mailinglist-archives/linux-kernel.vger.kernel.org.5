Return-Path: <linux-kernel+bounces-37493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4A83B0C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B144287DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FD12AAD0;
	Wed, 24 Jan 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0VTmBJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69012A175;
	Wed, 24 Jan 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119967; cv=none; b=KPNPhLapeH/JdvslfcFUzpKuG1H4qBZSZl2JX6qr17mHh+/YpprKuEutbQxwJ4i6RF52rx9UnH65Hwt4NQcsh4XxwAGhbEJhS0ElVrpIhVhlG8olQwgloHVcy0NkIlIlmB6zVFmBTGeYPMazQEaErbJfCzUW0T91XRx2/8JEoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119967; c=relaxed/simple;
	bh=KDY509WkoApN5+z/RyjZkULoN7R+WASGjlTC5t9MtKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SldFxK3aaF7tpaoltJNMx80JJNypGBEJsifBZiTLZKUzn+dbUxHD8p5ft4kjFSibd1WJoK0tBFYd4/qF31rUnioaWm5ADU6gtMo60nnVyl1saDm5xYESWgCZZ2yVZ7CMwyZQfvX+SKclhm7WZ3ixjoYH3qu0ug3wHBJWg/blPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0VTmBJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F572C43394;
	Wed, 24 Jan 2024 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119967;
	bh=KDY509WkoApN5+z/RyjZkULoN7R+WASGjlTC5t9MtKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P0VTmBJYxVMvv6CB8TA/HaVVpnLazvfoQIO697Q4uJSOo7Dg3hTcn91J+OixF1ASR
	 hbVPRNMPuLpA4gC/Y+/RXlehw3eqEd8HrdBb3/03IIZVLo8F3jdsTCNVwG4bAciVFd
	 F/06JVle+J1ju+JdvdYo54cGQ9PFaosU+CUuKZUQE8AkeeH72AVeFwlBolm8zoAetl
	 bv9Aj3DUP5L1RetvfILfpS68v/W5matoazWFV3e4NWgQMlf7wRsX1f+UkNtqLqAB8U
	 apgI/kBvrf9P5ErXGQysG14TCOPk39SmHvvjuVKwvy5oeDX1txMj3bQIzH6pSm3sAP
	 Zt1JYHyTe1PnQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 18:12:35 +0000
Subject: [PATCH v2 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-arm64-sve-sme-doc-v2-1-fe3964fb3c19@kernel.org>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KDY509WkoApN5+z/RyjZkULoN7R+WASGjlTC5t9MtKk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsVMYpqkQjc6VNKfuZEYrSrZAMU6J3CcxlySvGDnw
 LM1Y+neJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbFTGAAKCRAk1otyXVSH0O0xB/
 sHaiosBRNM9PRQ6qCgCrhkGx4jai+8aN/V9HnQhDoimnQECFzrDb1N9gNzouahQUi6CFvWI5yzCFwb
 6Jz7jEYghYHrxTNvuGjWDRZ7TQxArBujtdwLWsMlkNWdvgdtTDo4ZqtHKXt9mImEHFpJxvJkz9B386
 Ovh90rpYE4oWw4N5h0UJYK4aTJrR3E+kOT+YDyMIPwSL8YKIjqyqgmLvpLaRyzRCFRWzBAYUWWK71x
 OCitOlwB1hXnxZuPi0ebUVsrC+Fysq1upE522w83j76AyUwAYeWKWPZ1DOLWxoQHlkSMEzgmB9wHpJ
 U/pwfP57f3UrMCjv6cYMdM1uYqHnIT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we documented that we always clear state not shared with FPSIMD we
didn't catch all of the places that mentioned that state might not be
cleared, remove a lingering reference.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sve.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/arch/arm64/sve.rst b/Documentation/arch/arm64/sve.rst
index 0d9a426e9f85..b45a2da19bf1 100644
--- a/Documentation/arch/arm64/sve.rst
+++ b/Documentation/arch/arm64/sve.rst
@@ -117,11 +117,6 @@ the SVE instruction set architecture.
 * The SVE registers are not used to pass arguments to or receive results from
   any syscall.
 
-* In practice the affected registers/bits will be preserved or will be replaced
-  with zeros on return from a syscall, but userspace should not make
-  assumptions about this.  The kernel behaviour may vary on a case-by-case
-  basis.
-
 * All other SVE state of a thread, including the currently configured vector
   length, the state of the PR_SVE_VL_INHERIT flag, and the deferred vector
   length (if any), is preserved across all syscalls, subject to the specific

-- 
2.30.2


