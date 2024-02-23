Return-Path: <linux-kernel+bounces-77708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBA860948
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5562A28655E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFAD26D;
	Fri, 23 Feb 2024 03:17:11 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F6BE7D;
	Fri, 23 Feb 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658231; cv=none; b=c4C+AJtmfY4AT3axEN0EvPYufIu6/1XuIn7kPvSmp53QnK7Q0vyq0r4tygkCwQPOeLXo5ovYJ/CRD/0N1c8yTDS0DjMid4A298R48wWqXfMXWOAcCPBtZU4Lyhy2IfOvntRhCVZfwfnzyhue/gft2DPn+st+Y1JtNehefNTF0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658231; c=relaxed/simple;
	bh=AOFDVig+qtC1FMg26lE/IlypjEeqd4lm+DmWUHDkZIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3UdtXsHC0qg20AstC83SkdkXsYZMb+mz2F8EcmpcHs/NfWKNEG2ug+SOaWEH/p0ny6oKm2A69MTxin0SO6wzOTuGdDOBhyOpnU3IUXPTMEBTOvfRm8aHE+O1K/1+0we0ls76yXEoSlEOaofj/b0LEeGt6ILVSX3G+gnqImbpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.140.157])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 7FDA17E012E;
	Fri, 23 Feb 2024 11:10:25 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: andersson@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	robimarko@gmail.com
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: ipq6018: add LDOA2 regulator
Date: Fri, 23 Feb 2024 11:10:20 +0800
Message-Id: <20240223031020.78744-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cliph5zxla23bgguzk52ulxh6trl4qcggjg7hqvrg2d4qdh3a7@mq6fewwjfk2m>
References: <cliph5zxla23bgguzk52ulxh6trl4qcggjg7hqvrg2d4qdh3a7@mq6fewwjfk2m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0lCVh5NSEpMTElNH00eGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWU5DVU1KVUpPS1VKTkxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8dd3f157da03a2kunm7fda17e012e
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6Txw4EjMPExwWGCFDTi8c
	HQkwCjdVSlVKTEtDTU5MQ0lNSE5KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
	VU1KVUpPS1VKTkxZV1kIAVlBSU5ITjcG

Hi, Bjorn
> I still don't see a patch that does "something-supply = <&ipq6018_l2>;",
> which would imply that the main thing this patch achieves is that the
> regulator framework might turn the regulator off after a while.

> Shouldn't there be a user of ipq6018_l2?

Although there is the sdhc node in ipq6018-cp01-c1 in the qsdk kernel,
I don't have the official rdp board of qca, so I can't test it.

Normally it looks like this:

&sdhc {
	bus-width = <4>;
	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
    ... /* specific properties */
	pinctrl-0 = <&sdhci_pins>;
	pinctrl-names = "default";
	vqmmc-supply = <&ipq6018_l2>;
	status = "okay";
};

As for actual routers, there are users.
One of the examples is on openwrt, a development board like 8devices:
https://github.com/openwrt/openwrt/blob/main/target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq6010-mango-dvk.dts#L272

	vqmmc-supply = <&ipq6018_l2>;
	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
..

The function of this node is to reference sd/emmc supply for devices
with pmic. Please let me know if it doesn't fit in this patch series
and I will deal with this in another pmic patch series.


Thanks,
Chukun

-- 
2.25.1


