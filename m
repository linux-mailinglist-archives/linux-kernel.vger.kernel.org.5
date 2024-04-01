Return-Path: <linux-kernel+bounces-126944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9E8944BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0C280E02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A853384;
	Mon,  1 Apr 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="rGiJUWy2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="xyl5F/SX"
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4A54F1E5;
	Mon,  1 Apr 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995793; cv=none; b=kAn7PnmY/7Mac+P+5/aE8Ej+BCawpSwzJNqZqAEa++zEpmZ13UpIsyCxjd85XC/rNW6KheFWwMU0137dnKVLJh+2FRwT1mgGW5xuOzwXCPxf7HGi5IaVxGvxLWJUa2MP5R7jEO89l2gx6sf988ZUEVSSCskfLauSpz/E0RmBE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995793; c=relaxed/simple;
	bh=YUtnO/HRuRkk2kX8LJRlnCGpFK7W9keZuPRRh9eedas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAD632T/Z2Kap388PZnuz6eAvY+eO0ZOZ1nK9FjAtucIiil8W/sB0hVvHw0czrPejTN8M3yAVGUi3P0G0/gpbXNXTtIwAF9SVguEDdfo+M5MtPrYxgrZ8MjrTl8XjwuZpfC63ffrTv3heFbOMW+iAkQlrAQQZ0DhiBeReTI3R/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=rGiJUWy2; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=xyl5F/SX; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=ShGyo1CUXQ5HPR3+k6tqEEBbNMUAZ7JWfYNb5Y/jwgo=;
	t=1711995791;x=1712085791; 
	b=rGiJUWy2vPO1OxJ1CvUK15eJfepzmT6FFU+ejL58TshwmN7gb/VniULD/z+jx9q09SMHW4x49FWEjGGCkapZBPWRVYLROjuSoi58tQ+NKTatGOFMcnak5RLwV2nAMs2Qj0iRB+Mhy0kKy+xKf66Er8waS7LehOnBHUzkCPmvRmk=;
Received: from [10.12.4.7] (port=60032 helo=smtp33.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rrMJB-009y8P-Ud; Mon, 01 Apr 2024 21:23:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=ShGyo1CUXQ5HPR3+k6tqEEBbNMUAZ7JWfYNb5Y/jwgo=; t=1711995781; x=1712085781; 
	b=xyl5F/SXJK7c1K5tn+IHz4aSxqpRlRAoK9wPakvXfLfmblc6N7SDNWp3M6ViCtzZ6CDUwP9dHjM
	1dOPsI2kmzfKXSM+ZY6Ps6UrMZB4fTRS2lmHlhUCdZaLgKozyhAe45nVOyv4KJ6Gt/GL8ffYd7FuK
	fgbZe9ybTmQuZUScy+w=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rrMIt-00000002IQ2-1ZbC; Mon, 01 Apr 2024 21:22:44 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	manivannan.sadhasivam@linaro.org,
	davidwronek@gmail.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] phy: qcom-qmp-ufs: Fix PHY QMP clocks for SC7180
Date: Mon,  1 Apr 2024 21:22:38 +0300
Message-ID: <20240401182240.55282-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B8467D85483E9EA2C72D4DE81C4A4EEAA95182A05F5380850402B52B0DDFBE73495F378A8CA21F699D64179DF9C447BBFCD754E9BE2FEC5E1B818FB9CDCE596FCA9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77633BACAB33B9508C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE721AF84DC1D70954DEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871F6D061299D4DFACDFCDFBA1F025B8584A17D34953EC636E0A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7820CF4CC0E318EFB9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFA4DC95554899BC9EBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6D4C4ECAC619A54F376E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A8DADCFA31BDB70175ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A53162F1C686CC645C5002B1117B3ED696AA99809DCD2E960B30C8F815570A3530823CB91A9FED034534781492E4B8EEADB71243024C627CEAC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFEA8A2686A51622C3E5B9F373AF52626300E8ADEC78EC0D7DC2807A2F3F6B43D1E80DAFFC47B24EFF58CF1FE2B37DBE10001FABD5F0BBD70D66FC8896552336569188EE975B8B1B39457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t9vcwvJsGGJ/Q==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498113902588151D385CEA62B7A4765414871F283CC98C034A737BFAD2062C45D6D62C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD60F3889908575E02049FFFDB7839CE9E676DC208F0F4A05787DBD83E3C3C6ADC3723A190316B2DE923FA25777803A10D
X-7FA49CB5: 0D63561A33F958A5839001B5FD176FC06B951A06F851E1BE35B5EAECE2A4CD458941B15DA834481FA18204E546F3947C07E7064A143892FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006377827508AE46B0BF5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C34B556A7116F344E835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZkLXUwYT7t9Tv9QF8esWHA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series of patches is based on the series from Manivannan:
https://lore.kernel.org/all/20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org/

Patch from David adding a UFS nodes for SC7180(SM7125):
https://lore.kernel.org/all/20240121-sm7125-upstream-v4-6-f7d1212c8ebb@gmail.com/

The patch submitted by David and a series of patches submitted by Manivannan
were both applied at approximately the same time. As a result, David's patch
did not include this change.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: cros-qcom-dts-watchers@chromium.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: David Wronek <davidwronek@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
  arm64: dts: qcom: sc7180: Fix UFS PHY clocks

 .../bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml          | 1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi                     | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.44.0


