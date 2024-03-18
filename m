Return-Path: <linux-kernel+bounces-106035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D423B87E813
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437E01F23691
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA30381AD;
	Mon, 18 Mar 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="F2SDco8b"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447D38DCC;
	Mon, 18 Mar 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759986; cv=none; b=O/KWavonI3qi2pXlyymk8Y7bFJjEQVK/ZkLSgl41pLwwmlymROoSThW+0iUNtfT3aDrNIoryEwfexef23rsV3invoM/fQJjBUiAlRI9B3akEu6iHf9v0SxR77CX4VPO7/ir3e4qcU2Zoh/b8rpiShh6dHHK0oOa+o/jn147ID3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759986; c=relaxed/simple;
	bh=4JcGj1iOgsRaooMehHy5+Ymz3mBcNGp3rkPG+AXYqmM=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=n2L5pOKKeZ+a22M1tmk5ZTaMJ5QlIWS8LnGnn2ispffbuwXqJhmZ7kT77nkAeVqY5OwbdwUxmqudd7mNatlBPiqDWU50lBV9zBqipPhD0unvKbiJG/61APMnSVOypsOscQusfQbAPMr0wPYcim1HyUcGK4tRyAHIF7XWJ4BaztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=F2SDco8b; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=EZ+RYzhu8nBC4S05v34LDNcR3a55K37vUqtB/c+7Oe4=; b=F2SDco8bqCuJDS
	51aCTXUIPJAzBSqpbMN4hOWcAlyYEJHrL0pKmkDZKa3V4LJnjldmghjtFN+iebqGmbeZmDpNYrCEM
	Nj4EncB7XuqvluXFJJYorRoJguyv57CsEiTnUXPkAmjdTjtO1qWS44Y48E6D9GYrhYQ2QZA5laNgv
	bQjBLH8M8voenO4In7wZGCi9zUESuPDccOqsN7E0aW10GXhFV+VZepU3cu+ahKEqsR1fUHiJFvNit
	F0/IQQPfi+Hv660VyooLaFBZl1L02sKwgjx52kr+VpEAe13ogNBWmRJnKCgWgVOUll/D5fiF9wATm
	iBY7zq4B0psRuGYHo+Ow==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmAoq-000rcU-CS; Mon, 18 Mar 2024 13:06:19 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmAop-00049G-Bn; Mon, 18 Mar 2024 13:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Mar 2024 13:06:15 +0200
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
In-Reply-To: <18327bbe-10ad-4b39-ab70-2f74f0d4fb08@linaro.org>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
 <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
 <18327bbe-10ad-4b39-ab70-2f74f0d4fb08@linaro.org>
Message-ID: <8614589cbeb5ca9bd28bb3a34378734d@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+2Mbgfkvmv2eJybW3R3E6yPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNMwpa8J6LDEGB71xpBP9rMN3suOKfn8Hl
 koyhyj7ioi1H+3FR74FPtCVqefSOps3DjBaEzxvm/wSPAqUO1+xOWSBZB5ABM5ibrJKBc41fzX2f
 c4dPBW7pWChw4uEjGhn8NxWJwjYpP3+Q3/7iG2wtXlC2P5rB47V4b9UQ2zWgw8rgo+5B/jmqOvZj
 iTeRCozF+pjfbFrzHCaFHgNTrYhVbBAqR8ZRvY88PgTw/yJlftBcHX6tS8NW54gm54VAvfk9VDzu
 2DWvs648c5Z9erCJvcji+JcS2GUvCK1BsRI8tTKkBVM18TehOmSn2kZRt3z8CHTZnKdQqcB0QMMU
 IPF3mL0sZmYqDqSi6Ubx7BN0H0IaZOsZnP36dPZwQWhvr8FGGENbqE9x654AXkUfGHPAHnWD1MEm
 8zNnsSuSxjl6RVTXva2Jl4AHe5oTGEWuK7wQuHiJKcf5Sqd6P3zHxU4Ham35bIM7+pzQRR2+p5za
 8H1gUaDJZGpg6c2oigrh+YcF3SeOS5epce2vBFQn8BLQG4wdJz5OZPl/85ViK8Ea0fe5iniRDU9a
 IkFLX1Ne1hGTitUHsPftyxriH1hAvmSO1crrLwiF2BozUnkjKLcelPzx2oqVYjg7pBU6N7n2Xnf9
 ORWrllgKtBSNx6xUC0rhukb6/HI5FFTbPOoZF9qxZ4vEB++mMxBCD3fThxO9W05Fm9+rv3zsXbI1
 Zx6qHvQb2XcXutruHTpS87YkskBoFo6eZ5Uv5yUh4sH+KRvQOJ2675fcuW/3lDmDZZ7XgBhunFdj
 VYxKH3qWyoySMt2NXQeSeCQL64BFVPTx/kcAi/BxyOiyAGbikZ2msyovPMmZjc4llXfxglzPppq8
 fnAVuB1y2DNwOgV373pfDhBQ21Od8BCsodKtWDQizmRHoSVjKnexcCkQ+p5zWKzxeWKxLCyS8776
 l4RSwc4z5cqDb97hdiFVwaP90eVaqnDphEW4xEWnj3iKGpP30awjRzKpQ4kPl+3D1YhNMZlGTB68
 YWMe6VM9RYQVmV8q7nN/oibcn491jt+pt12gBHaGoo19huz2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-18 11:23, Krzysztof Kozlowski wrote:
> On 17/03/2024 16:43, Justin Swartz wrote:
>> On 2024-03-17 17:29, Krzysztof Kozlowski wrote:
>>> Objections to what? Coding style? Coding style is defined so you 
>>> either
>>> implement it or not... and even if someone disagrees with one line
>>> swap,
>>> why it cannot be done like for every contribution: inline?
>> 
>> I had been asked to include empty lines when I had left them out when
>> I had contributed a patch regarding the serial nodes, which resulted 
>> in
>> a second version of that patch.
> 
> I don't understand why would that matter. It's expected Linux
> development process to receive comments inline in the patch.


>>> Organize your patches how described in submitting patches: one per
>>> logical change. Logical change is to reorder all properties in one
>>> file,
>>> without functional impact.
>> 
>> If I had accidentally deleted or modified an attribute in the process
>> of cleanup, this could have had a functional impact. It's easier to
> 
> How is it relevant? But you did not and splitting simple cleanup
> one-line-per-patch is not affecting this. Just because you could make
> mistake it does not affect patch readability at all.
> 
> Nothing improved with your patch split.


>> notice this sort of omission when the wall of text you're confronted
>> with is as small as possible, and not multiple pages long.
> 
> We are used to handle some length of patches. Multiple scrolls for
> obvious cleanups are not problems. Why aren't you applying this 
> approach
> to everything? Add a new driver with one function per patch and then
> finally Makefile? It would be bisectable and "easy to read" plus
> absolutely unmanageable.


>> But for future reference: is it not enough for the Reviewed-by: 
>> trailer
>> to be sent in response to the cover letter of a patch set if a 
>> reviewer
>> has looked at the entire set?
> 
> Sure, one can. I still need to open and download 14 patches.

Thanks for your input.

I can imagine how these sets of very minor changes might greatly reduce
your signal-to-noise ratio as an upstream maintainer.

I'll try your suggested approach next time.

