Return-Path: <linux-kernel+bounces-148159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDA8A7E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A151F2171B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DDB7EF1B;
	Wed, 17 Apr 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AdlsAK4A"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8E8529D;
	Wed, 17 Apr 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343222; cv=none; b=tyiTDS5sO6q96xCdvwSr5luetJQNxZ9+hzGjsbhZQjYJWdGJM5Kno3BPON4e9oPdnUAwRh5p9+qXPTQGfjASRc/G1XRYAGnzLPYgH5rD0RQ/61OF/4U1qRHpiCNUnhorItAQGZoYds+bccVO0Prsz1moCkKK+vcJwD81jKmONk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343222; c=relaxed/simple;
	bh=zEiPERZJKSDRCkJgHODqJT/l8hNbR0wSJNM5rQn2U9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmrWaa/woSrAimj+cJJYeLMifK21yD/JE018FlvXZ8ER4Tr5gAmnFie7CxctUnRV1936a9hITDQGQpFR/cqIcG6OZYF2b4oj2U9gnXa6jBNsQ2zo2SiXrMqCO3LFXKa/m+yAtG8QChjHDAOSiJ4YdIk/p5TwsGNqAQKyXDq/zwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AdlsAK4A; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 97559100004;
	Wed, 17 Apr 2024 11:40:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 97559100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713343208;
	bh=vzd5CRR2cDvfBR88K8Vu/kXje8h9WcD3OB/r8NxbU0A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=AdlsAK4Awszbn81O4XFpoLY26dLzLtGQfpXe0DiZTXrtT1pF7tYsME626ZVBohY0G
	 U0LM8iwzaisfPW2dWWQEhQI/RDLP0dQKgfrx/WzCVldyErmpvwn1MfE4AdagB7GcW5
	 RhYpnMKeYCvfxJYdmX08kO7XY2Kaodg1o3w/vUgbr0N1zcn3u9lDCr9Tzdh5d7G+yq
	 Ujo2uxes4/VAfYx/lKVXhorm76xRDkply7agqIcbF+Sotde1zv1qC6rmPyBGOMxts/
	 Tao5pwd/9g/mArcsHLoQl/dkiipqLl2FQ5p5Ltl6b08kgWvCqB/avWZJnUoEs8y8v3
	 CdG3cIHrBsHKg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 17 Apr 2024 11:40:08 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Apr
 2024 11:40:08 +0300
Date: Wed, 17 Apr 2024 11:40:07 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] thermal: amlogic: introduce A1 SoC family Thermal
 Sensor controller
Message-ID: <20240417084007.uzg2uc7gwb6mi7bi@CAB-WSD-L081021>
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
 <38ba3618-2a67-4e21-b08d-7e382411e51a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38ba3618-2a67-4e21-b08d-7e382411e51a@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184751 [Apr 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 17 0.3.17 f2153f38d75b12894d9cf445f96cd15c9ef63a9d, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/16 18:45:00 #24828684
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Daniel,

Could you please let me know in which repository you have applied this
change? I am trying to cherry-pick the original applied commit and apply
it to our internal mainline branch instead of the internal commit.
However, I am unable to find the applied series in any of the
repositories on git.kernel.org.

On Thu, Apr 04, 2024 at 02:23:21PM +0200, Daniel Lezcano wrote:
> On 28/03/2024 20:13, Dmitry Rokosov wrote:
> > It is primarily based on the G12A thermal controller, with only a slight
> > variation in the offset value of the efuse parameters. Therefore, this
> > patch series provides appropriate platform data and dt-bindings to
> > ensure proper support.
> 
> 
> Applied, thanks

-- 
Thank you,
Dmitry

