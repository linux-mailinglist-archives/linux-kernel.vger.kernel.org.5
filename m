Return-Path: <linux-kernel+bounces-34135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56880837425
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B928C6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1D482D7;
	Mon, 22 Jan 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJMJhdkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720D482C0;
	Mon, 22 Jan 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956146; cv=none; b=Gkh+ierMhkto0OBxUHwtkX3ZQNC6LzTPk8lJHaZmToto2EV5o8qWgQzjMXCSy3c8jVoMxk3umJNuDcfUjh7nUwwHmz82SB0I/lJ125Sn8sli3I+FukvgPDbWMbgaXRCNpMnqtb/ptTAJrTdVdnwC+y7K6jEj+Uj4lIiT98IP7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956146; c=relaxed/simple;
	bh=9wwET/SR7knk4oSeCNFeV/MEM9M1Z+V//fKVMmchNVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCkvGzz4IRZWvb7cK1xwT9g3OwAKjbSu5338ROhRDNtSN1PrxWG86pTAi5eUA1vnUSVocKHjGK6hQ8ChGZaajmII3sKdiFumNTh/9Pf9UHHCvLa8ZDLbwHPNqGAvhvVi7Wu8DPjbhSgN38WKaTiZeGtI3TWDbadRaFQE5O5y6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJMJhdkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09458C43390;
	Mon, 22 Jan 2024 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956145;
	bh=9wwET/SR7knk4oSeCNFeV/MEM9M1Z+V//fKVMmchNVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WJMJhdkEMVCsME+TmfhWjSnniEDJHwowqo5SHRtMJ6QQ79jW80iSuhn8ruChmQRNe
	 uajnlUjNW8Zsh2qgHCl5obP2siMRrvEOVeD1u9IRtexCD/GZ4b254yFGMry4OPFZ42
	 cc71nCZfe8phSoFEjR+O+n6Q0vDTnkdZAzFYoohK+8Y8OiUEltZDQrPvkXV04HoVvv
	 1AOwKoagGq191arGl0quSnDW3wD8ZPcZ2zDsek7cqO1tjU7JvsLEWBVvzgdgvME2/P
	 syOA4PcoE/irBksey7CvpMyB9TEoVFiA1oRtI6NjXrkV0BbHv9WlUJhtYbQJkrPGlj
	 eLAaaBdIYX64A==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 20:41:54 +0000
Subject: [PATCH 4/4] arm64/sme: Remove spurious 'is' in SME documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-sve-sme-doc-v1-4-3d492e45265b@kernel.org>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9wwET/SR7knk4oSeCNFeV/MEM9M1Z+V//fKVMmchNVA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtMjztdy04L3pPKFQ1UwQtFqAqS9I99xBUZdbr7I
 CdmgEmKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7TIwAKCRAk1otyXVSH0EOqB/
 4kOHuIWx69XoT/RvheUGIeg8J6oxM+WtZVJEVFPIDAlWVc83YY8eyKp9n+WWz4MhO5XYUUQ+1/kVIL
 nu5oS58CpKIFsYZCz4KlWQzu/AOWr6Mtbb5szjzWKxz1JDZQugZzC4EjiExRx4FOiMb34XkH/DGt2q
 s/GEdytazihB5d9tSxFE0/1XlGZE0hU4vjbJzkegGoX5+sCRo3M7OyUZTsgIfjk2GafMUY8uECNAet
 u5zr8YjOhg4d2TO68AHXFdqE+48uvKVJQO0O+9SqH1guCb9gwuE5QIAAre4fOas6m4x4oTyWTq83U/
 WQIIiyJOgp1a4HIpKh7NqPRZNS5J4y
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Just a typographical error.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index ba0a5e5b2523..bc9855e599c8 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -75,7 +75,7 @@ model features for SME is included in Appendix A.
 2.  Vector lengths
 ------------------
 
-SME defines a second vector length similar to the SVE vector length which is
+SME defines a second vector length similar to the SVE vector length which
 controls the size of the streaming mode SVE vectors and the ZA matrix array.
 The ZA matrix is square with each side having as many bytes as a streaming
 mode SVE vector.

-- 
2.30.2


