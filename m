Return-Path: <linux-kernel+bounces-128582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EBB895CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6501C226F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91F15B99E;
	Tue,  2 Apr 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="LulzpXgC"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7A15A4BF;
	Tue,  2 Apr 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086527; cv=none; b=QpKJvI2YwgS7pHBecmgWoJSeQN//AZSIvDA4VomHVIyfL3yl7ABhcK+wY5ttwfgopDGGxrCSzMsBqrPP4QCGjcX50EbLgqZWrg0c8OHIXG+TwDp+mloOgpw0/U3Vo2RpoHovD27xGSHfNvWpnW/ecmYwiJ8c2JaxKAlYAn5ApCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086527; c=relaxed/simple;
	bh=+zAe7o09J6serFR2r/0vb6THqtUx+qDsorvJK9fW8Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dp21yEajzjnYzTEG7MLT28oO7IBXCs4dii5fiZPZZv+s/gd4XqaunvJtAl1wcLYAI/EeF1p7Rd0pemthzTc2aPvT79QO6LtkIApOSAlK2L6uIi1gslpeRRoIfLh2U6wwhGiQ+FwwnQBVSbWJcvls22njY8UDsqAL7ga69HZZd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=LulzpXgC; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjul-003lfn-1I;
	Tue, 02 Apr 2024 21:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBJJNAhxKWi/Tvk/Q58agm+t55arRQEeNGCVkeymcB8=; b=LulzpXgC47WzvErKhj38qRS6H8
	ttWEmsW2Nl5Uj65J10CJiU0z56Qu0ccvnx3dMFdJWWK5xbl1GpYkM0zhoJFSvLPoGsr4QERAf684W
	mnpvq0R/gqN5c92JpcB4EfNKipMwjqTpf/qRupKtD5rnyQ4bkIbzDncx2U7KGufMjVtcRGrdF7oFK
	RDbAaVzcjvzZcMj74ZggCaktXkkN5R6LI9SZ45Z0XaFctSsMfmOnu1RT/789+v/BdHSNbf6v0OTSm
	x7TWKqSklY7tvQmuE+sygw+sxiVUesQoE7ADcconG+QC7pKQI9PyxtyyL53gWVxD7KMQ3ZZRP6x+0
	ZgSpHlrg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjuk-000J3F-0Z;
	Tue, 02 Apr 2024 21:35:22 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjug-0029dy-35;
	Tue, 02 Apr 2024 21:35:18 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] mfd: Add ROHM BD71879
Date: Tue,  2 Apr 2024 21:35:13 +0200
Message-Id: <20240402193515.513713-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add software-compatible variant of the BD71828.

Andreas Kemnade (2):
  dt-bindings: mfd: Add ROHM BD71879
  mfd: rohm-bd71828: Add software-compatible variant BD71879

 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
 drivers/mfd/rohm-bd71828.c                                   | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.39.2


