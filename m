Return-Path: <linux-kernel+bounces-95044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E666787488C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA47D284E41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871591D54D;
	Thu,  7 Mar 2024 07:17:54 +0000 (UTC)
Received: from mail-m17245.xmail.ntesmail.com (mail-m17245.xmail.ntesmail.com [45.195.17.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF311CBA;
	Thu,  7 Mar 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795874; cv=none; b=LakwwzfRzb5234Z6+m/ll5nW6gMaTlLgSXaPj9gNBDhZSLIsB064UQKUrh9kMsLVbavNZElsaCsKUzokQhbWe97XgoA9i+AjHR7QF9OKVihstMG1NjtzjFgyMFKMhB67YjuXc1jJHIYEdHkOgWoTvtxe8Iq396yw0EtNzqtZCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795874; c=relaxed/simple;
	bh=QmoWsKT312NudiuLBdzhVN+EEkH7n+MNgnYRlipqeMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+MPW+F8BcEQjs4xGUChz1xV1NoEDCHaBIlNiZfOQcfdFlR9qWw2fDZU5D8CXcBoMvymeWlNwGsyLU0F2bugv2wvvO8g4av2eJdUtsfVJN9fhT+6DPblvJ/ajFDFidjwDT+lVcffSw4yXd63VFJD1FZpUa3kqAxmn5K5EoEVf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.17.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:4970:b7c4:f23e:200b:4ae6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1D0A37E0117;
	Thu,  7 Mar 2024 11:02:23 +0800 (CST)
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
Date: Thu,  7 Mar 2024 11:02:19 +0800
Message-Id: <20240307030219.92701-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpoghqa5r2vc5XXdfVJy1WDBysXs4LdMybgdgqMTcEPDfA@mail.gmail.com>
References: <CAA8EJpoghqa5r2vc5XXdfVJy1WDBysXs4LdMybgdgqMTcEPDfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUNPVh5IQkJMHh5ISB8fH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZFhoPEhUdFF
	lBWU9LSFVKSktDSEhVSktLVUtZBg++
X-HM-Tid: 0a8e16dca77d03a2kunm1d0a37e0117
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6DRw*DDMTE0IoD0koKQ8u
	Qz8wFBlVSlVKTEtCTENLTk9IQ0hNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBT0JMS0EZTBhPQR1JSB5BSUtLGUFPGh5NWVdZCAFZQUpDTEw3Bg++

Hi, Dmitry
> I did before writing the comment. You have the only IPQ6000 case, it
> sets  drv->versions = IPQ6000_VERSION = BIT(2) = 0x4. So, as I said,
> you are enabling this for all IPQ6000 SoC versions, unless I miss
> something.

Sorry, I didn't explain it clearly.
In fact, there are some ipq6000 SoCs whose msm_id is QCOM_ID_IPQ6018.
But the chip screen printing is ipq6000.
OEM boot log: `CPU: IPQ6018, SoC Version: 1.0`
For these SOCs, I tested the frequency is up to 1.5GHz.

Thanks,
Chukun

-- 
2.25.1


