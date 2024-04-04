Return-Path: <linux-kernel+bounces-132195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7D899131
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F34B28AB66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562013C3EA;
	Thu,  4 Apr 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="wOdiFMVM"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391D13B2AD;
	Thu,  4 Apr 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269224; cv=none; b=uihFrQkmYjPUWkrsiwjjo2uG7gvnicFIR1+mZE3uuHJgBxXUj87dWdvN6ZndUklJekFeXn2sXIzYaj40udecvPycjPmyqHWy8aUmNE8Wj347lDROLWahgno0Iffs9ac0vnEBtDyA9CC+O0xhMb0K8O89SIr0oV3foFQHJJMKPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269224; c=relaxed/simple;
	bh=k8qEGLL2If8scNURaxWNlbJuI1lpXFMLm5iEQoDWs4Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DN97tiqOB8NjR3G4IeDpiyxp5jcOTj11+TwG8r4BqJpIlQcuMRohA4/VGtjpZ/Ac0IZKRNs8iIQPoNqlMs9+sfFsLZ9HT4li4VaXDtjuCKxYStbeVnYGEAc8rtbZ6ojiwoAyuML1i1ZU2I2LmKb9zXXRYQ0d6eMuX6UC9xSH19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=wOdiFMVM; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRR-003r6K-28;
	Fri, 05 Apr 2024 00:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cwXwAMn63d+EV4+GVNJ0peEQrITL1XlN2ioPF/8sSAg=; b=wOdiFMVMdydHN60sazRrfx+gyR
	mD5LyUvzS20Ek2OgxRzBA+Ni6w6DmbNUZzwX1vEJ3gyETZp18YNSoUShrLKHGOtNMYNr9MxxyQz2h
	FFD0dEWWDTdAV6ZFBR93+fDHDSgsImbdkCZfokIrAFtu72FmJf/eGIFYtANkS9/HtE8qtOTjQfi9s
	IXP/YFUWAXtMWtIDA4e8pTj/xTcdromp1fLmHfcyv025KS71RM8r+FZERmhyu38J2IF0CscHI2emy
	kltYQtkkOuDixW91k6t9m1DECaATesi9MvJ/w25drp2C/BzKpV+9N50joxk03O+Sfs+CLsrh225xY
	3Zh6coHA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRO-000Nwn-09;
	Fri, 05 Apr 2024 00:20:14 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRN-002oTm-2G;
	Fri, 05 Apr 2024 00:20:13 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	o.rempel@pengutronix.de,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Subject: [PATCH v2 0/2] Input: add ft5426
Date: Fri,  5 Apr 2024 00:20:07 +0200
Message-Id: <20240404222009.670685-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ft5426 touchscreen controller and the corresponding compatible.

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


