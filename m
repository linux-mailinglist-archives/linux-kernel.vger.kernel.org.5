Return-Path: <linux-kernel+bounces-165318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD58B8B30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A6AB21485
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58D12E1E5;
	Wed,  1 May 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gfm9KiI2"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B412DDB0;
	Wed,  1 May 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570081; cv=none; b=f3yXh7kHkhd//rj1dqVqMN+Z0xOf4UlfwpXdfTp+tIei1xZE3Fg4Ej/IbIf6aIR87fUdnziliU0SOrmSpPphhxHN8QhQu+rsZpJaQWFNQwca8+xTa6/hPW/5cL/twbOViaRxHwdoT1eYZ7BnFzyuct5spMIqnpCvxGxqkpaOcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570081; c=relaxed/simple;
	bh=QtCYznDFxAqU7kOOd/hY0Cb2aqW53mLPzwqiX702hVM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UXgEmMSEP6utc+Q+duct8jJT9MdXgdmbWzsGbO3F0aP6oIyGccxcPIAyRmRgukiE2aFuCpzXdAzIE9zNGXD4/J8eg1AwHvikz8Z5egN/bHgOkMruL8EZcxEPT4HtPXO7PTplQx24vDS906fbHM4a21ci/9MEyDKgSgkLa8Otiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gfm9KiI2; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714569989; x=1715174789; i=markus.elfring@web.de;
	bh=iS/r3J9lwCCODjyNXcaefNMyX7CRPZrNN91+KUc3PB4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gfm9KiI213O4FGS2IDi3MOi5TLT1a5yfTjYqtTsLqkCMt8rHZHsHEdvNDEfKKMH0
	 uOgZwR5ufGuJJKTg8tlJrBEHgQDvmQbwZJVckzntSM6tFCKLNMYCX7c0z45qMZzwh
	 V2qo32T3mogEqYf92/qlWm2FFp9w2rXSqSvpkTeZEvzKWuacKpTCwiQ6CC8iRZnu3
	 gbBlA0sQFIVNY+EyanpAFzKGQVEWaUWKqlJHGx68uLAuaUDnCAaAJk3oskEEGzRne
	 idv5/M9CiNG4XfW/pXSYutyTkuy5JC7/bhuMkFsFDq1N8PuIIxtcXqZ25qs6Olu2z
	 qyeB1/Te+P/QzlqVHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjFg-1sqIf83FmM-00ylNB; Wed, 01
 May 2024 15:26:28 +0200
Message-ID: <d69ce186-6406-40ec-b8a3-a4b66d005ad6@web.de>
Date: Wed, 1 May 2024 15:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shenghao Ding <shenghao-ding@ti.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Baojun Xu <Baojun.Xu@fpt.com>, Baojun Xu <baojun.xu@ti.com>,
 Bard Liao <bard.liao@intel.com>, Bard Liao
 <yung-chuan.liao@linux.intel.com>,
 Cameron Berkenpas <cameron.berkenpas@gmail.com>, Gergo Koteles
 <soyer@irl.hu>, Jaroslav Kysela <perex@perex.cz>, Kevin Lu
 <kevin-lu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Liam Girdwood <liam.r.girdwood@intel.com>, mimperial@lenovo.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Shenghao Ding <13916275206@139.com>, Takashi Iwai <tiwai@suse.de>
References: <20240501122252.1215-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v2] ALSA: ASoc/tas2781: Fix wrong loading calibrated data
 sequence
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501122252.1215-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tC3X+GrzsotPgf+R/O7R1QzbOvKPtHRkYGtPGuFEp6iXPQyKEsb
 sCfhQHr+xF90jdOxVxhUmudOdLZB0aJwka+qTur5jv34SPxWBD2/sr/xDhuU4tDhfGO/6Px
 aopo2bxCZ1HfiAor+Rga88jCHsBAeLDKxHh761DdERfoXcH2wL8eeatxNIH8SWSnV5zmtep
 lNLON/93vd8Ab/LR9RZ2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2AKk/GKNh8g=;DIT/7tzccpnbJLKqm6tsIt75NpI
 aWJarwT56NcwoY13VQFhfeqfTrfiXm5Bl8jUwZNNdbxut7Src4TEm3BWh4GhFONIHezvTvWjV
 uAcIBU+YyWb+yJjs3J3vFMR4WeBK4TWfeooN+Bp7W3RkQaS0DW06EKAVlnNQMm8AXaITXBdYB
 jxiwYlU/pxE9xypmgCUX0xBwQIHtL82FDWNc+t9impuUZPbOfQ1SXkQqH7Qi2ErIxLBqykb+0
 v/ZOZLhjkObxaElawDIm5VCAFEA5e5pv/edEX8m1GI0+c+E4DCtqGc+AI1/rfWQBpjSX9J5zb
 CmHZvh3QrtTJwtvKeEM4N7dVSi2FAy358EHRGZ3jau2H+uYnfKRPxgETEV4O5N01ezjiTjLbL
 uRtd4FjvCebmu/35H5BEAD4PC5uW72pv1NVl0PjfHcRMkDQMy7JIZ7hxF65yhopKkhlcGnF0M
 K9/yY4qBGKztNR1OAqeqBlpv+TPd8N1EuyLsmX6NWzquTyL80AP0N1KBLaVS22bOJ+lnwOmSQ
 6nFktRzAf+PslYRG23Atkm54lAQMZPAGlV+L+udlUuNtmvi4+XaUXy1BVWED6fWeWF4rYPqmK
 3DMlQ+7LYaPV28A2NH0c6LmaVtv82rTLcrChU+eEg6nmM8hKt6l4fTfuamwTVyeh/sPh8vwXC
 ihr2xa9SvaLFrduH+/nMb2GL/0+cQ4RLeVl0Kvkfe+SO53F5p+G2aLgI0eXW4HiGI0IEX/bRx
 tbnHwAAyu49s1BmpgWb9kySsxa44No6nJfxvR8bupqH+G+xL40pX0YUOZnusx3IQ9Tm2YTguK
 XmSQb2wFpaaPieFpc+qEHnNlBw+2nh5Y11t1jaQJxHcTE=

> 'Fixes: 0a0877812628 ("ASoc: tas2781: Fix spelling mistake "calibraiton"
>  -> "calibration"")'

Please improve this tag.
Would you like to omit a line break?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n145

Are you looking for better ways to embed double quotation characters
in the corresponding commit =E2=80=9Csummary=E2=80=9D?

Regards,
Markus

