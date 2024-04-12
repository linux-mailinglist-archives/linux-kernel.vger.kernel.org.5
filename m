Return-Path: <linux-kernel+bounces-142180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E268A2886
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDFD28618D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8B4F5FA;
	Fri, 12 Apr 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="btjszst1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="RBM3cxh0"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BD4F200;
	Fri, 12 Apr 2024 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908401; cv=none; b=sojxLutUBn/K4lA2lKBH/ypxXdJx0JKl33oj8YqdwzNN0u48Ige71t/Rk4MQmfIeT7KHOra4fM2VC1uvcXcpHxSuRyMYcLY/jRq7x+Rdo1/SdsNoQAtca0GuaJvOoh9E7w7uHt7hISW/9VmNj84cjSasCFz4+kM5CPcbgRh+GSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908401; c=relaxed/simple;
	bh=OKx8RMEOBNirQ1rOvDayBC9TYkIWkSrEyJ8Drzfi+tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfCenDZNj1nCevsQNcbW/qTj4ulV6xrpumJtMcTDgxveqWlLZO82gxoSZgpaQv0cFS8mGLwNDTL0fF0rUtfCIOUBUiTffM1QnILN+OCb59g1xy3dT0SEXZNhHsZk/uq9fb7ATBqGT2XnDzcDrPO/09DhLKWshOdM2NTBNerzgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=btjszst1; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=RBM3cxh0; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Nw7gw8V1g7SWa06oevaWJ4weuXT4Q/jFQXTqUvgoqX4=;
	t=1712908398;x=1712998398; 
	b=btjszst15a6Ib/omk+ca8PK+g0rdlk7OKNhvmuocv5kVdBGk5LtFYdtVvEkibV5RL3ISKIXgq2wHN526TtU0TNf91DeACthSL1u6FoX7jQOSDG7QkYswxhyaKOng6GYpG6lSpMTXOv6M2iGf0d9ddrS/+WZVWzmwykwI8bAkjv1/nx9kmszXEwIvMUIPRXhoim+KulVK52IXvIW1H88Egwx5Yt027I3CVeLaL2Y6lxnfQUmd81wTvxNcNKcXh5y6DaU/D6Fw2NDhZZMMoWjgwfTi8W9jLVIIpS65lCXHp+xzlZ9WDOSWYGbIy0JQ2cosfMGt5kTNxqSen5RIxUfmvA==;
Received: from [10.12.4.26] (port=36338 helo=smtp50.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <end.to.start@mail.ru>)
	id 1rvBig-009LvR-3k; Fri, 12 Apr 2024 10:53:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Nw7gw8V1g7SWa06oevaWJ4weuXT4Q/jFQXTqUvgoqX4=; t=1712908390; x=1712998390; 
	b=RBM3cxh0TkLK0BRHJ3Q19FsNncDmeqT92ZAonmjmDhUxKeXtHYUHbEtCuuv1vLI32ay3OEcz9Pf
	oQ6FJEYhapATu9J6Ghpu3v+RadpqhnngMr2BB5c3Fcs8jsMV6J2ve3p/ewTO3/duQNO6TJ0yqHss9
	tTWYCAqIKEXCi5VLytHM6kYlx+d/v0aHud4tWjj/avAbzruXxhUGFgXIPXyCvk98znEg8TpSa6Qf/
	+CyLWDouw/mhmDvcjTtDVXBCizc7MV1Sn7r10Bv9ST0hoTSQEvcA0yOaqCxc2UwneTtz6QM54xyLi
	GitAQrQ0ToQkz+P5QOELudjicibj2WZjPBVw==;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <end.to.start@mail.ru>)
	id 1rvBiR-0000000H2q6-2vBq; Fri, 12 Apr 2024 10:52:56 +0300
From: "end.to.start" <end.to.start@mail.ru>
To: broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	"end.to.start" <end.to.start@mail.ru>
Subject: [PATCH] Support microphone from Acer Aspire A315-24P
Date: Fri, 12 Apr 2024 10:52:22 +0300
Message-ID: <20240412075222.9562-1-end.to.start@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D37A377202123D15E2522C17BB21D33F58182A05F538085040F90E0877D182F11A89CEA9C911D0999574D1B7AB0ACAA2244EEA2BC59F931303E41C5801A3FD0B27
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70F1463317FA92A59C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7624C4D757C4F5837EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871DAA35A1D7314D5952739E8A0AC86CF83580ED61A867047991DF9E95F17B0083B26EA987F6312C9EC9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B5278DA827A17800CE764603B5C71CE8B8F9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3776A0366D588B3C3117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF86712D2D5FBAF151BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6322AD207363670A176E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D52CD31C43BF465FE827F84554CEF50127C277FBC8AE2E8BF1175FABE1C0F9B6AAAE862A0553A3920E30A4C9C8E338DA3C19E37C924DD61743847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A58E751B7D3ABCA9CD5002B1117B3ED6969A73F4EC7CEBA76147A99E6294EE8661823CB91A9FED034534781492E4B8EEAD13926AAAFEFA6645C79554A2A72441328621D336A7BC284946AD531847A6065AED8438A78DFE0A9EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFA66A8B581C0755EC07C24D1998CB35ED275FE1048C5238080C47DAB95AAB298331E81B06003A5D531E5F415AA55898CC8DC79277775420DD71ECAF277B75E13A21A9F8578786A662C226CC413062362A913E6812662D5F2A65982B5FD154E7DC8F0ECD54AF826900C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf01chujAgwQSrg==
X-Mailru-Sender: 0EFB88FCB9539F62C512525400A14327185286590AF757AD89CEA9C911D0999574D1B7AB0ACAA22487BBD21BC54961EB3F19AE7352BF46025A92E71CC7C3152D8D05DC8E9113C1AA6463BD5ADB651FAA6DC89CDB30474D55C77752E0C033A69E3453F38A29522196
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872E42D0773418C2900980F43BF76D49B75868F3CF0E9FE49B69572DE16CB4682662B32016D36410CA15E7BB253B9568306E66F4DF1066E2BE9E
X-7FA49CB5: 0D63561A33F958A55113AB23EF158DD6AF3CAE66BD12DAE900FA3FC803982463CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006378E5B25976F539216389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C824672CB62AFFF2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7DCDFD9654CA3005A731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojj8Sl06kWf02B1XWdI2jDlw==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

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


