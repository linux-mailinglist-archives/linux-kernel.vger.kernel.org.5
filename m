Return-Path: <linux-kernel+bounces-129653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8076896DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770541F2443E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3865142E89;
	Wed,  3 Apr 2024 11:20:08 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54891353E2;
	Wed,  3 Apr 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143208; cv=none; b=qgZDO5FXK37ISIITeEUWaYefJ7WHVs+egfDnGGipQmEdVAsHlH3tULQUplkmAPyV5VLYRNkAghpCPfVnsvTYs2DUk1wWqirwuVeFL4xwgLx06DlvmxkbP1JlwBK2s9+LN2gvZhOiKgyuPWECdjwMQweOo2N+/B7It3ES6XTARV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143208; c=relaxed/simple;
	bh=LZcCaweuM6QMzoYUQ4SVyuK0er0XsmfzNV90+UiZHx4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=WGz1yPOow/GUaFHyb5px5keyEwZ+85pfWHu5fa050pHfeIRrlqfdZhjXkcsM4TgbvNHCukoIiNU57CVggcgTEJKqE1vOo00QZiOKWCnFSPNUWEh92CiUM/Tfq4YUYoUCixzvkgONpUBNKlnks1byUo13+cVg3si3kAi/vcwxSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 81D8037820E7;
	Wed,  3 Apr 2024 11:20:03 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <a2f88176-b4e1-4202-843c-a00c5a2b1622@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35e566-660d2080-1-7eb9eb00@16488675> <a2f88176-b4e1-4202-843c-a00c5a2b1622@linaro.org>
Date: Wed, 03 Apr 2024 12:20:03 +0100
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, heiko@sntech.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <35f774-660d3b80-3-513fcf80@97941910>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.=
kozlowski@linaro.org> wrote:

> On 03/04/2024 11:24, Shreeya Patel wrote:
> > On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel=
@collabora.com> wrote:
> >=20
> >> This series implements support for the Synopsys DesignWare
> >> HDMI RX Controller, being compliant with standard HDMI 1.4b
> >> and HDMI 2.0.
> >>
> >=20
> > Hi Mauro and Hans,
> >=20
> > I haven't received any reviews so far. Hence, this is just a gentle=
 reminder to review this patch series.
>=20
> Why did you put clk changes here? These go via different subsystem. T=
hat
> might be one of obstacles for your patchset.
>=20

I added clock changes in this patch series because HDMIRX driver depend=
s on it.
I thought it is wrong to send the driver patches which don't even compi=
le?

Since you are a more experienced developer, can you help me understand =
what would
be the right way to send patches in such scenarios?

Thanks,
Shreeya Patel

> Also, you sent it just a week ago and you already ping. Please relax,
> and help out by reviewing other patches on the mailing lists in order=
 to
> relieve the burden of maintainers and move your patches higher up the=
 list.
>=20
>=20
> Best regards,
> Krzysztof
>


