Return-Path: <linux-kernel+bounces-87686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E986D7B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66303283649
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0813C9DE;
	Thu, 29 Feb 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="T35ZCjxn"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B355E76;
	Thu, 29 Feb 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249024; cv=none; b=Eq6BomKbfjqev29sf4T5WbQHMk8ktfCcFgHnAaU2K7dr05prEf4qaptqCVbNvKDkrsqFIPiYgUNVsW45ft10dsFznRcr4Gx95syinR2Tdi7xCkvT2mBAFEeWGiGGzQQCZiuKDo7KMx71r6eeM/rJOQxZ5KKElJhpCI9GOXAMZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249024; c=relaxed/simple;
	bh=iwhvBuR3uowqRZpqmpqi0jgdnW+GpbB/EsS1T+Pi24Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1geHNgtd1OVgku2xuqHPwMzedRr7rSmSxytlM0lxvi550ykZH5Fz8TOwq1vPtJWWzvSuTnh3Z+1QKjQc3HOvFatoOO0tPYeb/4LULC9dkJ1A8b7j4b1iSf5wyCaXtB8XWNz6cDmAwpi9cevO00S5H845DkiHxYMIK93BGjBGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=T35ZCjxn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-70-176.adl-apt-pir-bras31.tpg.internode.on.net [14.2.70.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1092A2014F;
	Fri,  1 Mar 2024 07:23:36 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709249019;
	bh=iwhvBuR3uowqRZpqmpqi0jgdnW+GpbB/EsS1T+Pi24Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T35ZCjxnY32uGh1veM/9q6f1NytauK7tck34JYdig1hWxH48PHb4OylbgljFV7Yvs
	 lMwpgNgI4Adtol5s228u5RgVH7fEvlW3pjC0EK2eb60yPen92xuja2B5vU5IebcL5B
	 46yZkX+PriKqmQP57m/8GL90/NGbUfHxBLQUOjJqRSn5Ib+kxFGEknw6UBb8zDbq1r
	 eeGC8jDGcZ5U2JxbesjLGLOKSsRRbqr391cKM/bVdWQuYYr0RdkJUTFmhWUzwLHrgm
	 bm/iSfjkySDatt8zWhbl/05ELmOZPHoJTYyYixQXlMxOKxz9J8tHxm3fB6gCcavcbW
	 PrNZeGOggyRag==
Message-ID: <e55aa1321ccac8e6391ab65a5a439b49d265bfce.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 linux-gpio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 01 Mar 2024 09:53:36 +1030
In-Reply-To: <CAMRc=MeEyo7y-G1saydxtTRedNtHPaEeLANuzXt6KsiDU2jOWw@mail.gmail.com>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
	 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
	 <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
	 <CAMRc=MeEyo7y-G1saydxtTRedNtHPaEeLANuzXt6KsiDU2jOWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 09:52 +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 29, 2024 at 4:21=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> > >=20
> > > You still have way too many examples. One is enough, two is still oka=
y.
> > > We really do not want more of examples with minor differences.
> >=20
> > Noted, I'll keep them to a minimum in the future.
> >=20
>=20
> As in: I'll still send a v7? I can trim the examples when applying,
> just tell me which ones to drop.

Ah, thanks. I wasn't planning to send a v7 given the R-b tag from
Krzysztof for v6. I intended for "in the future" to mean for patches
converting other bindings to DT schema. But if you're keen to trim some
examples out I'd drop the aspeed,ast2400-gpio and aspeed,ast2500-gpio
nodes, keeping just the aspeed,ast2600-gpio example.

Andrew

