Return-Path: <linux-kernel+bounces-110648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D628861C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239841C21D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A41350D1;
	Thu, 21 Mar 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="HlW9mUyy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Zo26VBvX"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F95660;
	Thu, 21 Mar 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053682; cv=none; b=kvNjib/qInHCZqDWjbzuhEOthghCy+R5satIhQxYuhrNNmxmM+4oWo56nCITx5NyFJjSuMopU5qZxBKkEy5EK90e4tfJ0FtJXnKD6kzOjaxiQe+VGDbT6FBtnt8odG90y4e1iOEzu1jIztGoKCTyphDexohaRiQRHIVeZtMwzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053682; c=relaxed/simple;
	bh=BnYtIwuw/2b/3vdvy2XgYNIkhimsRG88bIipYxK54WU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGt4zcBJa1pLvLL6+sxSult4q0k/lSquUnHkc9BPZCi0QD0L6S4JHm79MrYaIUI3MhV1DRH+f0fEM5H8e/73ltHYCVk7MuzX5G3djGo2oFUgBxCS/lE1GwCwlv6H+NjC1fECfv/EI8qX6fnLKR8kXgn6hv2TqCsuhP0vRzpjqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=HlW9mUyy; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Zo26VBvX; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=3DQ7R9E3fkw/LRozVd+Y1xkz1Cnq0Gx+/x0PUNhoOvU=;
	t=1711053680;x=1711143680; 
	b=HlW9mUyyrhj22i18GL7OyQr3PalCFXfV8EQ2N4CUOpWetRxCh9WSRM1CUMw8qdfY/COP4C4DEqdlAQV7SeBC0qypMId4I2NQVCG8Z33vLFmRdR4hMxIxzwT1ZN+FBYdSjon/ZdE5UBlhn3xwMpYJvvcpvbYemFYu6j9c7SmnJcg=;
Received: from [10.12.4.2] (port=58572 helo=smtp29.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rnP2G-00ElVG-WC; Thu, 21 Mar 2024 23:29:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=3DQ7R9E3fkw/LRozVd+Y1xkz1Cnq0Gx+/x0PUNhoOvU=; t=1711052953; x=1711142953; 
	b=Zo26VBvXqX/ulU5WZ6ji6ZHViTPYZA6WEwMNhzGpnb1leLbG3LHT0ppz1CAR4Nkawy7aIYSocQO
	Cnjvykj+zx5IGILSUlGRf+gfKpje8dcIM6AoXW7PTJCPGeDPJJR++kW3Ksu63bHpMr4owabZsX3U1
	e9jbOpSrqWnY6h7/+BI=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rnP20-00000005qz4-33rx; Thu, 21 Mar 2024 23:28:57 +0300
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
Subject: [PATCH v2 0/7] Add dispcc, videocc and camcc for SM7150.
Date: Thu, 21 Mar 2024 23:28:07 +0300
Message-ID: <20240321202814.59835-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92CB91DAA594FB6BFBB91359AE34AC56FDC45F69F1CDD9C6C182A05F538085040ACBE9AE061793060D27678DDAA806314FE3BC179E5C52477DF7EF9FDA0AB3C1067D05D8178A78D18
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C59BC9C499248573C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE78C6616F30072131EEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871DA52BB59AB7702E4A2E791B4B590506301DD028134C9E799A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE764603B5C71CE8B8F9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C390D92131081DE748117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF30B39F36F4341585BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B654D8DBA2F838621276E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A0CD97369C4BDE2E089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5EF7F25161DC27D4F5002B1117B3ED696D8C3924A16BEECA84A0A47EBA01A636A823CB91A9FED034534781492E4B8EEAD9F68E8F4EDE74A9DC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9E7F0732E50E559C1E46A34E0CFCA5683CC0C22ADFB8E41E2080B7593ABB39939EC5AF04A575AA6CA5E652D4FCD6795A956B77AC907D458807F407391B6C10D8B479818CAECDF190146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes25dEmFYDuiNpg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498123F80C9C64FBB36EF6A6F50B1491C03520769053F69089FD7CBA92510FC6000E2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A873E06F0BBE0AC52C7C9BC2A173244ACA555425FAF015D968F3CF0E9FE49B6993595096ACAD5B56A699D4E6ED4DEE20252F4A093CEBFC588127D9DBB485201F
X-7FA49CB5: 0D63561A33F958A592CF1183090CA3BD3C791133B6816EA74C2605B28D18E60A8941B15DA834481FA18204E546F3947C05B7D4054DE234C1F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006377B3E3CA19E3E440B389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C39C2627E4F2648A8635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojt33F1wIes2407rFjbB6fsQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds dispcc, videocc and camcc support for SM7150. This series
also introduces various fixes for sm7150-gcc.

David Wronek and Jens Reidel were added as maintainers. These people will
be able to test new features at any time or make fixes if necessary.

Changes in v2:
- Drop patch 1 from v1 
- Add Rob's R-b tag to patches no. 3, 4 and 5
- Switch disp_cc/dispcc, cam_cc/camcc and video_cc/videocc
- Make clk_init_data const for dispcc (For some reason this was missed in
the first version)
- Add gdsc cxcs for videocc
- Fix topology around titan_top power domain for camcc
- Drop the CAMCC_ prefix from camcc gdsc names
- Add flags for camcc gdscs
- Link to v1:
https://lore.kernel.org/all/20240220165240.154716-1-danila@jiaxyga.com/

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

Danila Tikhonov (7):
  clk: qcom: gcc-sm7150: Make clk_init_data const and various fixes
  dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
  clk: qcom: Add Display Clock Controller driver for SM7150
  dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
  clk: qcom: Add Camera Clock Controller driver for SM7150
  dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
  clk: qcom: Add Video Clock Controller driver for SM7150

 .../bindings/clock/qcom,sm7150-camcc.yaml     |   60 +
 .../bindings/clock/qcom,sm7150-dispcc.yaml    |   75 +
 .../bindings/clock/qcom,sm7150-videocc.yaml   |   58 +
 drivers/clk/qcom/Kconfig                      |   29 +
 drivers/clk/qcom/Makefile                     |    3 +
 drivers/clk/qcom/camcc-sm7150.c               | 2061 +++++++++++++++++
 drivers/clk/qcom/dispcc-sm7150.c              | 1020 ++++++++
 drivers/clk/qcom/gcc-sm7150.c                 |  394 ++--
 drivers/clk/qcom/videocc-sm7150.c             |  357 +++
 include/dt-bindings/clock/qcom,sm7150-camcc.h |  113 +
 .../dt-bindings/clock/qcom,sm7150-dispcc.h    |   59 +
 .../dt-bindings/clock/qcom,sm7150-videocc.h   |   28 +
 12 files changed, 4060 insertions(+), 197 deletions(-)
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
2.44.0


