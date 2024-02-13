Return-Path: <linux-kernel+bounces-64166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CC853AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CD71C262D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AFE6086E;
	Tue, 13 Feb 2024 19:32:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3B10A3D;
	Tue, 13 Feb 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852742; cv=none; b=PhBVXWh+GaM6+GrXHUfJzmzMAHt/KBQCZgpjLfvdCrnftHC/3VPh3gqybV8oG7hDI3LysO0JBXOV4cQ+1Tf+GmIONetHzB0Xwym5iZUtE78dyEFNoAzuzjzH0gWUihkbj4igqfUp1juli7vjt7wkORFZXhfmaRdn+l0eb+N+d5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852742; c=relaxed/simple;
	bh=+dWU2wumMmM+JuL0HBE6MCloJNjkKYefewt62HqiROM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjuqFSVL9E3iyjjaF1fC4NeYBRZb5F39kXfDb5bennmxsHadOwuXB04OgEjQVtcnMspk9ZwYqOhvYlZMPM0/rjeWqaGrxn8t2Af1h6UTxFUTY7Oo0RnjKdY10hWsrvHJMIcEYzAdph8NGWzBun5AFKAtjUsWif8INgLI36wwhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyVc-0008Or-10; Tue, 13 Feb 2024 20:32:00 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Tim Lunn <tim@feathertop.org>
Cc: KyuHyuk Lee <lee@kyuhyuk.kr>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board bindings
Date: Tue, 13 Feb 2024 20:31:58 +0100
Message-ID: <2185016.Icojqenx9y@phil>
In-Reply-To: <194a0894-a9f9-4c5e-b304-e7278104d8e7@feathertop.org>
References:
 <20240115145142.6292-1-lee@kyuhyuk.kr> <47795047.XUcTiDjVJD@diego>
 <194a0894-a9f9-4c5e-b304-e7278104d8e7@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Tim,

Am Mittwoch, 17. Januar 2024, 11:03:26 CET schrieb Tim Lunn:
> On 1/17/24 06:55, Heiko St=FCbner wrote:
> > Am Dienstag, 16. Januar 2024, 20:26:05 CET schrieb Rob Herring:
> >> On Tue, Jan 16, 2024 at 09:31:35AM +0100, Heiko St=FCbner wrote:
> >>> Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowsk=
i:
> >>>> On 16/01/2024 03:00, Tim Lunn wrote:
> >>>>> On 1/16/24 01:58, Krzysztof Kozlowski wrote:
> >>>>>> On 15/01/2024 15:51, KyuHyuk Lee wrote:
> >>>>>>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly wri=
tten
> >>>>>>> as rockchip. Fixed the vendor prefix correctly.
> >>>>>>>
> >>>>>>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> >>>>>>> ---
> >>>>>>>    Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
> >>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>> You need to start testing your patches. Your last M1 fails as well=
 in
> >>>>>> multiple places.
> >>>>>>
> >>>>>> It does not look like you tested the DTS against bindings. Please =
run
> >>>>>> `make dtbs_check W=3D1` (see
> >>>>>> Documentation/devicetree/bindings/writing-schema.rst or
> >>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicet=
ree-sources-with-the-devicetree-schema/
> >>>>>> for instructions).
> >>>>>>
> >>>>>> The DTS change will break the users, so would be nice to mention t=
his in
> >>>>>> its commit msg.
> >>>>> I notice there are a couple of other boards that incorrectly use
> >>>>> rockchip as the vendor also:
> >>>>>
> >>>>>             - const: rockchip,rk3399-orangepi
> >>>>>             - const: rockchip,rk3568-bpi-r2pro
> >>>>>
> >>>>> Perhaps these should also be fixed at the same time?
> >>>> What is happening with rockchip boards?
> >>> Copy-paste stuff ... boards using rockchip,boardname instead of
> >>> vendor,boardname for their compatible.
> >>>
> >>> I do remember us noticing this a number of times on some boards
> >>> and requesting fixes, but looks like some slipped through.
> >>>
> >>> So I guess Tim is suggesting changing the compatible, but with boards
> >>> being merged a while ago, this would break backwards compatibility.
> >>> So I guess both the Orange and Banana Pies will need to live with tha=
t.
> >> You may get away with it because we generally don't use the names...
> >>
> >> Though there are some discussions to start using them to select dtbs by
> >> bootloaders.
> > Ah, that's good to know (both points) ... so essentially right now woul=
d be
> > a good time to do what Tim suggested, before the names get actual usage.
> >
> > @Tim: is that something you'd want to do?
> >
> Sure, I will prepare patches and send them out soon.

As I stumbled upon this patch just now, how is that coming along? :-)

Thanks
Heiko



