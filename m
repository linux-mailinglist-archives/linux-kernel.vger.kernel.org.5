Return-Path: <linux-kernel+bounces-94920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363908746C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683AB1C22321
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CA101CA;
	Thu,  7 Mar 2024 03:27:59 +0000 (UTC)
Received: from mail-m12824.netease.com (mail-m12824.netease.com [103.209.128.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECBD53E;
	Thu,  7 Mar 2024 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782078; cv=none; b=olPgkcJTlVwcJRkerH2krn+BZyM+xJN3tFMdv+UxF+4Dz4g/ULJc8wNhZTXF9LB3KLvIK3B9mp9HOjVujAxVtvQBXDA2D1jstK2h6y02QHGBG5nvsDdbyZ4nhshYWf5m9xKyUD0i6R5M4t+BKHOZzR1M0/Ar4MDF7KP0HkEjey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782078; c=relaxed/simple;
	bh=tu+3UyYopgmXT8N6DtMYhdKGd4KMCBspXBcRYdi2ZZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZ2zwe3ljuyIYJZUspSIRYVEIt4R5KKT7FqudBeHcUu99yZoZFRYDWu9SM6AolMoygN9+HmahBeJuDy0W3Jo+1my17hBhmsAnII7NPQuqtgedSF+V5NCAKd0x0rTD4yYn+JPbMIIPGSQScfFWc9aDs+KbZUk7bcd874IS1+05UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.209.128.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:b7c4:f23e:200b:4ae6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 9F5557E0135;
	Thu,  7 Mar 2024 10:50:19 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: konrad.dybcio@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Thu,  7 Mar 2024 10:50:16 +0800
Message-Id: <20240307025016.91979-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <21a53796-c4d4-44d0-b62b-52d327784a90@linaro.org>
References: <21a53796-c4d4-44d0-b62b-52d327784a90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQksdVh1KSR1NQx5MTU1OSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZFhoPEhUdFF
	lBWU9LSFVKTEpPTENVSktLVUpCS0tZBg++
X-HM-Tid: 0a8e16d19d4e03a2kunm9f5557e0135
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6Vhw6GTMLH0I6H04VKSsC
	EjRPCj1VSlVKTEtCTExCQ0lLQ0lNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZCAFZQUpNSkg3Bg++

Hi, Konrad
>> Some IPQ6000 SoCs have CPU frequencies up to 1.2GHz,
> (which ones specifically?)

This depends on the efuse value read by the driver.
For the boards I have, there are two cases: fused 1.2GHz
without pmic, fused 1.2GHz and fused 1.5GHz with pmic.

> Looks like said SoC can *only* run the CPUs at 1.2 GHz?

Yes, if the SoC is fused to 1.2GHz.

Thanks,
Chukun

-- 
2.25.1


