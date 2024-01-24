Return-Path: <linux-kernel+bounces-37496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29283B103
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158A7B375A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FBD12BF0F;
	Wed, 24 Jan 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMj4mlky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60A12A144;
	Wed, 24 Jan 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119974; cv=none; b=WVvsNOSB+s+bQbvGTLQEoJ130rydLdhixU3BTbMkhIIDiMZEl4orLgP7C5O0xCaDPXwIvhqmMeGDoiXYYQtSEbEbuXMWZ4F+Dwzg8jU2x37fhSf0FsbM2Q4u0rinxCuOZE38AeWquvfQcQx0Nki9F1ewVssJo2S6Nt8bH/hdFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119974; c=relaxed/simple;
	bh=LreoHv/YiNY4KXZSn6k3Z9OgPKJ9pxNDRUBhp7vgJ5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VxCYkQhzwwdrJnQvUDAkaNkB7A3KpXm3VVrDa3W4gCUgv2Xtceqy0DXss2LzCRGN+RIGZDsF628OpJf39DCEEbwPdJZHLSUM4hDTtBwfJsrlr/l7WVn9FIPrpm4bcdGd3WuS8otoLW3eM/Lb/bdPFiG3elkspqkml5rNhJd0zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMj4mlky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335BDC433F1;
	Wed, 24 Jan 2024 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119973;
	bh=LreoHv/YiNY4KXZSn6k3Z9OgPKJ9pxNDRUBhp7vgJ5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZMj4mlkyCgYWGSurSzFvLUXXVk9PUmjShji+B3N3/vTN8TAc3vIr7ZCXT45uq281b
	 lVwkSa48Jl49/rSLFgOZ/dR2WTGGtyjuP8aSghgrRsRz0MHc7DS7D96THB2a3cjCmz
	 XB6uOeoWxdCJV0kPS2WJ+mq2//SUv652iNlsJhvUODGOXf3wwENq2XNRWLGEdwFoxf
	 dz3i9oGAipHuKSr1f3EQgeuOqKDSU4p1ImUSNE0WEzueCveH1qPvguWOiGiHatsPvj
	 otOpTa66T+WnvmpGZtZi3SiqL2ziAqxqQCmNs5kD7Bkv/fgaIxvYoscEVX6Qw3qhev
	 nP2wkLKyWUX4w==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 18:12:38 +0000
Subject: [PATCH v2 4/4] arm64/sme: Remove spurious 'is' in SME
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-arm64-sve-sme-doc-v2-4-fe3964fb3c19@kernel.org>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LreoHv/YiNY4KXZSn6k3Z9OgPKJ9pxNDRUBhp7vgJ5U=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtSNwVIBwVoGmeKzXyvOq2WRvssQJuAacPW50iTdgOKMj6/9
 eII6GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJRP5n/59XY8vp5hfbmnjTNsV/yr
 K1yyvF5bub5kcVzHkcYaIkrr7uj4165KyGhr+m2b/MN38t8w6LypyctON12uOGyb48ZRXF6dEbu47f
 42lUZF4/Z87mxGrbRZ76fsEqO9mavh/p6GGU5UixSmRcxtvVEXiSofjHDN7ug0wn24qiZ8nud91suG
 vqHr3i7w+nLlSz+6q/OFEpRnbjwixT+YXr/i5UD9tQHrDa7fheVu1TTZEiBTKiZzOVMr8+Fu2RZfJu
 W2/88satvAPXTH5fNnXM2tX3Lyv14hlhjhumOVetirlra85+/q+6rsL0zP6mNLnbCSEPo+uMjncq6I
 Y+MfZs3FaayX40ZPKuUJNk4yUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Just a typographical error.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index f4376c06f447..be317d457417 100644
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


