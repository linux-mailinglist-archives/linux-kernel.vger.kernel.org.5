Return-Path: <linux-kernel+bounces-142186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4F8A2896
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02694B22B00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804EB4DA10;
	Fri, 12 Apr 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="jwqe7mtf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="UOmCLDNm"
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86B4D5B0;
	Fri, 12 Apr 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908566; cv=none; b=IA764K7fFuLgc92D0QcqBfp76TQT+IOxZE2U3Ij0IERV5hoGA6Mt2dQJu2SpvTHGIrHSOUSKdFIXOmbNrog0ewiKmTqUYW8YQnyYQB2HoJ1CIgpdujnSZj5NJ0IfeILcJwHYzg8GjEu5GMlqBPIuGkkQEZcRYZ256HOb+sis8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908566; c=relaxed/simple;
	bh=kB1Waz8AUN0PHSbSmVoStQXkB/ZpKeNHH8pJoPL0nNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6IesL6V4QuwUCxmYpuNpqA54eFjBgay1sgDE/LSzcIfClSxYv1+8RjH7U1ZiFAtdiOfwy6Einuu4l8gSIJ0afFDPWJkz2Ppo4VQF4dDdi3QEF8fGtjTzvTjfMb969V0xDkm89bQ5t2pGWCBrBcwpp1jSV6FmoCTigG5rNJ/L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=jwqe7mtf; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=UOmCLDNm; arc=none smtp.client-ip=79.137.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BV2c+il9OQ5tVjtXpgd2HOLpxQh2bl7++uI9FhX0auQ=;
	t=1712908564;x=1712998564; 
	b=jwqe7mtfgmFfARwcncruE3czTlIDUT1m3qUbmv2gPe0g8Fs9daQG3Dej4gC8ajUbk0mUXuWRyVrSWJjjl3YPCsZ2LAJbmXdKRhKFtCFBtBc0MIkogY6tXJ79dsdCn/erS1IlPnCRbw/dh7HdDaeW4Hnm3534TKU+ZhHtHx5BkWHGtO+RhkXaMtDVKtiyCrq6rmATa7eEIEZ+KvcTa2fxf7ZwqGYDRowHY5IxFP2jsOuwFT438CUE+Ej9Y/O2y7C8lhrLFy1ebaR3XK+vDj3zPTdkDXSLUgDeV5oZxqpZ8IMt6Sa0RrTPT9Y+Rp6UQce0wHpQ7Q9RLbMU18xH1LvxZg==;
Received: from [10.12.4.15] (port=60664 helo=smtp40.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rvBlL-00FRcH-J1; Fri, 12 Apr 2024 10:55:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=BV2c+il9OQ5tVjtXpgd2HOLpxQh2bl7++uI9FhX0auQ=; t=1712908555; x=1712998555; 
	b=UOmCLDNmnHum3rjtviMRqEWbJ3QW6FfePrHM7XWab5Q1T7i06zTSWHHDo2/Uv03+vpzaLv0aKH8
	H99/0cUEoF11fSFCAzQKymWinduRlIyzylyuZi/xHQ92+HKF+3mxdNfnD2zg2X4rhDpdj3BKDOlx1
	2nziiD+5pS5chOFasTsHueVHFm/+q4XZ3NNeaW84H+ZV9vjPRDGT651C0qBR1EljCXOTWsmDZCIkI
	NgI0eRQWPaS4Puil4WHnMRJHeGzYxl7IjJvcOkrgUZuBk34X3bY/cV0xMZXlZqCLo5MNS2xM1Q+4O
	2rvlET4Nt5TxJ7IXMBeThUvyo8/zI5hmrCWg==;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rvBl8-000000068GU-1CoZ; Fri, 12 Apr 2024 10:55:42 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	"end.to.start" <end.to.start@mail.ru>
Subject: [PATCH] Support microphone from Acer Aspire A315-24P
Date: Fri, 12 Apr 2024 10:55:33 +0300
Message-ID: <20240412075533.10214-1-end.to.start@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D37A377202123D15E2522C17BB21D33F58182A05F5380850408454703AA2CBF6152EB5D77EF37489D1F7457EF4EC70DEE14EEA2BC59F9313033EAE9E3EF2B3B1F1
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74BE895B46187343CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376602C647E39EFA3A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8CA4CEC26D07D834D4548D2022A6A8DCF86087224137D367F20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FA18204E546F3947C744B801E316CB65FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063793270F7220657A0A389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006373025A2C56EC5FF29D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED62991661749BA6B97735BFC1D8BB4B114D1EB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE1E561CDFBCA1751F2315B90ADEC130413A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493D1AC325EA934333D2219AA581D1B0840C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A54372FD205B77D1E15002B1117B3ED696752432FECF638CF35D145BB8EF0DE66B823CB91A9FED034534781492E4B8EEADBD2EDBEAC172B1CCC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6464F64A29485441841A36B9D400164561D53AB837C2658DF1F8F3F0C39DC30B744A43F78FC6FA901E5F415AA55898CC5CDE3DBCACC57D11C7D2B8D7FCF3C3E9845E8EAF60D5B0B0C226CC413062362A913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf01z+rn20RGmsw==
X-Mailru-Sender: 0EFB88FCB9539F62C512525400A14327F9B431478F2211232EB5D77EF37489D1F7457EF4EC70DEE187BBD21BC54961EB3F19AE7352BF46025A92E71CC7C3152D8D05DC8E9113C1AA6463BD5ADB651FAA6DC89CDB30474D55C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872E579AAE18C5595C6873652B6E47CFC31E68F3CF0E9FE49B69572DE16CB4682662A81AA93D5FB9131C9D39524722C14A502240B6AABC043C3F
X-7FA49CB5: 0D63561A33F958A5A95A83A5097BF01E8F3FF00A5340CC8EFEBC3524DA186765CACD7DF95DA8FC8BD5E8D9A59859A8B6F9238D9F5226D930CC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE73D680CD0B734B321731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf03MV+CH2kk3lg==
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


