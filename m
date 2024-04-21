Return-Path: <linux-kernel+bounces-152494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ED8ABF48
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34311F217E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51DA175AE;
	Sun, 21 Apr 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wSbQqbr1"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D879FD;
	Sun, 21 Apr 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713705709; cv=none; b=hj2yp4KDtJChJpd9OG72NX0bbu/a7YFS5mFdVxCI1z5ksIaDKdD5tK4LWQqSL5Wmh4hM6pOtPFtnWzzYZz9DBdXerAdVl2fnPDosvfn3N+1ZdEqO+2WX3eRsPoDEgzrov6KQkVaIZ2XlnOwT4jbwYqHc/2wPgPjHo6AuZpm26jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713705709; c=relaxed/simple;
	bh=evdFeQD/L6zQL0Vd61pp1Z/7nDj1MNxAxQVGWpoT+5Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FfoVVud94txZxnyYXpRei18+n7ev2DIUrFd7VS5iwVH+E0GL0ZECNkUOpUBrLERnyrmODMBwTjPS0bf2UNMMDeoP7Ny6CAPyCMPEc0kDddxhqvZ7AXcG3uhhkWh5vICfd16P4gwhEgvlcucGsVGSTgpjS9x8BVtQoAr5Jj/QBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wSbQqbr1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713705647; x=1714310447; i=markus.elfring@web.de;
	bh=evdFeQD/L6zQL0Vd61pp1Z/7nDj1MNxAxQVGWpoT+5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wSbQqbr1RYsm3tjLf190P21u4mfqY5aRfGWHBCzP1Tz+qjJbOZNzusg383orT8WI
	 tSzdWXRHMEiwSiFpRqoAZlK2q3ooF06CVAShhoh9FDKzJ7lO8AVijWqJrghP3TqjE
	 0CBARr3a/umf8F79eZvsTVGkG9sjPSZGc7nJIhLmlAHuZm0PT9F8+NAZhZBc/8JHc
	 2UNOy1XBc2dA1dXwhRMgAh9OMOoW2TbZX8ry3KKlJ6o37U61JfoXnLc5thhP6xQ7O
	 LurcAQzJ57IXNComwOPeRrOpYUYPpfUMzVV8kVAuyMwp6oXEM+g+072xqnSzrm7XA
	 KIgAy+B5QXtJEpR4xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1rvGOR2UaS-00Gm0I; Sun, 21
 Apr 2024 15:20:47 +0200
Message-ID: <de7d846a-01d9-4fdf-bc9c-86de86daf4a5@web.de>
Date: Sun, 21 Apr 2024 15:20:34 +0200
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
References: <20240419-fix-cocci-v2-23-2119e692309c@chromium.org>
Subject: Re: [PATCH v2 23/26] media: venus: vdec: Make explicit the range of
 us_per_frame
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419-fix-cocci-v2-23-2119e692309c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MbmB4lbr0en+rNEVuMVQKHm+9+SobHtxinkTBmRYl4i4b+31EqI
 eDwjrXrIaKZp+/JDMGyO9mK7R38liq/GAdwkTbVh4sU1ZIHKBPZL6Gz352kCK8X+Ott1p0I
 Zv1ZyMxrJePW9LRPcsVaIQBR5rTY4R57i5DKnUO1EgZCWx2pdd7i/yiO++WyTX9PkWwOwgX
 MxKtk9/Gp6Qa/8l3U6jHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dATBYSaFibE=;Jyz5Mi9ajE9LhE5N43qTaPY70xl
 gVnbMBqQ5QAVpzMNHzeG1wkunna8DaKO0ymMAIZrSDfx0FleIE5fYhcVDypdKp8lR0v4WHcJj
 bF1xILN9gvohbueA/zfLRvRWF/gnoBdL1aWPZIPYB6kW2aEMGTFMghdmtL5DzlX7WZWxY85WW
 7/rtRlA3gxcuo0iB5+M6gRylehhBreCGYF7EHnbs8rT3Qcx1II3k2Dyqm8RBDtSXvU7dv1N6U
 wajFglzV/nmJbI63wkecxwZpApsrBBwyGVnTzWSBdoBfU3C4RujxPe3Y17PUEOT3Qfcr+lWft
 Spgzxaaq6PmSulrGutImZxLGx6OdJEuFSUMxgD+J+EvG6t/pjkHn+vOgN3GI/ReQMP3/AaEI3
 DPD60h7q/Pfljd4BWJDamWuEcR+oILfmcG5AxOGnq3FQjtZH0ODtrTt96/lbKRZ81vYH+CXDU
 8hAuZwDshKlLcPUF2fWSJ9ntrW3rHm2W1nJQqIqZYiPZ8TEAYD2X0816c/Ntrsq+7FzTN/6tE
 juSDURgQk1ei57P0vsoouKErDTufZMRKnfag2p9ne6EeSN9khMGduG/U+G+v+uFKk8ERONGSO
 +6CgcGekJA/w17fJKphVwZPdG45Dp1ebt2C8pS6Nexw+Jhi+ko/DkvucwTGBphBPr8jlq4zHw
 RAOu1GUx/DwMa53tKCYa9ud2jOpt5G23ikqn34bwaNYhEBmgXqWZYY0SUcrMjJssH12bp8Mnm
 KyOHm0Qd0TkYbjXImY8P4Mo7M0Itn4iAxgjNzq5zbjtPyhRSe+ycsO/K8UZEm1x8LUST+Tq7H
 N6Tf56yDUtKLeIYD1zeJEW4KcLnGLGsBFNG6+hHWAgeA4=

> Unless the fps is smaller than 0.000232829 fps, this fits in a 32 bit nu=
mber.
> Make that explicit.

Would it be more appropriate to move the word =E2=80=9Cexplicit=E2=80=9D t=
o the end
of the summary phrase?

Regards,
Markus

