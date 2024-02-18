Return-Path: <linux-kernel+bounces-70496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC58598A4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286D9B211C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B66F08D;
	Sun, 18 Feb 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="QaGkIg5n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b="Y8ltRv6E"
Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A01E4A7;
	Sun, 18 Feb 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282062; cv=none; b=fW4j3BnQcXEiEDSPzs4Jo9w7LCe8N7gqYrhmj+i6rqk/zbNzyo/fuhm4wFVQT7AbAbixGPoRoA/0IdNI2FSYDwL5ncFJlpCSfwJyh46KD393uHA6aI4GuZCzwRmNYFecaRsdiLSyREwTPnJOvpUNNeNJlaeMmE8lMiuja/4brmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282062; c=relaxed/simple;
	bh=ZzpDwJa4K3+r41sklRhJMsnSJw7DbIBjHFPOcVs5fcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlhMSIHRsIKJNSb5GDxIP8vWxkti+oIc1hYfU1+dxXSBMhK+oE+iG5csKnT5MhHBtIJnrBQhTICwFhSONKhlgouRWdIdKjHvYTHfyHHYegoM3m6OEQI1SY6EjhF9fu7db2n4aVOpLYRW5uAe1J6fw2agZTVviFcZhjhof3Uc5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com; spf=pass smtp.mailfrom=jiaxyga.com; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=QaGkIg5n; dkim=pass (1024-bit key) header.d=jiaxyga.com header.i=@jiaxyga.com header.b=Y8ltRv6E; arc=none smtp.client-ip=79.137.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jiaxyga.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jiaxyga.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=oJ4HI3fXNLVifEKRkv+30ROKoxZ8SdDtjau/By6D28U=;
	t=1708282060;x=1708372060; 
	b=QaGkIg5no8JOga4WGwnYd7lvTxLNZoDn3bMkwFroUUi4wEGRYV11afKm5e4gKFWEQdsa3lVVnILQFLDyshSEPpNRNUkbguPtRPjtP4HJCNCuE3r8SgGFp2wHdwEMP+dOhUpm2IlCylL0KKcd8Eg2rNI/825bkJse6zh/0dz6gew=;
Received: from [10.12.4.36] (port=57416 helo=smtp59.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
	id 1rblyH-002TRW-Hw; Sun, 18 Feb 2024 21:33:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
	; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=oJ4HI3fXNLVifEKRkv+30ROKoxZ8SdDtjau/By6D28U=; t=1708281181; x=1708371181; 
	b=Y8ltRv6Ee3lonjn5UAjJGBVGylNjtOGQhdtJr2YomFs9UAEsjajH5PX2scHM6/AvhP0J6CCrKuH
	rG4KgEdfE89Q2vd7hKdozKj11w2FqktAuusS75MVCD/6xl6rize3vlxGgzM34nlfBkf/dI/dw+hj8
	nsrE0E+B54hYWBvaWuo=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
	id 1rbly2-00000001iw9-246d; Sun, 18 Feb 2024 21:32:47 +0300
From: Danila Tikhonov <danila@jiaxyga.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	djakov@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] Add interconnect support for SM7150 SoC
Date: Sun, 18 Feb 2024 21:32:37 +0300
Message-ID: <20240218183239.85319-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD2021F4B2298ADA324AF81BB1825BF5AE0A1600894C459B0CD1B98C9EBD09D8BDACF3C7109C2D567B645AB2B869AB8C39342FF215CD5087B8A2F965B98BC17AE4ABE7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A179494B5629353BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370D3D68FCEFFDD9EA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85E6ECE5FBCF80ABBF545006DEB2F19AEF66D7B8855061AF7CC7F00164DA146DAFE8445B8C89999728AA50765F790063773DCDF0198120BE8389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C0085B890FD2717DA6136E347CC761E074AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3B8066AFCF2BB2551BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C31BC2FD6A5287AC5335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5EBC449AC771117205002B1117B3ED69619A38FAB5AA2C3660E58516B1639A14B823CB91A9FED034534781492E4B8EEADF4F3DF47829F65C7C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF05F377F6E0C1461EB10DBCCD48361BBEFA0CB07EC5489145AFDCBFFE1E75A92B760962882471415B34E84B500378195FBCE35CC6DDD33EE04C37877C5488D6FE914199AC9651CD60AF108DC32EA72A8402C26D483E81D6BE72B480F99247062FEE42F474E8A1C6FD34D382445848F2F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuuN11JQCrtBHw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498103638563C1357B8A459FBC39F2FFFE83B33547D50490C739EA4BE9FE96A283482C62728BC403A049225EC17F3711B6CF1A6F2E8989E84EC137BFB0221605B344978139F6FA5A77F05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C90205846E38A0579049FFFDB7839CE9E8F5A60B08382AFE37B48B0B2F3D55BE30B510F342DFFD572D0817233229BD881
X-7FA49CB5: 0D63561A33F958A57A2B3967897D26BDBC493CD0BEA3941A68C4D234F0F740FA8941B15DA834481FA18204E546F3947CA14973FBE0621AE5F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637C1C2752E44B586D5389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C36153467CB5E707FD35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3ZJ49a6yxuvSU2GOb5vijQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add dtbindings and driver support for the Qualcomm SM7150 SoC.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
  interconnect: qcom: Add SM7150 driver support

 .../interconnect/qcom,sm7150-rpmh.yaml        |   88 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm7150.c            | 1753 +++++++++++++++++
 drivers/interconnect/qcom/sm7150.h            |  140 ++
 .../interconnect/qcom,sm7150-rpmh.h           |  150 ++
 6 files changed, 2142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm7150.c
 create mode 100644 drivers/interconnect/qcom/sm7150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h

-- 
2.43.2


