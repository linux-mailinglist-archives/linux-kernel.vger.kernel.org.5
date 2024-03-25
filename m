Return-Path: <linux-kernel+bounces-117285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A388A99B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E2B2E5944
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C454FB5;
	Mon, 25 Mar 2024 14:46:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EB3FB09;
	Mon, 25 Mar 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377963; cv=none; b=JI4c9TywDx48ySgDqAdDNv8/z8FsOVN8Lc4Uu4I99lW1wbiOta4ZQuodSC7niYevH0JwlyJfvMRsN3eaba5K06jcUfljr9smfF1hSRk4Qmu3viRMeiQ+zSo1xUrPYEZajbQZugQPRw81qAF/l5Dch9ABNilYNzVqGuIcLKkH1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377963; c=relaxed/simple;
	bh=mCTdO+HDMUf/fvJY1XT3NqXDR+XWD4WNc1uQhNVpl+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlNCkGGVuQJf2/s6j7zF96qd7zuZA8UYbfRFE+vScXs6E+aIqt9sB7ClrEK8uLfqQC/hZWXBTtchzz+SNhxQJtETAmpMa4WX/tUjRe4pt5c8/nTdqZJCqD/4RpCrHie/XsBl8RDmdbiX94O3EebD83O7ss6yZXxriO4lnFRk9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3G1d3lVxz6K6JX;
	Mon, 25 Mar 2024 22:45:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DF1D140B39;
	Mon, 25 Mar 2024 22:45:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 14:45:56 +0000
Date: Mon, 25 Mar 2024 14:45:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Primoz Fiser <primoz.fiser@norik.com>
CC: Andrej Picej <andrej.picej@norik.com>, Jonathan Cameron
	<jic23@kernel.org>, <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
	<lars@metafoo.de>, <krzysztof.kozlowski+dt@linaro.org>,
	<imx@lists.linux.dev>, <linux-iio@vger.kernel.org>, <festevam@gmail.com>,
	<s.hauer@pengutronix.de>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <haibo.chen@nxp.com>,
	<kernel@pengutronix.de>, <shawnguo@kernel.org>, <robh@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Upstream] [PATCH 0/2] i.MX93 ADC calibration settings
Message-ID: <20240325144555.00002d16@Huawei.com>
In-Reply-To: <44ac8977-cf98-46a5-be15-1bec330c6a2e@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
	<20240324135559.1640551d@jic23-huawei>
	<3423ea96-859d-4c4b-a9a7-e0d9c3c00727@norik.com>
	<44ac8977-cf98-46a5-be15-1bec330c6a2e@norik.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 09:55:23 +0100
Primoz Fiser <primoz.fiser@norik.com> wrote:

> Hi Jonathan,
>=20
> On 25. 03. 24 09:32, Andrej Picej wrote:
> > Hi Jonathan,
> >=20
> > On 24. 03. 24 14:55, Jonathan Cameron wrote: =20
> >> On Wed, 20 Mar 2024 11:04:04 +0100
> >> Andrej Picej <andrej.picej@norik.com> wrote:
> >> =20
> >>> Hi all,
> >>>
> >>> we had some problems with failing ADC calibration on the i.MX93 board=
s.
> >>> Changing default calibration settings fixed this. The board where this
> >>> patches are useful is not yet upstream but will be soon (hopefully). =
=20
> >>
> >> Tell us more.=A0 My initial instinct is that this shouldn't be board
> >> specific.
> >> What's the trade off we are making here?=A0 Time vs precision of
> >> calibration or
> >> something else?=A0 If these are set to a level by default that doesn't=
 work
> >> for our board, maybe we should just change them for all devices?
> >> =20
>=20
> The imx93_adc driver is quite new.
>=20
> If you look at line #162, you will find a comment by the original author:
>=20
> > 	/*
> > 	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> > 	 * can add the setting of these bit if need in future.
> > 	 */ =20
>=20
> URL:
> https://github.com/torvalds/linux/blob/master/drivers/iio/adc/imx93_adc.c=
#L162
>=20
> So, for most use-cases the default setting should work, but why not make
> them configurable?
>=20
> So this patch-series just implement what was missing from the beginning
> / was planned for later.
Hi Primoz,

I doubt anyone reviewed the comment closely enough to say if what it was
suggesting was sensible or not, so the fact it was listed as a todo
doesn't directly impact this discussion.

>=20
> BR,
> Primoz
>=20
>=20
> >=20
> > So we have two different boards with the same SoC. On one, the
> > calibration works with the default values, on the second one the
> > calibration fails, which makes the ADC unusable. What the ADC lines
> > measure differ between the boards though. But the implementation is
> > nothing out of the ordinary.
> >=20
> > We tried different things but the only thing that helped is to use
> > different calibration properties. We tried deferring the probe and
> > calibration until later boot and after boot, but it did not help.
> >=20
> > In the Reference Manual [1] (chapter 72.5.1) it is written:
> >  =20
> >> 4. Configure desired calibration settings (default values kept for
> >> highest accuracy maximum time). =20
> >=20
> > So your assumption is correct, longer calibration time (more averaging
> > samples) -> higher precision. The default values go for a high accuracy.
> > And since we use a NRSMPL (Number of Averaging Samples) of 32 instead of
> > default 512, we reduce the accuracy so the calibration values pass the
> > internal defined limits.

Ouch.  Let me try to dig into this. Is this effectively relaxing the
constraints? I guess because a value that is perhaps always biased one way
is considered within bounds if those acceptable bounds are wider because
of lower precision?

I was assuming it was the other way around and the device had fixed constra=
int
limits and you needed to take more samples due to higher noise. Seems the
opposite is true here and that worries me.

I'll definitely need input from NXP on this as a workaround and their
strong support to consider it.

> >=20
> > I'm not sure that changing default values is the right solution here. We
> > saw default values work with one of the boards. And since the NXP kept
> > these values adjustable I think there is a reason behind it.

I'd assume trade off between time and calibration precision, not the
sort of use I think you are describing.

> >=20
> > Note: When I say one of the boards I mean one board form. So same board
> > version, but different HW.

Superficially I'm struggling to not see this as broken hardware that it
is out of expected tolerances in some fashion.  Maybe I misunderstood
the issue.

Jonathan

> >=20
> > Best regards,
> > Andrej
> >=20
> > [1] i.MX 93 Applications Processor Reference Manual, Rev. 4, 12/2023
> > _______________________________________________
> > upstream mailing list
> > upstream@lists.phytec.de
> > http://lists.phytec.de/cgi-bin/mailman/listinfo/upstream =20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


