Return-Path: <linux-kernel+bounces-2291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572AF815A94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AFA285B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6733067E;
	Sat, 16 Dec 2023 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OONG6yX9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C532E65C;
	Sat, 16 Dec 2023 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JIQyBU2dMmtfHPrerB2o6NxM4MWH9UtHkA27Czb7HVU=; b=OONG6yX9CUnwBFMoGDHeu+eMK3
	rgwdYV9lMHkrRZirjVuLGjbKDeKlD3sFKH6Fv0CGCk9ekpjJ8Rsdn4fBnQfz8f+G8r2EuBI/Kc5du
	pktxSrFYfn9Emn+Udnru771tXL+blPUm3WKL8JSEzFGBEIibu4qxKZN6nRzPW6nkfIKizkTc/nkKq
	T5r8giiiv29KZdUJfVlH7hZNnnDuUSsdQ6OW6leH7KtGQI+afTnHA0VzGOK94YI/+sr/cNOEZHj1D
	tre6lX16dOCIsFOKJBQY8Y7H0n4HDFEkWYZvmGWM2mXRwKwZgg4ZE8M6RRiQw21u+3b3BSjqHGTu5
	q4hU6Rvg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEYGo-006RPV-2U;
	Sat, 16 Dec 2023 17:16:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-sgx@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] x86/sgx: fix kernel-doc comment misuse
Date: Sat, 16 Dec 2023 09:16:10 -0800
Message-ID: <20231216171610.13224-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use "/**" for a non-kernel-doc comment. This prevents a warning
from scripts/kernel-doc:

main.c:740: warning: expecting prototype for A section metric is concatenated in a way that @low bits 12(). Prototype was for sgx_calc_section_metric() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-sgx@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/sgx/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -731,7 +731,7 @@ out:
 	return 0;
 }
 
-/**
+/*
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
  * metric.

