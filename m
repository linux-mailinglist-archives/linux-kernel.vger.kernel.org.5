Return-Path: <linux-kernel+bounces-134380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348E89B0DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09613281D17
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993F2A1B2;
	Sun,  7 Apr 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="VT8r9rV8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="OfK2rVOc"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301C288DF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493694; cv=none; b=k0kJtC6nSTH6s/NuCGNSGYrYYpWjSAkOqZw1zvjNHHfEmNJCqKsKM88MFEuJF5EGCAf9gU9nN8+XDdl+DZ0XPL97FXh/ruJfEVPyJq6kPy/pd1kEgJOx9Yw5aA0VvKuUWQA6Exu9UAPjFFR8c2Wf+B63nfjiMgcqEcJoU9DzHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493694; c=relaxed/simple;
	bh=fRgtLU64VmPj1RO8aNoSSRiD5pgeaJ/c24+Azmvwe5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEWa8ji1WTv3QNruwg89lsQPopkT+jHKs1vE+U4sigxvnhnx4ivpiClEW6CHkuaNwntswUzYkH3p/gCfwwpdsZUQ3xJJU5rgK1hkmvgQfeJcdwCTssAQ+7vQJ31OkEpvT2UXGxoAfG1vOF24gA+RsezBzSrMncnrFRdGjShi2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=VT8r9rV8; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=OfK2rVOc; arc=none smtp.client-ip=79.137.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=pS0J51qkDW3l6yHbMntKpzwzWZ1OozH3qDAmrSmG5EM=;
	t=1712493690;x=1712583690; 
	b=VT8r9rV8wLPkP8O6rKLNv50zd3DZ9eJiMDjXGZqV/cNerHjiy62C31MR9+uewk7jToowjbbMSvY9lwY+JwXlTh4uT9RiX2MBvvZKfQbF9putkxWZe5Y2t9Z0UeAJCCUBwL21sVQC1Lg6nKkV/I1mtofKIMPqEV1oBXWOz5CTybpBYb3/VDahAxAUvUk66NCcIyjZ3V4uHiCS1YZ5LLZDdf81rnzvHhy6rDQnuB735bHzo7RXRxyTofZbE3VPj9Ud/TCkW88FlfIBKrZxmwkCJE4vdc6WG5W0hobsRkVllSTXu6DEI+ZzZEcUgCTxEnA/FHQzwxbbrRK3clWTFTgzeQ==;
Received: from [10.12.4.36] (port=41840 helo=smtp59.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rtRm3-000j89-Ta; Sun, 07 Apr 2024 15:37:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=pS0J51qkDW3l6yHbMntKpzwzWZ1OozH3qDAmrSmG5EM=; t=1712493447; x=1712583447; 
	b=OfK2rVOc0rLX9Lux6peSOa2BbMXjpfzpLQd0ZoloVF0ck886UYzw6+IsF8yuo4xx6WeL+LLEByX
	1QdeutkRfDlVNOWQvcp1Q50xJqu2v8JXdj4SzDKvPNhbF7vGJyRaqHqt900vPwY+CEFsRu7yfLCUJ
	rqVDrmVCVVL1XmPaILyDPZib4TQ/Ot43tt88i14DJA1h0HV4RYBJW5SLfXNRS8bIXluIhUE0tcJw8
	ZAejRwB7zUSXn9leiAlXJQzQ3X288G5aoJ+k8Kadu9VZlSdJ+yyUOqUckDmNEcVR4r2wwoRhgZd0K
	kABV+wNyV2t/LASNqwt3LrhWJzv5zD5KPOGA==;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rtRlp-00000007I2h-3JMb; Sun, 07 Apr 2024 15:37:14 +0300
From: Dendi777 <end.to.start@mail.ru>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dendi777 <starrynightowl2@gmail.com>
Subject: [PATCH] Add support microphone for Acer-315-24p
Date: Sun,  7 Apr 2024 15:37:08 +0300
Message-ID: <20240407123708.11711-1-end.to.start@mail.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9517FD34F787F37912125E25EEC01EB21C392840CC940D142182A05F538085040DEDC7F3FCAFEBBB491417EB218679B82F0E2F1F536CAA48A098812AEB9E207D5BCD1920673F9FD49
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78044725E6B9C7F2CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F91103FA893F53AB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F7F057EAFEA888A64A51B625B318CA68A4E9862C0D948A5920879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FBF931FEADDDACF0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A7DFDF579AB090EFF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B65218A6880B2A9D023AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FCD215BE4436AF2686E2021AF6380DFAD18AA50765F79006378A4BC95AACA28A5322CA9DD8327EE493D1AC325EA934333D3946EFC6A664F553C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5184982995C294F365002B1117B3ED6962E552F56C4FF55A2361FAC1196A180DE823CB91A9FED034534781492E4B8EEAD303003AC7AA20DD0C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD287DE0BDB1282B5033B63303960A1008E972AF00D9D2DC332D73DB2867940FB4905B00F5DFE93A21CFDFDFCAF5E4A4B4D446B11C510E2B76781B6748A9801D9D1F142497979342F9F49EEF1215E7BEC913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXiY/CdR5KJX9+YP1JNfYyuY
X-Mailru-Sender: F34414D909EE10BD7829694AFAC1E9591977A2C26515A0C9B951B70A5BD4BD8E1358432E7FF7EB32FCE6092CAFFEA8A5C773E5EF782A67EF9314192DE98EED7FA9800083D4B72A528C9769C13AF3BBAE440A67913D6ED084D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4391B3D424BB050C88CA47C6C7B6271788641987756A17BB9049FFFDB7839CE9ECE99CBBB6ECAA327C8146FC688DEE5F0B2F503B31D9C400E86F2EF6A562CE637
X-7FA49CB5: 0D63561A33F958A5356A1CE935D219807DF8C9CF79639937052FCECB064A9487CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE793809DDD77344E68731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+HQIBMt8ajWTHGsk+jUUBQ==
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


