Return-Path: <linux-kernel+bounces-25838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CAC82D68A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07661C216F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875AF4E9;
	Mon, 15 Jan 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="e+bmhS0s"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD92BAE4;
	Mon, 15 Jan 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1705312752; x=1736848752;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uQts1tBeQahw7yIJZ2JO2t05z0jjvt6OA35IEEr1+kY=;
  b=e+bmhS0s6VxiK7NjZt88vwXGDPjAhRse+KqIJmUJoa30wZ40UYNCubca
   8/q/xQ0GOp1j1plGtKf5AEqLOtGsTUQGvY4yVJnOhaOXCOoTyhKx5r0gN
   qZZwd5ReO1MhfRJvqcp74uP9f6gnhNRe7bcr/VxLhqM2d0rdzVdTWC4RV
   Kcmy3lvRbBVIwfGydIHTSgh3K06Vkhn02oASl7/eU26bGiEp/pD3R3s3F
   /bWisa7zK7YPw72Mf/YUhc3pT6vqZCI1e2t6fifl3j/y4Yd3qqppGSdFx
   IC7K8P8cHVSk000llLWO/g+04+rq+yC1ZdnQlv+tCKdTwaDiuMC8koP7+
   w==;
X-IronPort-AV: E=Sophos;i="6.04,196,1695679200"; 
   d="scan'208";a="34892366"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Jan 2024 10:59:03 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 148E9280075;
	Mon, 15 Jan 2024 10:59:03 +0100 (CET)
Message-ID: <e16cf4bc7e0bbd04f993c685095ab7f1728d5d0f.camel@ew.tq-group.com>
Subject: Re: [PATCH 05/16] arm64: dts: ti: k3-am64: Add MIT license along
 with GPL-2.0
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Pierre Gondois <pierre.gondois@arm.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Wadim
 Egorov <w.egorov@phytec.de>,  linux@ew.tq-group.com
Date: Mon, 15 Jan 2024 10:59:02 +0100
In-Reply-To: <20240110140903.4090946-6-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
	 <20240110140903.4090946-6-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 08:08 -0600, Nishanth Menon wrote:
>=20
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>=20
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>=20
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).


Acked-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

