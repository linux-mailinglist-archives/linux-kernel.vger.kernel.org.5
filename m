Return-Path: <linux-kernel+bounces-21659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC7829284
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662041C254A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D23C35;
	Wed, 10 Jan 2024 02:49:45 +0000 (UTC)
Received: from mail-m6039.netease.com (mail-m6039.netease.com [210.79.60.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0323B1;
	Wed, 10 Jan 2024 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.118.191.185])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id ADA5A800017;
	Wed, 10 Jan 2024 10:30:23 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: robimarko@gmail.com
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: qcom: ipq6018: enable sdhci node
Date: Wed, 10 Jan 2024 10:30:19 +0800
Message-Id: <20240110023019.10096-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ddc610d5-5047-4921-869b-47bdafb38d9a@gmail.com>
References: <ddc610d5-5047-4921-869b-47bdafb38d9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHk0dVkIaHktIHktKQkpITVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVKSkNVSkJKVUpDTllXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8cf134e229b03akuuuada5a800017
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Igw4NjwfUTQyAhk3Ez5N
	TzwKCSxVSlVKTEtPQ05IQ0lPQk5OVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSkNVSkJKVUpDTllXWQgBWUFKTklONwY+

Hi, Robert
> L2 LDO should be used as VQMMC supply, otherwise you cannot change 
> between 3 and 1.8V.

Some ipq6000 devices do not have pmic chips, resulting in l2 being
unavailable. So vqmmc-supply should be configured in the dts of the
device.

Thanks,
Chukun

-- 
2.25.1


