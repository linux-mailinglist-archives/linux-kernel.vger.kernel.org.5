Return-Path: <linux-kernel+bounces-119800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16E88CD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB50B1C668A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226B13D504;
	Tue, 26 Mar 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PZhnlhvB"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DF802;
	Tue, 26 Mar 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480993; cv=none; b=QayMoNbxdmQ0B9Bsy20468dQuawsyX9kejWvkYcks8cE+ihz37OKJxO46yQaxE/ETfTNDZ0wSBmKTJV1WbWR5Auocc8YTML9bxU1VDULRp+0WGxs99tnx6NjiLv8LN4zMqV0LkdiK6GfQrxUotLS8I3NjA3nu6L8pT1fY4PYtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480993; c=relaxed/simple;
	bh=kmKZtc5buFmyGG+RNBXpUTXtwNmC+ibxdoCrNE0mBQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iR+1MpDj6p4ZauQM7cbQWQD3mIpQysjkYXtTN8uXxVe0qoVMWaeV/UdF3AyKNqdGdFo5ahwzeKVzCgLzilu4uEa8Pxf6PiR0/cs1JrpV9YeuxqWFutIOBQHuIpgcyDMqyOM3w1m/5iy8UFwAdl7ujLo0QWu2eIJrcm46oxm0TX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=PZhnlhvB; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCO0-003QYP-13;
	Tue, 26 Mar 2024 20:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Lf6XxywsuS4g/Hh5g1Y3WYkx2PBSiqprgPmi50zaLM=; b=PZhnlhvBAlbfj3gz4cpmjyhBr2
	2vEpBpVVOZXNxJL3blEMPZes6RPxnTMbj3UeaqyAXZAWv6PLDQe69wyjf+L15p1UiNHgBHanrJEPn
	130WIcTLITNwuBdEQJGogqfHp3iQ8bCL9x2gvuP1NKJXpQPnoMmkgGkBvV7DbdWfnCQ0gj00vbiiH
	ZPasujwstfhnvfIGxN3wO0ejK2WIivKk/cudv6shafmWpndmStfvHyBlCIdV6qPYultvVBINndHMa
	zlO42ilgvzp8I22aaKgvrcxEq7RBT+gvCErseBUwGkTcu6ahI0uCt9FXmBFG7w3EBbTqNzWkiQ6Rc
	tULk5ODA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNx-0002bW-37;
	Tue, 26 Mar 2024 20:23:02 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNx-001FZ2-1O;
	Tue, 26 Mar 2024 20:23:01 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] mfd: rohm-bd71828: Add power off
Date: Tue, 26 Mar 2024 20:22:56 +0100
Message-Id: <20240326192258.298143-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power off functionality. Marked as RFC because of magic numbers
without a good source and strange delays. The only information source is
a vendor kernel.

Changes in v2:
- style corrections
- remove unnecessary writes and delays
- correctly unregister handler

Andreas Kemnade (2):
  dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
  mfd: rohm-bd71828: Add power off functionality

 .../bindings/mfd/rohm,bd71828-pmic.yaml       |  2 ++
 drivers/mfd/rohm-bd71828.c                    | 30 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.39.2


