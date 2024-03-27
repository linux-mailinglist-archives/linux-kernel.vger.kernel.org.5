Return-Path: <linux-kernel+bounces-121782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9E88EDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C431C2EAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52B14E2E4;
	Wed, 27 Mar 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="siyrYAwG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Wm/sJgoO"
Received: from fallback24.i.mail.ru (fallback24.i.mail.ru [79.137.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FF131BCF;
	Wed, 27 Mar 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562831; cv=none; b=jiB/mkUisQ5bP6P0WxJoV/BnhIEx1Sc9BFmDhayOuA2J+4QDPs2s5Q09urN4jIGCGLpjETUGcD35kZLoEWW11bx5aWmoI4+t/7BszTHJQFNaYqKtvKwYHdKGKfCNKyJt5EpSk07XefvGtGlMGH/FM/4i9AO16qGR2BACdQhHwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562831; c=relaxed/simple;
	bh=mQIQDbM97VVKGtE6f0hcV7pSxonc/xRXvuH4LyGXWQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5ABmCCNBiScW72KuxFbltevD/e7yOPRi/QmlDawkBpGdwHYSflgNH1cUxCewPAsRztjg2hyy0GT9Ki4OwooKw7dkqmguGnftSevzzdVPqhoDkZq7i2oCXUAYcyD6381CWg1NqCZgA8GfwxNhQ5Q2VrpZTp+llLt3ZhqtWV6enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=siyrYAwG; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Wm/sJgoO; arc=none smtp.client-ip=79.137.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Kl4DAfMrThUTbEpsy8OIaWRx4ECJjsEC+DZgg6JUlFE=;
	t=1711562828;x=1711652828; 
	b=siyrYAwG7KDQJcmlpU2fbl27nG5FgzwU/HdlHIUuZWJZbvYLCKaKNg9Y80r+Onb1XG7m3wj+1qtMNJX3PnVL9hjHBoVuLo4l8LJTCz/gW5zAbt4+yaquhmADpTocBowNQv7vdzg0bD4DIr7VkF0UC8rQifXeg+AUECvBQFfL2Lk=;
Received: from [10.12.4.29] (port=49644 helo=smtp51.i.mail.ru)
	by fallback24.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rpXfx-003NBS-8n; Wed, 27 Mar 2024 21:07:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Kl4DAfMrThUTbEpsy8OIaWRx4ECJjsEC+DZgg6JUlFE=; t=1711562821; x=1711652821; 
	b=Wm/sJgoOemmBhF5vww4DNpEpQv+MFE3gSA7kcwzShTGwmMACHt12OrEasDilNYbXqhSIjVP5cpG
	pgPI9K32WgsAunonTL9EKupkCgBVIwC24c2ep2Z4ZLIOqe6l4wtiFSedOmWiXNqGp6iBNZI8JraYS
	LexoVKsoroM34gvwMgU=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rpXfh-0000000E2q5-0q4E; Wed, 27 Mar 2024 21:06:45 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] phy: qcom-qmp-ufs: Add support for SM8475
Date: Wed, 27 Mar 2024 21:06:40 +0300
Message-ID: <20240327180642.20146-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD92B2F338B3A1B03DBC32C72577B1B4A4B195BE4FF90B52CC2182A05F5380850404C228DA9ACA6FE27D2B3368C890E70B603ED270C30F246C5224714DC9D89A041FEB17DC202E68E303EE2A1A432EA2933
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70043D879A87EF1BCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C867FEFF36BCDF178638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83B0D53EBDBBEB31787CFF83901193707C9582587F0825ED9CC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C34964A708C60C975A117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFA281FA8EA08C6015BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6088EA859A876218C76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B615F38A1EB2280F99089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A572F24DCADD00AF615002B1117B3ED696A07DC1F01FB75464E772F934B9BCD185823CB91A9FED034534781492E4B8EEAD5C5DFC4BFF39B799F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF962540E96D3749566F3157B2473DCC9B393CF9C2F1A5992CA52A15E792DBBD0575F3776783CA996BF212F37558E72466442710B1986103C2E5E1C781D7312E8BFB0F00F6D3F2FCEA42BF32D1DA1046D202C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojRawEQSF5UtvrSC67IYQ+kA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981DE6AB1E6944A41F4E693A2F4CD4B10000F9BD50AEF180468C84098C9553D294F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD60F3889908575E02049FFFDB7839CE9E088A9832E852848505BC316D8B91A368610446C7B24AE8BF0162CE7EF3E6A363
X-7FA49CB5: 0D63561A33F958A57EDBABF2EAF213584906D23894274437BBB3F00DD3EAA9B88941B15DA834481FA18204E546F3947C68B9A68E260AC75CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637DFC0370CCA7FDEF5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3F65C0D82C631A427089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojRawEQSF5UtujJgOAMFub9A==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds UFS QMP support for Qualcomm SM8475 SoC.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM8475
  phy: qcom-qmp-ufs: Add SM8475 support

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  2 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 71 +++++++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.44.0


