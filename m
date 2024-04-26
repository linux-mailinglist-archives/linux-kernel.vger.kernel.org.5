Return-Path: <linux-kernel+bounces-159633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B615D8B315B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72505285166
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEBE13C3E1;
	Fri, 26 Apr 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="VZNS7CzH"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295913BC2B;
	Fri, 26 Apr 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116681; cv=none; b=if1D0EF0SAq3Ow8CINIO7iuRFuA+o2jRScUr69X9wKzUYjO4nYcR2dWrJNJ8Dkmd68KCMB0rxSSWt6xcCTqfH3hqc7GVsjE8H4l6R3PM+nCPDnYr0fvAMmMfZ0noyxQ5+9F/EG16WzbpAa5ueyZvGf6fKpb6JOFHKZbLgsv9NBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116681; c=relaxed/simple;
	bh=bu5G/FK54u1pJ/J+TA5ReeZ6pPyfUo9bcJmqrR9GqrU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSTeELJ0TXfWvcIEkTMC+1BtnWE/HFUnTg3trV0g2LgpNOvygCzK6tAQw4zxq77EhAZJWg3jKuIQQZhNvxGehAi/DNctTEW1IXz4CmUk33RTqSuffx6Pomyx3SeHd3oy5jin70qL0IFE26FyfoKuT+7//GQSeY/aoYPmiAL1D/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=VZNS7CzH; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6A933100003;
	Fri, 26 Apr 2024 10:31:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6A933100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714116667;
	bh=1oOjBRwahzipflI9HVMGrMYwyUxQIzND3/Gm6BB3fCE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=VZNS7CzH0eVFZrgEc/d7px8hOqwLpYdDOuDyBpOsR0Ps9I+KgQGbqColp8rLO1rI8
	 BDrTaXF7mVomrXocSLkhnAWJtvCe2+aN4J/ToGC+nGQiWn2pbQQsFUBXZWlW9ufdYx
	 zQhqSPDpuTgmyixpLHfcikym+cYsjWl+Xwa7zeKaStj9Tfy/FjXbBATI8Zrll2002r
	 HsDDMt1lz0P64YymnTbVhDpYW4Wm0BiJXBYtPRJWwi0FkBHDlAGqTaxicXNZPq0/WH
	 Lk1+p5dWeEzxZ4mTwU3XYt4n2LHk+njJ8AeJF1JefqhAPtB29xpLrhVzRxaSE07Zjh
	 Pe6PQpvnIv3Ag==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Apr 2024 10:31:07 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Apr
 2024 10:31:07 +0300
Date: Fri, 26 Apr 2024 10:31:06 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, <neil.armstrong@linaro.org>
CC: <jbrunet@baylibre.com>, <mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] thermal: amlogic: introduce A1 SoC family Thermal
 Sensor controller
Message-ID: <20240426073106.3yl2dplvauper3lg@CAB-WSD-L081021>
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
 <38ba3618-2a67-4e21-b08d-7e382411e51a@linaro.org>
 <20240417084007.uzg2uc7gwb6mi7bi@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417084007.uzg2uc7gwb6mi7bi@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184944 [Apr 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/26 01:49:00 #24972266
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Neil,

I hope you're doing well. I was wondering if you could assist me with
below problem.

I'm a bit confused about which kernel repository the series was applied
to. I asked Daniel about it, but unfortunately, I didn't receive any
feedback from him. Could you provide some clarification on this matter?

Thank you in advance for your help.

On Wed, Apr 17, 2024 at 11:40:07AM +0300, Dmitry Rokosov wrote:
> Hello Daniel,
> 
> Could you please let me know in which repository you have applied this
> change? I am trying to cherry-pick the original applied commit and apply
> it to our internal mainline branch instead of the internal commit.
> However, I am unable to find the applied series in any of the
> repositories on git.kernel.org.
> 
> On Thu, Apr 04, 2024 at 02:23:21PM +0200, Daniel Lezcano wrote:
> > On 28/03/2024 20:13, Dmitry Rokosov wrote:
> > > It is primarily based on the G12A thermal controller, with only a slight
> > > variation in the offset value of the efuse parameters. Therefore, this
> > > patch series provides appropriate platform data and dt-bindings to
> > > ensure proper support.
> > 
> > 
> > Applied, thanks
> 

-- 
Thank you,
Dmitry

