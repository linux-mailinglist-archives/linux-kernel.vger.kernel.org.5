Return-Path: <linux-kernel+bounces-152509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAB8ABF87
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94620280F27
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8117C95;
	Sun, 21 Apr 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tQYCgFiD"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640FD29B;
	Sun, 21 Apr 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713708487; cv=none; b=P4FroR9vj9Gfg2/lqHBzJg+62Srp3xDHgqi0pmqOz8HEHYvUZPrQ0K3EfGv+HQsdJmCYPsXK8QyYnYeBjSGFbQdLWz+vrZ6c+JH7MgL2KGUoJPGnR1QG7nu6/Q+pCBICxvRGS3tIBKgzmXWoZoqqSnUNE7Xj0EG9vyF+Xm9a1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713708487; c=relaxed/simple;
	bh=rGFEHaSAYJNx3UiIUNYR80pXYXBmvUUDb2g2ErCYGyU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qPUIhyLIMEZvXOupfYjDN4x3gi1t9rIWpJ5Vb3iFeJmd17TwF/kTnpFf2PQvWkyl50++9vNRRj28r0x4IODYpipCauX2DVuTcs5DI0lSCU9M1HS44mmcPjJP83TYZCg2fkKGerIOTjiF0tn8+APa+zh5PZ3cqwJRYtpe1nIXLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tQYCgFiD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713708433; x=1714313233; i=markus.elfring@web.de;
	bh=rGFEHaSAYJNx3UiIUNYR80pXYXBmvUUDb2g2ErCYGyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tQYCgFiDBtzuJtaPSJ86VUUlnx3bXoxnIn1J0YHGl7VF+oYJVzcRSwD+G2zZBzgc
	 uTB8dvnwWkDivQsAUzxLsiwv5flkheBVFHvsQiOfznxtj7fLZB3M8RFbR5o6aFner
	 Sj1t1PzkywvlBvwKXs4Lr6JhavodozKnL0Svdq+lChYVhVirwNbPz6tS+gVYWlXqa
	 95mVIMsrQSmRFKT9TUNwZGTilthpjTn79LrHyCd7LFaP6wfUdMG/3T6vJ4rOdi4dH
	 iwGmCcl6aPaM0eI/pxYxleUmRrN9tSkK8x+A6S2Z4uZFiufNUmPWXhufwg8tihQys
	 I2EGKqoXEcArn2eUPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1rt3fo3mEe-00EaEg; Sun, 21
 Apr 2024 16:07:13 +0200
Message-ID: <8da94316-239a-4870-a29d-02a685ac9ae5@web.de>
Date: Sun, 21 Apr 2024 16:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Abylay Ospan <aospan@netup.ru>, Alain Volmat <alain.volmat@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Osipenko <digetx@gmail.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, Sergey Kozlov <serjk@netup.ru>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240419-fix-cocci-v2-26-2119e692309c@chromium.org>
Subject: Re: [PATCH v2 26/26] media: dvb-frontends: tda10048: Make explicit
 the range of z.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419-fix-cocci-v2-26-2119e692309c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITKldMmeWvicPfSwk1lGM7Lql2Cm3DyJ9It4EIHpN6gg859l9MR
 aVD74QMk+LR7UI7fCic1Ij6uvX8fwvnr7wmvQM8i2QbG3+d/JBqLNeRM3I4bZa4E34XPC0i
 SYsbUCsj7/cRMEyPRu6MKnSrI42n3gk8CvyH//Tym6kHgNuHGbXy4egSum6bjeRch61q+dN
 e/VFoFn+HOp3S2jycBj4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aX93InMPE+A=;h+M1UNdgZoIAePk/gLkMPUcnWFE
 5gaoXXP6v2pwlnxGO6K7et1oLiL8TIAKeJnHv51y9QwquJqybP572QDhkhzEsuPTkoIRzUN/7
 mShPYDLUIN00VsLwJwEmnundkTslk9hH7wxBTGzqOXKZ5TY5ODDTJuvlXRSs6Qt0j6Z/P7XXu
 15PpEI3BzQ9oSDuGd4BeLDWBmnFddw2ZuXCPSrm3HnBRmIp4rcHTseicBP7mUCsPTUTDT+3Y+
 vWHqY5jFyqwmk7ss25eqM/46T0rHpKxI0nKyahCwXvP7DUiZ1GPEITM3E7kQt4ALfzBy8uKQ3
 /QbGwtOhCqs5WJIPQAZqJR6XUwVGf7oZKojimwo3AaT5UA3U1JOPBrIBsYOKM154eq6cLRhb7
 iq3PcpnWcp3XY2aFQX8MCVRIVXgd8lxxQdtn8YCerRLUuZvtUlbR4R5j/YvI2UKy7FgzUXB1x
 3Bhlx0CwbqmbGIefOVLAyR4cfc+nIFs51pRtQ8+ewYveJRDBdeXtJMHFEz0n4phTP8RtZsl/0
 gBuiCYpYSSRcLDJIy3sB4G28Z9bjW/ocQDIUzqRvU2jwtnKM/PbNp1oZAjsy9Ua/wqTwFL3Yy
 D08zYttD1lPwxETSj/WDnXQ3ihq22+OycigTle4pH0Fu9sjflBCpMtE0wevQzd9/RPzz87VXO
 1UKjbmrDXvCF8Uxa9dvN/3c2y+mOW1EZ9w+T50Rgk7lXX021VRrmvb28kFBahImqiPOj/VuzQ
 kgKYpxl/BMOIFE87FcD1inozha/zbBUBsau+PpHyJL+sc7SUX97HhHV18g4SNex2a01C1nw4y
 muG/WBbFF6tZ2iO9s0OozwYOGKNkAjvz3gnxDEJWMz9DY=

> We do not expect the sample_freq to be over 613MHz.

Would the summary phrase =E2=80=9CMake the range of z explicit=E2=80=9D be=
 more appropriate?

Regards,
Markus

