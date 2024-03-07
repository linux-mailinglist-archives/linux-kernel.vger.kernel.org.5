Return-Path: <linux-kernel+bounces-94919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5D8746C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20CD1F23000
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAAFC1D;
	Thu,  7 Mar 2024 03:26:42 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C82F28;
	Thu,  7 Mar 2024 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782001; cv=none; b=PzMWr2Tzf2SXiTetHnq/clzO2zdmpfkYeprSyuIRZBW19p7RbkDTr2T6oTwpPCwU4HR5dELvC05PYhN5sULUjhLspOaGd2u+pH5C0HqcqWIBZjw05mVcumSkoL7hLZJq5K5tGNO22u7ChP5ZFSb6JZQgE8aM/Ixq5bzS7QxIVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782001; c=relaxed/simple;
	bh=xcYQQ0PtAhbpq+vnjverHxFQkCiFpC+1cT63vMExgvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9nPOXioXJpwgST+P4eLY3MBgDrZO1jbGi++a1A+mRrakLzQADxESvHi/vnzvt+V7PmQ3HZ6VL5nja+fhOrrZPivtDrZp3CY/ouCH/tBejAiW4OuMIoLDG3gPv/q0o89Lm6sjAjF/l+Jb7/WOUffdZ3ZG2G3uurx7lKIF+F+pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:b7c4:f23e:200b:4ae6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B98E57E013F;
	Thu,  7 Mar 2024 11:26:23 +0800 (CST)
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
	robh@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Thu,  7 Mar 2024 11:26:20 +0800
Message-Id: <20240307032620.94310-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0b032929-f525-4b2e-a176-1a447cf0fa7f@gmail.com>
References: <0b032929-f525-4b2e-a176-1a447cf0fa7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS05LVhlJTBkYHUMfTh4eGFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZFhoPEhUdFF
	lBWU9LSFVKTEpPTENVSktLVUpCS0tZBg++
X-HM-Tid: 0a8e16f2a2f803a2kunmb98e57e013f
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6PTo5NTMLKUIqDQ8xEg8s
	NDUaChZVSlVKTEtCTENKQkNPSEtCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZCAFZQUpOTEw3Bg++

Hi, Robert
> Can I ask the source of this voltage level?
> Because, its not present in the downstream QCA tree at all.

This voltage level is what I guessed through the mhz tool.
The downstream QCA tree uses 0.8625v voltage corresponding
to 1.32GHz, which does not need to be so high.

Thanks,
Chukun

-- 
2.25.1


