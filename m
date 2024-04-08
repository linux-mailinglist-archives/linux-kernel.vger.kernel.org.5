Return-Path: <linux-kernel+bounces-135589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047EB89C80C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3537B1C22931
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F3B13F45B;
	Mon,  8 Apr 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="FcpHsEul"
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [95.163.41.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611813F44E;
	Mon,  8 Apr 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589572; cv=none; b=aKfkfDMBgB1WheXIJGBu4/l93CFxnjJY9l5rlQY7xVgbtBRxhx/tZLITidvJKkRAhu58Rf1Jggikj4Ekhxvx2Xn7eh2FJ8EFcaZRy5nhJEHpe895cnWeQnK4mRvR5aEU4lueFJkmxhxOn8QRMms6SArp6WM3pBEohEBz7WnBVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589572; c=relaxed/simple;
	bh=p3uqGizp9xIMGF6CjhHwqsqD088dKF3LY0AdqM5qQiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFb5aM6DJzxfmgwN5bZCdoCTOWOSWiQGFDG28WdeL1RGk17hSlEq6IxvToNWJSJMLK/mjT/B6+wA+ZHzFh6dLZ8DI1AvTaByweWUj2z+CeMMK1qzdAQttTv3ebqmLAKH+ntAEy7jVtKjeMuAIwd2XCSoBAvLExYF52tf6hDm/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=FcpHsEul; arc=none smtp.client-ip=95.163.41.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wx+/Kt3SIcMw3DZo1mkGE7FX70+jMpgo7G/HwD3+K2o=; t=1712589569; x=1712679569; 
	b=FcpHsEul1rKfWo/Dct7yBjiBIVoFpc8lod+TQZ+7mLtSeGmvQvn2Ow4R+qd8mTwyMV5EpUYvqGz
	2nUdWGEH+c42fO7M9u9KgHOtGQP8Br+q/CtVh0lurxJ2pUt/3Rwg1acXICpYI68rpwiLSDAQXCLYM
	fd8Uw3euwIr+3e8wKco1+Fcy8h5hMJA3mPhhclm5nfbb+fkHI0lQkTNvxLL3jjswi2WoXfpdwGDon
	aikQ4znIm/E6hejCNrgrA0AjC+JoOzxPHQhhYQkFhqiKVq59Dwo3VeqqgK1Or+JrSuyRQh+hfEaLk
	Fp3WfYzWX0MyYHdZvadcbJvP8dbykpfqHfgg==;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rtqmG-00000006bN0-0nLt; Mon, 08 Apr 2024 18:19:20 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "end . to . start" <end.to.start@mail.ru>
Subject: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
Date: Mon,  8 Apr 2024 18:19:14 +0300
Message-ID: <20240408151914.44030-1-end.to.start@mail.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp30.i.mail.ru; auth=pass smtp.auth=end.to.start@mail.ru smtp.mailfrom=end.to.start@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D37A377202123D15E2FF4702E432B109B7182A05F538085040B9323BDBBFC7CCBD2EB5D77EF37489D18698FC1950636B7EF5BE69892C5964BCB9C4F2611CB3DCF4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7492D3E4238663367EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DEEC83A7CF8598608638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D800B9EE98F4FEBD2DF439883391C714277B47D1ECFEE2ACF220879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006372A3B24BF85B2E607389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C223C850C947643096136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3577BF6776F123B00BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFD6B8D1F75A55B56DE827F84554CEF50127C277FBC8AE2E8BF1175FABE1C0F9B6AAAE862A0553A3920E30A4C9C8E338DA207FAB6C32963C0243847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5C44FD24CCC68300E5002B1117B3ED696CB6082D8DACE180919AC5B239BAD4335823CB91A9FED034534781492E4B8EEAD5973B86847D985D2C79554A2A72441328621D336A7BC284946AD531847A6065A27ED053E960B195EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF45B00B261A430CA5BBCEDE6F76895AB947921DF39F88E614015E91357665F65FE98901B1639BBD631CFDFDFCAF5E4A4B332E52EB94E5ADE41C1AE82A563365E59F3DF397AF4625935F4332CA8FE04980913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojabKNeIbMV3tT9US8tr4Y6g==
X-Mailru-Sender: F34414D909EE10BD7829694AFAC1E959B249BAAA1DC6BB89B951B70A5BD4BD8E5BD28AA36A3542F6F817479B9098B064C773E5EF782A67EF9314192DE98EED7FA9800083D4B72A528C9769C13AF3BBAE440A67913D6ED084D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok

This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working

Signed-off-by: end.to.start <end.to.start@mail.ru>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7..1760b5d42 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.44.0


