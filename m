Return-Path: <linux-kernel+bounces-24124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DE82B7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DC01F263AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D359147;
	Thu, 11 Jan 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W6fuOii+"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CE57870;
	Thu, 11 Jan 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0418DC001651;
	Thu, 11 Jan 2024 15:15:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0418DC001651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1705014944;
	bh=M4Pnz4SMQqI0lENHCgy5dIi8o1y2ThJ8yVBhP6cY9ZY=;
	h=From:To:Cc:Subject:Date:From;
	b=W6fuOii+mWtXgU0zZXSxfAijx6nMI6BDrlkVQPB8zXOg21QVYx4hZgF9+NjIMy+oW
	 zQkkDDRFpaupb0kooPHntf5JwgyhUIqBMHF6TTs2JRzE0/9cy0jgz/Jgp2du/NJ/cg
	 rN9IH8GK29M76bw3Jp9VWqiE3TYYUtu6cjhkdWL8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6FDA418041CAC4;
	Thu, 11 Jan 2024 15:15:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] brcmstb_gisb updates for new chips
Date: Thu, 11 Jan 2024 15:15:37 -0800
Message-Id: <20240111231539.783785-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for BCM74165 to the brcmstb_gisb.c driver
since new offsets have been introduced which requires the driver to be
aware of them.

Florian Fainelli (2):
  dt-bindings: bus: Document Broadcom GISB arbiter 74165 compatible
  bus: brcmstb_gisb: Added support for 74165 register layout

 .../devicetree/bindings/bus/brcm,gisb-arb.yaml    |  1 +
 drivers/bus/brcmstb_gisb.c                        | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.34.1


