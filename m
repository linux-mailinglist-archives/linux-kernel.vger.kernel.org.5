Return-Path: <linux-kernel+bounces-94170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D1873ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FC4B22951
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1F1369B6;
	Wed,  6 Mar 2024 15:36:32 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4168136987;
	Wed,  6 Mar 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739392; cv=none; b=MvcghaESf3uRBueXl19V1oCuZFcMQq15nqwNQLwtAO8fWpAFGZAqMVXMOusTnj5lXCzP/1ticbV8ENIKIjpXpO0nLPxp42BX5nNSVKRghXuMpIk/6BNX6g2D2wtgqIPNIwq74VOaeMEU1i1cbRqhTGnceBEGNxVCqsn+/SmUZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739392; c=relaxed/simple;
	bh=r8rlS53KDa7OBL3LUkW9yTADcn+889iX4PNH/lTZoaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zk6KvT3ICi5WhdQtDbk7Rz38Xdw/dJZQdxH0y7o+UL1GMFQhCg9A9ShypbSqPzLE8GowUpYg8gq/uxaqtymHNNaX01Akvve8/5VVcN2CBnA5E2/mFXZJpomfFktnFPnQQ9qy88d0erxZ9OGFoPkdeTHrc3SROPDf0jF6uAWJaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 3FE0B7E00D3;
	Wed,  6 Mar 2024 23:36:13 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: dmitry.baryshkov@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Wed,  6 Mar 2024 23:36:10 +0800
Message-Id: <20240306153610.1289999-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpreeGWfstEKEFiHM_RJCZbYYdo0H=fY0GqPPtZM-7ZUhA@mail.gmail.com>
References: <CAA8EJpreeGWfstEKEFiHM_RJCZbYYdo0H=fY0GqPPtZM-7ZUhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkMeVh5NHh1OSUJDTxhPT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e146873b003a2kunm3fe0b7e00d3
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Pgw*SzMIMUM#QzoDLB4P
	QxhPCzJVSlVKTEtCTEhCSExIQ0tJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUpDSUM3Bg++

Hi, Dmitry
> How is it "some"? You are enabling this opp for all IPQ6000 SoC instances.

This is not the case, please see `opp-supported-hw = <0x4>;`.
Also: https://github.com/torvalds/linux/blob/master/drivers/cpufreq/qcom-cpufreq-nvmem.c#L345
This 1.2GHz Frequency only takes effect when BIT(2) exists.
For fused 1.5GHz devices, the 1.2GHz frequency will not appear.
I have tested this patch on both fused 1.2GHz and 1.5GHz devices.

Thanks,
Chukun

-- 
2.25.1


