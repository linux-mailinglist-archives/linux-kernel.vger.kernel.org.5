Return-Path: <linux-kernel+bounces-62346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAA851EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833A828316E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868A495E5;
	Mon, 12 Feb 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="hzyW7NP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="WKVtD70h"
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10484BA9A;
	Mon, 12 Feb 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770306; cv=none; b=jL8IIE0dJW/+mysaIgxSIfbhQqWpgEMLfFnMs7jAeYZP76Dq8LyMqgSfZqlGCYfJsneDTy9L53r3K59NSaDFP45j9z1jSR9hNfrSlis+D55PY/IuTTvTj0ubrj+/Sh08wtIHahKnc9KhiQv2/G+R+JmvLuZppXVzoTXS8XItIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770306; c=relaxed/simple;
	bh=922tXyX5WCku5kuQKtYuAS8MwcisrRU2zVn0d7eKXfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7PggpN0ORk4LGxOZz9cBdAZVtivWCAoMisg2ZTH5jVyXUuglsqmQzuQtzgZZk7ullME7XIWnFgSIYsYVvWmsrOtJOTTKYk3b6GKD99wHbxaIawmUqF6BV9ruk1PEQQM/uFWhA+H7THBWXMK5DzNeY7iX8M/sf6OueRK6z/O89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=hzyW7NP9; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=WKVtD70h; arc=none smtp.client-ip=79.137.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=wcLJSlFaelyzmb0Nt4rTgam/UIHx9JEcPbGDOaNnEL0=;
	t=1707770304;x=1707860304; 
	b=hzyW7NP9vrGw4WdLvITK345sRecRx3U8c/JEDCyaHStGANLZBnNBAAUpvT7hxtRY2xKluynCIoi1BRcLLv41YmHtNvnRVKwc8X+oFnsKPfdN5oR9DUB4tdP37YnouAb+emnrneRqWm6bISUvPHSrI/trRCB61kjKEqSXasyvK50=;
Received: from [10.12.4.23] (port=44422 helo=smtp49.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rZchT-00Gmcm-7u; Mon, 12 Feb 2024 23:14:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wcLJSlFaelyzmb0Nt4rTgam/UIHx9JEcPbGDOaNnEL0=; t=1707768887; x=1707858887; 
	b=WKVtD70hQEKgV0AP14Xb7xVpOZi/TdMv1Etx61nhZ1qPLc7UzvDawybVsmsv/2pZJs5LPoe/8Hh
	MVaS8Qb/KKGNU1jD6kBR7a0sokW2xlbCQu8vzrE6MglK8NHYODBX+XMHh1cB1LXpHQR5yhCRa9yov
	rSbaEB5DgIEBUXHjcNM=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZchE-00000009OKr-3ONU; Mon, 12 Feb 2024 23:14:33 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add Soc IDs for SM8475 family
Date: Mon, 12 Feb 2024 23:14:28 +0300
Message-ID: <20240212201428.87151-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212201428.87151-1-danila@jiaxyga.com>
References: <20240212201428.87151-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DB32823BD983060DE06DF84F99322535F5182A05F538085040324A43424A21CB7F5D1BE6A8D71B10A55489205C562D9E24B994F2484CBC5EEE0422B37ABB051B9D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7353CFE866E745C13EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF20B9B7F5DD35A68638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E055D6F70B91A2D6EF2F179BCC4484011D268EFCDCD9FE40CC7F00164DA146DAFE8445B8C89999728AA50765F79006374F09588CB15B21E6389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C2B5EEE3591E0D35F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CB5C78E0E843E24DA03F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C30BDA4C47DF1277F1BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C376F138C68E4EE6C935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A571FEA194E1F956295002B1117B3ED696F783585EB72B29D392212597CCBD6D77823CB91A9FED034534781492E4B8EEAD87AC71952E7BCFF3F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF58AB62DC7933A7FE302129ED8DE35ABC6953A82C6ED3370F99BAE6ED92879E04543A65BC901B9540233AFEF422F2DFF9DF68B031E8D2851531CB3C20478AD93C31D5F1F516F6A20F034D55ECCE8C67C6913E6812662D5F2A78A556DA1408BD603BAB4BE5B351B77B77D7EADF59166DF0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM0h4HsH6XT5ow==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814C6C55408358ED2A741D06F8E7BD5C49302A5EF51641B0F11B155545B1CDE02F2C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C74D4D0F5526761AD049FFFDB7839CE9E21836B46C57BA719E5D28CFE8FCA62FD8CFF75A0F7964E575388E2E835CFCDD8
X-7FA49CB5: 0D63561A33F958A57894EE27B44C061FFDF3B3C7B325EB3FB79B7BB4BF3A7AB68941B15DA834481FA18204E546F3947CC824672CB62AFFF2F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006378E5B25976F539216389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C38ECB62DBB60BCAAD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM1WpwI9S4Weww==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add Soc ID table entries for Qualcomm SM8475 family.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/socinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 5a44ad870fb6..e8ff9819ac47 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -424,8 +424,11 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ9510) },
 	{ qcom_board_id(QRB4210) },
 	{ qcom_board_id(QRB2210) },
+	{ qcom_board_id(SM8475) },
+	{ qcom_board_id(SM8475P) },
 	{ qcom_board_id(SA8775P) },
 	{ qcom_board_id(QRU1000) },
+	{ qcom_board_id(SM8475_2) },
 	{ qcom_board_id(QDU1000) },
 	{ qcom_board_id(SM8650) },
 	{ qcom_board_id(SM4450) },
-- 
2.43.0


