Return-Path: <linux-kernel+bounces-137884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2B589E8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD251B2452B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3110A2E;
	Wed, 10 Apr 2024 04:32:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA910A13;
	Wed, 10 Apr 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723530; cv=none; b=C69BhU2xs5oc6283MPzZnmt/e5fZ+KhbBhneyD/lFrZMfs+pYNdQl7fwSVVmKIu9aFOwBiOLG6FCA8wsDhyHc29UItg7LOQPZ2G8FoyZloxrnc6Ne8ZJpWr4YxqAmMdqQc6GiTnxdG9cjarwSB90m78TaXJcU95buaO9q+KtLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723530; c=relaxed/simple;
	bh=siZOQ+4XPskfy2znOMEDWoSkPbfewpmOGbasV0ucBXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyRdRuEqSzFgfm0jicmlBDlq6o01vywuQ6BkKPHk4Gc0/0HWRVX+MGhOKcsiz491jXqFdSfLEJhUTJGEbpKJn/cEpYfyQltsrW0NJOCVv3ww0eWLGz68n1ol7kbZefhL8qynaV4GdpetGNqNnO88C/xR5g4PR1HcGX9ljUmgLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruPcr-0007Sx-9l; Wed, 10 Apr 2024 06:31:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 liujianfeng1994@gmail.com, robh@kernel.org, sfr@canb.auug.org.au
Subject:
 Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from
 vcc3v3_pcie2x1l0 on rock-5b
Date: Wed, 10 Apr 2024 06:31:48 +0200
Message-ID: <3879529.iIbC2pHGDl@phil>
In-Reply-To: <20240403075916.1025550-1-liujianfeng1994@gmail.com>
References:
 <2535182.Sgy9Pd6rRy@diego>
 <20240403075916.1025550-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 3. April 2024, 09:59:16 CEST schrieb Jianfeng Liu:
> Hi Heiko,
>=20
> Tue, 02 Apr 2024 12:39:17 +0200, Heiko St=FCbner wrote:
> >Does the pcie driver enable the regulator too late somehow?
> The pcie driver will enable the regulator imediately when it is probed.
> I added log at when driver is probed and when regulator is enabled.
> Here is the log with "startup-delay-us =3D <50000>":
> ```
> [    1.572991] rockchip-dw-pcie a40800000.pcie: rockchip_pcie_probe start
> [    1.573697] rockchip-dw-pcie a40800000.pcie: going to enable vpcie3v3 =
regulator
> [    1.575194] rockchip-dw-pcie a40800000.pcie: enable vpcie3v3 regulator=
 done
> ```
>=20
> And here is the log without "startup-delay-us":
> ```
> [    1.518490] rockchip-dw-pcie a40800000.pcie: rockchip_pcie_probe start
> [    1.518603] rockchip-dw-pcie a40800000.pcie: going to enable vpcie3v3 =
regulator
> [    1.518610] rockchip-dw-pcie a40800000.pcie: enable vpcie3v3 regulator=
 done
> ```
>=20
> We can see startup-delay-us will delay the driver probe.
>=20
> I also take a look at rockchip's SDK kernel, their pci driver is probed
> very late:
> ```
> [    3.398682] dw-pcie fe170000.pcie: invalid resource
> [    3.398686] dw-pcie fe170000.pcie: Failed to initialize host
> [    3.398688] dw-pcie: probe of fe170000.pcie failed with error -22
> [    3.399396] rk-pcie fe170000.pcie: invalid prsnt-gpios property in node
> [    3.399410] rk-pcie fe170000.pcie: Looking up vpcie3v3-supply from dev=
ice tree
> [    3.405195] rk-pcie fe170000.pcie: host bridge /pcie@fe170000 ranges:
> [    3.405253] rk-pcie fe170000.pcie:       IO 0x00f2100000..0x00f21fffff=
 -> 0x00f2100000
> [    3.405283] rk-pcie fe170000.pcie:      MEM 0x00f2200000..0x00f2ffffff=
 -> 0x00f2200000
> [    3.405310] rk-pcie fe170000.pcie:      MEM 0x0980000000..0x09bfffffff=
 -> 0x0980000000
> [    3.405372] rk-pcie fe170000.pcie: iATU unroll: enabled
> [    3.405381] rk-pcie fe170000.pcie: iATU regions: 8 ob, 8 ib, align 64K=
, limit 8G
> [    3.666917] rk-pcie fe170000.pcie: PCIe Link up, LTSSM is 0x30011
> [    3.666932] rk-pcie fe170000.pcie: PCIe Gen.1 x1 link up
> [    3.667139] rk-pcie fe170000.pcie: PCI host bridge to bus 0002:20
> ```
>=20
> And it is reported that startup-delay-us is necessary in rockchip's SDK
> kernel. But in mainline kernel it is different.

that's not directly what I meant.

I.e. if the behaviour changes with arbitary delay changes, it points
very much to some sort of timing issue in the pcie driver itself.

That's why I asked about the regulator turning on, because if the enable
call returns 50ms earlier or later should never influence the behaviour
of the driver.

=46or example other threads could also just hinder the kernel from
continuing the pcie probe even after the regulator is on - again
leading to undefined behaviour, as you seem to be experiencing as
described in your mail from yesterday.



