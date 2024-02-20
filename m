Return-Path: <linux-kernel+bounces-73441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61E85C29E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E97B24040
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055076C9C;
	Tue, 20 Feb 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="IwQkkJiP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="vYUByz32"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD75768FF;
	Tue, 20 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450033; cv=none; b=Z3lFWeuAXCRixs2KOMCTcU2oehpMKFykJzUlD4/Z5HlHpRcT2UkUbh+C4xGpcK1X2zpmyWCvjbEcswUkPTz7Yk1pRrMRZpmDvAU5hBbIikHCJDEModx+4BMV9LMqF/Ip2h6KoyQLqBYLlNCCybkB22cQ5+OUcv6k4FB9Uo/9eMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450033; c=relaxed/simple;
	bh=okABaVT7+CIHHlsiriS0GGjssKFiPKnr2dcVi1SFLwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faU3MsIlyjE5TE28Zoe6O9dVyiDnpLwenV7dU6VB4NVLFpuu1PyR177C2b4Q2Z4+sf+fPZ4N7nBQhAFKSI7899h813MhMOeG4Q0GgsEhGIGBF44YHx/Cyc6UPamdxk0LZZ1SbV2hjYZuo5q4E8gH75L/qxSKaff6O/BfrnAaruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=IwQkkJiP; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=vYUByz32; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=LtWU+fCgLk3TkGGwkHEmGF+GgL6Q2QCoI4GdaUjSMHc=;
	t=1708450030;x=1708540030; 
	b=IwQkkJiP6mArrLWzlPr93FjyjgiQX83wwrrP5gQY2U2xr6j2tYf1VECBbn6VuHG5feVJgdbSIeB82IfCDKbB0pJmLaTZ8uiq/9oQTDeJls8xivfzSE37WFTA5zDHUoRS6307hvuo27kNA5ceIaKDOHdWd1rvbfLe18Fsu3Sv6ZM=;
Received: from [10.12.4.25] (port=58224 helo=smtp54.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcTMa-006skZ-AZ; Tue, 20 Feb 2024 19:53:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=LtWU+fCgLk3TkGGwkHEmGF+GgL6Q2QCoI4GdaUjSMHc=; t=1708447980; x=1708537980; 
	b=vYUByz32Kd6yKCpblODIifQUvKT24BKl0c3SEU1JwgJqfsDmv66mkWtmV+CC719FwBD04IxP/aP
	pgzI8yZu7sAXooxhmIF6GQLq5eW2gX0hDLgHxf8DXem2vLl5M/ECpb+9ievPa8psccV01wq+60rXi
	OrizBs5RCJzuDeVKZKw=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcTMK-0000000GhgU-0ICk; Tue, 20 Feb 2024 19:52:45 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	david@mainlining.org,
	adrian@travitia.xyz
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/8] Add dispcc, videocc and camcc for SM7150.
Date: Tue, 20 Feb 2024 19:52:32 +0300
Message-ID: <20240220165240.154716-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F5DFE3806F3A3DF1421ED8B206DEDB9600894C459B0CD1B94ADE4151EB5B4A4B40A02D48E7B53F4AFD67307F9E126EB7EAC3EACB7F7CF7DDB7AB0E7134D2E1A8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74D0D2DEF2EB846B0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063721BEEAF38C6AE0B78638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F75BEBF34F84E3A1CF466CB8E830073E526F8D462CD70F74CC7F00164DA146DAFE8445B8C89999728AA50765F790063706586D6E6283AEAE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC89E541A154B51D14BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C2D01283D1ACF37BA6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C31BD302B0759A9E1EBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3E2C51E5CF308F7B035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A567197AEA91247AFB5002B1117B3ED6964B4FC5DE71FC4D0292B673A2F5DDD7E7823CB91A9FED034534781492E4B8EEADABF80F987DAEDACBC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF4CE8889836CA475411E8C8E25B9EFEE1460D9544A6E531A4EF249378277DA864FA89AC6828CC4048F1AD97FD9824DBCDD93EDE836A8FA79DC96C25594159584065801EF3E41EADE1146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCkecM/R+H073w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498132FA18D1217A7BFEFD3DE253F98C97F8354E8E356F47C7EC063365C932E8B3752C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C9224595B18E9D805049FFFDB7839CE9E76E35804B2850F2048351A5F232CA6F49E30297E6DDC893F611E60463AB16E4A
X-7FA49CB5: 0D63561A33F958A5973C95C0FF11898D552340C5AF72F266E92A5B90FD97C94C8941B15DA834481FA18204E546F3947CC39EEDDD9AFC6874F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A7BB3E4B80B357C4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C367B172B3F0F4CA5635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCmJuJMkNLWqCQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds dispcc, videocc and camcc support for SM7150. This series
also introduces various fixes for sm7150-gcc.

David Wronek and Jens Reidel were added as maintainers. These people will be
able to test new features at any time or make fixes if necessary.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: David Wronek <david@mainlining.org>
To: Jens Reidel <adrian@travitia.xyz>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (8):
  dt-bindings: clock: qcom,sm7150-gcc: Add missing CX power domain
  clk: qcom: gcc-sm7150: Make clk_init_data const and various fixes
  dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
  clk: qcom: Add Display Clock Controller driver for SM7150
  dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
  clk: qcom: Add Camera Clock Controller driver for SM7150
  dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
  clk: qcom: Add Video Clock Controller driver for SM7150

 .../bindings/clock/qcom,sm7150-camcc.yaml     |   60 +
 .../bindings/clock/qcom,sm7150-dispcc.yaml    |   75 +
 .../bindings/clock/qcom,sm7150-gcc.yaml       |    8 +
 .../bindings/clock/qcom,sm7150-videocc.yaml   |   58 +
 drivers/clk/qcom/Kconfig                      |   29 +
 drivers/clk/qcom/Makefile                     |    3 +
 drivers/clk/qcom/camcc-sm7150.c               | 2054 +++++++++++++++++
 drivers/clk/qcom/dispcc-sm7150.c              | 1020 ++++++++
 drivers/clk/qcom/gcc-sm7150.c                 |  394 ++--
 drivers/clk/qcom/videocc-sm7150.c             |  350 +++
 include/dt-bindings/clock/qcom,sm7150-camcc.h |  113 +
 .../dt-bindings/clock/qcom,sm7150-dispcc.h    |   59 +
 .../dt-bindings/clock/qcom,sm7150-videocc.h   |   28 +
 13 files changed, 4054 insertions(+), 197 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
 create mode 100644 drivers/clk/qcom/camcc-sm7150.c
 create mode 100644 drivers/clk/qcom/dispcc-sm7150.c
 create mode 100644 drivers/clk/qcom/videocc-sm7150.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-camcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-dispcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-videocc.h

-- 
2.43.2


