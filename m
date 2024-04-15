Return-Path: <linux-kernel+bounces-145005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F58A4E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF5A1C2107F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A7664C0;
	Mon, 15 Apr 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mVNncCu/"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34E5FDA5;
	Mon, 15 Apr 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181756; cv=none; b=K4+5uw1HazGFyBSi+KjGXBIKwEWw1yepBdYgYMrx+ViAKtMdPfjcDAj8H42uhZPHmFlyJ9qHmLj1TQt0MdZV26Gx6GFwdj6rMSO8GiWMpSBEORArhQvwzgNW9MZSJVr6C5B46IZoEIzdiBbkAGcJT2q9TECVRS6/mQ2eUXN6OMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181756; c=relaxed/simple;
	bh=G8fWXo3iYomK/Zb8qEDLPhPh/MgtbTcPcQX5b29Ifzk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Cm3wx9DAkrZUBKvdYdSeToDT9DnQjK2BAgQibht9ZP0n9RISMHZbHeGjtnWpxriZmtxyY4wy46/e9r4c33MoDHef8FvhT5rkLy8oAxDYxK0BfDf2T/xK93hNjssSEGY/HRwg4ZHgNI1A/m4k17OEW3a4qL+ToJazJGhuRJU+Zjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mVNncCu/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240415114905epoutp047ec76ae33f35546306f3645b8a63e6d3~GcbiXPQqs2027520275epoutp04F;
	Mon, 15 Apr 2024 11:49:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240415114905epoutp047ec76ae33f35546306f3645b8a63e6d3~GcbiXPQqs2027520275epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713181745;
	bh=xiCoQ88Z4aGkr+U0s3cjc/8zyNw/xshgaY2fZquL++8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mVNncCu/4q324nre0zv4OS2gPOdqkPVfQgxQVb0C8k9GPKF30WlBMBu8+LVObanpl
	 ZtaDf7es8zp8wDqChl6ATSV8N5a0br+8bdEhggjd+z5puL/NAe2NNZ4aReN17AIx6L
	 3Dnl8gALewtz09KtOzW2dFOTuL5ILBztMYs0doIE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240415114905epcas5p4eacaaad84bb05b4fd2bf1ff9eca4400f~Gcbhyt3Pj1794217942epcas5p4M;
	Mon, 15 Apr 2024 11:49:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VJ56l4Ylwz4x9Pw; Mon, 15 Apr
	2024 11:49:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.EE.09666.F241D166; Mon, 15 Apr 2024 20:49:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240415114903epcas5p47c4eeb90c7407377878f6a6bd2bc1458~Gcbfxdu7t1794217942epcas5p4K;
	Mon, 15 Apr 2024 11:49:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240415114903epsmtrp190d3f7c835c3802c90fd5f7e320072df~GcbfvzlT40122301223epsmtrp1R;
	Mon, 15 Apr 2024 11:49:03 +0000 (GMT)
X-AuditID: b6c32a49-cefff700000025c2-6f-661d142f157f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.57.08390.E241D166; Mon, 15 Apr 2024 20:49:02 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240415114855epsmtip20375f57d0f3c7972dd46af099f38f3dd~GcbYxrnY92898028980epsmtip2b;
	Mon, 15 Apr 2024 11:48:55 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Rob Herring'" <robh@kernel.org>, <soc@kernel.org>, "'Krzysztof
 Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>, "'Conor Dooley'"
	<conor+dt@kernel.org>, "'Florian Fainelli'" <florian.fainelli@broadcom.com>,
	"'Broadcom internal kernel review list'"
	<bcm-kernel-feedback-list@broadcom.com>, "'Dinh Nguyen'"
	<dinguyen@kernel.org>, "'Tsahee Zidenberg'" <tsahee@annapurnalabs.com>,
	"'Antoine Tenart'" <atenart@kernel.org>, "'Khuong Dinh'"
	<khuong@os.amperecomputing.com>, "'Liviu	Dudau'" <liviu.dudau@arm.com>,
	"'Sudeep Holla'" <sudeep.holla@arm.com>, "'Lorenzo	Pieralisi'"
	<lpieralisi@kernel.org>, "'Ray Jui'" <rjui@broadcom.com>, "'Scott	Branden'"
	<sbranden@broadcom.com>, "'Robert Richter'" <rric@kernel.org>, "'Shawn Guo'"
	<shawnguo@kernel.org>, "'Li Yang'" <leoyang.li@nxp.com>, "'Sascha Hauer'"
	<s.hauer@pengutronix.de>, "'Pengutronix Kernel Team'"
	<kernel@pengutronix.de>, "'Fabio Estevam'" <festevam@gmail.com>, "'Paul J.
 Murphy'" <paul.j.murphy@intel.com>, "'Daniele Alessandrelli'"
	<daniele.alessandrelli@intel.com>, "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Gregory	Clement'" <gregory.clement@bootlin.com>, "'Sebastian Hesselbarth'"
	<sebastian.hesselbarth@gmail.com>, "'Matthias Brugger'"
	<matthias.bgg@gmail.com>, "'AngeloGioacchino Del Regno'"
	<angelogioacchino.delregno@collabora.com>, "'Thierry Reding'"
	<thierry.reding@gmail.com>, "'Jonathan Hunter'" <jonathanh@nvidia.com>,
	"'Bjorn	Andersson'" <andersson@kernel.org>, "'Konrad Dybcio'"
	<konrad.dybcio@linaro.org>, =?utf-8?Q?'Andreas_F=C3=A4rber'?=
	<afaerber@suse.de>, "'Heiko Stuebner'" <heiko@sntech.de>, "'Orson Zhai'"
	<orsonzhai@gmail.com>, "'Baolin Wang'" <baolin.wang@linux.alibaba.com>,
	"'Chunyan Zhang'" <zhang.lyra@gmail.com>, "'Jisheng Zhang'"
	<jszhang@kernel.org>, <linux-fsd@tesla.com>, "'Michal Simek'"
	<michal.simek@amd.com>
Cc: <devicetree@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-realtek-soc@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20240412222857.3873079-1-robh@kernel.org>
Subject: RE: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
Date: Mon, 15 Apr 2024 17:18:54 +0530
Message-ID: <0b3b01da8f2a$e9560ca0$bc0225e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLY8iYk/Bpt/dsaN0W9BEDsUNhRuQIeG7qZr1t/T6A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1CUZRT2/a67MujHxXijtHUdLTUuK7eDeUkj/FRUZpp0pqlwg2+BAXbX
	3cXSsNBdEUSwrUBYAeWSFBKriwMLQuqKGk1KeEFHxEDAARFSbCoEpYVPy3/POed53uec98yR
	kO4lEm9JvNog6NTKRDkzlao5O3++j5/nTJV/VuqrYLTpoSZ9CbR0OEi4/AOGh4VHEYw3nkfw
	Y9Y5CiobLxFw6+4ZBIeaLtFwruUkAV3XNkBVzW0SCr7fBuN3BmjIv72bAZOlhALjeSsDFTl1
	FBR/XUND+je1FGT3dZHgMJ4mwNbdRoP51EUWuu5tgiv1BQxcMbYisOZeZWC4c5wEc/sxFvJa
	fiIg408LA6e/20OBacxEwS5TADReaKXhwIODCEYdwzT05lczMN5gZ+FMxXECntTaKBg62oPg
	j5EV0HfCC7qvjzFQ/oudgpH6IgqqSvNZKO+sZ98O4HdffsLwTwetLF9ZVIn4osrPecvvFxne
	3lGG+DpLB8uXNvQTvK0ig+FvtTUwfF1XKF9d9iXfV53vJNgfEXyWcYjhjw/ZiciXPkhYEico
	YwSdTFBHa2Li1bFL5Wvfi3onKijYX+GjCIUQuUytTBKWysMiIn3C4xOd65DLtioTk52pSKVe
	L/dbtkSnSTYIsjiN3rBULmhjErWBWl+9MkmfrI71VQuGxQp//0VBTuLmhLjiMzZa+9jjs/Z9
	D9lUlD59L5JKMBeIK27lob1oqsSdO4lwRkfrs2AY4YM3TLQY/IXw/cdt9HPJ5dxsViw0Ipzr
	MJNi0IfwaPd9ZoLFcD7YXpo2iT25hmn4dlHSBInkMkmcZ901WZByIbi5+ubksx5cBC7sy3Zi
	iYTi5uL92asm0q5cKK5qbEAidsPN+T3UBCa513DtYAEpdiTDI71HaNFrMS4prSJEjhfuP9c0
	2SnmTC54fMDIiIIwfDTb+GwcD3zvwglWxN64f38aO9ED5nhcMuYtpuPwYLkViXg5Pn21gJqg
	kNx8bK33E62m4azRHkJUuuL0NHeRPRcbh65RIn4FmzMzn5nyuKf+EfkVmm15YTDLC4NZXhjA
	8r/ZYURVoJcFrT4pVtAHaRVq4dP/9h2tSbKhyWNdsNqOOjof+DoQIUEOhCWk3NPV5DFT5e4a
	o9y2XdBponTJiYLegYKcn20mvWdEa5zXrjZEKQJD/QODg4MDQwOCFXIv14HdhTHuXKzSICQI
	glbQPdcREql3KhFgyFPVDB9zq2sqkW1+PWDGRunH0dJThd0kzTbNaouY58txUZHW1avLFh2S
	jm3esH6Dm2rtlLwpNR5JZetD3l/Xdac3U4h7mLZmTur1NS3Fs2Yc/luzx7Di7saIdpXL8mvL
	MsprvVaMyqokWp0uxXhz589FK2fteGo3bwrp8FzYnhO+5UBnqNFkowJUZ0cevKXS0Tc08WMU
	77OwLTV6zuzh7i0qs094wkDKu6kVndMPTAtbmZAT/m1znefesSPSugs72eaCN1q+aNru6VJU
	qe4VloX4058UZ6zre7N/lV6m/XD/jhEXWc5gYXFwWPJ2P0dI6zyHmyl5/Ld/AlO2rmk++9Gv
	uyLklD5OqVhA6vTKfwGghwx2NQUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH97u9vfeCYdbCyg8IU7sHA6TiVDwom2Oa7C5bxJgZE9wyyygv
	KZAWx8oeENoiqCDVQG3lDcqoCKMQKNhu0EkXNnmIz03rqFKFIQyZYWOoTChL+O+b8/meT84f
	h+Hwj1G+TGJKukSWIk4WUu5k24/C1SEiL/+40KKcraA0yqEtLwIG7FYODNVjeFR2DsG8xYbg
	fEEPCQ2WfgJu3+9GUHGxnws9AxcIcFyLgsa2Oxwo/VYB83fHuaC7o6ZApa8mQWlrosBQ3EFC
	1Yk2LuSdbCehcNTBAauyiwDjvetc0PzQR4Pjj31wpbOUgivKywiaSq5SMD08zwHNre9oODXw
	PQH5j/UUdJ05TILqiYqEHNVGsPx0mQvaqdMI5qzTXHDqWiiYN5to6DY0E/C03UjC5LkRBH/O
	RsJoqzfcu/GEgrqfTSTMdpaT0Fijo6FuuJN+ZyOrHnpKsc8mmmi2obwBseUNX7L63/so1mSv
	RWyH3k6zNeYxgjUa8in29nUzxXY4wtmW2ix2tEX3vGD6i2ALlJMU2zxpInYLot0jYiXJiZ9L
	ZOvfPuCeUNVt5Kb96/nFrWOP6GyUt/IIcmMwbxMeKimkjyB3hs+7gLBGOUa7gB++0Vy0lD1x
	/bMHS6X7COeevoQWAMULwaaaXGoBePGuvohbLEruAuDwijm4cmKnayMP4f65CWoBuPG24N6W
	3xZLnrwPcdlo4fPMMCTvNXy88L2FsQcvHDdazMiVV+Fe3QjpcgZj56/Opbwat0+UclzXrcGz
	zrOLSi/eVlxd00i4Ot54rOciXYQ89ctU+mUq/TKVftlKJSINyEeSJpfGS+Ub0t5MkWSI5GKp
	/FBKvOizVKkRLT5sUJAJmQ1TIisiGGRFmOEIvTxUnv5xfI9YsSJTIkv9VHYoWSK3Ij+GFHp7
	zIwXxPJ58eJ0yUGJJE0i+58SjJtvNlEXOJ9QOWywz6y69m7YgbW0qlZg6RisEEhTE6tPVO4p
	2TWnLiZPapPf2h2y+WyIIylAvR32p6tTAmzBigeZr7w6BLHSCCbjkjDpqzUPNzd/sG58TKP9
	2jlyvnrl66Lsvds7Fdu8oxIc4/z346YeZ4mQ+e+d8tCsaajRBAfm9gZzTYXRD1eE2bZp1QG/
	vJBxtzeZ2KdsVZxJDA/00UaumOEOygYqBfGN/HrnJy9rhTGWikhvwQ7fw5tiQtfGrEMvdflH
	55wK6oY02/oOza4o9ug3HyWV7b95VKr4J8LuI2jt24Jse4fsNwdbParyD+pwSBmaKN3hV5Xz
	cWaBfY8g7A0hKU8QbwjiyOTi/wBJ6xsTHwQAAA==
X-CMS-MailID: 20240415114903epcas5p47c4eeb90c7407377878f6a6bd2bc1458
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240412222916epcas5p4eaf4b2eeb34e8fad4634d8fca9196e98
References: <CGME20240412222916epcas5p4eaf4b2eeb34e8fad4634d8fca9196e98@epcas5p4.samsung.com>
	<20240412222857.3873079-1-robh@kernel.org>



> -----Original Message-----
> 
> The "arm,armv8-pmuv3" compatible is intended only for s/w models.
> Primarily, it doesn't provide any detail on uarch specific events.
> 
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> SoC Maintainers, Can you please apply this directly.
> ---
>  arch/arm/boot/dts/broadcom/bcm2711.dtsi              | 4 ++--
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 2 +-
>  arch/arm64/boot/dts/amazon/alpine-v2.dtsi            | 2 +-
>  arch/arm64/boot/dts/apm/apm-storm.dtsi               | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 2 +-
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi     | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi  | 2 +-
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 2 +-
>  arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi        | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 5 -----
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi           | 2 +-
>  arch/arm64/boot/dts/intel/keembay-soc.dtsi           | 2 +-
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi        | 2 +-
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi        | 2 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi         | 2 +-
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi             | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                | 2 +-
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi                | 2 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/sdx75.dtsi                  | 2 +-
>  arch/arm64/boot/dts/realtek/rtd16xx.dtsi             | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi             | 2 +-
>  arch/arm64/boot/dts/sprd/sc9860.dtsi                 | 2 +-
>  arch/arm64/boot/dts/sprd/sc9863a.dtsi                | 2 +-
>  arch/arm64/boot/dts/synaptics/berlin4ct.dtsi         | 2 +-
>  arch/arm64/boot/dts/tesla/fsd.dtsi                   | 2 +-

For FSD SoC,

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>


