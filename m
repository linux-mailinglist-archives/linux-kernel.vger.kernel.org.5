Return-Path: <linux-kernel+bounces-134379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8D89B0D9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989441F21824
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAB024B4A;
	Sun,  7 Apr 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="zL0VKq9R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="Zpt1fWEu"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2023772
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493633; cv=none; b=AhR0ioWtG6yphtkD7v4tzkJQoHuGHzfhhldNiEsbxCg7YQ3LEw5ubqeVZiXevihPPcQ5LHQV7mU6APe6Z6yI6TWnSir6JyM6XrdVCYZ/lxNGXpNmtQyzdVvKaIOabMFyyRwYt96j2bEsGgXYOYOGbtMdP1ToxJneDRKRrA0FaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493633; c=relaxed/simple;
	bh=fRgtLU64VmPj1RO8aNoSSRiD5pgeaJ/c24+Azmvwe5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLxbd3D+q2cSNHyz3L+L1OTYSpGw5WlZASt2LCzmU17zOqc4QxMXzW5drC3XZCzSqtMWDmYkcjbULOf+Aq1HLh6HOwqyZnkKLN4z/yqr2naZ5hqmf69IaX93sXygm4kZwGuRG983kwkX9o0tzafSoWANdsy3eZugUPoknvsND/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=zL0VKq9R; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Zpt1fWEu; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=pS0J51qkDW3l6yHbMntKpzwzWZ1OozH3qDAmrSmG5EM=;
	t=1712493629;x=1712583629; 
	b=zL0VKq9Rxvb6cJFTMrrsLrJV6BLSnXAktD8W6TJn2p7AV3mzVMkwUYZ32YBoW8sn6ZLKAEl9nBOIEGnjKo7w+a2ufh5+4+jodB5UuJTqf7WokUm38EqIZ2RED/IinTF+4plZ3ys/skphgNMUMu+4vx16mdTpiOuhMzlDfAQNEsXi3hLY43BGO59pQ1zqkqRlt2lDlSHlPKjnLhuZ42gUZBrH6r/KQ7DbmQGLi/VdArJfjNhIgOSk/23jF2JmQki0cXh1pUGtH7gYs/67TdPII8QJT1n0Yla/xctHB1ZbySXNJIEcTXyB5iAYWAeyB4ghExk/JXaohYD8yhgBci9z1A==;
Received: from [10.12.4.18] (port=54070 helo=smtp45.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rtRow-000lyE-V3
	for linux-kernel@vger.kernel.org; Sun, 07 Apr 2024 15:40:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=pS0J51qkDW3l6yHbMntKpzwzWZ1OozH3qDAmrSmG5EM=; t=1712493626; x=1712583626; 
	b=Zpt1fWEun4+3dRBcclRzIdyYntalBwwDBkSgDKZRT8odm5P/RilmC9XJf5Zg5JflObiznONSur3
	VOEQXCpjA3pv8S569R5ok2An1sez2vrMBerO7XuZHp4zcpSW1+v9nV1OlMhMrJ94wK2JMZzIZ7wBj
	pdkLjhGxU0LzpBTzfV1Td+uhd/572cdzgY3v6oleSmjFTwhSj+Q6S9DWK7hJodgNCfLyYfCdpyCnT
	eKpLGveu6h73thLkri51eu+Q0QGbIaNrHgkp3R6rQDD1FfyqMJLljdFVjMnKYcyLYQBI4G0guN7lh
	hizg4aFXEy8S2oyNdpZlD/hH5C5uOLFoErKw==;
Received: by smtp45.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rtRoo-0000000Gee0-433G; Sun, 07 Apr 2024 15:40:19 +0300
From: Dendi777 <end.to.start@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: Dendi777 <starrynightowl2@gmail.com>
Subject: [PATCH] Add support microphone for Acer-315-24p
Date: Sun,  7 Apr 2024 15:40:13 +0300
Message-ID: <20240407124013.12060-1-end.to.start@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9517FD34F787F37914DDBA212EF492D9AA17C4F0F4DC32816182A05F538085040BE82C82839E35CAB479CDAE959BF6424666E8353610C5A98098812AEB9E207D5ECA116FACD37B17E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78044725E6B9C7F2CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F91103FA893F53AB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88E947CB7A343B5BB922A8612B0E924759A48169AAFCD0AC420879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FBF931FEADDDACF0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A7DFDF579AB090EFF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C540F9B2D9BA47D5603F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C343DC2DC31C5DEC88BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFA3FB0D9844EF8EC51DD303D21008E298D5E8D9A59859A8B64854413538E1713F75ECD9A6C639B01B78DA827A17800CE729C2BF44C95AF91E731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A56AD5A2C1033DE5695002B1117B3ED6966F55A39DF7C27CDC219207EC0A953D2C823CB91A9FED034534781492E4B8EEAD3BF9A24AEF94352CC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD287DE0BDB1282B5033B63303960A1008E972AF00D9D2DC332D73DB2867940FB4905B00F5DFE93A21CFDFDFCAF5E4A4B1E92E308162695B703E77001BAEE1AA74A5C9587ED0B52A1111DC66A97D0BFE2913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+HQIBMt8ajV9AgrwgEPzUA==
X-Mailru-Sender: F34414D909EE10BD7829694AFAC1E959F378FCAAE587C0C3B951B70A5BD4BD8E101A68CC1F1DFC53EAEC386BEEE43C4FC773E5EF782A67EF9314192DE98EED7FA9800083D4B72A528C9769C13AF3BBAE440A67913D6ED084D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-4EC0790: 1
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4391B3D424BB050C88CA47C6C7B6271787469668418FAFBA1049FFFDB7839CE9ECE99CBBB6ECAA327269DEC87193C61EE9F15CDA520E9DD4612499DC39A4DB49E
X-7FA49CB5: 0D63561A33F958A55F74040EC96C22B539A6F0DD7DE084BA898F6E688483CD26CACD7DF95DA8FC8BD5E8D9A59859A8B6B737A621A50BC793CC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE71FF203B916544781731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+HQIBMt8ajWvsBDj4PBbzg==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

From: Dendi777 <starrynightowl2@gmail.com>

Signed-off-by: Dendi777 <starrynightowl2@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7..9b1ae0314 100644
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
+ },
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.44.0


