Return-Path: <linux-kernel+bounces-94009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C787383F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FC828492B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9A132C36;
	Wed,  6 Mar 2024 14:03:58 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7313174F;
	Wed,  6 Mar 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733837; cv=none; b=nxHwMwqDTLykafpLXD5DxG6tbOYP7O8Lt5IIoaQRq8T0RMvI2x4wo2P91FiyA24q0Febxta7z0S79TtIIVTLZxd7tJrX/ED8jfS6zYR3qdvfvHEhN5uCdQQ41Sx/Y0F5yY+DzSmf2VLWk/LxnnJMsG9G5hVFJX4vrQ/neFBuLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733837; c=relaxed/simple;
	bh=0PB1+IAj/L4iM3iwe8bAb1OMuoljeznhHX1ogFGitqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dIR5W3mfWv5hT9OGLs3NyLhIoCLDuDRi29OhH2X0tkJqg4Onhr5jvmd7DZTdEkY8dQS89bGMe36C+E+VTGEKhQWP+oNNSV8mOqa5GQKYOBQY0EczS/ejG0f32hLvcnJkc4wpFlKd6kkXBLaUyjPLIZaXKURH7Ej/ipBcJZhCnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id A8C157E0122;
	Wed,  6 Mar 2024 22:03:35 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/4] arm64: dts: qcom: ipq6018: rework CPU Frequency
Date: Wed,  6 Mar 2024 22:03:02 +0800
Message-Id: <20240306140306.876188-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEweVkoeTktNTB9NHRodHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e1413a65a03a2kunma8c157e0122
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6KDo4CDMPF0MaGE8WCRc1
	KDwwCxJVSlVKTEtCTEhIQ0pNSElMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUpPQ043Bg++

Changes in v2:
  Add more CPU Frequencies in ipq6018.dtsi
  Move mp5496 regulator to ipq6018-mp5496.dtsi
  Add LDOA2 regulator to support SDCC voltage scaling

Note that the addition of sdhci node has not been merged yet:
https://lore.kernel.org/lkml/20240306123006.724934-2-amadeus@jmu.edu.cn/

-- 
2.25.1


