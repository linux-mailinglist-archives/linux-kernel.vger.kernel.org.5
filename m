Return-Path: <linux-kernel+bounces-10759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB081DB60
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC211F21635
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7ACA69;
	Sun, 24 Dec 2023 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bcUiXv2U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA5746B;
	Sun, 24 Dec 2023 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703435634; x=1704040434; i=markus.elfring@web.de;
	bh=9BiVbz0igTm7nDWglduX4wzhh6jbXHBNsHlsQ9SchSQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=bcUiXv2U4BW3uHtoz7UtDb6wyaqIKmeSH/2Vpxvpi0wHdbLtL9hpLXPD3e5XgmrJ
	 3r/YGP6GAbSigggtezR2bIi3u9QU/E5Q4DUVllR6UVxNWMQHpHonMc5svlO1ulT+s
	 1sIRTueixLnrK2WaB8zFJ+yznhBwlM9+ofYlEUn+sxPZ/HQSM4G+V/KomfQ5GQTga
	 NjqCeFIqSs07LExzNYIl9OEC28+HWlX7mF6l5rklWd785DZ5L+D6ErIp5dwJ+Pd0u
	 vcr79swPG6UqAydDMb3z6B71DTy0PD+y3iHPJx3DQ1tFegwviu8PAqWuStaUoKr2B
	 wOQAR+qslyfwunedng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1quU862wzU-00q6gg; Sun, 24
 Dec 2023 17:33:54 +0100
Message-ID: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Date: Sun, 24 Dec 2023 17:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 00/10] clk: ti: Adjustments for eight function implementations
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XEePEDeY0FjWsC2QA7qlbhxGaU3mauLYiNr3cIZ3Rev3r7moCG
 EpqJ5+3sRGzZEKYzU6HcAzj7DCmep7Xg8Tm/h8uVyIgo4bsJV230JuACQT+Lh7iPDMaoa5w
 YuOKgsWqAVAOcPYBEsyoRGfW2IpfQG0Oweudch3paIq20Grmi4eJ6yK8O2vOHz09oDkMIhQ
 TjIiSk7LLBH4CH5fbYnRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sYxr3ZCv3ls=;Fc31zMwDem2J2sC/1TXNDDqWzLq
 KizXtddyaG01hvUgdhUdsnWXDpOhPMZ/iOhBrTtWK5psW9hdxHDQ8qMMal5cLjiNk1KEqfT+0
 3r6ltPdwgA4uvhY9g9IAV3/jmzG6A/gCWhrQRyOzCeqAKjBYyEpGQEqPIhGypu+jVvZgV6vRZ
 56ljNC/Zd3ZxsTfEkPZAP3K2zgibymLHjr73JZPBoZjHLTAQrh+n0DjlZC7ziXQaa0DRPlMV8
 /DS3cXxlwGmsuAJM+eQcYiYBOxWgQmkSxAZtDgM4a/F4/nTFii8MJYq1dWq+6rZhzwbUe59uZ
 KeN8+phus6suqOrNsWufP9qhID71c1Abt9rpsxCnCsYV+Pr1iWVR/D9dPz+09u1syJpFyyJeH
 aiIDZ/BZ6zasMD5bkEJLmnaPfbHFsztIjLCmm2hT2QRp442T4UH4QV+YZox7aizwPRsuopY2G
 wzZJ71VKEqReNrj14v07z8VOqPxATOTylivN27I6OfdImm88s/nk7ZUtN4x6OcLooew0CUxcM
 otwNOL/miNiMJF9DzLwqwaAQs4AQN/onGGmximvXKORAZPVW14RswOqGnXvtD4+IIY2emcCb4
 lWQGtXjdFxbpDby9V/vLgEJ87crXqvq+LTaBfxCyCrU+ZVEW5ty0nQuOBHD4xnFPVlL4xdMUS
 HjbKMgWrkXVOqbClJf580CuFOPI9DX+3GyCrtBggtuS4jRwHW63BlcnhRvrHjH0ei0vPFOBPQ
 KbkwRqGXxylsUB1XfSKLsRO4/nplWyD+cRYB/He33vP78noQK0rQM8H+Vqe63ucJnCXsAJTsZ
 brE5ck63LeABS/gweDDsEiXMATYIQ4Lpj0n1yk+CWB3BAKhGP7euaESCzLJ4kTNEXyaCIx81r
 VrCmV6WIWMtA+6OvdBPaH7vw/z+VKXMHYoYaosZ0qHeU0MmMj8OseArsdmbjuTvdHJRJ2N2ue
 H/J3fEwt4bRW88KgzRMmsshSsh0=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 17:03:21 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (10):
  Less function calls in of_omap2_apll_setup() after error detection
  Less function calls in of_dra7_apll_setup() after error detection
  Use common code in omap_clk_register_apll()
  Less function calls in ti_fapll_setup() after error detection
  One function call less in ti_fapll_synth_setup() after error detection
  Return directly after a failed kzalloc() in of_mux_clk_setup()
  Less function calls in _ti_omap4_clkctrl_setup() after error detection
  Use common error handling code in _ti_omap4_clkctrl_setup()
  Less function calls in _ti_clkctrl_clk_register() after error detection
  Delete an unnecessary initialisation in _ti_clkctrl_clk_register()

 drivers/clk/ti/apll.c    | 58 ++++++++++++++++++++++++----------------
 drivers/clk/ti/clkctrl.c | 44 ++++++++++++++++--------------
 drivers/clk/ti/fapll.c   | 29 +++++++++++---------
 drivers/clk/ti/mux.c     |  2 +-
 4 files changed, 76 insertions(+), 57 deletions(-)

=2D-
2.43.0


