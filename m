Return-Path: <linux-kernel+bounces-135597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08289C834
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421521C22B34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA014039D;
	Mon,  8 Apr 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="N6gl4j5b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="tWhF6ys4"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284E6A012;
	Mon,  8 Apr 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589924; cv=none; b=Bxt8cBM12FWgpYJepFVj+pnR8bYddNbAcZDGZvNiX0mMD8jVSojgjxJHoxa2onff8i+Mg/1S6wjhlNLNmTPT0B+h9NpiVBkiTzn2Lhp8yNY6eX2JZ7cSrvIeeGVybdWV228XupPy/syCB37HUDKIIH4qn77/fs6uzjrzcBhBE3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589924; c=relaxed/simple;
	bh=p3uqGizp9xIMGF6CjhHwqsqD088dKF3LY0AdqM5qQiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xm6HmItQAL0MrlvlkXV1D/xknOzucwcD5Rb+wsNlHg0923i5bb2ikYd5PeoLR08YwqfgldFCdr2f+iiGl1kCgCVwAzS2y7X63bZcm4WRnq6MgSYlpxCgy/6whm1KZsBmTDjGHRQ6HtUjs7VRufrJEZMNsp3S6e2cTsMM3+K6L60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=N6gl4j5b; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=tWhF6ys4; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wx+/Kt3SIcMw3DZo1mkGE7FX70+jMpgo7G/HwD3+K2o=;
	t=1712589922;x=1712679922; 
	b=N6gl4j5bE8kWPt4aJ9GEonteJrhxNLZzWHjv4dqJuRM8X1PRG927pcvV6vCDgI4s/xCm+cu3I7SD+tipPVasmMrkXHscZ+R7An8iwRv2wrmOLVXlntuBwqjuh2Wq9WUmaCcwyZDtmJKKmD3cSgFqaCq8zQ/grFG2EJRjkaBZpmU1W0so5Pb7klb7ewnMHUndeDQX59olwZhFSA5Ys89eHgfi6yiajaYtErz6MEGrAJPZ6S3ijdEHByBd59W4Lv8pSuQ0Z2hNqV3dB1mT8CK7Aw7NqFyy4ZCTJMdfnS59Sz3eJ2P3ue+4Qci0MV/Fy8s5/ssF1FFJzLx2o877w5dPuA==;
Received: from [10.12.4.8] (port=59284 helo=smtp35.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rtqry-00AKnI-3R; Mon, 08 Apr 2024 18:25:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wx+/Kt3SIcMw3DZo1mkGE7FX70+jMpgo7G/HwD3+K2o=; t=1712589914; x=1712679914; 
	b=tWhF6ys4wyOTb607I+HnarpFLcZjkQLwi/zDQwYGWhriMF+3x3oTUUwyv93RifL15vpuszuGTiN
	0uaCULJi5Rm/Mpzw+ENlcdSjzIUP2o+40XAJf+w7pF+AcilRVYB9hXK2uAGEN5I4rkDif6p4lYzRk
	FwdzYlnKLoIsvjCOo2Ti4u+0Cvb4q9bF2i9PWC1vI8tBDcXX7m7Zd/3SEdUGC1V2VvhJ71QRaun6n
	yzk72MZmc6p2ucsCdth+T1uCo13FceHsbOwLK+8u72CV8zgDwugUF1QsWo/8mZ6C7SqYKSYUBWLOY
	jC5f9Ti3wb4BOfXn4oHjH9F9jb4LKiPrmnlw==;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rtqrl-0000000GUNi-0ObH; Mon, 08 Apr 2024 18:25:01 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	"end . to . start" <end.to.start@mail.ru>
Subject: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
Date: Mon,  8 Apr 2024 18:24:54 +0300
Message-ID: <20240408152454.45532-1-end.to.start@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D3B5F9CEDACDA8A376D5C6B368178EF610182A05F538085040AFF3088811DA9414479CDAE959BF6424A3F01E6D7526D147F5BE69892C5964BC5C3268B322D90CF0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7492D3E4238663367EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DEEC83A7CF8598608638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80B8FDF7C59563F5CC938DB726AE1A08ECD86ADFE652E764F20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006372A3B24BF85B2E607389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8A9FF340AA05FB58CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C223C850C947643096136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3577BF6776F123B00BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF1A3F3A3731258CC51DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE798845EE5634E197B731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A54BF324A16E95B57A5002B1117B3ED6965521600224EE5451C638DF663A625AFA823CB91A9FED034534781492E4B8EEAD2E48F5DFA0C1F120C79554A2A72441328621D336A7BC284946AD531847A6065A27ED053E960B195EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF45B00B261A430CA5BBCEDE6F76895AB947921DF39F88E614015E91357665F65FE98901B1639BBD631CFDFDFCAF5E4A4B5CC41FDF40B3447BF36502CCD4CFDF0893AE7FEBBBF509A136DDF96CB8D31E6A913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojabKNeIbMV3v6+fTf+xsXTQ==
X-Mailru-Sender: F34414D909EE10BD7829694AFAC1E9591DF4185174300678B951B70A5BD4BD8EB2F2DE6BE9014C790296AFEE49C50801C773E5EF782A67EF9314192DE98EED7FA9800083D4B72A528C9769C13AF3BBAE440A67913D6ED084D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872EC5718FF4C5F5599C004E71FC1AB0F17D68F3CF0E9FE49B695C3EC5CDC8399ABCB8338F23E4050283CFB73BA2CFCD1EB00001C509F6CB740E
X-7FA49CB5: 0D63561A33F958A5F844114F9570460AC74EF4F72D971603112F3065048386C5CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7F5CC3C73AD0FAAB0731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojabKNeIbMV3tRYYBiits6/A==
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


