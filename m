Return-Path: <linux-kernel+bounces-47561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAA844F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BCB1C23AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030A3A8C6;
	Thu,  1 Feb 2024 03:08:57 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB33A1A8;
	Thu,  1 Feb 2024 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756937; cv=none; b=YtcoBiGbzeU516I2VGyrhg0twIdaU9fODfYLPlYlTV0ynvWyTJp6hKRSry2dieJwbwnNG/oCz6YfbOBFm9+FoI+DXkzwQ1Yg/LIHlJmOMRhJquuJYOqQ1sMBTuz4xWsXsxmJLugJfhlOPoGrNzLvE0UDxNsgdvmlWsYpDws7GDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756937; c=relaxed/simple;
	bh=ba02lxagDOqyC6LatKURHMkiG2wDHaP/LE00MbQrzlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkdL05d8HvRKT2PddQmHha6HUYs1uZiPRpOlxwkNKzLy7hSdclThNqV6wt1jIySE2M1CY9WDe7c/a1LxuHFla4EezuMNPOLQWnmcyGZ4MN3MM7HML5MDeZHbeJtFPbSZOSsUdpp/C2dp8KHHY/HWWDXaOmqRoEv6NRxvt2PYWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id ADB177E013A;
	Thu,  1 Feb 2024 11:08:31 +0800 (CST)
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
	robh+dt@kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: ipq6018: separate CPU OPP tables
Date: Thu,  1 Feb 2024 11:08:28 +0800
Message-Id: <20240201030828.12515-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJppDQAdnceYhL_=Di0n5j3W0F2+7ntpNMxpXBXgnYoh_uQ@mail.gmail.com>
References: <CAA8EJppDQAdnceYhL_=Di0n5j3W0F2+7ntpNMxpXBXgnYoh_uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGRpNVkhDSx9CSB5JTExOT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkpLQ0hIVUpLS1VLWQY+
X-HM-Tid: 0a8d62a3b49f03a2kunmadb177e013a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Ljo*KjMNTU0sKAkiSRMR
	NQgKChZVSlVKTEtNTE5NQkpJQ05KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJTkNPNwY+

Hi, Dmitry
> I went on and checked ipq6018.dtsi. It will need to be reworked before
> we can continue with PMIC-less devices.

> Obviously, the PMIC is not a part of the SoC. So please move the
> "qcom,rpm-mp5496-regulators" node to the board files together with the
> cpu-supply properties that reference that regulator.

Thanks a lot for your advice, now things are clearer.
My idea is as follows:

1. Add all frequencies supported by SoCs in ipq6018.dtsi

2. Move cpu-supply and mp5496 nodes to ipq6018-mp5496.dtsi

&CPU0 {
	cpu-supply = <&ipq6018_s2>;
};
..

&rpm_requests {
	regulators {
		rpm-mp5496...
		ipq6018_s2...
	};
};

> The SoC itself supports all listed frequencies, so it is incorrect to
> split the opp tables from the ipq6018.dtsi. Instead please patch the
> PMIC-less boards in the following way:

> #include "ipq6018.dtsi"
> &cpu_opp_table {
>  /* the board doesn't have a PMIC, disable CPU frequencies which
> require higher voltages */
>  /delete-node/ opp-1320000000;
>  /delete-node/ opp-1440000000;
>};

Thank you but no need. The CPUFreq NVMEM driver will give the CPU
maximum frequency based on the cpu_speed_bin and opp-supported-hw.

Thanks,
Chukun

-- 
2.25.1


