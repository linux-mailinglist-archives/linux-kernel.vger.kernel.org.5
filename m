Return-Path: <linux-kernel+bounces-135592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C089C818
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C8284131
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2D140381;
	Mon,  8 Apr 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="HoUXJp6S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="yjqDBG6G"
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4313F45E;
	Mon,  8 Apr 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589745; cv=none; b=Y9I72atoNvvlC2G+6Csm4y503ASbeXsFPBSvJn77mvA9x8pcsfVHpTMlgVV9F0vIUxGacxt2VRVPcd9uSB8mF4llMjJ4oVYq4ByQZ4n37cI/qRhR9glSVa6Ykwqr/NYt1m8339c8Bv0c4mLKj6+7AZzDj84LVej6IQu6UVeM8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589745; c=relaxed/simple;
	bh=p3uqGizp9xIMGF6CjhHwqsqD088dKF3LY0AdqM5qQiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qq7rG6g6x6UyRiRE8C0PWuOCEpzuPSdcajUKtR5mWBZl/ZD8bGSepzcaheLzy7jNRyHAZDceshtJPK+hVsY//2a0KfXmX52fGMy3fBLAwByXogC9DYNSLY0sAdkcGHkV7eqIOc9lF7CwSUR7FYBW/oCZbbonwShRceCZ1btnu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=HoUXJp6S; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=yjqDBG6G; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wx+/Kt3SIcMw3DZo1mkGE7FX70+jMpgo7G/HwD3+K2o=;
	t=1712589742;x=1712679742; 
	b=HoUXJp6SeqVinIgCUBN52+/roPTJLzz2FJjeVhKtjKZddGdr2I0O8zDlLsM7FYxP/226b/GAXAGwRdlaGhDUWxNWVdGCXcFWMelc1C1scfJPzANjZS+6bV4HufizFmONdSZx11pnivn0lYeuZw5riIzh0e/tk864cP4pzyxQTEiIrg3Iy8EkHSKTYl2GsFDlqvMr2xAM4Ruv6q2E8aKBVnrfXMpYeUv8X4YcE9zF6Yj6l6JOT1E05VvaskijyYEU9ALTws/O4BUNxPqxax0rzT2yCyG/iZqdPa10BFe9V7CZH59zYAMkP/fbOeSmcH2XIajKKdB8r/U/gPJTTf83sQ==;
Received: from [10.12.4.14] (port=36942 helo=smtp39.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rtqdF-000xdo-ME; Mon, 08 Apr 2024 18:10:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wx+/Kt3SIcMw3DZo1mkGE7FX70+jMpgo7G/HwD3+K2o=; t=1712589001; x=1712679001; 
	b=yjqDBG6G0J5L2MHnjxjVOoKN7xNAN7I5ksll1/A0v1aaK9FTZ8MhOX/P+CP7cPSFp/R9ZX87sTR
	NVFE21oW+67Iw8zEJPChONI2S3VTJQx3AeQ6xFGBHW1JIx4Dz1qRQFKnBv3oH7GDgUxSaKypFvjNo
	muXDT4WaLcs0EEeSBz/eF0NsPRACa3Uby2QOvIupqq1BJHBata63LpDzV4Ddh0H6/kArHI+/h7SeJ
	gs1DkFNXZtkq1p8f511xWhUKVlegivV5+CnjIEqHzLW0a4aKdk94WtS/Q6UH6C6B1uqtwHdSObUsi
	2p8xWKsHJfA/SPV8R7qp+eXYJ/jgmjQGqTLw==;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rtqd2-000000009jk-20tw; Mon, 08 Apr 2024 18:09:48 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"end . to . start" <end.to.start@mail.ru>
Subject: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
Date: Mon,  8 Apr 2024 18:09:05 +0300
Message-ID: <20240408150905.43407-1-end.to.start@mail.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D31116567C8E3CFDFF0E1C6585A2586D0D182A05F53808504030E86D195FBFA14D3DE06ABAFEAF6705ECCA9D1F5DDEDF42BBAA07CA003C8BA6BC0FEE398BF55443
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7492D3E4238663367EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DEEC83A7CF8598608638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D805961545C5C777FD9EB30F61FB181D1959AD1E186B66E7AF20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006372A3B24BF85B2E607389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C0085B890FD2717DA302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C34B26726BD97DF1CFBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFB73CFAAED92B6E131DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE796B81110D3CD4288731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A56F17E783356658EC5002B1117B3ED6960CA70ABAE5EA647230E4A65F242F5898823CB91A9FED034534781492E4B8EEADABF80F987DAEDACBC79554A2A72441328621D336A7BC284946AD531847A6065A27ED053E960B195EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF45B00B261A430CA5BBCEDE6F76895AB947921DF39F88E614015E91357665F65FE98901B1639BBD631CFDFDFCAF5E4A4B417BCEB617B21AD3031AFA059D85FBFFD5C9CA713F8CFD3936DDF96CB8D31E6A913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojabKNeIbMV3uh7/WLBVO8nQ==
X-Mailru-Sender: F34414D909EE10BD7829694AFAC1E9592C6A313979055771B951B70A5BD4BD8E35E73068979AA8954C683740FFAD31F6C773E5EF782A67EF9314192DE98EED7FA9800083D4B72A528C9769C13AF3BBAE440A67913D6ED084D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-4EC0790: 1
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872E8DC4F42B55D8A582718B3D7011F544C268F3CF0E9FE49B695C3EC5CDC8399ABC44D82FE0EB9EC2B801A36E2F7E7FBFCD39401918445667E6
X-7FA49CB5: 0D63561A33F958A5889B563FAA9B3D83BE5021A100EE5A3BCF32B16F353EAC16CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7535881B9F39D4165731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojabKNeIbMV3txdPNMKTGzKQ==
X-Mailru-MI: 8002000000000800
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


