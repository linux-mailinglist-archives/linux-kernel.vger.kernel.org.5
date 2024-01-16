Return-Path: <linux-kernel+bounces-27128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1382EAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18E21F23C83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F97611CBC;
	Tue, 16 Jan 2024 08:32:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8D11C84;
	Tue, 16 Jan 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rPerA-0000Y0-Lt; Tue, 16 Jan 2024 09:31:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tim Lunn <tim@feathertop.org>, KyuHyuk Lee <lee@kyuhyuk.kr>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board bindings
Date: Tue, 16 Jan 2024 09:31:35 +0100
Message-ID: <2421144.zToM8qfIzz@diego>
In-Reply-To: <3dfe868d-ff8d-44ac-a68e-066ac42a6705@linaro.org>
References:
 <20240115145142.6292-1-lee@kyuhyuk.kr>
 <8b31ae29-b88b-4ded-95b4-c2d9bbad24e1@feathertop.org>
 <3dfe868d-ff8d-44ac-a68e-066ac42a6705@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowski:
> On 16/01/2024 03:00, Tim Lunn wrote:
> > 
> > On 1/16/24 01:58, Krzysztof Kozlowski wrote:
> >> On 15/01/2024 15:51, KyuHyuk Lee wrote:
> >>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
> >>> as rockchip. Fixed the vendor prefix correctly.
> >>>
> >>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> >>> ---
> >>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> You need to start testing your patches. Your last M1 fails as well in
> >> multiple places.
> >>
> >> It does not look like you tested the DTS against bindings. Please run
> >> `make dtbs_check W=1` (see
> >> Documentation/devicetree/bindings/writing-schema.rst or
> >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> >> for instructions).
> >>
> >> The DTS change will break the users, so would be nice to mention this in
> >> its commit msg.
> > 
> > I notice there are a couple of other boards that incorrectly use 
> > rockchip as the vendor also:
> > 
> >            - const: rockchip,rk3399-orangepi
> >            - const: rockchip,rk3568-bpi-r2pro
> > 
> > Perhaps these should also be fixed at the same time?
> 
> What is happening with rockchip boards?

Copy-paste stuff ... boards using rockchip,boardname instead of
vendor,boardname for their compatible.

I do remember us noticing this a number of times on some boards
and requesting fixes, but looks like some slipped through.

So I guess Tim is suggesting changing the compatible, but with boards
being merged a while ago, this would break backwards compatibility.
So I guess both the Orange and Banana Pies will need to live with that.



