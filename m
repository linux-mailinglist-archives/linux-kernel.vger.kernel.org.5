Return-Path: <linux-kernel+bounces-50062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86D8473D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB901F29497
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443314831F;
	Fri,  2 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3YzqHSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D29148306;
	Fri,  2 Feb 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889514; cv=none; b=VeZlrYTX4IDr44KRLxCWsBTj0KZyLo8OLto00t2MVO3nNrAxulO4HD9/HSwIcInwEdnEALdWEpxgZ+kVbIYZPWXQhJAKjUNcx6srPz4vjnInlnUGOvL4uS3ggyK9xey1NjDVhsa0vZa8RLJavoEG2UgxAko6bZbdlwTTRRLytX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889514; c=relaxed/simple;
	bh=U5NM7Nt1jzE4iRK2epL3mIB1zFDNJP0QdfPYsv0sK38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Paffz+8cnpXb+fd+SbNygp5dQP/bt4eEaClRNEFq5sLaTOAx5MArwz1gzft22gCD30xb4dOc++nyVCYG+AWGxueN9PJ1kXdbNVBCJAESlVQAF6wcSQZhOwNWk5Jy76qAsxO1LZZYJkbKL8XE/Y4Ku7J5b+fXaAZRg1COaKqFZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3YzqHSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2052EC43390;
	Fri,  2 Feb 2024 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889513;
	bh=U5NM7Nt1jzE4iRK2epL3mIB1zFDNJP0QdfPYsv0sK38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3YzqHSFhHi/Xn7vCle18PeBGaX/7q1UbDyit2H5q+IpYHWf0ytoRBCOnCJE52OHB
	 bVVZygYNsWon2/wSxLISzOFDKYs9b2af6fJvaI6U+KqexT4vjwUV7FafeB7snJlsuM
	 AljXW9pKS0iOCaTXeNV+TPqcJ8MmbH3zRyE3nWUpkXPr37NpBam/0n0MU46rejfLMj
	 kjETDZbZptK2dSJlxCdoY759SVoQClevoVR7z2zJgSpFfdun8Ln4QUMCOBGYUAuKkP
	 kKsOSErVCP6nsd5o1RLn0YIqr0E/HN7vX/m3PTLhHqSk47xl4/7ZFkTczY2CIT9G/j
	 JM9wM/B7FMspg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 03/27] kconfig: remove orphan lookup_file() declaration
Date: Sat,  3 Feb 2024 00:58:01 +0900
Message-Id: <20240202155825.314567-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no definition, no caller for lookup_file().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 4a9a23b1b7e1..e0d866569155 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -279,7 +279,6 @@ struct jump_key {
 
 extern struct file *file_list;
 extern struct file *current_file;
-struct file *lookup_file(const char *name);
 
 extern struct symbol symbol_yes, symbol_no, symbol_mod;
 extern struct symbol *modules_sym;
-- 
2.40.1


