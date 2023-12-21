Return-Path: <linux-kernel+bounces-7852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF381AE42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EE3285B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B0B673;
	Thu, 21 Dec 2023 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTzpHbY0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E042B654;
	Thu, 21 Dec 2023 05:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5465BC433C7;
	Thu, 21 Dec 2023 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703134930;
	bh=zntg2Srs2s2c96faHqg2OXqoNhfSS5jKTqCwm/IUeKs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OTzpHbY065f7WY5n+aAc9rAgTRq09cwEnMU6bKWP0FDhxFLRW2UMo7i8sx5gKqZzf
	 OsrNJFlBJD+iBXI7A+n8TZDtr9D02FiRTSGjo81K3AxExQAHwgsSNBpVnD2aju7Sq9
	 P4uF9JNAbEhZYOYthQiWY7unydXBRs8g2S2p0Y51yqD6J/DI1s3gBtufJ5LA8PDnie
	 fp40kyyaDjCD0YsBpicFna3ZnrAmSzeThrGpFR3Nzup14CPKkVNhN+hPMKp74EulPr
	 jUBJ1bLGbDtrvZKU6foRT+wjLlOQATmKV0dINhEsgJpFpy8GUSl9s9oKN9j47IYCua
	 A4KXqu65/atNw==
Message-ID: <057db34aae21f78ca68ca0cc2930c97f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231215115914.11588-3-zhifeng.tang@unisoc.com>
References: <20231215115914.11588-1-zhifeng.tang@unisoc.com> <20231215115914.11588-3-zhifeng.tang@unisoc.com>
Subject: Re: [PATCH V3 2/3] clk: sprd: Add reset controller driver for ums512
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Zhifeng Tang <zhifeng.tang23@gmail.com>, Wenming Wu <wenming.wu@unisoc.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Orson Zhai <orsonzhai@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Zhifeng Tang <zhifeng.tang@unisoc.com>
Date: Wed, 20 Dec 2023 21:02:07 -0800
User-Agent: alot/0.10

Quoting Zhifeng Tang (2023-12-15 03:59:13)
> From: "zhifeng.tang" <zhifeng.tang@unisoc.com>
>=20
> Add reset controller driver for ums512,The reset register has
> the same base address as the gate register.

This looks largely self contained. Can you make this an auxiliary device
and put the driver into drivers/reset/? Then we can logically review it
by reset drivers and possibly find commonality across other reset
devices.

