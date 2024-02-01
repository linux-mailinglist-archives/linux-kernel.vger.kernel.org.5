Return-Path: <linux-kernel+bounces-47596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6198844FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B61728E9A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CAC3B78E;
	Thu,  1 Feb 2024 04:00:58 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD23B2A6;
	Thu,  1 Feb 2024 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760058; cv=none; b=ha+IGntUQPpvpzBcBQQ2KinR/FJPhfWzZbPlh2DkRd0OTAHbnQ0d7xOx06XfHWa/xqeHuBxpPK395aQrpGL2ciO0P36/Vxiy2io0oQOnP3VpyyomhoTdC5wwA7b+QPk8glxMN8m1A6grH9cT8x0d1insC0QM6UToVZ64sKCMxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760058; c=relaxed/simple;
	bh=gdpOp04JWfjnJCKvypEu4np3p5EXlbEJ3fJVxQUR0aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+2ZFBrd8zrnyPYkdw/XQ+S4yAjJbkp2lh7OgaY/J+BywNN/GGJYQFSR9fx/iWwLnWMKeeSwjW5uyLMhK/2DGTKnhrCRlAwJFZRhp7F5m16rfKxx8U8HTMW2zXDlXScmGeTfkUdqixHDpNTpazTClr6UB2i8kF5Q9b2shZc3el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [116.25.94.16])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C2EFA7E010C;
	Thu,  1 Feb 2024 12:00:23 +0800 (CST)
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
Date: Thu,  1 Feb 2024 12:00:20 +0800
Message-Id: <20240201040020.73949-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJpoMXkAd3EBf=p+nig8VWzY9tiUAWhfGJn3XOX1uSa=22Q@mail.gmail.com>
References: <CAA8EJpoMXkAd3EBf=p+nig8VWzY9tiUAWhfGJn3XOX1uSa=22Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkoYVkJJSEkfShodTkNPGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKTVVJTlVCT1VKTVlXWRYaDxIVHRRZQVlPS0hVSkhKTk1JVUpLS1VLWQY+
X-HM-Tid: 0a8d62d3311903a2kunmc2efa7e010c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Kio6FDMLFE0pLCIoLCsB
	PCgwFA9VSlVKTEtNTE1LS0lPTExPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	TVVJTlVCT1VKTVlXWQgBWUFJSE5KNwY+

Hi, Dmitry
> Straight to the board files, please, no need for additional includes.

Is it possible to move the mp5496 node to mp5496.dtsi?
Because ipq9574 also uses this mp5496 pmic.

&rpm_requests {
	regulators {
		compatible = "qcom,rpm-mp5496-regulators";

		mp5496_s1: s1 {
			regulator-min-microvolt = <725000>;
			regulator-max-microvolt = <1075000>;
			status = "disabled";
		};

		mp5496_s2: s2 {
			regulator-min-microvolt = <725000>;
			regulator-max-microvolt = <1062500>;
			status = "disabled";
		};

		mp5496_l2: l2 {
			regulator-min-microvolt = <1800000>;
			regulator-max-microvolt = <3300000>;
			status = "disabled";
		};
	};
};

> From your patches I had the feeling that you still want to limit the
> high-frequency OPP entries if there is no PMIC.

Sorry for this misunderstanding, the cpu max frequency is determined
by the cpu_speed_bin. It's just that the efuse of the board I have
without pmic are all 1.2GHz.

Thanks,
Chukun

-- 
2.25.1


