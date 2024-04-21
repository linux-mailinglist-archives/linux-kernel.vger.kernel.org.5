Return-Path: <linux-kernel+bounces-152503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038178ABF6C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8636CB2163C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC27175AB;
	Sun, 21 Apr 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="C4CWtl+D"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12D175A7;
	Sun, 21 Apr 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707681; cv=none; b=LJ0Q13Ee55CTzuR8k/4JvaYtoXMHJUHe3DUBOck7v/R6qR5Q176+oluCab2XI0C2VRExpKgCszQU9ZarMT7Q7OGDbGJra8ncPGq2jYSLW/0hpL4XvIP/tv836LhDBybC9fhTecoKvPIvPukGAc0woutWHpj3nyFIZA/g83lWbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707681; c=relaxed/simple;
	bh=NA+h1kZ4ZYosSXB9YC2ayj8s4oTUaovMwew+/FDs8yo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Anbk4uIzSQDhoeG1Oi1f2fX7BJ+is1SAMf5tBU33VoFxDuTrdOSzyTh1h5KJP9m3vwCIiIW5AFghJhItN1zRPUo5u2vc11LApSt0bpDyXaOOAY3gNvmWQdy6w2nAmZkrghC+XG8asUUprcSEIs+vLVU3YZo3yu1do4IvKEhOMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=C4CWtl+D; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713707675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4ooY+dJBDon3+uBiWdkfQ49raa8NLkoa8U8AjhBhvA=;
	b=C4CWtl+DvcM0SmFngK7FHkT2L/ZMtfaY6AswksaDF51yPAlkJLOg7sc9j+mRdNRjlt4Qqp
	IdmaYM6OJN8IGQaaHdfUybveyzIOgkjYQPTcaG46wuE2lZWRmWtxb8HmM1NGAgWJ3pM9JQ
	wKNk6Gn+OA5IDp+jcm0Fk3f+lI/aoQAcK3eEOLZG9KSbl88ppMwjFMyfYedDFfWDrSQ9A8
	roWBJ2bmEE3Ch2WLVybA4EBG02vYlB8Z+ajPSDL1A0Vrq/a0ngbUlL1cSJvgHHA/c8CEfm
	lckgPzXyZyoU65b/4Pb2yAR8GuPL2rV2qBCKp/02SE7qECbYyBMywyIlizS12Q==
Date: Sun, 21 Apr 2024 15:54:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
In-Reply-To: <20240419-triumph-cheddar-77fc2f6948b0@spud>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <1888572.CQOukoFCf9@diego> <20240418-attach-tigress-bc2b9f844fc7@spud>
 <c3c4a6ad48fbd62b44991c9bfd81570a@manjaro.org>
 <20240419-triumph-cheddar-77fc2f6948b0@spud>
Message-ID: <a3930b26634a78888c9fe3013284563c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-19 16:09, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 07:12:35PM +0200, Dragan Simic wrote:
>> On 2024-04-18 19:04, Conor Dooley wrote:
>> > On Thu, Apr 18, 2024 at 06:59:42PM +0200, Heiko Stübner wrote:
>> > > Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
>> > > > Correct the descriptions of a few Radxa boards, according to the up-to-date
>> > > > documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
>> > > > it up, the short naming, as specified by Radxa, is preferred.
>> > > >
>> > > > [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
>> > > >
>> > > > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> > > > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> > > > ---
>> > > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
>> > > >
>> > > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > > index fcf7316ecd74..ae58e25c29ec 100644
>> > > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > > > @@ -767,22 +767,22 @@ properties:
>> > > >            - const: radxa,rockpis
>> > > >            - const: rockchip,rk3308
>> > > >
>> > > > -      - description: Radxa Rock2 Square
>> > > > +      - description: Radxa Rock 2 Square
>> > >
>> > > I may be just blind, but what changed here?
>> >
>> > There's now a space before the 2.
>> 
>> Exactly.  That's part of the Radxa's naming convention, which may be
>> seen as somewhat similar to the general rule of spacing out values and
>> their associated units, e.g. "2 MB" is in general preferred over "2MB"
>> in nearly any kind of a formally correct document.
> 
>> As a side note, there's even so-called "half space" as a typographical
>> convention for spacing out the values and the associated units.  That
>> makes formatted text with such spacing a bit nicer. :)
> 
> Let's not introduce half spaces into the bindings though :)

Of course. :)

