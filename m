Return-Path: <linux-kernel+bounces-151381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF578AADDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77380B214CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80283A09;
	Fri, 19 Apr 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwZEo8VU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A51823AF;
	Fri, 19 Apr 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526975; cv=none; b=hmULPww+/K06Amfay7UZ4edEohVx8a+XSjxgWLTTBzu4GskrXDIs8LFJLaNAfHqB4uEDZCOEMF0CDRzPd8nxYLsZLGyKrMA4AyTcOd8U69a45x1vbCbrt1+hy3Jt4jDCartEspmeDUly3cAlQ3dicsiS+nwKBoH7bxTd3xzxjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526975; c=relaxed/simple;
	bh=FxcW7VdpJiXtK3MRSvRJJB20oxQZtoBlZJZyIFAy51s=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qhsBeHRk/9rpiBMuGZqg2t/ImAEwV3BTBC+w8KpKy/n+hWubIHXnhZoETzL1JlZDW/9aMLmAJ7HOh1kqnNhXIFi+F6lPsNuk8DogA1snEJR9I1QVgDNDT/yTjP8E8mjtM+7jNkey/oVXD37fCXu5IM+pScIubpbz7PeUXyd1ZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwZEo8VU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so2121982a12.3;
        Fri, 19 Apr 2024 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713526972; x=1714131772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vtm/qtvswOnFXXfebYKskz6/e32yJZ1ZzR1vI0Fp9dI=;
        b=OwZEo8VUBgCQUJYn9A0TPLxEizgP9ndnDrH/9L8VquaFMOoFnWBWSqlhFPcH3oCAQ9
         AiM9x+5lS9EA6gt8EWv0/pn5uQJVPLrazUDqB6qJR3PYqSFpub3tEHQgrSi08fAKS2m2
         fvrMFWHY8g6DnSpf5YDT+MCaKBw9k4XCvOFx6Gyu7f6kiNKJIAB75/3A81ZUBIrooeMP
         NmILJa5vusSpVqcfUrR0Nm7+G4KUQAOoFWZe9Lm6ayH+ppftICpkxuN83fFjvS3BT1TK
         QV/KdZrmPqdvEdJ5ncJgibXDoLLhfBsvCGNY3Elxq+YLDKpbFNSJDkgeaVDE+rRdNYfr
         DLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526972; x=1714131772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtm/qtvswOnFXXfebYKskz6/e32yJZ1ZzR1vI0Fp9dI=;
        b=F0ZXtDDz5l2kg1iEmLvXbQG8/+yKGOeWHGjQvm8F+vvJik1AJpDL6H1OHT0jaJ6XPj
         un0bMhU+xZmYuIZ2w8GOGoM+9itKRmyJBa31Tq1YX+GVfnFdDpVEi0mi1cNyx6eNTJXA
         6q96F9YbmT5PV/hgzmsAO5VWMzXzu6dniOJUKXydhnpIrmT3SA8rrTH5sijVLPjn3Cwe
         JIJwXnopQHVmELRWAQLUo1sMQOT8MyMBxmmPqoji/8Fh0b545m7cedB3v5YPs8aTYCvd
         zkXoN/wV69Jld/wIU1PzGNvZq6kFnsWS/cbjS2gn7qmePK/sxKr693gPbxDyz2nvFDQ0
         snpA==
X-Forwarded-Encrypted: i=1; AJvYcCV7ewr1+642PzSxTn9idqTGGhXJOopG+fJgsLrFj/0SCXzUxH/EyJEprvLhSz0EPT0m/OZgXceNNTK2SJmq/6yijhTcmEdNCw06/IxkP0/LAfZh3LV6D/JCbLuYYyp2THtvhHx7quUovST4nedTxkRa8dXPvkVK4Fg0KwiPgfHoUue6/pNWTE/3eGlkdJ3D671J8QTYsYuWKmTSLLFeM1Tmz0QVzK/Yxq64cA4=
X-Gm-Message-State: AOJu0Yx81g8pQuiUPOcv40/8NQ0LSKTUg0CVdSOoLnHicHz9ByDsGWBe
	h0Akss95mvlgnBexLtB58eXTV4sDS0PX9xlox9WwcHFYHaOxsu+z
X-Google-Smtp-Source: AGHT+IEwLsjbBwvBlONApjs+36NUlgAVIroqpndgR5Yohi7VmGBl9cWXP/CC/Cs/xZloP3RIelGMIw==
X-Received: by 2002:a50:a416:0:b0:56e:f64:aaf6 with SMTP id u22-20020a50a416000000b0056e0f64aaf6mr1348117edb.5.1713526972237;
        Fri, 19 Apr 2024 04:42:52 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t16-20020aa7d4d0000000b005701f033da5sm2034565edr.79.2024.04.19.04.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:42:51 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=028f56741d52f91b0bec672921ccea60e74b58ce9c1c05854f65f7d060c2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 13:42:50 +0200
Message-Id: <D0O2M756FW2M.2XMFVYGKJ1O7W@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
 <linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-realtek-soc@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible
 usage
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, <soc@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Dinh Nguyen"
 <dinguyen@kernel.org>, "Tsahee Zidenberg" <tsahee@annapurnalabs.com>,
 "Antoine Tenart" <atenart@kernel.org>, "Khuong Dinh"
 <khuong@os.amperecomputing.com>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@arm.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Ray Jui" <rjui@broadcom.com>, "Scott Branden"
 <sbranden@broadcom.com>, "Robert Richter" <rric@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Li Yang" <leoyang.li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Paul J.
 Murphy" <paul.j.murphy@intel.com>, "Daniele Alessandrelli"
 <daniele.alessandrelli@intel.com>, "Andrew Lunn" <andrew@lunn.ch>, "Gregory
 Clement" <gregory.clement@bootlin.com>, "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, =?utf-8?q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, "Heiko Stuebner" <heiko@sntech.de>, "Orson Zhai"
 <orsonzhai@gmail.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Chunyan Zhang" <zhang.lyra@gmail.com>, "Jisheng Zhang"
 <jszhang@kernel.org>, "Alim Akhtar" <alim.akhtar@samsung.com>,
 <linux-fsd@tesla.com>, "Michal Simek" <michal.simek@amd.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240417203853.3212103-1-robh@kernel.org>
In-Reply-To: <20240417203853.3212103-1-robh@kernel.org>

--028f56741d52f91b0bec672921ccea60e74b58ce9c1c05854f65f7d060c2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 17, 2024 at 10:38 PM CEST, Rob Herring (Arm) wrote:
> The "arm,armv8-pmuv3" compatible is intended only for s/w models. Primari=
ly,
> it doesn't provide any detail on uarch specific events.
>
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> SoC Maintainers, Can you please apply this directly.
>
> v2:
>  - Drop QCom sdm630 change
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
>  arch/arm64/boot/dts/qcom/sdx75.dtsi                  | 2 +-
>  arch/arm64/boot/dts/realtek/rtd16xx.dtsi             | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi             | 2 +-
>  arch/arm64/boot/dts/sprd/sc9860.dtsi                 | 2 +-
>  arch/arm64/boot/dts/sprd/sc9863a.dtsi                | 2 +-
>  arch/arm64/boot/dts/synaptics/berlin4ct.dtsi         | 2 +-
>  arch/arm64/boot/dts/tesla/fsd.dtsi                   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 2 +-
>  31 files changed, 43 insertions(+), 34 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--028f56741d52f91b0bec672921ccea60e74b58ce9c1c05854f65f7d060c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiWLsACgkQ3SOs138+
s6HVMg//Z1vpOVfPGexT+l41R4BiEbrkDCVeBZnbDapafPEWSkvhzVK3ncQk6yUO
y7l7yTq0l1PHP6Qh8orKSY6xO/Ui6eLRHnpIXJMhSj0l8hfPEYeiRlc8MSzEWhMH
ame927kd5iiRpnjhVpRVhthE/gwH8diAIvay/Rx9PULbdsQvF8YsWAPff3+AFtVB
mBz41wbhUOjDOhIW96UmbH8dwkfse0fNv5sYCuLvS1NtkvUIScL6TYHwTazMDYz0
npHZJ8XNjGttSj7QCuSGoC7chz4GB3LKTcvYWIvL9he9wxN/CQX4BAFGqv0mx+nK
FyU9Pva3xbjf6S8f48LhsIa2hbkhhET9km3FLZGftAkYivkD+0wBPFRHo8DRBx4P
p9Lbo4mpG4QTPs1UV0bvglTGlBXW5YzZkuuuc0P2eMFAkpS4SVZXNfjPzKoSXqA7
/PWBHccFqXCo64zLeJ8Ls0zhWBfC86BRQquxy/HO+WgsWdDjYNTrjp05bZ+QKkr3
CjmyXxWDg2ANMnZB/o1Z1Q0B3t2LOou3diBKCp9ez3Cr1oKnarzM1jOZXS8ahnof
ujUahheBul/NG2JO05EOV6BOabip6CrXH2B/NbfqjmYZM24kTJ+n6hBRcx07/6HJ
9ARHNqLTLCFSGnbml4wZ68W8+bNiCXuB2BYKniHguyk+zpu5YMw=
=sTJr
-----END PGP SIGNATURE-----

--028f56741d52f91b0bec672921ccea60e74b58ce9c1c05854f65f7d060c2--

