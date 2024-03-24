Return-Path: <linux-kernel+bounces-112793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB2887E34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0301C20AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182151AAD2;
	Sun, 24 Mar 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="u0RcmHdo"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512519BA2;
	Sun, 24 Mar 2024 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303173; cv=none; b=FwkT8uGZf9WskzBTkLj/4AofKEne3C173RZ5/1RdwZqgJaaTY72vUxbJo7i51pGO12beghiAoFGtXjdihsg78EPdmGBiQ8uzHMH+AJGdg3TS9VFJazaAyhsHRqqWXWieHImy2b3yxOJ0hlZIWow/BukW5YDaTNLBzCwQMbKaBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303173; c=relaxed/simple;
	bh=vOzA/tKqPZp4+9Wm+5C8N3FOA99D7YrNR9zQplxWvkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gfkuYpxVhVSYdk5OuEr/vdFlTvZmGoqzr1bQnkERc50S0XaSL6g/OdgXrP2uB+kHaEwfw5S0MZDFlKC1oDzSrjyE29ziNgD2PhKigOjfQ8HRrRSVl//roU7JTmjVk9/xWhZZjzldKxug87sLbp6/TzajEogUmqyOWmSVao2vduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=u0RcmHdo; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 41699120003;
	Sun, 24 Mar 2024 20:52:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 41699120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711302753;
	bh=rPCKzwxY/P8E8hlP0ZyZIPxAhwhwOHS8SkfFEzDhMSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=u0RcmHdomX0A7S94roBud3m3OftVEWIzyfo0+wLhUD5RNO2YIkm+Bu+sexbKz179I
	 i5GpnTO/k7ENM3P7qRlc6B6vZqKFCKks80+FEUdIZzUFiLmcW4x9WMI4RwDatDFD+s
	 74VhHD8YZCnqv3GTD0mCN/EuweCj7PqXiHaozecwcU+QA5GnFuJ1v8BlPSQH1zvKKd
	 Ub+6IlO1kQcvkqML+hbN7VHMgEfmPuNcbPG0++Sw67iUPMk2tVUOvD8BGR6OOzMjZ3
	 urrDZRZmxUZ0I5/8cNdc7ZI870Fc8Z7WiQRuHU+sxzLq25zcJtMwWOzVeay3zaRvL9
	 zYYThkk6c+Khg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 24 Mar 2024 20:52:33 +0300 (MSK)
Received: from [192.168.20.2] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 24 Mar 2024 20:52:32 +0300
Message-ID: <2bc7976b-3910-4a44-a969-7b6bc5d72869@salutedevices.com>
Date: Sun, 24 Mar 2024 20:51:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/25] ASoC: meson: g12a-toacodec: fix "Lane Select" width
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
	<linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
CC: <kernel@salutedevices.com>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-7-jan.dakinevich@salutedevices.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240314232201.2102178-7-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184373 [Mar 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/24 14:08:00 #24408963
X-KSMG-AntiVirus-Status: Clean, skipped

Sorry, I screwed up. Original code is correct. I mixed up the maximum
value and bit offset.

On 3/15/24 02:21, Jan Dakinevich wrote:
> For both G12A and SM1 the width of "Lane Select" should be 2, not 3.
> Otherwise, it overlaps with "Source".
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  sound/soc/meson/g12a-toacodec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
> index 531bb8707a3e..b92de2235627 100644
> --- a/sound/soc/meson/g12a-toacodec.c
> +++ b/sound/soc/meson/g12a-toacodec.c
> @@ -229,11 +229,11 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
>  };
>  
>  static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
> -	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 2, 0),
>  };
>  
>  static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
> -	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
> +	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 2, 0),
>  };
>  
>  static const struct snd_soc_component_driver g12a_toacodec_component_drv = {

-- 
Best regards
Jan Dakinevich

