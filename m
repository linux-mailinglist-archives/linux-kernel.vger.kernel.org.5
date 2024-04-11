Return-Path: <linux-kernel+bounces-139934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE788A0947
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C52D1C21CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6013E8AD;
	Thu, 11 Apr 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6BWzOsO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A013DDDE;
	Thu, 11 Apr 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819261; cv=none; b=i/FrRa1t4MFR69ojJJpbo2tYsvN0dvuGtlHTS6iHLBBAH/94I2T9GpVLuS861N9NROy85P8zdS5KIqu6kQ6ge3RcvsAVLsjToVbDdjcpniUWTyN+gO6zgrKkB3VWULSuq21J1Hx8S43TFGMUnqkSbcHldHchsLkfqsaBW9eC7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819261; c=relaxed/simple;
	bh=QZARi3xW5yvZjqHIn7c/E8XOF4a47lACIjQDQkKBaq0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rHNMbf1GtZUunVGyV3WWHuSkSHDWASPVK+/xFiB85oCROGpJ6aOSE/61jyW9ttGngd1g8mWjPCD1OIhFBzeITganR0TZBPiPDwsLcUl07KfZRnGRl9tXha040B6rkHaNBMQ9f7YyNEgTJMK7FZcF0fudgjGcEJe1wBBx1dXUv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6BWzOsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14E4C433F1;
	Thu, 11 Apr 2024 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819261;
	bh=QZARi3xW5yvZjqHIn7c/E8XOF4a47lACIjQDQkKBaq0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=V6BWzOsOV1BOaERfwEQn8jrZa7NmzzKij7Ug/j8s2QhXuV5zmf0PWhmsdzZLKiBjC
	 yGzEUNkS2oB54TRljHEwq/IT2Js8sHe4E9FWiZSWzu1TRwyNoz1liMgq5/Yu0adY4z
	 5Wr32Kc2i+H/UoyKxxhd9TNCoqjOzhzjgmW5iSf8eXttufTMZlMhsVC7S0OdZ1lKu0
	 7q4NunQM0JvDDp9IrTc3Y6Yz/iePBfle6YmBO08voU+nsA5jutM+2xEzoJAC9qm1v1
	 0qEl6nbZTznqYSdESx1HWbGagqp7kfuDJ9KgyXT9SgnFHgchazmgJEGtGzPqez4XZe
	 jsxJF5K0PlMOQ==
Message-ID: <1d7aaa45113a23ecd6798e68e2742d2c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB495357FB5EEA1623DAB08C94BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB495357FB5EEA1623DAB08C94BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v9 3/6] clk: sophgo: Add clock support for CV1810 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 00:07:38 -0700
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-03-09 01:02:53)
> Add clock definition and init code for CV1810 SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8=
df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx
> ---

Applied to clk-next

