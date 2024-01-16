Return-Path: <linux-kernel+bounces-27750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DA82F542
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BBF1F24AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BED1D527;
	Tue, 16 Jan 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY7+CK8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2E1CFA9;
	Tue, 16 Jan 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433168; cv=none; b=Khn16j1moGZ+caawCi+4zX0Zps4XyswkBWRwwSAOtO2SR2ms3UBNdlisSabMOFJlbDsovVW2Zzgz2fyKfw0KIZglrNG4SK/Vib90u5z3NnAdD6exO9/yebV887XEcQ1oqaP+ZEw3dAQ43X4EBTcjEu6el2BvAREI4tvBJtPI85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433168; c=relaxed/simple;
	bh=B4b0GWY0RQ8JpYsz9T55TuKhWcRS0NpwY9X992qXy6Y=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=Y7WX4mQkSkXgh2u5tctvgMotD+J5PDdVNSbQDMiif3Rw6D57fD4+hz9REb68F2dNbZBfAmXESP6GNsugRIeN0tk+v/0YX18ecxAYIKHYrwh0yO2vHYsPMxlXjUJyE2vVtpGk7SlX7RYaCPE9p3fNvWhg/l32rr0Va7gKNqsNIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY7+CK8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B24C433F1;
	Tue, 16 Jan 2024 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433167;
	bh=B4b0GWY0RQ8JpYsz9T55TuKhWcRS0NpwY9X992qXy6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY7+CK8WU7DjDEgOihpyGM+XAuWkFtPSJ72WNOfgGwo6D1fpQDJcpdXtkpqV3bUX3
	 CGC4ukQylgEKR/VzXIg0Is83b1JRwHCOMiq5UaGFtwuhPwnZ/Ea31ZyAzT8mSEYRaj
	 u0kiaEQYQ+lvDittBjpxD1PTrDTjkw6JcAv1VnjyAx8VfYbcyt+B66SF0uY2dMJgCA
	 leDjeBKo7gW1XfQaUgqQMbiXGTS+UhDitnK/12NNqK2g0hivR6k5pXKwp5Liu5Vjiy
	 Pl4SErZCsJ0eCI2Y7f5G97lrHSxjhGPHxeB4tqp0QtuQQizh4BarJjc4G/Aa9VKMK9
	 RnzQLq3tSdhgA==
Date: Tue, 16 Jan 2024 13:26:05 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Tim Lunn <tim@feathertop.org>, KyuHyuk Lee <lee@kyuhyuk.kr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
	Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board
 bindings
Message-ID: <20240116192605.GA274661-robh@kernel.org>
References: <20240115145142.6292-1-lee@kyuhyuk.kr>
 <8b31ae29-b88b-4ded-95b4-c2d9bbad24e1@feathertop.org>
 <3dfe868d-ff8d-44ac-a68e-066ac42a6705@linaro.org>
 <2421144.zToM8qfIzz@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2421144.zToM8qfIzz@diego>

On Tue, Jan 16, 2024 at 09:31:35AM +0100, Heiko Stübner wrote:
> Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowski:
> > On 16/01/2024 03:00, Tim Lunn wrote:
> > > 
> > > On 1/16/24 01:58, Krzysztof Kozlowski wrote:
> > >> On 15/01/2024 15:51, KyuHyuk Lee wrote:
> > >>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
> > >>> as rockchip. Fixed the vendor prefix correctly.
> > >>>
> > >>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> > >>> ---
> > >>>   Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
> > >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >> You need to start testing your patches. Your last M1 fails as well in
> > >> multiple places.
> > >>
> > >> It does not look like you tested the DTS against bindings. Please run
> > >> `make dtbs_check W=1` (see
> > >> Documentation/devicetree/bindings/writing-schema.rst or
> > >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> > >> for instructions).
> > >>
> > >> The DTS change will break the users, so would be nice to mention this in
> > >> its commit msg.
> > > 
> > > I notice there are a couple of other boards that incorrectly use 
> > > rockchip as the vendor also:
> > > 
> > >            - const: rockchip,rk3399-orangepi
> > >            - const: rockchip,rk3568-bpi-r2pro
> > > 
> > > Perhaps these should also be fixed at the same time?
> > 
> > What is happening with rockchip boards?
> 
> Copy-paste stuff ... boards using rockchip,boardname instead of
> vendor,boardname for their compatible.
> 
> I do remember us noticing this a number of times on some boards
> and requesting fixes, but looks like some slipped through.
> 
> So I guess Tim is suggesting changing the compatible, but with boards
> being merged a while ago, this would break backwards compatibility.
> So I guess both the Orange and Banana Pies will need to live with that.

You may get away with it because we generally don't use the names...

Though there are some discussions to start using them to select dtbs by 
bootloaders.

Rob

