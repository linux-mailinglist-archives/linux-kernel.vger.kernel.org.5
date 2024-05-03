Return-Path: <linux-kernel+bounces-167343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B58BA832
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A16B21147
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF01487EC;
	Fri,  3 May 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fpFYMV31"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575131465B5;
	Fri,  3 May 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723156; cv=none; b=bHkcykX++i2bmlZKV/Umn5l9XU3kvmcZIo1vUCUoQ5+hUYDv1FlEQ4Gei6EqYLOpazBBoCfzwFn832StsJZpIux6DaHC/nlUoNZY59+1mlRrOumhuSuI2f/vrhEABbRAhEEGa8ii9mwIv7W8bLnPFPgAqI38sINLtrmQF0Yo7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723156; c=relaxed/simple;
	bh=f7H+OF65L/hmMeYTdnOeeM0VJ0Havz3E8X5ne5zG0X0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxfXw8iOEeMRPtYo7owbuoqrLQVelU/eR/fcVfMD2pGyXrO7lYP+REcdf8EUstUt6MQYMgCAQEU49DVxEZ6MpiiLH1faIDpPmm6IOH99bEQNuoeszjJEnxpWcqd4yhxNpfcyFIMH/n02JffUdg7gsyIynABmotkFepHqNZEU6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fpFYMV31; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 314C012000C;
	Fri,  3 May 2024 10:52:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 314C012000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714722776;
	bh=vPYAXAEpU06TIJUWj2rEgevmEmcxPqtBx4Bo9O+8NsY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=fpFYMV31LZZ4ynG08Pe03cA8a9KzeMzVOBBPvA7yhE4GkpadK25lCQuKD2i2VquMz
	 Yz2DhND7KNfEk2+ltk4DG2n5sHRn/ShXRUyQBX5z9Vtq/SzCVzCDXnu9WFmmsJPx48
	 8HvcyN8as4yWi9tBk9eSuA3QviSdPYK2y5i8T9XOvrLluchZWqS3KvWT8nEmmMbGKI
	 tbTiIsbUOP7BUvWAOvkkDjZapdbfl2s/lJPO9H7UBpNw9HFaXqduhJbwm6j/zoYJxD
	 82MWVXvE5/336Red8Oe25+0pqPkLKRhcuELTb2VJ0iOdTsbKXVG3CxND1nltay1lBr
	 /xQsNWMXw7uwA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  3 May 2024 10:52:55 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 3 May
 2024 10:52:55 +0300
Date: Fri, 3 May 2024 10:52:55 +0300
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
Message-ID: <20240503075221.suupx27777tvhdvu@CAB-WSD-L081021>
References: <20240328191322.17551-1-ddrokosov@salutedevices.com>
 <38ba3618-2a67-4e21-b08d-7e382411e51a@linaro.org>
 <20240417084007.uzg2uc7gwb6mi7bi@CAB-WSD-L081021>
 <20240426073106.3yl2dplvauper3lg@CAB-WSD-L081021>
 <35c9dbe9-9166-4358-bfa9-99f205acd8de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35c9dbe9-9166-4358-bfa9-99f205acd8de@linaro.org>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185030 [May 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;git.kernel.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/03 06:33:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/03 06:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/03 04:34:00 #25076274
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Daniel,

On Fri, Apr 26, 2024 at 09:57:29AM +0200, Daniel Lezcano wrote:
> 
> Hi Dmitry,
> 
> On 26/04/2024 09:31, Dmitry Rokosov wrote:
> > Hello Neil,
> > 
> > I hope you're doing well. I was wondering if you could assist me with
> > below problem.
> > 
> > I'm a bit confused about which kernel repository the series was applied
> > to. I asked Daniel about it, but unfortunately, I didn't receive any
> > feedback from him. Could you provide some clarification on this matter?
> > 
> > Thank you in advance for your help.
> 
> I was OoO the last two weeks.
> 
> Your series is in my tree [1], which is pulled automatically by the linux-pm
> tree in its bleeding-edge branch.
> 
> Today, this branch will move to the linux-next branch [2] which will also be
> pulled by the linux-pm/next branch automatically.
> 
> Hope that helps and sorry for the delay to answer
> 
>   -- Daniel
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/bleeding-edge
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

Thanks a lot for the update! Now I see the patches in the above repos.

-- 
Thank you,
Dmitry

