Return-Path: <linux-kernel+bounces-30154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4559831A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66571B21FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FC25615;
	Thu, 18 Jan 2024 13:31:07 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6825569;
	Thu, 18 Jan 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584667; cv=none; b=GbQIM3lblYi98WW2GruEs6wvtgLHJhUWZOqRla63jpZm/uXSdFzwAYYL46ADvV0PLrD4WHHYbj7lllXyAXByrrGik+FvJSt4XBSEK/E9RqYnwcA6FyDIX8hxD5q/o3g0YY4em/kYW0By2XKQYusOZzMjUxk5wxiEEeYJdfQEuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584667; c=relaxed/simple;
	bh=GTiSa5lMTd1oAE4QDSjtmAjXtoc2F27VOWJ3i2Khzqw=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-HM-Spam-Status:X-HM-Tid:X-HM-MType:
	 X-HM-Sender-Digest; b=BmIFuxmyyNIwjwKN63V5U+KvL8lVJocVz763s/vlhHTeEzFQY+jEFekhICocffUziUyi0WpgoBewP5fczitf6aWObJxgN8Nr2USEEe1kjrPqsLQLdwnVBxU+3tTqUpIQG+e/ArZ6No/CbMbUOwTq0hOAQZdyx8pd24aFOJIwCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.189.0])
	by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 448EDAC00A4;
	Thu, 18 Jan 2024 21:30:27 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 0/2] arm64: dts: qcom: ipq6018: enable sdhci node
Date: Thu, 18 Jan 2024 21:30:20 +0800
Message-Id: <20240118133022.553339-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh5DVkNLGBlPHUJLHRgYT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNCVUtZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a8d1cc40f4ab039kuuu448edac00a4
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ND46Oio4FzwfLhcuFBAXNQpO
	E1YaFBlVSlVKTEtOTkNPTUlDSUhPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNCVUtZV1kIAVlBSkhNTDcG

Changes in v3:
  Remove always-on for LDOA2 regulator.
  Remove 1.8v properties of the node added in dtsi.

Changes in v2:
  Add LDOA2 regulator to support SDCC voltage scaling.

-- 
2.25.1


