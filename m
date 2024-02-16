Return-Path: <linux-kernel+bounces-68901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF18581A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3D81F21D79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EA12F5BF;
	Fri, 16 Feb 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BcA1dBeB"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443D12F5B3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098403; cv=none; b=j9X8y6lYCqOhRuSA5GtB4H+mL5sQfR6kdKoskWbczxGdt337xqMHmz2dicrxko3WVXDC3F2XrQ4NH6HefOnzQ7Wx1c3Tj3ue8MZoOR810PVtOmmO2H69hmhCvQT1eY08goMQAphFmNl+Ug08a6iNkNCdv5CPNoaMf4Q9hkH3nE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098403; c=relaxed/simple;
	bh=EJcL3ayVx/+4LZ8p+1YLaepYD5JthmMhCsLuz49NPRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uU28N/ogM0Tigd6gVDAv+R8fBmtMPNMJk4HQD3y/R3f/GkhxHnj+uXRjjIEdwngPrM0tBz4IwjU5LdVqKY2yZ73h4MhN7mj1zfV2PBiEbkJj7Sh00qQAnujfq46wL8wXVf9RSbulqxK+vM1aVio+HbpBojbcO/cJT+7c22otwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BcA1dBeB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708098398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oChCMUJBblwbWgGNEA6nPdDFOOQTJgcnMNy1ciDrlTg=;
	b=BcA1dBeBbbEYTvHmit7FVdKDu9HlUJr2yP6uRL4i7pyPmSidN5CuuxIDuJExvol+Xgdwap
	qpX5f0Df/SRG6jhdLPE87xF2/kcPZwhs9QRgLJJL4gtrRs7pdn/QMViyvEhQ0HUuOKS4RI
	aOGxF4+rdsD8xRSY7o7MHmt5FFDHU7c=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paulmck@kernel.org,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] doc: Remove references to arrayRCU.rst
Date: Fri, 16 Feb 2024 23:44:55 +0800
Message-Id: <20240216154455.22327-1-zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arrayRCU.rst has been removed since commit ef2555cf68c3 ("doc: Remove
arrayRCU.rst") but is still referenced by whatisRCU.rst. Update it to
reflect the current state of the documentation.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 Documentation/RCU/whatisRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 60ce02475142..dce1678ec1f8 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -416,7 +416,7 @@ their assorted primitives.
 
 This section shows a simple use of the core RCU API to protect a
 global pointer to a dynamically allocated structure.  More-typical
-uses of RCU may be found in listRCU.rst, arrayRCU.rst, and NMI-RCU.rst.
+uses of RCU may be found in listRCU.rst and NMI-RCU.rst.
 ::
 
 	struct foo {
@@ -499,8 +499,8 @@ So, to sum up:
 	data item.
 
 See checklist.rst for additional rules to follow when using RCU.
-And again, more-typical uses of RCU may be found in listRCU.rst,
-arrayRCU.rst, and NMI-RCU.rst.
+And again, more-typical uses of RCU may be found in listRCU.rst
+and NMI-RCU.rst.
 
 .. _4_whatisRCU:
 
-- 
2.34.1


