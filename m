Return-Path: <linux-kernel+bounces-66491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFEE855D76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E032B34D28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D41C692;
	Thu, 15 Feb 2024 09:05:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F71BDD3;
	Thu, 15 Feb 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987928; cv=none; b=rYqo0gCT6gN4y/0GPfsS6/akPGXOtEw5ilbXiXbgTLUOXTY+8AvkShoGYPLDCNb6fjptZeYVMEbGFkVRy1zk0/7HNzgx71bXCyHJacxAgQA/ipETLTbvVsMZlbxomEUplIQ4NIKwIbhPo7k4+Tnff9nte12PfrGc+uhXEq5B3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987928; c=relaxed/simple;
	bh=BIvvBUd1xCcYt9Gd3j0yw7U01qqEA5f/8IOw0Jxl8+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAdTgsge/2KYw9RpAbE0jNHTLM1ud42ktWSTab1lG0giIVPQheygVW11ApFb0iwIardxt8Q2LTOVog59hrUCCAqwNitmAj8L6CtG7n1QvyLLA8s3fxikGUDBBWGGw8EI00j37WYyru45xrM/AP97/SN66rJcaxsuNkNGNtfLb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raXgC-0002M4-TR; Thu, 15 Feb 2024 10:05:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com
Subject: [PATCH 0/3] drm/panel: add one more Leadtek panel, the ltk101b4029w
Date: Thu, 15 Feb 2024 10:05:12 +0100
Message-Id: <20240215090515.3513817-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar in setup to the ltk500hd1829, group it with this driver.

Heiko Stuebner (3):
  drm/panel: ltk500hd1829: make room for more similar panels
  dt-bindings: display: ltk500hd1829: add variant compatible for
    ltk101b4029w
  drm/panel: ltk500hd1829: add panel type for ltk101b4029w

 .../display/panel/leadtek,ltk500hd1829.yaml   |   4 +-
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 265 ++++++++++++++++--
 2 files changed, 244 insertions(+), 25 deletions(-)

-- 
2.39.2


