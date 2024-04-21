Return-Path: <linux-kernel+bounces-152614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68208AC131
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2832CB20B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB343ADA;
	Sun, 21 Apr 2024 20:20:46 +0000 (UTC)
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C461BF20;
	Sun, 21 Apr 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730846; cv=none; b=nyl8F9ym+YFW8O0u39hDEt6pyhbyJoX2gWjp0RiDsLRta4e8wkaChTPNKeoTOvhthrZ/VCYRdkSZUInUPe/1KMUvpQhAxRFuKXIWLCoUwvU8laQPE1yfmT7XEt2wWTRPAtoNDq0lptfxtzwzLcDq6S9jFcVH6i1Ij29B4wLMsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730846; c=relaxed/simple;
	bh=7ulEOlS3JkhNXQTRzN6bH+s/Benk94+XyHnjn00QtVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orhREMwFudQkmRU58ZIhkyxsSc98xHtuozmFL0VK87eU9DypqbPga83QrZK3B6smg7YZwHiCDTS+ZkhPYfAZbzkXbDr8kO8eNNlansNjugGx3VqMjTDSHQlwXza5wsClOD9y7JODiHmru+5ULCbHMOPsjP3f0EZohvIMB2ylk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout12.t-online.de (Postfix) with SMTP id 2E71317285;
	Sun, 21 Apr 2024 22:15:06 +0200 (CEST)
Received: from delle.local ([77.47.123.226]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rydaZ-2KqNDU0; Sun, 21 Apr 2024 22:15:03 +0200
Message-ID: <1422c0bcf359a0dcbe09c8954aa4c723511463d0.camel@t-online.de>
Subject: Re: [PATCH v2 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC
 Clock
From: Alois Fertl <A.Fertl@t-online.de>
To: Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com, wens@csie.org, samuel@sholland.org, 
	linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Sun, 21 Apr 2024 22:14:55 +0200
In-Reply-To: <6035510.lOV4Wx5bFT@jernej-laptop>
References: <20240421183633.117326-1-a.fertl@t-online.de>
	 <6035510.lOV4Wx5bFT@jernej-laptop>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1713730503-1FFFCD4A-8CF207E9/0/0 CLEAN NORMAL
X-TOI-MSGID: 428dd07f-58e2-4c9b-a4dc-ecb5c5a5ae97

On Sun, 2024-04-21 at 21:57 +0200, Jernej =A6krabec wrote:
> Dne nedelja, 21. april 2024 ob 20:36:33 GMT +2 je Alois Fertl
> napisal(a):
> > I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618
> > SOC.
> > On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
> > operate correctly. Without this change the clock from the SOC is
> > ~29kHz and BT module does not start up. The patch enables the
> > Internal
> > OSC Clock Auto Calibration of the H616/H618 which than provides the
> > necessary 32kHz and the BT module initializes successfully.
> > Add a flag and set it for H6 AND H616. The H618 is the same as H616
> > regarding rtc.
> >=20
> > v1->v2
> > - add flag and activate for H6 AND H616
>=20
> Please move changelog below --- line.
Thanks for reviewing, will move the changelog
>=20
> >=20
> > Signed-off-by: Alois Fertl <a.fertl@t-online.de>
> > ---
> > =A0drivers/rtc/rtc-sun6i.c | 16 +++++++++++++++-
> > =A01 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> > index e0b85a0d5645..5d0c917b2099 100644
> > --- a/drivers/rtc/rtc-sun6i.c
> > +++ b/drivers/rtc/rtc-sun6i.c
> > @@ -42,6 +42,11 @@
> > =A0
> > =A0#define SUN6I_LOSC_CLK_PRESCAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A00x0008
> > =A0
> > +#define SUN6I_LOSC_CLK_AUTO_CAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000c
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_16MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0B=
IT(2)
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_EANABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0BIT(1)
>=20
> EANABLE -> ENABLE
yes sure
>=20
> > +#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0BIT(0)
> > +
> > =A0/* RTC */
> > =A0#define SUN6I_RTC_YMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0010
> > =A0#define SUN6I_RTC_HMS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0014
> > @@ -126,7 +131,6 @@
> > =A0 *=A0=A0=A0=A0 registers (R40, H6)
> > =A0 *=A0=A0 - SYS power domain controls (R40)
> > =A0 *=A0=A0 - DCXO controls (H6)
> > - *=A0=A0 - RC oscillator calibration (H6)
> > =A0 *
> > =A0 * These functions are not covered by this driver.
> > =A0 */
> > @@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
> > =A0=A0=A0=A0=A0=A0=A0=A0unsigned int has_losc_en : 1;
> > =A0=A0=A0=A0=A0=A0=A0=A0unsigned int has_auto_swt : 1;
> > =A0=A0=A0=A0=A0=A0=A0=A0unsigned int no_ext_losc : 1;
> > +=A0=A0=A0=A0=A0=A0=A0unsigned int has_auto_cal : 1;
> > =A0};
> > =A0
> > =A0#define RTC_LINEAR_DAY=A0BIT(0)
> > @@ -268,6 +273,13 @@ static void __init sun6i_rtc_clk_init(struct
> > device_node *node,
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0=A0=A0=A0=A0=A0=A0=A0writel(reg, rtc->base + SUN6I_LOSC_CTRL);
> > =A0
> > +=A0=A0=A0=A0=A0=A0=A0if (rtc->data->has_auto_cal) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Enable internal OSC cl=
ock auto calibration */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reg =3D (SUN6I_LOSC_CLK_A=
UTO_CAL_16MS |
> > SUN6I_LOSC_CLK_AUTO_CAL_EANABLE |
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL);
>=20
> Remove parenthesis and fix indentation. Since macro names are pretty
> long,
> maybe put one per line.
will do so
>=20
> Is this safe to be done even on the boards with external 32k crystal?
Can't tell for sure. I don't have a H6 board. But I would think that
it's even required because H6 has a feature to autoswitch clock source
if the external is detected to have failed.
>=20
> Best regards,
> Jernej
Thanks and regards,
Alois
>=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0writel(reg, rtc->base + S=
UN6I_LOSC_CLK_AUTO_CAL);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Yes, I know, this is ugly. */
> > =A0=A0=A0=A0=A0=A0=A0=A0sun6i_rtc =3D rtc;
> > =A0
> > @@ -380,6 +392,7 @@ static const struct sun6i_rtc_clk_data
> > sun50i_h6_rtc_data =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0.has_out_clk =3D 1,
> > =A0=A0=A0=A0=A0=A0=A0=A0.has_losc_en =3D 1,
> > =A0=A0=A0=A0=A0=A0=A0=A0.has_auto_swt =3D 1,
> > +=A0=A0=A0=A0=A0=A0=A0.has_auto_cal =3D 1,
> > =A0};
> > =A0
> > =A0static void __init sun50i_h6_rtc_clk_init(struct device_node
> > *node)
> > @@ -395,6 +408,7 @@ static const struct sun6i_rtc_clk_data
> > sun50i_h616_rtc_data =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0.has_prescaler =3D 1,
> > =A0=A0=A0=A0=A0=A0=A0=A0.has_out_clk =3D 1,
> > =A0=A0=A0=A0=A0=A0=A0=A0.no_ext_losc =3D 1,
> > +=A0=A0=A0=A0=A0=A0=A0.has_auto_cal =3D 1,
> > =A0};
> > =A0
> > =A0static void __init sun50i_h616_rtc_clk_init(struct device_node
> > *node)
> >=20
>=20
>=20
>=20
>=20


