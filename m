Return-Path: <linux-kernel+bounces-130701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD44F897BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AC5288D4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBE156881;
	Wed,  3 Apr 2024 22:49:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FD29CA;
	Wed,  3 Apr 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184544; cv=none; b=CKY8mzIbydJQyvX+sIEOSJYnuTqS3zpAFPcWT9vbFeN5C+NBze/60RCkfb0XQFjIWoLQ2gkQ4bi5lAUOBiuu71Ktk6IzngORKuAcuCcUNVwqiksn+JEX3eye1M5U76xEorPnWS0wnAcZQZhin1ozBCeRZPH9c/3QCCsGAIfiz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184544; c=relaxed/simple;
	bh=aXWZraWkuHUebmsbdINo56HuhEXVRhqs1totcDah4dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT5SVw22aTrkAqx0/foErHi6DuOD2o4JyJK/e3jZ8L6LIu3SXBN1o7Z4hK1cQ5HInB+duIbEq1AlvW1E7+cQtviXJ3hcp7VF4zHr7WyyPy5TKyRUMzep+5CvTfteBJjdvOPcEJJMIuWtGy9nbSFTXabkcYWmqM0OiOO8kqLrs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rs9PL-0003DP-QW; Thu, 04 Apr 2024 00:48:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Shreeya Patel <shreeya.patel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
Date: Thu, 04 Apr 2024 00:48:38 +0200
Message-ID: <3049149.687JKscXgg@diego>
In-Reply-To: <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org>
References:
 <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35f774-660d3b80-3-513fcf80@97941910>
 <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 3. April 2024, 13:24:05 CEST schrieb Krzysztof Kozlowski:
> On 03/04/2024 13:20, Shreeya Patel wrote:
> > On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > 
> >> On 03/04/2024 11:24, Shreeya Patel wrote:
> >>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@collabora.com> wrote:
> >>>
> >>>> This series implements support for the Synopsys DesignWare
> >>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
> >>>> and HDMI 2.0.
> >>>>
> >>>
> >>> Hi Mauro and Hans,
> >>>
> >>> I haven't received any reviews so far. Hence, this is just a gentle reminder to review this patch series.
> >>
> >> Why did you put clk changes here? These go via different subsystem. That
> >> might be one of obstacles for your patchset.
> >>
> > 
> > I added clock changes in this patch series because HDMIRX driver depends on it.
> > I thought it is wrong to send the driver patches which don't even compile?
> 
> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
> Please get it reviewed internally first.

For the change in question, the clock controller on the soc also handles
the reset controls (hence its name CRU, clock-and-reset-unit) .

There are at least 660 reset lines in the unit and it seems the hdmi-rx one
was overlooked on the initial submission, hence patches 1+2 add the
reset-line.

Of course, here only the "arm64: dts:" patch depends on the clock
change, is it references the new reset-id.


Am Mittwoch, 3. April 2024, 12:22:57 CEST schrieb Krzysztof Kozlowski:
> Please do not engage multiple subsystems in one patchset, if not
> necessary. Especially do not mix DTS into media or USB subsystems. And
> do not put DTS in the middle!

picking up your reply from patch 4/6, there seem to be different "schools
of thought" for this. Some maintainers might want to really only see
patches that are explicitly for their subsystem - I guess networking
might be a prime example for that, who will essentially apply whole series'
if nobody protests in time (including dts patches)

On the other hand I also remember seeing requests for "the full picture"
and individual maintainers then just picking and applying the patches
meant for their subsystem.

The series as it stands right now is nice in that it allows (random)
developers to just pick it up, apply it to a tree and test the actual driver
without needing to hunt for multiple dependant series.


Of course you're right, the "arm64: dts:" patch should be the last in the
series and not be in the middle of it.


Regards
Heiko




