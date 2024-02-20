Return-Path: <linux-kernel+bounces-73666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E185C5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFAB1F21359
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFDA14C59A;
	Tue, 20 Feb 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="TN/PwmLc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="sXhXx7IQ"
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8E612D7;
	Tue, 20 Feb 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460537; cv=none; b=ai0iS2VaSn/zUqw6x3JAYhe+Uyo2hUjr31/VEa6n9ODI2A4PN1i1KWxQ2DQRi9vyiS+VxIAjxPftMYhBQ8dP0Azpm8IWtjHpQmUuKBomYhn5NDm3dTiuLucT9Qn9g2HrTKID6ro8KDliLcX5cnaPadonBDi9xF5+uLGbSrIEgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460537; c=relaxed/simple;
	bh=3E4MLkiFuwBFKarsqUzr5SifAuxcGtnLlgXY64OF8Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKtXCK1Dj8Tcv4NPAm4C6AH2qiG5CjQymFZQlwfTAxFkCIK09KZcgXwviIA0bZik3RnqB/7eSlrp5nt7/XGJ69ecv6RwfrkTJSFcpA3Q0DRHGj6hxdJTluIVVwV1kIQsHh1uxxmuUl4jHzK1d25X0L9bWL1W/dEt/oFSgUckg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=TN/PwmLc; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=sXhXx7IQ; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/23HhppizU5teo7s0TVpESXlpsTlRcLJEORAPFoVi/c=;
	t=1708460535;x=1708550535; 
	b=TN/PwmLcgMvtrHUJv/UvcESkPnJLNZdpz3SuJB8iLiuAQKXfwo/670nuEJkXrfub8r1WPcBgkjqH4Rhhhb/9K4Sw2Q3i8ABZFV/I3q0NSMRyfIKW1S9hrbwHOOvpP9Egs1apYFYEl2Pnq7F8VIuQB/fbkveNy4O9Qeh7ZExGG3M=;
Received: from [10.12.4.26] (port=54584 helo=smtp50.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rcWcw-000lZH-PO; Tue, 20 Feb 2024 23:22:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=/23HhppizU5teo7s0TVpESXlpsTlRcLJEORAPFoVi/c=; t=1708460526; x=1708550526; 
	b=sXhXx7IQiP0PvbfiIAgV3OfM+mCE9GbddFXdRyUCtubkJlyZUMitBUQRUpS7dpieOY7JvBhFoCJ
	Eh4nNmyTFOVdUG5aK6UdmCuz9vDoGbxxDtO5x2jDEAwyUHwsUW91QxXu5YhwdrU/TerqcY7nZowh6
	jmTGRD426UhUYuiUcVs=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rcWcg-0000000BzSN-2EA0; Tue, 20 Feb 2024 23:21:51 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: bryan.odonoghue@linaro.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: qcom: pm6150: Add typec support for PM6150
Date: Tue, 20 Feb 2024 23:21:45 +0300
Message-ID: <20240220202147.228911-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021A4088691FB60B4B8D975C14E9881615F00894C459B0CD1B99D553C75EC2FCE92FFB2F1BA4D151868A6BECC4A1668E3AB6DC888E7B15EF0D45F9067195EC86057
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F2393C4755A27B53EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637352A1F9739ED04D38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FF2381FAD6D9207E69776ED762CC1B4334536186EC4BDB88CC7F00164DA146DAFE8445B8C89999728AA50765F790063767B9C6E70FBE8DD8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC878444BBB7636F62AF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDA7BFA4571439BB2AD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30F1327A8DDF03E57BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3ADE50F0DA4A4E48C35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A598B14B2296C2CBF55002B1117B3ED6964AE3E96169070B664869453249F34FA4823CB91A9FED034534781492E4B8EEAD05E80F4396618BB2C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9A3339327BFF3DA8DD9398A4720105F57F0866819A6A4B3A787603E93AC8B1C2B23470503F0B8DDFF1AD97FD9824DBCD378DBA4B44E23A7EC74530A4B3B7F0BEB0CF564DAC222AD0146D90F64BF3396102C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVClFNp2JagLBcg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981CD4E5312E4C90D18EDE2FBCE1621770AE4E4237182B44ECFE42C4E39D2ED70212C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C90205846E38A0579049FFFDB7839CE9E76E35804B2850F204C3A487B7DB4408995EBF8936FA3539D66A481B74CE84283
X-7FA49CB5: 0D63561A33F958A5094F982880FE9456460509FB89EFD4EEDBA1162031844C7E8941B15DA834481FA18204E546F3947C1E06CC37AB71BBECF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006374826D2517DB07896389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C35CB5556AFF48B99435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojiWfz0I2sVCkiBDDYAGIU2g==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds typec support for PM6150. Was tested on SM7150
(xiaomi-surya).

Changes in v2:
- Drop the patch 1 (from v1), since it has already been applied:
[1/3] dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150
compatible (commit <ec29a4d9b7c7>)
- Add Reviewed-by: Krzysztof for patch 1
- Add Reviewed-by: Dmitry for patch 2
- Fix typo in commit msg for patch 2 (Quacomm/Qualcomm)
- Fix IRQ flags in patch 2 according PM8150B (Bryan && Dmitry)
- Link to v1:
https://lore.kernel.org/all/20240217163201.32989-1-danila@jiaxyga.com/

To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
  arm64: dts: qcom: pm6150: define USB-C related blocks

 .../bindings/usb/qcom,pmic-typec.yaml         | 11 +++--
 arch/arm64/boot/dts/qcom/pm6150.dtsi          | 46 +++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

-- 
2.43.2


