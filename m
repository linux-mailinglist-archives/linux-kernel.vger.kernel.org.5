Return-Path: <linux-kernel+bounces-24456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6D82BCCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CD81F24DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7155C1C;
	Fri, 12 Jan 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nCmO/Kpf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656056B63;
	Fri, 12 Jan 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705051066;
	bh=cBSetI9NmhfjBU4f9Ab6uJ9+nMBdjSL4RAxJKWa+Y8E=;
	h=From:To:Cc:Subject:Date:From;
	b=nCmO/KpfckjVxaHOZgYAv17cUuS7f55AC8fOR2qmU4I2A7clPCnqJwa4XC0EtJVkv
	 +kT4Yq5V797vO+YzWTsHsrGni994EEW3pb3HuDZjw/gOPC1QK+eh4M0Y1Kmc5ULBLV
	 /o/cdoox9DhCzkx2nx50qomdiSNxPYWTFalA+cwZzeGJC7OBs/on0iWfnIcFarXViJ
	 pmPa7lfZKNbuDOxYy/QKR39ORsFaqVx+FJWhrDbikzN1UAnflnGX82D90xPZca39Rz
	 763B+bdJNkeyq+SzxqB3T8+DnrzBdMm/lna8GrkfZezu/ANUPRKpIESpSKKb+5SK8H
	 wQCIVWAdZQuhw==
Received: from beast.luon.net (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA17D3781FCF;
	Fri, 12 Jan 2024 09:17:45 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 769459ED98CA; Fri, 12 Jan 2024 10:17:45 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Set boot tags for the usb0 port of AM62x SK and Beagleplay
Date: Fri, 12 Jan 2024 10:17:06 +0100
Message-ID: <20240112091745.1896922-1-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The AM62x SoC can be booted from the first USB port using DFU. Set the
relevant boot tags for both


Sjoerd Simons (2):
  arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
  arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0

 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.43.0


