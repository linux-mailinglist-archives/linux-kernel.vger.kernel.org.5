Return-Path: <linux-kernel+bounces-160295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970708B3B89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85F61C22016
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8F14D71D;
	Fri, 26 Apr 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="PtrucRD7"
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01891DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145446; cv=none; b=ir7e9O5OKJT5CcbplicuMD9bXGzqkGsLt7I71ajMtaDDhfnFvvAasSxTKCMFv/QJrVBRA8BX5CJgluj3kDo8pzQFJhUHfkFSoIMNsi7V4cQglvbKMPDayfdNmQkiglDqMd9e7IDYePumKln1bAwhowR3RE5v6IBh49Av/2Kjr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145446; c=relaxed/simple;
	bh=PPOvHOjX3H6a1eJib8FVSuczhsp29/GL+2rj/10QgCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vh+pC+hi73jEKi/OGn7JmobLYH40Gc9GKg47n+k97Izf5LfBX/vrG6pNkBLNqr3G44d0qunroorfmY47D9oEBtq+Z9LKglMs57r3GVzYwCJVMRKgXmR3T0qUgowSRxL9EJESqpPa2GuK8YjUHPeNCv76jZIQbokbuVqr5XIdDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=PtrucRD7; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([146.241.23.148])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 0NU4sgEVa6epj0NU4seY2d; Fri, 26 Apr 2024 17:27:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1714145253; bh=PPOvHOjX3H6a1eJib8FVSuczhsp29/GL+2rj/10QgCg=;
	h=From:To:Subject:Date:MIME-Version;
	b=PtrucRD7qz+b74U399+00jt64HS/XFxxvMcLL+1y62UcumMOx+IBHYscZrKfqGIZH
	 ObzNaaof72a5ztkIxHSsPcIJq+ZhbjUgvyM8FvE7S2rsWYuGzf3eG4OMyt6D/cKI0w
	 gcqQ/Dtjwq6xlr5HCzta0AqH0N1HXAKBtAHpt1RjVSsvuc75f6tGU0jpC608mhlXZ+
	 gG9g3XYjshoXjVEG78bLBnf++Ky8D3QvWQJ3tN6SiiMc0cV0ANQ49oaLvqroVoQq58
	 FwkOB4A46/tD259Oek7kKZkgG7pyQEbTvgmtyial9bF9pSCzQ5cc+5y2iP1I8121tU
	 2DDOIvRH9Dbvg==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Aiuto <fabio.aiuto@engicam.com>
Subject: [PATCH v6 0/3] arm64: dts: imx93: add i.Core MX93 EDIMM 2.0 board
Date: Fri, 26 Apr 2024 17:27:27 +0200
Message-Id: <20240426152730.9806-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMTvfIKp43jroyPzM9eFcaXc58FWdQMH4I0Oz1aMYWOABFg4j9idxqovLasUoG86ElJmFnwzd283jFRZ+F4ky0WgWKotYZWJ4poie+G2crOe6Udr/Epj
 VYangradRIcLhw+GCTj/NB6u5TsdXjTng8qOcbAjlpvMnzy3CcjKb64JU2NrYpSSAZEw2Wz/aV27oKMszIYNXtkBo7B5auTSzpDeIcIPIT/JlYjqXnvftyhD
 unx/YndSFotxjVHvduZ9A2AaI8UTnASq3TDnnHftf6h+Dfx55Exvab3jI6T33ZySuAvoR6kKVPXXfvuSPdpoc5EyYQ+rEPrFpvHqgQXN2sKwZcrw/Ud0Ihnq
 E/om1tDvRCmoY3mXIWPjbxdI2zZJSceBqBsFLDC53uS3NqAceHS26kYiV1jmlKBnED8dvVg9Byj64BHaEJ+fRwTXSVQKoRwdNiOac+2BdBGp2SGW0O9X9+xe
 IEzfFpi7OUGHeBHk4nJkXnVB09Vxf+Qn29ChDKxoQsVh/gp8xLDC6OtDJpCSoIWdG/7UE4lAi9fi9EuQ

Hello all,

this patchset adds support for i.Core MX93 EDIMM 2.0 Starter Kit,
a SoM + Evaluation Board combination from Engicam.

The number of patch has diminished to 3, for I dropped the
patch introducing a change in nxp,pca9450 binding which has
been already submitted in regulator tree.

(Dropped also regulator tree maintainers as recipients for
they aren't anymore involved in this patchset)

This patchset introduces just basic functionality for board.

Thanks in advance,

fabio
---
v5 ---> v6:
	- added property in lpuart5 node
	- removed unused sai1 node
v4 ---> v5:
        - done some property reorder, indentation fixes,
          node rename, drop/add new-lines
        - fixed line wrap in 2nd patch commit log
        - added Reviewed-by tag
v3 ---> v4:
        - drop wl_reg_on regulator in favor of
          mmc-pwrseq-simple
v2 ---> v3:
        - fixed dtschema warnings
        - added Acked/Reviewed-by tags
        - removed regulator-always-on on
          bt_reg_on
        - fixed clock rate assignment on
          sgtl5000 node
        - added wdog_b-warm-reset; property in pmic
        - fixed indentation issue
v1 ---> v2:
        - dropped patch updating nxp,pca9450 binding
        - fixed indentation issue
        - fixed missing space issue
        - improved naming of regulator nodes
        - removed unneeded include
        - fixed email recipients

Fabio Aiuto (3):
  dt-bindings: arm: fsl: add Engicam i.Core MX93 EDIMM 2.0 Starter Kit
  arm64: dts: imx93: add Engicam i.Core MX93 SoM
  arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM 2.0 Starter Kit

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx93-icore-mx93-edimm2.dts | 324 ++++++++++++++++++
 .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 269 +++++++++++++++
 4 files changed, 601 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93-edimm2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi

-- 
2.34.1


