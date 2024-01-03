Return-Path: <linux-kernel+bounces-15348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE5822A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A221C23165
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D718AE8;
	Wed,  3 Jan 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="frzsmtiG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD111862A;
	Wed,  3 Jan 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED34DFF80D;
	Wed,  3 Jan 2024 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704275318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3crjHipz8ylphfT8gV2CwmUqWOugPx5m7omm1xw0lg=;
	b=frzsmtiG+iVMwlK3ZpwWx53fjskDg+tcGRTPEFXmUA7Qy/NPq3F8RFjBgEdYCOhx/ba6Y/
	fr2AKxxZSIzUYUMLA3ZrSrk0X/PEDetpMhEM+KUCGKn9xdMAzLOwK8erDSnCOoa/NldO+F
	P4J1wtfYSDedjZnfAHOCQgsJlpR4M76nqkqtR/g7hrvQqQghwbp+xYN+tBETXoFFiSNktd
	DGjJsNEvzW/qw9WNGniuc4oIPbzolwi2MTBSI6aJcTeHOXDkT+t8gkzFkSfNIFFoOsnYrb
	UlfvkzKR3uPSEoPLIPiDVp3wuIiYNBgRbfPqDnPNRWZ6ZcwdSpBlRy2S9GCjRQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 10:48:37 +0100
Message-Id: <CY4Z6GEO8Z7F.2XPPJNC2X29IU@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh+dt@kernel.org>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>
X-Mailer: aerc 0.15.2
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com>
 <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
 <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org>
 <CXUTPV1ZOSID.323RSEP4BL2AT@bootlin.com>
 <CXZ9C7Y8QT0D.38ZNTXUY0HWUW@bootlin.com>
 <24c6c928b1714490360f534fe30c55df.sboyd@kernel.org>
In-Reply-To: <24c6c928b1714490360f534fe30c55df.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 3, 2024 at 12:43 AM CET, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2023-12-27 08:30:20)
> >
> > I went ahead with a V2, feeling it would be more productive to come up
> > with something and gather comments on concrete stuff. There were many
> > other things to address anyway.
> >
> > I've addressed this point by declaring a dummy fixed-clock in the
> > devicetree that gets fed to the GIC timer. It is pretty much the same
> > thing as using `clock-frequency` which this specific clocksource uses
> > if `of_clk_get(node, 0)` fails. With the sent approach we have the
> > timer appear in the clock tree as a consumer.
> >
>
> Ok, please send another round then. I was away from my computer for a
> week or two.

No worries, hope you had a nice time.

On Wed Jan 3, 2024 at 12:47 AM CET, Stephen Boyd wrote:
> If the frequency is fixed then this seems fine to do always.

It is the case. Can you confirm that the taken approach is fine for you?
One issue I see with my V2 is that I still expose the timer clk from
the clk driver, even though it is not consumed by anyone and it is
exposed as a fixed-rate from a devicetree node. That makes a duplicate.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

