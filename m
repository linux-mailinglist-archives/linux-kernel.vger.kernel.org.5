Return-Path: <linux-kernel+bounces-126899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F45894429
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA5D1C216AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14124CB35;
	Mon,  1 Apr 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="TAqmqURq"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C82BA3F;
	Mon,  1 Apr 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991984; cv=none; b=qK0mxDr52kIQgHIhd8jUYltLmwEGq+BoQoUyNPHnBJchdFwJf/qnzoU48TzuRmhPNT1WtUf+Lak8FbAJIcOpy+/rXTQIxgmRixcrm0qU5m/vST2zPENfOPDRc3d5DQlC5XN9uLzV3NnR2KvBw6PBEbqfgag7wsI1O5BwPas2HrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991984; c=relaxed/simple;
	bh=0nsGe2Ub4lpBuotazO/vhKf3p/hWT6uQuP5ChZjO+OA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+yiHOlVxX4a8vbBvHJIuBa7qmj6rvX+gy5vBiEDj6rn2FVxFLFIi/+zg+Dm+CPI1o1bauD+KLMFT6EP26v5QZhH609U0RVx7X677QJpPGO8kD+KAOv01BTgA0QYDUnFIvEl9TBGMFlNJszabyN+q1WSBppDqf7nzCDWhhkwOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=TAqmqURq; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 15BF1100007;
	Mon,  1 Apr 2024 20:19:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 15BF1100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711991974;
	bh=qgJttL0sqx5Y2EBpQH+iH8vcd04Yw7u5T84Z9XbPqFM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=TAqmqURqvD7ow4Z0XUa8pCQZuD55vH3SxZhO7JbiUeAJDYeaZudXp7hgZjOilOAsu
	 eS/Z9RMCjXTPsw+JjJDDA9l2FuA/CtGf9zd552Xck00yMugZXW9u1XkHiHJ0VtvzZA
	 92cpKqdqxRauvfYktX08lKGt7z8Gm47j4X1QwOexOjafnUKrsJlpXYlRxtoUT7zqOR
	 unsZKHNA7fQvoyIO7nci19Qw8zyANIcrZ8NcS+s2jNkF4ei/kwVTHQfKnKjhSPIGQG
	 W+1F2ObmO5ZznEWO4ev8YdB+ZHcbdyNCtBVdJkYcYisiA2xiM0eoacGTJ6CYLE5ERM
	 MdTZYgIw9cC5Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Apr 2024 20:19:33 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 1 Apr
 2024 20:19:33 +0300
Date: Mon, 1 Apr 2024 20:19:33 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Rob Herring <robh@kernel.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <kernel@salutedevices.com>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 3/6] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll_div16 input
Message-ID: <20240401171933.bqmjsuanqsjvjosn@CAB-WSD-L081021>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-4-ddrokosov@salutedevices.com>
 <20240401142136.GA559114-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401142136.GA559114-robh@kernel.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184515 [Apr 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/01 15:13:00 #24563578
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Rob,

Thank you for the quick review.

On Mon, Apr 01, 2024 at 09:21:36AM -0500, Rob Herring wrote:
> On Fri, Mar 29, 2024 at 11:58:43PM +0300, Dmitry Rokosov wrote:
> > The 'sys_pll_div16' input clock is used as one of the sources for the
> > GEN clock.
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml          | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> > index 6d84cee1bd75..f6668991ff1f 100644
> > --- a/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-peripherals-clkc.yaml
> > @@ -29,6 +29,7 @@ properties:
> >        - description: input fixed pll div5
> >        - description: input fixed pll div7
> >        - description: input hifi pll
> > +      - description: input sys pll div16
> >        - description: input oscillator (usually at 24MHz)
> >  
> >    clock-names:
> > @@ -38,6 +39,7 @@ properties:
> >        - const: fclk_div5
> >        - const: fclk_div7
> >        - const: hifi_pll
> > +      - const: sys_pll_div16
> >        - const: xtal
> 
> And adding an entry in the middle is also an ABI break. New entries go 
> on the end (and should be optional).

The clock source sys_pll_div16, being one of the GEN clock parents,
plays a crucial role and cannot be tagged as "optional". Unfortunately,
it was not implemented earlier due to the cpu clock ctrl driver's
pending status on the TODO list.

I would greatly appreciate your advice on the best and simplest way to
resolve this matter in an effective manner..

-- 
Thank you,
Dmitry

