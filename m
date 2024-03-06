Return-Path: <linux-kernel+bounces-94175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A645F873AED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FD1F291EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FF135405;
	Wed,  6 Mar 2024 15:40:53 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843391350DE;
	Wed,  6 Mar 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739653; cv=none; b=YX1XvxK3Gv4ORWp3Ob0gdMsuvtV3LPeI+sQEp23GoCYOXUBNpwqGONmQZKl96aen4+0xwsSK7Uzp5S1I6DBt9c/iOuW4TFXm8xmcdzCCWznriTGgM+r4yV2CxXwwk0Xn5mW4TPUsK0eFZnihqG//uzVOtd32hnvtlUNG6PHEqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739653; c=relaxed/simple;
	bh=8iuBFQ8oqHOkkPo6WFZS6qJnmeXi0Tgaz9wJ53pSCRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8fZZSx/zN2kKT/ie5hRyndoahmxnpJBzzCJFkosony/DfUGdkFoeQHP5f6gRfE5XtWgdxqlDCGS5OfuvTV+jnXpjSX5In/hDRvTt8l1+M57zCzo0aYo7UvR6QfWWNLyArEgJDnNzvvClBwywKKX1+x3+zIjYxCl5ADNwjSCkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:eaac:ef59:d8ae:5dc6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 4B9F87E0126;
	Wed,  6 Mar 2024 23:40:36 +0800 (CST)
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
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: ipq6018: add 1.5GHz CPU Frequency
Date: Wed,  6 Mar 2024 23:40:33 +0800
Message-Id: <20240306154033.1290330-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpo+wLYzLNheCJKXHTZwwQO9zEnVYyGbj4gSPVVo9yoAMA@mail.gmail.com>
References: <CAA8EJpo+wLYzLNheCJKXHTZwwQO9zEnVYyGbj4gSPVVo9yoAMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRkeVk4aHUsfTU9DQkxLQlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e146c774003a2kunm4b9f87e0126
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6PSo*PzMPA0MhQzgYLCpL
	KDUaFA9VSlVKTEtCTEhCTUhNQ0JKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EeGhoYQR4dTkJBH0MaHkFOHxhNWVdZCAFZQUpDSUk3Bg++

Hi, Dmitry
> After this patch non-PMIC IPQ6000 boardss are broken until patch3 is
> applied. Please change the order of these patches.

This is not the case, please see `opp-supported-hw = <0x2>;`.
Also: https://github.com/torvalds/linux/blob/master/drivers/cpufreq/qcom-cpufreq-nvmem.c#L334
This 1.5GHz Frequency only takes effect when the fuse value is `2'b1`.
I have tested this patch on both fused 1.2GHz and 1.5GHz devices.

Thanks,
Chukun

-- 
2.25.1


