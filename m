Return-Path: <linux-kernel+bounces-128213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D928957A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF22285DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591312CD8A;
	Tue,  2 Apr 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="FO0HCuQ5"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0C12BF3D;
	Tue,  2 Apr 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070035; cv=none; b=Lj22XAsmDOPpFVoWR9GgkWpYorrj4u8MN8lsU43kaTWazSYRlC9btsdauCybJ5Rpc1Atfytx6Y85OKFPTsyrKNkgd4LgdRZC6YIw0x6LJuAtogS29ZfLZ+evUZb4yBqcMzmu6IQxlz7Oin2tvgUuzvc60KZsw4llVXReU/HmkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070035; c=relaxed/simple;
	bh=cmom1ErdcUheZ0CJPk2iD8ce4Uaoh5OwhA8EpMDVFnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmLNCPPICW6Z7q70ywY+IDHoMjTDpLO5N56LLUwUJ0DZ2INrNekzzWsFznX9rx2rmyjm9RyhFjf0Oc5Vm6SWTjv5XXJueEDqMpZTbjBIwp9LxWia51WQg9ln56b2lW5j1L9vNIMYz0aCf2ebOTUZ4Uzoqw9iOgcZ+KgdejXmJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=FO0HCuQ5; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 086F4100008;
	Tue,  2 Apr 2024 18:00:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 086F4100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712070028;
	bh=jBFRAbcdr1AzYHPitiXnnWqvqH1LyjSLBccDvymWK8M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=FO0HCuQ5B87ozq5xGqK+E/OxZ2gprNssoVQXHSsQntdL8Qqs76BCagZJ/BdESmU9R
	 Pvha/UmvKLm5sAlxvcL3kU7yd+BEJPFw8/1wIukohJUFHSBEziZJZecS6TdBaFf3AM
	 PZWc8kjOuYh39ahOBmkZ8dIjDknhH8hfiprTRv7jxfBoC9bpUMhELIu0Cu7TYgkgtA
	 U6ThHfcnl5mDKydujNUmd43bxpijwSs9ZWJnDx/+TtOyoeddWdYPGG3kXYsAbiP01Y
	 19pLZ2MpuYiBb0D6RftliEMOvSGQQqqyjDUSBAlDnXow3RjS8Gw0y+y/tK9zkQPUlf
	 NaBxbpB802neA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 18:00:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Apr
 2024 18:00:27 +0300
Date: Tue, 2 Apr 2024 18:00:27 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/6] clk: meson: a1: pll: support 'syspll'
 general-purpose PLL for CPU clock
Message-ID: <20240402150027.fptfvov74zwed6vb@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-3-ddrokosov@salutedevices.com>
 <1j4jckjftk.fsf@starbuckisacylon.baylibre.com>
 <20240402121546.qrrc7r5un75464pb@CAB-WSD-L081021>
 <1jmsqbj0md.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jmsqbj0md.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184537 [Apr 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/02 07:07:00 #24571916
X-KSMG-AntiVirus-Status: Clean, skipped

On Tue, Apr 02, 2024 at 04:27:17PM +0200, Jerome Brunet wrote:
> 
> On Tue 02 Apr 2024 at 15:15, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > On Tue, Apr 02, 2024 at 11:00:42AM +0200, Jerome Brunet wrote:
> >> 
> >> On Fri 29 Mar 2024 at 23:58, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> >> 
> >> > The 'syspll' PLL, also known as the system PLL, is a general and
> >> > essential PLL responsible for generating the CPU clock frequency.
> >> > With its wide-ranging capabilities, it is designed to accommodate
> >> > frequencies within the range of 768MHz to 1536MHz.
> >> >
> >> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >> > ---
> >> >  drivers/clk/meson/a1-pll.c | 78 ++++++++++++++++++++++++++++++++++++++
> >> >  drivers/clk/meson/a1-pll.h |  6 +++
> >> >  2 files changed, 84 insertions(+)
> >> >
> >> > diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> >> > index 60b2e53e7e51..02fd2d325cc6 100644
> >> > --- a/drivers/clk/meson/a1-pll.c
> >> > +++ b/drivers/clk/meson/a1-pll.c
> >> > @@ -138,6 +138,81 @@ static struct clk_regmap hifi_pll = {
> >> >  	},
> >> >  };
> >> >  
> >> > +static const struct pll_mult_range sys_pll_mult_range = {
> >> > +	.min = 32,
> >> > +	.max = 64,
> >> > +};
> >> > +
> >> > +/*
> >> > + * We assume that the sys_pll_clk has already been set up by the low-level
> >> > + * bootloaders as the main CPU PLL source. Therefore, it is not necessary to
> >> > + * run the initialization sequence.
> >> > + */
> >> 
> >> I see no reason to make such assumption.
> >> This clock is no read-only, it apparently is able to re-lock so assuming
> >> anything from the bootloader is just asking from trouble
> >> 
> >
> > Indeed, I have implemented the following initialization sequence. I have
> > dumped the bootloader setup and included it in the definition of my
> > sys_pll. However, I have encountered an issue with the enable bit. If I
> > leave the enable bit switched on by default, there is a possibility that
> > the bootloader selects a fixed CPU clock while the sys_pll should be
> > switched off. On the other hand, if I keep the enable bit switched off
> > by default, the bootloader might configure the CPU clock to use sys_pll,
> > resulting in the execution halting when the initialization sequence is
> > run. This situation has led me to assume that we should place our trust
> > in the bootloader setup.
> >
> > If you believe it is necessary to include the initialization sequence, I
> > can prepare it with the sys_pll enabled by default.
> 
> I just noted your initial comment is misleading.
> 
> You could submit a patch to apply the init sequence only if the PLL is
> not already enabled. Maybe even condition that to flag in the pll data
> to avoid applying it to the other platforms for now.
> 

Ah, I see. Okay, no problem, I will prepare such patch to common meson
clk-pll.

[...]

-- 
Thank you,
Dmitry

