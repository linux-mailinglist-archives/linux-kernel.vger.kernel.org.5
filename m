Return-Path: <linux-kernel+bounces-14982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B668225A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B72128490E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1817980;
	Tue,  2 Jan 2024 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlc7N+gl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081917983;
	Tue,  2 Jan 2024 23:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321D9C433C7;
	Tue,  2 Jan 2024 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704239025;
	bh=kFQS2kcs4vWIF3FcpigacK/LpoIANw0VqrfugrwbvfM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Zlc7N+glWzOFFU31jvFmrC9RDWIh1jQswxJj88FgTnyfSZe7TuGcaoTerGI2XPa6v
	 Y1EdJRGb8zEHfR0Vpd1xxifwxJZpuzR94mfz+52eOCVojupd5rvpfQBww5fQzQ5gd/
	 zFfP6sFlfbVaafqVqODyimPetZpF26+l5/BPLqbahIBGENWgkr/5ZMPyOOY9k2PeqS
	 Sd/U+hhO5kv1EBGmKeqOJISHg1uBtC9tubHWRgZTuGC3tkIZpLOzghrMcBa+x/IAhf
	 yhh7v5WeHyV4zoUhdEbJ0I0LhXoLqw+sJnJ+xFDMXJu9GOyRdGQFnRDBbU0jqQ9YnR
	 B4v/wJNbEmX7g==
Message-ID: <fa1ff48adc4db82b7483535990620ee9.sboyd@kernel.org>
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
Date: Tue, 02 Jan 2024 15:43:43 -0800
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
>=20

Ok, please send another round then. I was away from my computer for a
week or two.

