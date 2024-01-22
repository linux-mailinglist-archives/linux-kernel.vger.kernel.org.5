Return-Path: <linux-kernel+bounces-34131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0C837417
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53486285A93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64447773;
	Mon, 22 Jan 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LknJED++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D23AC08;
	Mon, 22 Jan 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956136; cv=none; b=MoTZ6r2Kgj7tNVphVnhTWV1ULCqIJkOgCy/o/+SI6vspFiJ/cXYvrwwovFkUKsBkhnodwoUw212lJGTgQ2nsliIckwFV2jlMntsOCHRKKewf400mH3mECVg8uC7O4b9zXRjDtpy3ADIpbx6su8LxSgxD7YvlNeNKQhOvUvyKa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956136; c=relaxed/simple;
	bh=ndBfH8M4wh+LrVK1JOcjyzRIPSTgi1rdv7agVd5PKng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VnyyYDSCiZ6Ipq6UlxHbGOzwym33eKIAyrVLuNMuUbvCV6NUFNJoIk8TKLx/qmpWnLDPbfa0RyyqrlWHVqNL6sKwIRSFb/f85qCOrmsBemon7bGgbqM3xmoScEpZqgfa/YM93nm2Vrth+BKgMEXpzYgN55HnVaZhUCPZxWENMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LknJED++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2E8C43390;
	Mon, 22 Jan 2024 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956135;
	bh=ndBfH8M4wh+LrVK1JOcjyzRIPSTgi1rdv7agVd5PKng=;
	h=From:Subject:Date:To:Cc:From;
	b=LknJED++2Z6EWV/GHzdIfrwbnJW0fN2BZZUSHTv2bxMYQrJ3N//2GJdPxIfUn1MKo
	 aBg82e36z6Vj1W2kdrWSAyu8LFT3jjjEti4+rt8gcF7b5vtajVd9ZjLcl575gMaN5F
	 Mw197UIv8OnT1Xf+0NAJNNVGGlfTT7mA9JnE/s5J5HUWOSr8B+An4MYZDHZQsupILG
	 i2u3cPu2gjMDBM8qUV+jIGpl4NK3QklcdOh2KD+bW4MH5pEMty4emGrPhg0SuFxesY
	 E48XLBKWDgeZKSHYz+HG4yfaNXEreuK8Jmenhfz944HuNjGmwmGT8/QzkkiRqd3tQK
	 7hNpfLxSdkpLw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] arm64/fp: Documentation cleanups and clarifications
Date: Mon, 22 Jan 2024 20:41:50 +0000
Message-Id: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7TrmUC/x3MMQqAMAxA0auUzAbSUh28ijjUGjWDVRoQofTuF
 sc3/F9AOQsrjKZA5kdUrtRgOwPxCGlnlLUZHDlP1hKGfA4e9WHUk3G9Ii5xcBxtcEQ9tO7OvMn
 7P6e51g+4fwnXYwAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ndBfH8M4wh+LrVK1JOcjyzRIPSTgi1rdv7agVd5PKng=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtMgTmWXzoC+aNHeEG60GTON7PoDQD9++sM2Yy2M
 wq/WbtaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7TIAAKCRAk1otyXVSH0C1vB/
 9SiLUpeZW48xBAzLThoxTz5Gdj1NdtL02NUlki6mm6WJYfWXeYIF5PkFuvxz3sZHRWEd1RmwVJyTDq
 GCIyAtlk6SHdFLNx51NQmNaZoOUQ677u2As8Y6QNDyMiKhx7tMdcOQr8pNOMK2fUykcVdHnZro8R0X
 yrM3McC/IlDmKD/kXEzlcU0nRpxuTLCNrVbz6CZ7pBvvXmAyaN4TpWD4ivyxZsgNK7Dt4cpLMUF+ch
 NtNRf3bwV4/8caXb/euC6y980YCIyGeZkYQpyF0Lm7X2MLFy+FYMByZw4wFWaG0lcVU2cQjZsdZcUw
 d5wi/SX6+Eju+5dgqMWtwwL9Nmtqu7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Edwin noticed some issues with the SVE and SME documentation which are
corrected by this series.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      arm64/sve: Remove bitrotted comment about syscall behaviour
      arm64/sme: Fix cut'n'paste in ABI document
      arm64/fp: Clarify effect of setting an unsupported system VL
      arm64/sme: Remove spurious 'is' in SME documentation

 Documentation/arch/arm64/sme.rst | 11 +++++------
 Documentation/arch/arm64/sve.rst | 10 ++--------
 2 files changed, 7 insertions(+), 14 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240110-arm64-sve-sme-doc-bc62ec1a2005

Best regards,
-- 
Mark Brown <broonie@kernel.org>


