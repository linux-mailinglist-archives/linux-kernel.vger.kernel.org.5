Return-Path: <linux-kernel+bounces-163328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE3E8B6983
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE418B21989
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A411702;
	Tue, 30 Apr 2024 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CVf2bn01"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0BB8BF0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452220; cv=none; b=J5+JiLUCn6jELSx0z6ZSDKGlnrIOU+mos+Tw6U1c/NQu6WcPEFdnDm3suRRos+Z7g3fxjb9vduTNsbwIWkWV49HwBNZX13XFX9AgkAKboS8q3B7ing+wlg/N1phIwUbEfxZbGK0BWghXLP3dLL+YK1s38dBiBKo6WkbG9Dsoj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452220; c=relaxed/simple;
	bh=CN566b6VUqJT/L9HGOq+aiatkim/The49+TewPuFsWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTJM8xWOzJIDtTV9r82rs0rlyheh3f025xGUTqmQx1vIu7O86jmEVXZGzvEDb6ojaOc5cqXBoYzo+GXu7/hp4mGxsUSi0GDcBvNVM2OjuySfwwOVhRx9CdUWp/u4jCLCibd7kq4Npzux48iisVbV4noWQQ/NbfmpEL2xZQhlWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=CVf2bn01; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714452217;
	bh=p1Z98Nll64va/XikfjzgYHrDnlZjDKxfBwA4QojG/wo=;
	h=From:To:Cc:Subject:Date:From;
	b=CVf2bn01+dI3XbQmkOHbNhLEQLvwvOhgv5sK2f/TdjWGoivQ8G9ffnN9GUMpJSP0E
	 MmtkkSQTjc/G8ZQnC/fznUWoAnxsiE5TwC2Gda8EoyUNYTUhmBykcjbypiTnjb/6xI
	 myUC5tELV+Udy3yePvPTWMnam8p6xA+Jv2yUl/NIeRNs+cz1dSvyozrdDnw6nwwt3h
	 7aEz8bA8oTz4g3EMRFTIH36feF7jNtSFb3RybANHaleO17GjBVOjS9mMpMu0mi1j0M
	 ST87kygQgCAxMuJ6BH6B3j4x7SBivL6p2jm0lWjaqbc1ROWniWoTFbyCsQ6qBsXMdR
	 sJK5il06FNu9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT6yx3W3Wz4wyk;
	Tue, 30 Apr 2024 14:43:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kernel@vger.kernel.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	<aneesh.kumar@kernel.org>,
	<will@kernel.org>
Subject: [PATCH] MAINTAINERS: MMU GATHER: Update Aneesh's address
Date: Tue, 30 Apr 2024 14:43:27 +1000
Message-ID: <20240430044327.49363-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aneesh's IBM address no longer works, switch to his preferred kernel.org
address.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93af33ee8541..f096c9fff5b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14898,7 +14898,7 @@ F:	drivers/phy/marvell/phy-pxa-usb.c
 
 MMU GATHER AND TLB INVALIDATION
 M:	Will Deacon <will@kernel.org>
-M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
+M:	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Nick Piggin <npiggin@gmail.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.44.0


