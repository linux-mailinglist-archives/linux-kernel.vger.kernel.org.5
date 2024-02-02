Return-Path: <linux-kernel+bounces-50411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408BA8478A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7ED290759
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83315150463;
	Fri,  2 Feb 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+60b7os"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777D15044D;
	Fri,  2 Feb 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899300; cv=none; b=Vojum8r8tQOVAilA/rVEQ6pMoqv5St+fi4srzL47B/NbCei+hzOQ/ewGi17i09sDbt2JpFYfrnXC6qGrQTljac0elILgyeE0LIwhSwmG/94Pp2uNyNLHA/7Z71+Sa7O7EHTWKWl6vPYTwsyqirHsDy9v1Im1t8+Y3NnftZ7sQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899300; c=relaxed/simple;
	bh=Df7cO0dyj8M9NjBa2lGjAHf2hVRhGVQ64biRaupcjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtHHfv2kJ6Vdwf11B4rzHOH5J6rnn9AKjgxyG/OLDwx8qf4UyAacfui5HUy5gIfvxg3DjfZ1Uq1dGrk6hyIc7e8vPVoIxEt1rkmtcX6/B16N7noJ2fy5ZmjtYosovhswE654I4Jatj0cCRy26rWu2G8BLvH/PEA97juJQPCgsYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+60b7os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F8C433A6;
	Fri,  2 Feb 2024 18:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899300;
	bh=Df7cO0dyj8M9NjBa2lGjAHf2hVRhGVQ64biRaupcjmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+60b7osLka4q2Ym8fUoAdt68DCFMU5T8SQ6QVTb68cNN3og/13Y/OyuNlFQEez+g
	 rPJZs6fawjAtHBPb3FUltIf4iNq/qnjjCjDhG/lvwFe1kbaaDPzQOR6EarPrBNERnP
	 XNypLqEQshxCIwgQlOurLCaw8qM3GpX2UDdvvXN/DLzPRQaNI0rkUvrXS01hJTt+xu
	 Znmm1L8V2pW+miM43evCFQKDdVdWVWjqw2GZp/gJCUqUiQX3ttlpJKdqAEOKDBEGlI
	 COj8ESs/zKtWQ1FH34sVKGdkOCNWfeiqp0DhlXlPIoq5/VzsG5phDpxpb+RPJbl5RT
	 6V/VY4QrfnofQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: [PATCH AUTOSEL 5.15 05/11] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Fri,  2 Feb 2024 13:41:19 -0500
Message-ID: <20240202184130.541736-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index d975c60f863a..7ce43b47ab84 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -153,6 +153,8 @@
 
 #define INTEL_FAM6_GRANDRIDGE		0xB6
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.43.0


