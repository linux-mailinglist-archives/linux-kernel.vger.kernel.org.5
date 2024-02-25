Return-Path: <linux-kernel+bounces-80317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7B862D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB01C1F216B1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F351B970;
	Sun, 25 Feb 2024 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="DV33ijJt"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B81BC26;
	Sun, 25 Feb 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708897991; cv=none; b=BqwQjcdYmkBAM9ma2EAb38v/mG1mBiSYhbmorADlC+CdBypwfZkjntMr6Ka94Heh+wHzgUl1xIX8oDKxPfVx/ybryPxzvBQohYMxOKcMyjbRVZACKajiQO2FyITgZ8lB8gEXwv2Ii9PY+abuA+PCaBNjWP6P4TNnQJ3FE9MniaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708897991; c=relaxed/simple;
	bh=c7qVMzP3hjDjRYr9GI+qimmAMxJsHCBlkxOXyxRGfdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZzsa6vUykvfM+jk2x7WR/JPJwzX7iQ40apkgh51qBLuJzIqh/2Q2JRzgzv92HI17xRvW7yvf3TYmn8Wbw5NUMWLmNgaqdDyJJ0CfFtAOU1hVart2Us4eaDSjqPgIMtVvm0MBSHFiftis0iMe4uKb7ACNF9o3jC9qIQfvI84TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=DV33ijJt; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708897979; bh=c7qVMzP3hjDjRYr9GI+qimmAMxJsHCBlkxOXyxRGfdM=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=DV33ijJtLijd5NdSy6eThWEcxekzatlBDPxUL26zXZCKhZgfaJIVqGHORR06AUH60
	 02nH5El2hc/Rf1V5O1aVlFYmT2FNxcA9deWj3Cwdd29G2OtywSvtHSu28QaNzNh+Rz
	 FVn/I0O9GcuOo6ypcHwTUBuEQQIU7gejn+meqUdo=
Date: Sun, 25 Feb 2024 22:52:59 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
	Icenowy Zheng <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, 
	Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <mn2ewn33djqxmghin73l2exq426sws2ymqvajojctyywvosash@an7dzkftkqvc>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, 
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240222011341.3232645-1-megi@xff.cz>
 <20240222011341.3232645-4-megi@xff.cz>
 <20240225120700.2a0da3f6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225120700.2a0da3f6@jic23-huawei>

Hello Jonathan,

On Sun, Feb 25, 2024 at 12:07:00PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 02:13:37 +0100
> Ondřej Jirman <megi@xff.cz> wrote:
> 
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> > 
> > Add a simple IIO driver for it.
> > 
> > Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Check patch correct moaned that Icenowy is the author (from:)
> so doesn't need a co-developed.
> 
> > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> Hi.
> 
> A few really minor things noticed during a final review.
> I'll tweak them whilst applying.  Diff is

Thank you very much for finishing touches.

> > +static int af8133j_product_check(struct af8133j_data *data)
> > +{
> > +	struct device *dev = &data->client->dev;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = regmap_read(data->regmap, AF8133J_REG_PCODE, &val);
> > +	if (ret) {
> > +		dev_err(dev, "Error reading product code (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (val != AF8133J_REG_PCODE_VAL) {
> > +		dev_err(dev, "Invalid product code (0x%02x)\n", val);
> > +		return -EINVAL;
> 
> This should be warn only and we should carry on regardless.  The reason
> behind this is to support fallback compatible values in DT to potentially enable
> a newer device to be supported on an older kernel.
> 
> Many IIO drivers do this wrong as my understanding on what counted on
> 'compatible' used to be different.  Long discussions on this with the DT
> maintainers led me to accept that letting ID checks fail was fine, but
> that a message was appropriate.   Often a fail here actually means no device.
> We have some exceptions to this rule for devices where we know the same
> FW ids are in use in the wild for devices supported by different Linux
> drivers - but those are thankfully rare!

Makes sense. If newer device variant has the same register meanings, but just
a different ID register, this way it can be supported without driver
modifications. I'll keep it in mind when doing ID checks in other drivers.

Thanks for all your detailed notes during the review. I learned a few
new subtleties.

Kind regards,
	o.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> }
> 
> > +static const int af8133j_scales[][2] = {
> > +	[0] = { 0, 366210 }, // 12 gauss
> > +	[1] = { 0, 671386 }, // 22 gauss
> Trivial so I'll fix it up: IIO comments are /* */
> not C++ style (with exception of the SPDX stuff that needs to be).
> > +};
> 
> 
> 

