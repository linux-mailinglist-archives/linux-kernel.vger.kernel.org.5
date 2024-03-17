Return-Path: <linux-kernel+bounces-105453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C687DE11
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDE8281051
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117F1CA89;
	Sun, 17 Mar 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="EbezBHPP"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BE1C2A3;
	Sun, 17 Mar 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690220; cv=none; b=NHjZjnOoMBEWqV3FVZZdHHmbORR8HxDTlJj2XxqoICEqbsXQIVwFdU+ibFXQbhOKfsz68ngYk4kyfOLoT3eRr27CvJdil5PtGBGM1dBqTm+2P+TJVf2SeRqOaf5X3hk6uS8BUWkJeRwLlNblpo6aMU18lsBjO+y3gkx+tJ1pf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690220; c=relaxed/simple;
	bh=pDL0kN1MqTcIYGSEVsbX6PmsDPUpwUOu1jMe9oaJ5EY=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=KebcF0QbgNGd8F9RicA3gVYh1IirDUloFHTwphdG+7jJdRhw37fdXaA2tJKLBuRNFOs2N3jUAd1tTxCRcIC5ZTEAg8YhTbXWqPfpTlQ4YYqhyIdotfLjpUqeEfWu6R0q5eFaoCUKLYY0WhQUC2kX6/d+TuJtYYkrVXIDUBwZ16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=EbezBHPP; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=uuS8h13Dfisu/E9ZFdgp8Y9Wd2KPlZ+Qi/VX5ONUtms=; b=EbezBHPPuxqbvr
	67XQnoC/gP3StxqjxtZFsZEl0ttg5DCI8M05eWwMrr0JPnTENKlxaXhGQGLRZLuBcNSnShW8UwTQn
	N+ZofsgQfIgY79RXKthSU182nEp843rLvPF5ivkD18JFI+oOke4CIwMjuJKD30TBy8DUQ7ZoubfFr
	iW/jomBleoH32cTN5jCa6ziZhMUkx+SDTHjl1w1oKYw4/pIowEzH34Z34q2IknxHzsG4ZxOQjfO7N
	VlyNJt7zffCD0MSh5UNDG9OrxLSkEXDTeIvejvRWbBd1SLo/uiAT2Zu+LHsWXLnUrxwoiwMjad1e4
	Ua/nJsgmMzEh1V9D05jg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlsfY-008pEm-J4; Sun, 17 Mar 2024 17:43:30 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlsfX-0003B1-FI; Sun, 17 Mar 2024 17:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Sun, 17 Mar 2024 17:43:27 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>, =?UTF-8?Q?Ar=C4=B1?=
 =?UTF-8?Q?n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
In-Reply-To: <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
Message-ID: <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/3wXUGaFkOxFHAOpxTyCzVPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNMwpa8J6LDEGB71xpBP9rMN3suOKfn8Hl
 koyhyj7ioi1H+3FR74FPtCVqefSOps3DjBaEzxvm/wSPAqUO1+xOWSBZB5ABM5ibrJKBc41fzX2f
 c4dPBW7pWChw4uEjGhn8NxWJwjYpP3+Q3/7iG2wtXn9V0g81PkbicsmIyKXNwOrgo+5B/jmqOvZj
 iTeRCozF+pjfbFrzHCaFHgNTrYhVbBAqR8ZRvY88PgTw/yJlftBcHX6tS8NW54gm54VAvfk9VDzu
 2DWvs648c5Z9erCJvcji+JcS2GUvCK1BsRI8tTKkBVM18TehOmSn2kZRt3z8CHTZnKdQqcB0QMMU
 IPF3mL0sZmYqDqSi6Ubx7BN0H0IaZOsZnP36dPZwQWhvr8FGGENbqE9x654AXkUfGHPAHnWD1MEm
 8zNnsSuSxjl6RVTXva2Jl4AHe5oTGEWuK7wQuHiJKcf5Sqd6P3zHxU4Ham35bIM7+pzQRR2+p5za
 8H1gUaDJZGpg6c2oigrh+YcF3SeOS5epce2vBFQn8BLQG4wdJz5OZPl/85ViK8Ea0fe5iniRDU9a
 IkFLX1Ne1hGTitUHsPftyxriH1hAvmSO1crrLwiF2BozUnkjKLcelPzx2oqVYjg7pBU6N7n2Xnf9
 ORWrllgKtBSNx6xUC0rhukb6/HI5FFTbPOoZF9qxZ4vEB++mMxBCD3fThxO9W05FZS/TmgHUSTFx
 Dx7z8+wRG3cXutruHTpS87YkskBoFo6eZ5Uv5yUh4sH+KRvQOJ2675fcuW/3lDmDZZ7XgBhunFdj
 VYxKH3qWyoySMt2NXQeSeCQL64BFVPTx/kcAi/Bxzkn9uvVmO4JooE34GlwX5DwPyzXOCFYHd3xS
 6yFkloFy2DNwOgV373pfDhBQ21Od8BCsodKtWDQizmRHoSVjKnexcCkQ+p5zWKzxeWKxLCyS8776
 l4RSwc4z5cqDb97hdiFVwaP90eVaqnDphEW4xEWnj3iKGpP30awjRzKpQ4kPl+3D1YhNMZlGTB68
 YWMe6VM9RYQVmV8q7nN/oibcn491jt+pt12gBHaGoo19huz2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-17 17:29, Krzysztof Kozlowski wrote:
> On 17/03/2024 16:22, Justin Swartz wrote:
>> On 2024-03-17 17:10, Krzysztof Kozlowski wrote:
>>> On 16/03/2024 16:49, Sergio Paracuellos wrote:
>>>> On Sat, Mar 16, 2024 at 5:54 AM Justin Swartz
>>>> <justin.swartz@risingedge.co.za> wrote:
>>>>> 
>>>>> This set of patches was created with the intention of cleaning up
>>>>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>>>>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>>>>> 
>>>>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>>>>> 
>>>>> [2] 
>>>>> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>>>> 
>>>>> Justin Swartz (14):
>>>>>   mips: dts: ralink: mt7621: reorder cpu node attributes
>>>>>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>>>>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>>>>   mips: dts: ralink: mt7621: reorder sysc node attributes
>>>>>   mips: dts: ralink: mt7621: reorder gpio node attributes
>>>>>   mips: dts: ralink: mt7621: reorder i2c node attributes
>>>>>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>>>>>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>>>>>   mips: dts: ralink: mt7621: reorder mmc node attributes
>>>>>   mips: dts: ralink: mt7621: reorder gic node attributes
>>>>>   mips: dts: ralink: mt7621: reorder ethernet node attributes and
>>>>> kids
>>>>>   mips: dts: ralink: mt7621: reorder pcie node attributes and
>>>>> children
>>>>>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
>>> 
>>> These are all simple cleanups for the same file. It's one patch, not
>>> 15.
>> 
>> I agree these are all simple cleanups.
>> 
>> Even though the cleanup pattern was the same, or very similar,
>> for each node affected, the intention was to isolate each change
>> to a single node (or a grouping of nodes of that seemed logical
>> to me) so that if anyone had any objections, the discussion would
>> be easier to follow in subthreads identifiable by patch names (and
> 
> Objections to what? Coding style? Coding style is defined so you either
> implement it or not... and even if someone disagrees with one line 
> swap,
> why it cannot be done like for every contribution: inline?

I had been asked to include empty lines when I had left them out when
I had contributed a patch regarding the serial nodes, which resulted in
a second version of that patch.


> Organize your patches how described in submitting patches: one per
> logical change. Logical change is to reorder all properties in one 
> file,
> without functional impact.

If I had accidentally deleted or modified an attribute in the process
of cleanup, this could have had a functional impact. It's easier to
notice this sort of omission when the wall of text you're confronted
with is as small as possible, and not multiple pages long.


>> But if there're no objections and it lessens the burden on
>> maintainers upstream to have less patches to apply, then I have no
>> problem combining them into a single patch.
>> 
> 
> Yeah, one review response instead of 14 responses... One commit in the
> history instead of 14.

I agree that 1 commit vs 14 is better.

But for future reference: is it not enough for the Reviewed-by: trailer
to be sent in response to the cover letter of a patch set if a reviewer
has looked at the entire set?

Regards
Justin

