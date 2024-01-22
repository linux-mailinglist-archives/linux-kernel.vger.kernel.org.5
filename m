Return-Path: <linux-kernel+bounces-34132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF1A837419
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F7C1C261DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40B47F49;
	Mon, 22 Jan 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIHIvmFT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5C47A6F;
	Mon, 22 Jan 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956138; cv=none; b=ANOBHgKOkKobKbNcBfRr//pzdwaFhUabNUkza3bCHxfby9Am5BoMLAFDi0XTXqYxee8BneVkRQ+6fO+jHBme6UZC2PhaKV80rymisgzPmzwPFoQ5204s3tvw+l9Ra4gdj800U/AQKToaNyrJ3WK/p9Qiem8ROb6X2zENZdARAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956138; c=relaxed/simple;
	bh=lfUVq4d83TpgqB+IiKAo863O49OEz4Su7IWo3c36W6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVkyFOo7ULNe37kso0jqgj4AUOj5wd2wkyzA5wFSJvLva1G396EogueV0aQYtS9/ba4dU8jcj4ftM2Vk7W2dYzM6T24jAs5VDmpiVJljuHn7BCjbKeOp4blUpLUIzosFwhljpe0kEmIaQQR6Atz3HfuhdkMN+UtwgR7ZdO92wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIHIvmFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7FEC433F1;
	Mon, 22 Jan 2024 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956138;
	bh=lfUVq4d83TpgqB+IiKAo863O49OEz4Su7IWo3c36W6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HIHIvmFTqCUSJzRCT8Ld6KOulhixCJJDuGF3pL2SmCmosC3qC0PTNMFVTr0z7A76/
	 nsjhhwqJd7CWfYbiM8fm1ry9283VTqMP4okUwojTG9hg1SATGpGlCx/H5jTDshumzz
	 pP2GouGmXt3gcxD5xIYe4Qj4tAMdwLGhUxthi7KHWRWDrnMp+UgGwIYZ1uTE2GjPKP
	 10zVEzDvdxSKZmsUhAjAstnq8J5HbvXl0ntWH2HhO+dv/nNxcq2i3LzCnNNAR2DmJv
	 9prRHPrzzRTZtBfskwMGWGRogx8K/vATBdnNQB0IFbaQLoeMnrs75YAvIFMbkEpA4L
	 D8qo1DiPFdSjA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 20:41:51 +0000
Subject: [PATCH 1/4] arm64/sve: Remove bitrotted comment about syscall
 behaviour
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-sve-sme-doc-v1-1-3d492e45265b@kernel.org>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lfUVq4d83TpgqB+IiKAo863O49OEz4Su7IWo3c36W6c=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtR1lxUXfU2+78rT5LF8Y2ZNr4/SBmO7zrR9rVOsuBUs+wv4
 Ehs7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJzOBk/1+xdsIKiadlHrGG4qdDOo
 5OeeThFFVjfmU5v1bbT8EIUzVHp/6Dgnfn2Ug5l50vWeHkl9CTu6S0xdA17qBZj+i75TJZvgFtYRuW
 hOx/sZQ/dum1urB7waHsn15q9+9um/H8Fmf38Sjbc+sCk40OfTQzdNLX1s1qCwzvis+X6VVouiK0o8
 Vrx5VvNrF1PZk/D7AvnvX9SDJXdryTTsBdzgbVfbbP2t5EvZy0J2JG87o/N1RcjvMGtZ3TFir3Sb8w
 7coJD1GlaasduHtPPtvum7rq6u74zX92a1hr7n/GtmRBQH5pUMQXo+08KZEVv67/l/jDvMdostbct3
 ZNRf9+s+qJ92QwWvzs+n6zxe4gAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we documented that we always clear state not shared with FPSIMD we
didn't catch all of the places that mentioned that state might not be
cleared, remove a lingering reference.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
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


