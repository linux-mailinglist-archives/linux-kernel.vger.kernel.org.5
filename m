Return-Path: <linux-kernel+bounces-8990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403481BEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60291C24416
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F574087;
	Thu, 21 Dec 2023 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Lip4jeeK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="jwxVZ4m5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41428651A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8z752kWn2ItQPo1gIar/HLa1/HPTgnoBsS+XUrRGhd8=;
	t=1703185897;x=1703275897; 
	b=Lip4jeeKo7cCeKiLtcnLuDSI5Cmr9eRQbv8mMW15CyZRs31FNypkvEoVqBzn7rcmaMUZ/aXlPYsUFzYorXF35oSMUK39JQ22PzDfS78wDYKXwZYoTO/DoUi8ium9cDX7DWojq9nNPRftToqa5OP6IVP28icpul2Mr+S7eQFDe5SIa+Pil0Bj5oitLD1l6MKy8YLJd6ctoe4sC+KMCHTNPRke88FyU9TlDCCtRkOV80rPRtVCBcTbZwCiW9VUbPwE5TQ7wSnSxhk9Pq8ppHpm/v8l4AchebUNhdVsea+iCM7Z8BCqyAv575rVmQmzC+RCK2hXEqMI2I+vwwWcAZerkQ==;
Received: from [10.12.4.5] (port=41172 helo=smtp31.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1rGO9c-00HFp7-1i; Thu, 21 Dec 2023 21:52:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8z752kWn2ItQPo1gIar/HLa1/HPTgnoBsS+XUrRGhd8=; t=1703184740; x=1703274740; 
	b=jwxVZ4m5mKbhOx5xbOyf8rvm24LTBkWILTngfCcCTinLQj27eOLhHomIjhar/tsvPbaG3THUPT3
	m9v8KnatS5OU1cKWqm0VS4+/JAAGBHquWUwki5zULTDYCMHDI0z8f8ozsJkRw1u0blKovc3NfPcct
	OFC8h48fTgX9yd/7m7MnKPg7SpYzMFgpyHuNMfnejhaO/IE90vV9wi7LNQMhJyX2dprZnDNp4WoPa
	5HEMsNlBupuZr8Z7522INuQIjQLMICNN1kX5QAz/kygnY+55WjO8GiMZZp9Dp0Sk7B+ov12KWQPvv
	IKgb7OgBzlOWK/EUmZUc7AzXlZd7SJ2/hz1w==;
Received: by smtp31.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1rGO9L-00E989-1Z; Thu, 21 Dec 2023 21:52:03 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	robh@kernel.org,
	jiaxun.yang@flygoat.com,
	mpe@ellerman.id.au,
	aou@eecs.berkeley.edu,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if RISCV_DMA_NONCOHERENT is not set
Date: Thu, 21 Dec 2023 21:51:52 +0300
Message-Id: <20231221185152.327231-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9F008C97756F746CAE2B75521B1C23978BC5B3227EFB96EBE182A05F538085040370FE867DC3D4720A26974E0E12F2DC15DD9759C82CEB7C379A875CD76395E03
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A179494B5629353BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B997C8222C70C3D98638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8202B07C5C43061E46D7D784B04609B7D6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C592797616C97AB9FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86DF04B652EEC242312D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B63AF70AF8205D7DCA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A45692FFBBD75A6A089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5E90DC88608AF0C30D34BED36B961B47FBC9D70AD38F4B40CF87CCE6106E1FC07E67D4AC08A07B9B013BDA61BF53F5E1D9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCA5E698E74EB8E346FD914991A9554B3B451BD46D1873B37D883D4BC84590BAB0AA6441730D2A0F05FCFFA5448E432FF0300F8D3E5E7DFA5CBF13CAC92B0A663464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojd2R+qgYPpI3akiytHA9YmA==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE338AC28B8DC0150D286D00A84E9A3A6A6998CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46003E5D5A82ECDADC2F54683050715113578B945116E05EF049FFFDB7839CE9E0BADB79DF678AC5C3345F7B7C955DDA8131804649FAB4F6995E81222B0481DB8
X-7FA49CB5: 0D63561A33F958A503885CF79F8AEBA231C30751BF23E975D39B34D880AD07E9CACD7DF95DA8FC8BD5E8D9A59859A8B6FABAEF6C2F5AA74ACC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7F45C1E71A9DFFA2A731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojd2R+qgYPpI0onwr0MP0RrQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Not all the RISCV are DMA coherent by default. Moreover we have
RISCV_DMA_NONCOHERENT option.
So set ARCH_DMA_DEFAULT_COHERENT only when RISCV_DMA_NONCOHERENT is not set

Fixes: c00a60d6f4a1 ("of: address: always use dma_default_coherent for default coherency")
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6824bec2c00..111c5d92d503 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,7 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ARCH_DMA_DEFAULT_COHERENT
+	select ARCH_DMA_DEFAULT_COHERENT if !RISCV_DMA_NONCOHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
-- 
2.40.1


