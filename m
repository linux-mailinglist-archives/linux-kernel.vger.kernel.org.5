Return-Path: <linux-kernel+bounces-105289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B687DB73
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234751F21654
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDF71C29C;
	Sat, 16 Mar 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sicamp.ru header.i=@sicamp.ru header.b="csvzupis";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sicamp.ru header.i=@sicamp.ru header.b="T0FMrEPz"
Received: from fallback16.i.mail.ru (fallback16.i.mail.ru [79.137.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6F1C691;
	Sat, 16 Mar 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710621852; cv=none; b=Dw2+v0YKwQiqtXfrEaPFRFGaAhnMc9IZR6KHSOBTS4dN97IRKWVAfhkpWfQUHe+Tu6QUKKeIvWx6GAGslq23qYtomph/r+IihTaF1uLYSa2PzjTVo6+cHDS25IMzVWYGRfbxSAacG1EMXZll7PkuwDg+1DSqVc1f8YFSKZgYiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710621852; c=relaxed/simple;
	bh=ylsLLQnnV84Qsh7+pVU7K6Xy0L6EE8SrPRtjXjXDYvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKbTEsWWJ9MYOPjJYs22pXfFIe1pOJO6QAFBoFQlueloJUbTdYsKHI3U6ws1u7xADDrvz/dfglgH9h630SoLsRF75C+FrZs3Gtc3STTHjA3x9Afqouwaw/ZcOrPip3ixMRsNUHjGrqzesTso1JYnqdNEXd4lDgXbDGpabdejJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicamp.ru; spf=pass smtp.mailfrom=sicamp.ru; dkim=pass (1024-bit key) header.d=sicamp.ru header.i=@sicamp.ru header.b=csvzupis; dkim=pass (1024-bit key) header.d=sicamp.ru header.i=@sicamp.ru header.b=T0FMrEPz; arc=none smtp.client-ip=79.137.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sicamp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sicamp.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sicamp.ru; s=mailru;
	h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lVXxi9IxNWmRp/ln4bzTwbRHGkBocTuN05zUBMJcyLo=;
	t=1710621847;x=1710711847; 
	b=csvzupisxpPor6FEP9g4Yp/F/fHI3FVnDhseySkk2Se1ORsflaCsdjJ40svkXMrlhoEr4VlDIP1HRSHQx06Q9nFwSnP7lczREnCQkoFxpMTRhuNxhZXWKaa7U/fsogJGyeYtYCdKtgjXr1JOfGPanQH/buCRpdy1uyjKGWm8sS0=;
Received: from [10.12.4.19] (port=39914 helo=smtp43.i.mail.ru)
	by fallback16.i.mail.ru with esmtp (envelope-from <mrfoxygmfr@sicamp.ru>)
	id 1rlajj-00C6Kr-58; Sat, 16 Mar 2024 23:34:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sicamp.ru;
	s=mailru; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=lVXxi9IxNWmRp/ln4bzTwbRHGkBocTuN05zUBMJcyLo=; t=1710621275; x=1710711275; 
	b=T0FMrEPzRQ5kCfdeKlFlvqpJ9ibh0u7ScVto4hAUhrXBsGnpZSDoTH6hUpFKe/J5fqMqu77E+jA
	FyRfMYHU7yUfYCkh6qRZGpsBSQFyRMguSl2NMqfUickBJIJ+Qo55kEgkfsdiBKnErxoqPq6m6C1/1
	4K5bnsk+6L6owpO7Dpo=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <mrfoxygmfr@sicamp.ru>)
	id 1rlaja-00000000JP8-0Bbg; Sat, 16 Mar 2024 23:34:26 +0300
From: Grigory Bazilevich <bazilevich@sicamp.ru>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xin Ji <xji@analogixsemi.com>
Cc: Grigory Bazilevich <bazilevich@sicamp.ru>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] usb: typec: anx7411: Fix possible buffer overflow in anx7411_send_msg()
Date: Sat, 16 Mar 2024 23:33:53 +0300
Message-ID: <20240316203354.81591-1-bazilevich@sicamp.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mrfoxygmfr@sicamp.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597D173D0CE202DA28435F3B31DD656B8ACF182A05F538085040965117704A033EDD3DE06ABAFEAF670503EBC60C8AC65EEF45885973D0583CF81C9689494080BA7D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063720E5706DB08A2EAB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D805D75382964749EBAE2ABD947F765C3D893CDE14E5090B84CC7F00164DA146DAFE8445B8C89999728AA50765F7900637B18CEC08E50EEB57389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87BD21ED50D08CA4DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C62B3BD3CC35DA588302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3640AEE228148B153BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3F199082E59C9579835872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5C923A40FC14B0F455002B1117B3ED69687F668855384E661466072E6821086B3823CB91A9FED034534781492E4B8EEAD81B3E0F64AD3EF57C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE8717B14BB7B798BF7CA976B6C69600F433280D88872D5C14076FC139CD2CB8C8853F4E7B59623286CD0533D1BDF67EDA6BCDB4E4F9537E1FFD8A2475C8AB6C18422609D9710C5E736DDF96CB8D31E6A913E6812662D5F2A14F1DC29B890BA2A817439048FAE4D0BABD31F06B4533AA243082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcN8O91JMjzAaw==
X-Mailru-Sender: 1C8DD052CC8233A67C1FA63D918B7A582D2B82C55DCF0DE9B951B70A5BD4BD8E8501BE5CB54ECA669BBFB9D4C9B76856BE9C9B5F28F20EABAAFFD2005305549D6CC0A454D2D0B841F81C657903A81459BE340425E6CAE346B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F55EC4B11F4A1BFD60049FFFDB7839CE9E3B76AC3706630B51641E7F83528A66333FB82B451FAB97580704883AC02714AA
X-7FA49CB5: 0D63561A33F958A5D257B5263A0316668BB8E8C879237E6528FC0C15DC2E66F28941B15DA834481FA18204E546F3947CB645AEB2D65EEA52117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7EF2A066DDA19BA868941B15DA834481F9449624AB7ADAF3735872C767BF85DA227C277FBC8AE2E8BB57D3774856AD8A875ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpAzVD49/gcOBULQ/X+YEOw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Passing a size argument greater than or equal to MAX_BUF_LEN causes
a buffer overflow when the checksum is written.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Signed-off-by: Grigory Bazilevich <bazilevich@sicamp.ru>
---
 drivers/usb/typec/anx7411.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index b12a07edc71b..70ba56dfb22b 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -733,7 +733,7 @@ static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
 	u8 crc;
 	int ret;
 
-	size = min_t(u8, size, (u8)MAX_BUF_LEN);
+	size = min_t(u8, size, (u8)(MAX_BUF_LEN - 1));
 	memcpy(msg->buf, buf, size);
 	msg->msg_type = type;
 	/* msg len equals buffer length + msg_type */
-- 
2.39.2


