Return-Path: <linux-kernel+bounces-132062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC970898F42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CBD28B1D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A51350C8;
	Thu,  4 Apr 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kr0buz8g"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370513441C;
	Thu,  4 Apr 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260471; cv=none; b=AEXoU/ZcpW1pf66pYtfhWAVVOBgaxprJG81Nc6Kng2xu3jA93v0t8uGS9Z94S+CaPNBY9MdV17g+RsB+IYHJatHF6aWq97zyyMAqjwC8IFf+ocjLTrGOyBpBMzTBvG6ZJOLpc71TAitOjp/2MniUaYsXroUHNfiw6fIvfxZNWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260471; c=relaxed/simple;
	bh=WCDOqr6T0DsPX0MrpS9Z6MYxudmPTc8g6TlfS4Ix9zU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cuXC/ohPD0764seCDF9Eb051fxDr+KxZUN2Vzo7bh+HEJXONPzFS3ZcDL7Enn9sQUPmx/7vVwikm5H0zOQOLgvseeqV/zzgspgIEbhjs1LDBApkXb2WSdp2Uh+KQXRKX17U3uQIwKWCcjzFzYvLULR2J7votLetm0DKJr5xboow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=kr0buz8g; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAJ-003qnh-15;
	Thu, 04 Apr 2024 21:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TbywA3K21x1kIvOru3LrZgufkrtlW6LRTTh7bpqzLBE=; b=kr0buz8gu+4rcb7e4h/Yrr3FeK
	RlAofRkZMrVg531SyNH5LePYOMx6ZPXdXfHrJC7Jlz5PkLogIvyPUcA2mS+hkfSyE9MWOaZfTV/VF
	mVXaFC06TpkgS3srXMl8iCbe0otxmbSKEDh9hHcWF36M9KEZ7N/IRC+oXvimUvYGjNFwmAo30qAW4
	MVPsA5WECY+slpovUCddRvKk/VRfvTyzRZGIzJhi+xtMyph0pyMXIGcoy1pYLYvjwlxsFcwokH7bv
	BbE6qYe+iDXrA8dNcclSd/b6g5hkWr+CiKOwZ2EuprS6lQX3f2ZHtFBVZ7PinljXRj6H0Pz5mG6NC
	E7ha40Pw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAH-000Ngh-1W;
	Thu, 04 Apr 2024 21:54:25 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAH-002nNP-0N;
	Thu, 04 Apr 2024 21:54:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] mfd: Add ROHM BD71879
Date: Thu,  4 Apr 2024 21:54:21 +0200
Message-Id: <20240404195423.666446-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add software-compatible variant of the BD71828.

Changes in v2:
allow compatible = "rohm,bd71879", "rohm,bd71828"

Andreas Kemnade (2):
  dt-bindings: mfd: Add ROHM BD71879
  mfd: rohm-bd71828: Add software-compatible variant BD71879

 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml         | 7 ++++++-
 drivers/mfd/rohm-bd71828.c                                 | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.39.2


