Return-Path: <linux-kernel+bounces-150551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6AD8AA0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEB3282FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CC16191A;
	Thu, 18 Apr 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eFVjv2kU"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E866172767;
	Thu, 18 Apr 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460367; cv=none; b=G4X02P7Yel+FNqKPgjOxjQ75Emny66ZoM0HHBqKotuAOzz6FIFVCeEJB4aDOffVdefT6MzjxyA3MfovCB71EX6D9vh+55geWlYeSlipWfVIFf/4+iI2pv3Q+7qW1MvjuYAAy5GHr9Qb+VTmI/qJbiA3dITdCMAW6Q+jOuinU9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460367; c=relaxed/simple;
	bh=5UP6hIKu73ePFJsWvVaKvOwufezVyeDHU8eJCZIxzDY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qEdYhjhHpvxodQYCjLaWRb+RcjgrzYYIAXRED/QHrQ/IbIZe+touB0ly3+hkKSpaOwhvCk0NgSI6XzWT/EqYk6qcHjkG8NrijC36+Hlow6Z8B2yKISX84Cas32ZsR1NWGlqaJrAloQhYU+etnJaJu8D93eLnbNLMmTN0g3RbuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=eFVjv2kU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713460356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp3BHNlpl/flqveHSNFLjR/0cIYJe61lDJbuZ02ahKw=;
	b=eFVjv2kUpj6gObSIVUobqG3KuNqSsChntjr6G5FYtO0Gwg/gunXstWMC5N266T0pKiKfgj
	jblXm/q+VI3uvhlf6fDXK04+kIgFsSYyC9s4PNa9RNGKx8iNjOKNdOobpzUHoeyjnJRVjr
	DNwZV0eux8gUTgn2TTwwrDNwmd6Fw9JGxfaHn9+tX6VCA4iovBYvxiIy1bdJxNHku2NFHr
	1AHWQ/tQTZvOBe+gCZfebSOWsshxMueBTbZT8vC8tEeQMm0BZuDZPJBrlUdUN8unVtlYgV
	H+g9hwO2HuheD6NOu7UufdNEi1u/dKPa93XxAwyObYvT+AGqoAH583GB+puXvA==
Date: Thu, 18 Apr 2024 19:12:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, amadeus@jmu.edu.cn,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
In-Reply-To: <20240418-attach-tigress-bc2b9f844fc7@spud>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <1888572.CQOukoFCf9@diego> <20240418-attach-tigress-bc2b9f844fc7@spud>
Message-ID: <c3c4a6ad48fbd62b44991c9bfd81570a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-18 19:04, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 06:59:42PM +0200, Heiko Stübner wrote:
>> Am Donnerstag, 18. April 2024, 18:26:19 CEST schrieb Dragan Simic:
>> > Correct the descriptions of a few Radxa boards, according to the up-to-date
>> > documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
>> > it up, the short naming, as specified by Radxa, is preferred.
>> >
>> > [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
>> >
>> > Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > index fcf7316ecd74..ae58e25c29ec 100644
>> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> > @@ -767,22 +767,22 @@ properties:
>> >            - const: radxa,rockpis
>> >            - const: rockchip,rk3308
>> >
>> > -      - description: Radxa Rock2 Square
>> > +      - description: Radxa Rock 2 Square
>> 
>> I may be just blind, but what changed here?
> 
> There's now a space before the 2.

Exactly.  That's part of the Radxa's naming convention, which may be
seen as somewhat similar to the general rule of spacing out values and
their associated units, e.g. "2 MB" is in general preferred over "2MB"
in nearly any kind of a formally correct document.

As a side note, there's even so-called "half space" as a typographical
convention for spacing out the values and the associated units.  That
makes formatted text with such spacing a bit nicer. :)

