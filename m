Return-Path: <linux-kernel+bounces-50945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1F84841E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A701C228FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A415481A7;
	Sat,  3 Feb 2024 07:00:34 +0000 (UTC)
Received: from mail-m12830.netease.com (mail-m12830.netease.com [103.209.128.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D5481A2;
	Sat,  3 Feb 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706943633; cv=none; b=VCw008/YNXozHhakRfXu3Qi/IQ0Gp/yZHkfMumI+SPMlNEjb5DbCixxL050NPnBt4oIvYTQr1UYmgKHwzmChwTQ/1uC3XuydpNdZf1flhS3MEg7Fc8tD0/rHXirDoDliL+/vQU7gWk49q9GHIy1BxB9J7hqupyaX0/a3YQepVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706943633; c=relaxed/simple;
	bh=gwpYgD9SXVmLkQjZQCkPviuVubC9iSyJGLJsGJwbn0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cx45Eb/MA6bym1eZ1PS0CVd1eMDHK4H1MMSWa/DEEyDrFMPN6+J14eOAUjnoK9AEYddbp7ml6VYvSAUE96cKrmKqhyueBqegYQDg2B/afiEKTUVUova/ByobzgE/1MvLYSBrt3uxkLAHQ86nYgNJF4QegXiHvsmM5akilSmYOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.209.128.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 40F3E7E0154;
	Sat,  3 Feb 2024 15:00:11 +0800 (CST)
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
Date: Sat,  3 Feb 2024 15:00:08 +0800
Message-Id: <20240203070008.15206-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <eqepewdgp5k3ajusf3hk7nazi2eli2w6wgxlbjroldwyobzh3d@aewtie2d3ora>
References: <eqepewdgp5k3ajusf3hk7nazi2eli2w6wgxlbjroldwyobzh3d@aewtie2d3ora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEtDVk8dQh5DGUIfSkNCGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8d6dc4825303a2kunm40f3e7e0154
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PE06Txw6IjMSDzgaKFFIQzQK
	LjQKCwxVSlVKTEtNQk9ITUpKQ0JPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJS0tLNwY+

Hi, Bjorn
> That sounds good, but do we have any one of those boards that should
> reference &ipq6018_l2? Could make plug it into the sdhci node on some
> board?

Actually I have an ipq6010 sdcard device with pmic, which needs to
reference ipq6018_l2. Also on the downstream qsdk kernel, the sdhc
node writes 'vqmmc-supply = <&ipq6018_l2>;' by default.

> Essentially, why is it needed upstream, when there are no user?

Most ipq60xx devices have pmic chips, including some ipq6000 devices,
while another ipq6000 devices do not have the pmic chips. So it does not
mean there are no users but the supply is board specific. Maybe we should
move the mp5496 node outside of ipq6018.dtsi.

Thanks,
Chukun

-- 
2.25.1


