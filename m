Return-Path: <linux-kernel+bounces-12464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5F81F523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB71B21BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1834411;
	Thu, 28 Dec 2023 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MhX+D4dQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B33C0B;
	Thu, 28 Dec 2023 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703745568; x=1704350368; i=markus.elfring@web.de;
	bh=CQ9zUoeIIRPWlBOHSTjI21uVE111Q+XjbfT31zxGskg=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=MhX+D4dQaTRR+Wp4MmEKg0TlR/voAK1KawY4y0Kmtt1iRjc96BYEgrsIyORIW42h
	 BGj8vESq1+qATcYA4GPesp5Ni6H8/vmpKUXqB9nBmeWedZRgER7MDdqeEaCEKkLjT
	 r+QAM4n8nVGpsUinTQQ7r2HyUbhd9/k/m1AwVuY4p4IU4FnB8KUdi181SvNjYrjBI
	 6lm00WQHe7CmxrvIbSJ9bUWnnk3SMpaXg7tB2Xcz4/fwqjNCxpWNl13AO+fl17/XD
	 Kr5TwPX/ZKlYa8QwUA44tKb3yEDveRC4nmiPmANceRQ2jqc3XaUwjRLX1545Ihkwm
	 Q++93rc6AyyrT/kZ+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1rJIHV3Y6U-0015Fq; Thu, 28
 Dec 2023 07:39:27 +0100
Message-ID: <a206cd2a-03ef-4c8b-8f8d-635e8a02e72a@web.de>
Date: Thu, 28 Dec 2023 07:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [09/10] clk: ti: Less function calls in
 _ti_clkctrl_clk_register() after error detection
To: kernel test robot <lkp@intel.com>, linux-omap@vger.kernel.org,
 linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>
 <202312281350.5H2Rhh67-lkp@intel.com>
Content-Language: en-GB
In-Reply-To: <202312281350.5H2Rhh67-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DvP9z21vMsNBbQJt43X0o5GZcDwyooJWWYTx1miGfTsjAJDm9kX
 RMebBTOHOA/Y3UiZsegNNb4nbDoTDKwVi0QdLSK6XEeeyN1oRCi9kvtfm6R64pnj8aIVPU5
 D2HKwNGODLa8Vy4H7ZZ19kK9AxkOtD1xF5e7cTM+zzDiBUND+dbS0qoh71szBUmd5kZB96I
 hw0NGGO6aEgwgeIMt86sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:irS8BLfZwbs=;nqFf8TNcswZcxiA74aGtBUelV4W
 wPLFUNj9Y5LCKpgjRB5FcfIW56ElQ2n8No3Mz0qJmsKp7CJTLkGYPA+OKoCoDg99e67nykupF
 KpSV+r9k/fgCBat89n4CP8H+7w79DCBYKDURZWt5zBtFidlVEjK0KKUmx4F/fxnfcEw+wAuAg
 +J/KhYxaeUUlpbKvfA8pl1fDhWNUXnpD5x8x5PyQJVJwrWmFQJQWgB6gHF5e5tJpeVyEZDse0
 R2RMejLFBPLRr9XhrjsoRoEvWUsyLHcC+qRUe7EiFbQg42T+leSxKxNL0gHU+eJYOW5n2w+DJ
 gmDXRrqW99b7KkJh7WghhGBTJfbLiAo6shHSYtBhI6aWJtdvMXHTPoSistUCaP4Jjr8JwB+Hq
 A5qwohRaRlRXjCYWTxeh5A3+NeLkfYh0hJQIUEZ5YnkgxaZn9498LoIzj+ofmKEmbAkGVgN4W
 T37J+49AylfFtk3Bcui839UNbY3dJUAloHJ+yNQoRn7q5Ru4GNQGwX1Pw/NybnUTV6lNX2bf1
 G9koHh6MOi2mqgnJabHLBw7dlIJC0rV8cx2GNt++KewuO5BJLC6aniPGq3DLzyneGvNXJPtSR
 lzaS3OeGTLBbxt01C3K5ZQdtTrj5ZIvR1cCuzcbajtnrfrG87LozgIsgdcP6pRanPGt8GM1Zn
 k/L9rJ3zWGA5Uagli3s5EDjwL9NMBXaGiJzf6KqRtsQd5np3mppA4fdlnWS66/MdHNEJpMna7
 uNKF4L1v58q+hMMzPASNSRAXz0REqmImEIA7jUQe9uoVhgB7C3DuEp3AECTy2epta5GY38U2N
 yTyWJ0nqdzueADSiiqlxcbki9v+267z4ZSnfUyxWl1VpK3tQP/wovmKSXbfhmmcCGhKJxtGE0
 PJLzpWLAJiI+aZf5MNJf2THiWO78vioh01VmY/O2xpT3RC3sEo/ZErIXn4t1c1t5zmKqBVqjG
 F4f5jg==

=E2=80=A6
>    drivers/clk/ti/clkctrl.c: In function '_ti_clkctrl_clk_register':
>>> drivers/clk/ti/clkctrl.c:330:1: error: 'free_init_name' undeclared (fi=
rst use in this function)
=E2=80=A6
>    328	cleanup:
>    329		kfree(clkctrl_clk);
>  > 330	free_init_name;
>    331		kfree(init.name);
>    332		return ret;
=E2=80=A6

Will it become helpful to fix a typo for the delimiter of the shown label?

   Or:

Are you looking for further adjustments according to software design optio=
ns
which would be supported by the file =E2=80=9Ccleanup.h=E2=80=9D?
https://elixir.bootlin.com/linux/v6.7-rc7/source/include/linux/cleanup.h

Regards,
Markus

