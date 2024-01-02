Return-Path: <linux-kernel+bounces-14984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166C8225AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7F81F23193
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265C17982;
	Tue,  2 Jan 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP8lB1/k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AF17985;
	Tue,  2 Jan 2024 23:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61034C433C8;
	Tue,  2 Jan 2024 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704239232;
	bh=CZ2SLviVIOPK+w/RCmlYzrNM6ShsUO9iGFjmEfntgB0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FP8lB1/kk6nY0Zr06Xne+pu4Q10+zqNFW7PN9ts5upxtbHxZpmExa3uDU4gsAXVJi
	 2gEgFVvquWlyL8SF2znEwyCuXWP28zgv7TceWoxRDiwRz1jr0RR1GMlbBYtC2zCI7C
	 kYDyYA8Mgt0Drve6TyA2wLWel6hL2DjsD407tRdBOPloDGCaSBVl1coKRUzr+VPlvL
	 7EyTKnOgswXDWBfJjEZTsNmrRVRzwVyVWQdGZKPmpOYtmWVetAkFmEUaoJin57E+5d
	 hVNNZCF/RwZ+njrDa7TFUfGG7/8D7F3BphXb3i/W6Ijopxd8cNN+IoZq9BTkhNUsYL
	 kr1pRPVMNtjGA==
Message-ID: <24c6c928b1714490360f534fe30c55df.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CXZ9C7Y8QT0D.38ZNTXUY0HWUW@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com> <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com> <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org> <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com> <CXZ9C7Y8QT0D.38ZNTXUY0HWUW@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 02 Jan 2024 15:47:10 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2023-12-27 08:30:20)
>=20
> I went ahead with a V2, feeling it would be more productive to come up
> with something and gather comments on concrete stuff. There were many
> other things to address anyway.
>=20
> I've addressed this point by declaring a dummy fixed-clock in the
> devicetree that gets fed to the GIC timer. It is pretty much the same
> thing as using `clock-frequency` which this specific clocksource uses
> if `of_clk_get(node, 0)` fails. With the sent approach we have the
> timer appear in the clock tree as a consumer.

If the frequency is fixed then this seems fine to do always.

