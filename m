Return-Path: <linux-kernel+bounces-42102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5483FC51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D93228169C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B86F9EA;
	Mon, 29 Jan 2024 02:40:39 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621ECDF6B;
	Mon, 29 Jan 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496039; cv=none; b=BOw9dgsuPuoN8Ru1GcDkOU2Eme+65C90cLo4jRDHaioy19E+u9vIUqT3Yt5rHT5GtCZ1k10KefBIiuYdrtU2dhGz9QBFli3TJvgaHbIjYtT6MIw5NB0yb8nPDS+c9aOHRQvObRBEpx58SvDbI7WCEGBOAfYpUrDvnQ7i/YvI9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496039; c=relaxed/simple;
	bh=5XYlEQ66Z9ePUb0eC01nbpiLs67bFPrkK6FMsV+HLeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hqt+0mDOWB0lc/SoEjHuHqKipdED9OrNKoCqrF/uFMC7n7Y5cD3pTjzHVhCkK+y//ggi8Hdzyqn/87O396vd0K5/GxSyIUvr/Y/WMQPDAv98QT63IEy5gYkRexPYB04gbmCWUeeoLNNNodRVAHj3K6BNTb6Ks1pnmc2Pqr/ILmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.188.46])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0661F7E0120;
	Mon, 29 Jan 2024 10:40:11 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: andersson@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: ipq6018: enable sdhci node
Date: Mon, 29 Jan 2024 10:40:06 +0800
Message-Id: <20240129024006.1110513-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3dev6ez4iovtigj5felmwhascaaupzzptwz5wfoag7ml7knlmj@arnddy2jaqxz>
References: <3dev6ez4iovtigj5felmwhascaaupzzptwz5wfoag7ml7knlmj@arnddy2jaqxz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkxKVklPSx5MTUtOH0hOH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkNDVU9NWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8d5316b0ec03a2kunm0661f7e0120
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Pww5AjMQIgINTTMpQgJD
	KQEwCQ5VSlVKTEtNT0JNS0pISU1DVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkNDVU9NWVdZCAFZQUpCS043Bg++

Hi, Bjorn
> Subject and commit message says "enable", but this says disable. Could
> you change this to "Add" instead?

Thanks for your suggestion, I will change this to "Add".

> Do you have a patch for any board where this is actually enabled?
> Perhaps you missed a 3rd patch that enables this and uses the ipq6018_l2
> regulator you add in patch 1?

Some ipq6000 devices do not have pmic chips, resulting in l2 being
unavailable. So vqmmc-supply should be configured in the dts of each
specific device. As Robert suggested, the ipq6018_l2 node is used for
the device dts reference.

Thanks,
Chukun

-- 
2.25.1


