Return-Path: <linux-kernel+bounces-163327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FF8B6981
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A0B21A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256611702;
	Tue, 30 Apr 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ap1ovaM6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D38BF0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452162; cv=none; b=eeh+84ZOX0SqbbeI8n1HusIqXn9i9NEGvxDounayk2aplise5ehAcfEAptmRsaubZxi5JFy1HiUw076wOKOsvZwTZChqyXIXFKdyCU37pSL31owUGJje52rLppxrtsfCNPhoPnvyq9yE3kUhYBWkdoc3srbi6A6LHFpBQK23VYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452162; c=relaxed/simple;
	bh=99YvNFzHTeAVVOMgwroaGJHW9fkST2G6rqCjifr/cnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaM0Y3q79ItfixIg1N5nfC1d1NvNhzbYOIkn2vYzKhtHdGjji/11+VQe2f6yDtoFGxEiPv6GnTgMVBr3GBcLhi3R3GPDQJoOkdbDZdtF/qy+jbsfp9R01whfvrKNvG863reovlfrf1SFhzAvxnDa9d4z6cYivxST05DhJpEjB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ap1ovaM6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714452158;
	bh=hVwO34kPSmLeutYDfLcZ2znsLYIE4NMhTr3UcrMhXYw=;
	h=From:To:Cc:Subject:Date:From;
	b=ap1ovaM6ItjB+Z0xpnLRMvgWb5xXzN3J9paBTFK9js1D+AGdqW4jRJTGsN2c+8CMT
	 WZ3Y00sObEDQTxUBppvrWUl435YUdNr78jzgVjA8AqVMqp8PgL3Yi5AqzSCtfL+jDo
	 AuCghk8Od3sEmDsAdJ4/EK/UVxgGPT4oDYvjfZ+uB2R9sIAYc9txTwoRdTGWn6KpS9
	 sRkoqRvBx7m+iEeMygV5mh/jRGilL8mvWmm5npt3dlL0EAyDQtmp+27hKmckcntK/Q
	 awBdwbGmc+y1M6kIoUKgl78UmY0KVdfSkuVwqPLEefxyapQs4llWv69NNwNqysjhlC
	 ZPhvOLVffgTAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT6xp0S6Zz4wyk;
	Tue, 30 Apr 2024 14:42:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <npiggin@gmail.com>,
	<naveen.n.rao@linux.ibm.com>,
	<christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: powerpc: Remove Aneesh
Date: Tue, 30 Apr 2024 14:42:28 +1000
Message-ID: <20240430044228.49015-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aneesh is stepping down from powerpc maintenance.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..93af33ee8541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12478,7 +12478,6 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy <christophe.leroy@csgroup.eu>
-R:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
 R:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.44.0


