Return-Path: <linux-kernel+bounces-69972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D088590FC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62716282480
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F07D41C;
	Sat, 17 Feb 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="ACn6qfAv"
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [95.163.41.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693E1E515;
	Sat, 17 Feb 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187538; cv=none; b=ACUdFl/8UR5tIJYwGwQ0X0wlfuU1cwNnMTQJC3byjdzMr24GCsdz2UpNfCcPlkeDMr7FTWXYkN0OFg9Au/+4VVtm+EgP/x8OcRu+lILRBLWNxNJuuwR5yT8FuGqH2693rOjRHEQDCgZw6THHZhNy0O2MisHjU1Fk2hcXesFrnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187538; c=relaxed/simple;
	bh=waglkRq94cLkRSous5xScSg8E8aFCegITD/5AY8Akac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eghMmQ+xVV5aNjQUKs2CDUYISalOquCBEhbplU0FY1QmIWKkJkUIR+5/in3Zr/8kOBHIDfL47cA6wHXRHp4yfQZGmsiK940QOMY5Swbc/7gfbDd/mw9xCqyGRS3vgTcD/rA+LpDZ0rMkqqkr0hBOu7kNZG3QCZI3lsmgL071OWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=ACn6qfAv; arc=none smtp.client-ip=95.163.41.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=NYP0KqzX39FH1HEpHcvssyRqiC//HetrlMj6XNjdpfs=; t=1708187534; x=1708277534; 
	b=ACn6qfAv0bH6BhNTdwnGs+kkn0PlP3EsS+KMfNv13dWrJbbGfWF/srhao7wr7pt/MIuM3FXHuZ+
	X/xMa/uD6qY9uADjRGLAco5eosARS4ALDarqLZgiQH6oyVNtTzV34ZKTnXFy0u4j2alNLpGGSelW9
	fCc8oHCWh9BshdVvutE=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbNbf-00000008KBa-2n3G; Sat, 17 Feb 2024 19:32:04 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	bryan.odonoghue@linaro.org,
	gregkh@linuxfoundation.org,
	quic_wcheng@quicinc.com
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/3] arm64: dts: qcom: pm6150: Add typec support for PM6150
Date: Sat, 17 Feb 2024 19:31:58 +0300
Message-ID: <20240217163201.32989-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp53.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F5DFE3806F3A3DF1421ED8B206DEDB9600894C459B0CD1B9C6411566744052ABDCA9057F3E010A398FC044E4EE471DF874EE5BCF6350D8DFF8D9167951636B18
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70CB15FA6C489297DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063770995E888C5C26978638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87E9E3603502ACF502CF864E62A0E4A14C7E99F3F0C092272CC7F00164DA146DAFE8445B8C89999728AA50765F7900637B18CEC08E50EEB57389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CA816C540FC8EEC306136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3DE2BA4B60159ED7ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3201FE35DE540CA6935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A51962CA89E85192B35002B1117B3ED696A5A6F3C7289C73D2219207EC0A953D2C823CB91A9FED034534781492E4B8EEAD5E26F3260102D3FBC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFEE357A508B1C8125771F5C3AEF051970561393F3354666DC036304226AC371BBB0F06D2F9487D0FC34E84B500378195F15D84306A814E3A90B037B6FA0204BA50FDA6F562D417CA2457F7985AD47CF5C02C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojWUnWVIzXWr5lYuf/vhlIdA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498170F032DA97786BD29B464708D7791FD7B054138B21F9AF6C0760E49D7F1F5FBD2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok

This series adds typec support for PM6150. Was tested on SM7150
(xiaomi-surya).

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (3):
  dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible
  dt-bindings: usb: qcom,pmic-typec: Add support for the PM6150 PMIC
  arm64: dts: qcom: pm6150: define USB-C related blocks

 .../regulator/qcom,usb-vbus-regulator.yaml    |  9 +++-
 .../bindings/usb/qcom,pmic-typec.yaml         |  9 +++-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          | 46 +++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.43.2


