Return-Path: <linux-kernel+bounces-165765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550188B90E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8874FB22AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2A165FC9;
	Wed,  1 May 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="pLXtkvRu"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB409163A80;
	Wed,  1 May 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596497; cv=none; b=IBF+FOPzyVHSnES4cNdm12QEIknsQc8gWACIW/RU/PWe7CK6qnfgmLDNyiLVId6ZHUREHnyzfrLSQe+Y41Jm4GJLLpha1+dYZdqJ7TLPW/SpMNltXvNgNxLrnMdOIvqn30hY7qTPnzzLYUsKYGKTk6zbbrnSrNdwEATD1WGmSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596497; c=relaxed/simple;
	bh=2Xv24IW461dx87lQvZYqfi3iIdL1HV0h2BUIUMEuDyI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SgUQv4uudWSTj2prNXsnEAH0oXbgrTbBdJWwu1MhQPlQWkqAb4Wt8ga5JCfOx34ju+eC5umTulSjElOW3uFRIs7/tHfugj9j7XntyWArcgxqpfB23KpcpUdwxzOjzfG+U6SLUC5c2nxpfYdR2g9D0dRM5/hXb79jtDowiso4fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=pLXtkvRu; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grz-005PNg-29;
	Wed, 01 May 2024 22:48:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EziAVVGoDGwvfXefxOEMQP944ZbxBIa11u0lLKfCvuE=; b=pLXtkvRu5bxzky+I5Z6IOiLCty
	GYjbkq7sBI4GYlZYJSiDkpvQEd+EgdoLlqZ+idmVgwb842DxDpHVOxkhzXpf/8vPM1j01oHqM3btW
	V/ICUPOvRBJtVssj2WM/bJHPlO0f1zcEPjGKbWPe1udgADayHRUq/8CJz5HbXnt2r9Rdgu80VuHHD
	fgeUNMLo5b58HRz2Opk0cYLEHJf0fmGzfihzswul/SkeUKLBGRY40CHuPJZj2y9wTIV7tLXUC8598
	YIjHJroDSIuJ8n5N6w3X5P6ArLlXQunHvFYKYK22Rz1uJDv41UtSboB8rbrO9kVF/QIQDUkneT+lB
	xKa1clzQ==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grx-000OnR-1b;
	Wed, 01 May 2024 22:48:02 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Gry-003BKd-0p;
	Wed, 01 May 2024 22:48:02 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	andreas@kemnade.info,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	oliver.graute@kococonnector.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy.shevchenko@gmail.com,
	felix@kaechele.ca
Subject: [PATCH v3 0/2] Input: add ft5426
Date: Wed,  1 May 2024 22:47:56 +0200
Message-Id: <20240501204758.758537-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- reorder compatible also in driver

Changes in v2:
- reorder compatible

Andreas Kemnade (2):
  dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
  Input: edt-ft5x06 - add ft5426

 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
 drivers/input/touchscreen/edt-ft5x06.c                           | 1 +
 2 files changed, 2 insertions(+)

-- 
2.39.2


