Return-Path: <linux-kernel+bounces-6092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A864581948B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A4228828D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161E3D0D9;
	Tue, 19 Dec 2023 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnwWpwes"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF63DBA0;
	Tue, 19 Dec 2023 23:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155D6C433C7;
	Tue, 19 Dec 2023 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703028244;
	bh=GOWtq1QfVI0dp6mTGEex1rpFS5MGDjW4D97ACoEHImI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XnwWpwesKQKXKXzGQc9w0LCULCyVI5yIPmxX7EGVeA+qg9eEORBSdEBD+ORzXfVpX
	 58O85L5Vih+OboC5RUcGnIkJtoU3MKdayJHjMqbJGEEtOBcVyPgVbxX4IIFQMFjdiN
	 E53pmD2ZvKiq7tQ80rzffRHoAcGkEwxfR4MlXR/uNa5ytARZ2ILvdZuXtOId6HbtcZ
	 OX9zkT0sqgf7PCKXePVa2wk+bGdeNVq3kn4oBK5Z81Xkrjlb8vnqKDR7Err3fb7wlB
	 DnVMtwOm5zjge0qfLNjDv7LN6G3lvmIut/JRo3aCE4iyZx42HOLTxhNKf8tpNvwice
	 UrK6YaOrgOiuQ==
Message-ID: <498958059fbabbdcbcac62b979b8451d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231218-mbly-clk-v1-1-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com> <20231218-mbly-clk-v1-1-44ce54108f06@bootlin.com>
Subject: Re: [PATCH 1/5] clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_hw
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 19 Dec 2023 15:24:01 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:16)
> Add missing comma and remove extraneous NULL argument. The macro is
> currently used by no one which explains why the typo slipped by.
>=20
> Fixes: 2d34f09e79c9 ("clk: fixed-rate: Add support for specifying parents=
 via DT/pointers")
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

