Return-Path: <linux-kernel+bounces-3390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F5816BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B1283007
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6418EC4;
	Mon, 18 Dec 2023 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YTVZXeFC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8743199C1;
	Mon, 18 Dec 2023 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3zMsq
	zxERBHEQfxFqCRnEbkWCpgZ7dTA4M/X9Ze6/Rk=; b=YTVZXeFC5IzpriFx2JpK1
	fd9Bnf03DJplQQwExm868/qNYuzgCxPCxX6ISiLHfK2xnXeHZfq5jl21giEtaYSB
	j+UAzcw4lbTnHN2bKW4w80v7sMlFPmxHoRJ17P5mIBmsJ/3LijB5y7A1gfDB888x
	clKlxKeN1dnBXu9/Gz/CnQ=
Received: from ProDesk.. (unknown [58.22.7.114])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDn72EdJYBln1v+Bg--.7214S2;
	Mon, 18 Dec 2023 18:55:29 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	zhengxing@rock-chips.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 0/3] Fix mainline support for rk3036 kylin board
Date: Mon, 18 Dec 2023 18:55:20 +0800
Message-Id: <20231218105523.2478315-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn72EdJYBln1v+Bg--.7214S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrtF1ruF18GF43Ww1UGFg_yoW3ZFb_ta
	4fWw1kJa1rGr15t3W5tw4fW398A348KFs3GayDtFnrJF90qF17ZasayasFqF1SyFyS93Z7
	CrWYgF1j9wsxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0KQ6JUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBtKXmVOBAraoQABs4

From: Andy Yan <andy.yan@rock-chips.com>


When I want to test some patch of inno hdmi driver on
mainline, I found the support of rk3036 kylin board
was broken by somehow:

PATCH 1 is add psci dt node, as we switch to psci for
cpu on/off for many yeas.
PATCH 2 add stdou-path for uart boot console.
PATCH 3 fix the emmc per board rockchip,default-sample-phase property
issue.

Changes in v2:
- Fix typo s/patch/path/
- Change subjet s/arm/ARM/

Andy Yan (3):
  ARM: dts: rockchip: Add psci for rk3036
  ARM: dts: rockchip: Add stdout-path for rk3036 kylin
  ARM: dts: rockchip: Remove rockchip,default-sample-phase from
    rk3036.dtsi

 arch/arm/boot/dts/rockchip/rk3036-kylin.dts | 4 ++++
 arch/arm/boot/dts/rockchip/rk3036.dtsi      | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1


