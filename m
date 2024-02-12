Return-Path: <linux-kernel+bounces-62341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD9851EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E863B28327F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335C1EB34;
	Mon, 12 Feb 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="b7083Uy6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="An7LpAIK"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C91DFD8;
	Mon, 12 Feb 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770135; cv=none; b=N/FIQdDM5PX996YQz07OZwGyrmtg9raioBsrwpz47Qxfl8iPqlBZt8XIyVaEjS5YLjzTHN0SRjJBZNNVLr4NSkjmx2Kdndnl5Ia024ka6I9hYSeIOQRxQxS5+FJd0Vgg0bfiKnYHO5dxLQfNcEnBfEMi5v7RHrlelBSw7yU3bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770135; c=relaxed/simple;
	bh=vHh93kiXajwHiYYjtPEVQqJ383e7oT0JDL18IYoBdo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejhDJgCf17bQr4XDn2+GWy6bRoo2ndloulFgPtW9ntbCReYvkmDHhcMFfx25Av8RC6lzVOFDA+88VDvTzrhh5bRee7brzxAna/G68uGFpog5pus+oOunRl82QtuoL4qu6DcEvXbHb9l4LjDBrEZ/rhhIvxMHbSIqV8kU3getY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=b7083Uy6; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=An7LpAIK; arc=none smtp.client-ip=79.137.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=F2W/SdjdsgnOeiZVGLagGqwtap8od+DMR4Ml3F1zpIU=;
	t=1707770131;x=1707860131; 
	b=b7083Uy6ODfqChIQG0sf1nIJU6CQzNOn8jARNlNDi2FM/n8P51uPrSITE0e975wTD+G5yaeCpMzUVVNQouUhBldf4QpZqQr0nz0uZYTcWw5nwCF08cNLf2gTw6cAMKdCAZU1aAxLucTXgsO0Hke3vP4S/6yVfpRYEIpXZ34wPhY=;
Received: from [10.12.4.23] (port=58698 helo=smtp49.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rZchR-004HBg-Uy; Mon, 12 Feb 2024 23:14:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=F2W/SdjdsgnOeiZVGLagGqwtap8od+DMR4Ml3F1zpIU=; t=1707768885; x=1707858885; 
	b=An7LpAIKyBhfy3iqrfHjzx5dhPuMGatmYqWBQo9GBHvvbFEirdJRgfTqH6e3ZN/ZavTOLsWEyYY
	RDIsJREhvzDdc6xAZUKU9sB+aIJG2hlwqPGRXF2JyLRuH5GpYqzEMS8s/YVzZ+BCURwt4Ez5PdVmB
	Vf2fa4gA1d3F+m7fSh0=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rZchC-00000009OKr-08nz; Mon, 12 Feb 2024 23:14:30 +0300
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
Subject: [PATCH 0/2] soc: qcom: socinfo: Add SM8475 IDs
Date: Mon, 12 Feb 2024 23:14:26 +0300
Message-ID: <20240212201428.87151-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD96201AD55A1C8F7DB199691BBF2788CA8047EA577E0D2805D182A05F5380850401561197923D86C7F5D1BE6A8D71B10A51A3AAC20FAB14810B994F2484CBC5EEE984BA1D07646E0BA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789805A6418246A1AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379C6642364E0E74208638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80401827250B231A0EF2F179BCC448401AAA7369C5BB29C50CC7F00164DA146DAFE8445B8C89999728AA50765F7900637DCE3DBD6F8E38AFD389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D2DCF9CF1F528DBCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C643FE6A0CAC512C7302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3AB70B36A49903258BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C376F138C68E4EE6C935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5E554248E2912EBFA5002B1117B3ED6964202B572CCA044F3F5FEB6EB1EB183FD823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF92AE5381B99C6B92F020487101572E8242FC7BBBEE130D7A6E4928D89FAE3DF30AA6441730D2A0F0233AFEF422F2DFF9E941DB174C08723931CB3C20478AD93CC2780DFB0BF49F4C034D55ECCE8C67C6913E6812662D5F2A78A556DA1408BD603BAB4BE5B351B77B77D7EADF59166DF0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM3GH4wRhjrIdA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814C6C55408358ED2A1F93A76BF6F7B0A690FBB3BDFE0B09273A782A42D01DD7192C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C5E8DE89D725F9123049FFFDB7839CE9E21836B46C57BA719D1F0E982E3F336049CB9E2F28C959EAC41B08CCE821396D7
X-7FA49CB5: 0D63561A33F958A5FC0A2D135DBE8A398F84CCF55B00C5124AAD531C5438CE2A8941B15DA834481FA18204E546F3947C996A9F7B0561EE47F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063781DF5610BC3D4227389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C38ECB62DBB60BCAAD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UUEhvrYbM0tuos+OshPYQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This series adds IDs for Qualcomm SM8475 SoC.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh@kernel.org> 
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
  soc: qcom: socinfo: Add Soc IDs for SM8475 family

 drivers/soc/qcom/socinfo.c         | 3 +++
 include/dt-bindings/arm/qcom,ids.h | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.43.0


