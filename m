Return-Path: <linux-kernel+bounces-142183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5708A2891
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD41F24699
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FA4DA04;
	Fri, 12 Apr 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="X80d4CM0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="xkVT5lXS"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903F4D9E3;
	Fri, 12 Apr 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908503; cv=none; b=AlBaTmSAW94o1LXneThzi9Go3EvQBEVi4NLuMiywyRMKXjN5Wexmv3Z0bQeh/Zkoze+lil+UvAqCOPJ6D0PduzlZJTCQZdIL2frgGvQMdORw8uMTL9xGA3/qcvfRcN+jpvRHQrCxXDHG8zwgqSRrCS9HwQp+LOSwc0AbcBgn7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908503; c=relaxed/simple;
	bh=kB1Waz8AUN0PHSbSmVoStQXkB/ZpKeNHH8pJoPL0nNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jL1BQEO4fZOTei+3jTOzQ64tOHyD2WXSkAGlR0OBnNZI1Vshg2rfbdpESziLwbFB94tnzNc7A2jHMIUdmqUgCpN11t36FGqxHEnvbe4O6fWj2kqtvhD5nbmq8fNmQ1Mz0UrjJxNmbjPBpjtmf6zbTftnwMyEmSLj7p/NPaxjOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=X80d4CM0; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=xkVT5lXS; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BV2c+il9OQ5tVjtXpgd2HOLpxQh2bl7++uI9FhX0auQ=;
	t=1712908500;x=1712998500; 
	b=X80d4CM01FXHhExaixrQZ1wh9dGHeaEsNBAdLBrGRUA3cU9nU8IHuaNGIUUNEaEFds2L94BHJCBw6mMxuhNfYGFvZaQ8hegbaVlqZ+mQ9lc42SdD9ZKIofV7g/X7VAWVOcXaQLYDxjJ6rlbbDOXf3qDsLabJ1mBGtbQBIhhmLmiS9Ui8m1R39dy0rkirtUFHuxqmULa97LRb52u634g4hloO0jUSbtFtH1eknnYnbr116tf0h35Klnwxs1B+n6A8OgYjsh4r4fktSykqOW3eN6YrkNdoyHmmSU1P2X2y65Pd1VhhqyKnunul/Mfjlyb22pRyMV5wYYpcxoLg2SXxmA==;
Received: from [10.12.4.1] (port=54618 helo=smtp3.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rvBkQ-009O53-1j; Fri, 12 Apr 2024 10:54:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=BV2c+il9OQ5tVjtXpgd2HOLpxQh2bl7++uI9FhX0auQ=; t=1712908498; x=1712998498; 
	b=xkVT5lXSplQeYgbwCdSq5yCVW8odyDeGwxqnpss/1I7zK/AYOxFenQkLlRL7dTCr6N7ZbqwBuW5
	2XYxUv/4SSHAlYw/wYCMO7hz/LjWKn/vWMxzmsjzQs/a7euTZiS/VqNwXB8hYpxvS5R4+A3xc9LiP
	t3kc1YmrTbCnhr4zFcb8r/KsYWhoZIsKdEqiggjKrykJi7qdqgaoB5t3Xa2lldW2YVIkK3F5Ej4jZ
	98BdjdoraHaPLlW9DqUuf9++yD3lIzQyeKncW9bLsOkd/ZggDLpzByCSNEJB6EXVwTv+JCazzV/ev
	oTnVdRpSCmOFAvi6uo8eDFlJkpqIJefDiX4Q==;
Received: by smtp3.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rvBkD-000000003vy-08NX; Fri, 12 Apr 2024 10:54:45 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	"end.to.start" <end.to.start@mail.ru>
Subject: [PATCH] Support microphone from Acer Aspire A315-24P
Date: Fri, 12 Apr 2024 10:54:35 +0300
Message-ID: <20240412075435.9686-1-end.to.start@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D3B5F9CEDACDA8A37625F0445A84289E9B182A05F5380850403EB54AB831D0A5ED3DE06ABAFEAF6705BA6AE750571E41964EEA2BC59F9313038FD25975426DF111
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74BE895B46187343CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376602C647E39EFA3A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D838AA3F18E0E05145FB290CC73502DE30BA67294451748AAD20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0A3E989B1926288338941B15DA834481FA18204E546F3947C744B801E316CB65FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063793270F7220657A0A389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006378774E2E6E0491BBAD81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7FA65F758F0162B97EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE71490C1D4B6BF31602EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE748C4B04F31FA0DCC731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5FF2DAD78F0BEB9F55002B1117B3ED69675F0FBD661B3D315886DC9BC01168B20823CB91A9FED034534781492E4B8EEADBD2EDBEAC172B1CCC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6464F64A29485441841A36B9D400164561D53AB837C2658DF1F8F3F0C39DC30B744A43F78FC6FA901E5F415AA55898CCA726597C2B7B88C406A30589279D2D9E345FA4B40CE409CBC226CC413062362A913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf02iYSEjCKl7iQ==
X-Mailru-Sender: 0EFB88FCB9539F62C512525400A143272EEFE8F0679C505C3DE06ABAFEAF6705BA6AE750571E419687BBD21BC54961EB3F19AE7352BF46025A92E71CC7C3152D8D05DC8E9113C1AA6463BD5ADB651FAA6DC89CDB30474D55C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872E579AAE18C5595C6873652B6E47CFC31E68F3CF0E9FE49B69572DE16CB4682662ECF5EC5358D93994A7F12659CD70DB3111802DFDAD7C05CB
X-7FA49CB5: 0D63561A33F958A587C217138CEA755D476AFCF2139B94793501DD312F237E95CACD7DF95DA8FC8BD5E8D9A59859A8B6F9238D9F5226D930CC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE781C00CBDB52C0177731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf00wbDLYY9Nt4A==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

Add support microphone from Acer Aspire A315-24P and for some other similar devices with such vendor

Signed-off-by: end.to.start <end.to.start@mail.ru>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7a6b54fc1fcfc3fac3a73d58403071f5..1760b5d42460afe83f3d50dbcdd73daf9455fc12 100644
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


