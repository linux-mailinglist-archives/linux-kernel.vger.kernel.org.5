Return-Path: <linux-kernel+bounces-168499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6F8BB94E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7999F1C229B0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA8FBF0;
	Sat,  4 May 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSuvkY0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5F80B;
	Sat,  4 May 2024 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714790078; cv=none; b=XkoLt+SZDvYtF/SiOQTeGs7kgsur6zDvqsYXufy8PjLiMogHT5AVzSNMfQ3GXBhcnoLZcCMu4eLY4nCn9aUy1TJR0zsO8EyOfs4wiLtfJMSYJOBg3GFQ1fG1sIO2k8KKMYfYStjuNUU589uc4WCb+wb5dEEnO1WEovKWrauit6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714790078; c=relaxed/simple;
	bh=yVXtEN60WPDs64dv0Sh0OrP9dwoVq7s070uOhEnMXTI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EBWN5d5Gjq7FJu7VCtGjmskKj5SHSPJAHo2JMkzfSVgQkMCwX6hzAikQG2qP1nK/s6ITafa6CoFXYCnSXm192sL3/7PIxSq4WoiJj5ZP+y4NeUtfA5PGtcKHp9OM6E+HtbqInmfuqAriSETTb+7Wd78wv0/P2gY8jOFJIoelv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSuvkY0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729ECC116B1;
	Sat,  4 May 2024 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714790077;
	bh=yVXtEN60WPDs64dv0Sh0OrP9dwoVq7s070uOhEnMXTI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CSuvkY0STqC1kOsfeQtFTBRAqnzH39UXnwMdiVfjFg8MPe6tAXdsHGdLC2aw9L9Yr
	 Lbi7jZ7BC+ZdIHdpTCM0butQqpvIVTJbtokAAXtOgUEnazbsMf/bJ481YB+eK0kc+u
	 Q+PN9K2u2word9wovED4Vu8bfqYigtkn3r5j9TGxjCQKMqsyVZgX69jgwOmdctC0/F
	 qn61F6ElPnVIyIGMzdFtVMOjPjZLHsByndJl4apRR791VCDfgovWNycWnWhEPM2tyl
	 gCu+RtFaqmV23gPo3N5PPEBTt7s+7cWoGGRZ7iAl1/Sk0Rs3O9YTHwZ+aTh0jfpo5h
	 z6IsnyR27zhdA==
Message-ID: <8dcdb1422cd144128c1dc6fff1c273d3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
Subject: Re: [PATCH v2 00/11] Add Mobileye EyeQ system controller support (clk, reset, pinctrl)
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rafael J. Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Fri, 03 May 2024 19:34:35 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-05-03 07:20:45)
> Hello,
>=20
> This builds on previous EyeQ5 system-controller revisions[0], supporting
> EyeQ5, EyeQ6L and EyeQ6H. We expose a few OLB system-controller
> features here:
>  - Clocks: some read-only PLLs derived from main crystal and some
>    divider clocks based on PLLs.
>  - Resets.
>  - Pin controller, only on EyeQ5 (rest will use generic pinctrl-single).
>=20
> EyeQ6H is special in that it has seven instances of this
> system-controller. Those are spread around and cannot be seen as a
> single device, hence are exposed as seven DT nodes and seven
> compatibles.
>=20
> This revision differs from previous in that it exposes all devices as a
> single DT node. Driver-wise, a MFD registers multiple cells for each
> device. Each driver is still in isolation from one another, each in
> their respective subsystem.

Why can't you use auxiliary device and driver APIs?

