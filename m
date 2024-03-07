Return-Path: <linux-kernel+bounces-94907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36F87468D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8935D1F24619
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A7DDC9;
	Thu,  7 Mar 2024 03:08:22 +0000 (UTC)
Received: from mail-m6010.netease.com (mail-m6010.netease.com [210.79.60.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73963C7;
	Thu,  7 Mar 2024 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780902; cv=none; b=M32Toe6ZTRXW4E6bLgwuMa7/3FsTupfePxvPcwjGRep8oEjGE3PFlAYSCs0VtWxKTQ5onGDbr95rCnyAa9hfktwAJzvd5kAbslunEjeX2JO28joTX8hweMIznqTIGO9CiJizPTL2IydWZ9TBjiK+r8G/Fc0vVHRudAyKweJ2Mm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780902; c=relaxed/simple;
	bh=kvj3ANri2yPy3uMgzwhpUyEVGlN5bp99aSZhUob99TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y48rrO4sixgi98nTi8eVLgZrPFQXHaZ4/aKKTJS1/zsAg2tlXnXXElS1eqCcZeH0tGTUC71JU2y8cleeKmkAtjjqDOnUZNxzo7+/hzVobOucgDV2gC+L/OhSob06lQRZJ2PDa+Xjlv+fMzGYoRI9vD56JNqzRjj4iK1tr2oFO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=210.79.60.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:b7c4:f23e:200b:4ae6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 2533E7E012D;
	Thu,  7 Mar 2024 11:08:04 +0800 (CST)
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
Date: Thu,  7 Mar 2024 11:08:01 +0800
Message-Id: <20240307030801.93061-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpojj=3dv+FDm1GwXQ4+DPLncaZ6_6LwWQV2T8JCFpR16g@mail.gmail.com>
References: <CAA8EJpojj=3dv+FDm1GwXQ4+DPLncaZ6_6LwWQV2T8JCFpR16g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUxLVksYSE9JSxoeGBlMSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZFhoPEhUdFF
	lBWU9LSFVKSktDSEhVSktLVUtZBg++
X-HM-Tid: 0a8e16e1dbaa03a2kunm2533e7e012d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Qyo*PzMJIUJOD0hRKRMv
	EkhPC0hVSlVKTEtCTENLQ0NPQkpKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZCAFZQUpNTUI3Bg++

Hi, Dmitry
> Then the commit message should be changed, because you are enabling
> 1.5 GHz only for non-IPQ6000 SoCs. This patch has no effect on
> IPQ6000.

As I said in another reply, there are some ipq6000 SoCs that will be
recognized by the driver as ipq6018 and fused 1.5GHz.

Thanks,
Chukun

-- 
2.25.1


