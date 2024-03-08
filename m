Return-Path: <linux-kernel+bounces-97377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2768769B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B07DB23B03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EF2D627;
	Fri,  8 Mar 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="dBaP8mSR"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D272282E1;
	Fri,  8 Mar 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918384; cv=none; b=k2LwKnBkhEHE5zjcH5ysM+DqEdZiQ3iH0HiKGTmrVBR+8Hh0//m51V2xHIFzWDbikQoSDmA7vH8udhuf/7py7PjDN+9cV8covmNgPS0MrkiFkxALf9e5M9N3z5iQ5qoEUs3BOYkE21K0ExhzcgbNX6rjV3xJHytyZGHyXeQle2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918384; c=relaxed/simple;
	bh=pu2djzYCt+PJn5YBXm8TLI2sMKIP9W9f6BUNV602+hI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=fL8Dv44n/mWRmD25Wci4m4Z0H99NHDtkOGk8I1oecBvXgqUJ1Hzdu6ttE60dv/Q2OM+jWMsFY7sYd5bKRZ71mh4uHnWEX+VS0q/BHYh/vhH4qUHXYi2/Uzh7CjBzgummFxit48MUx2FEZn+lGVIS/FWm+94kQZYsvKMcNx4AJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=dBaP8mSR; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=a/vpHfNPzt7TGK8d8dpGB4WwTK9WQCuP3uAyqQISEGU=; b=dBaP8mSRxS4lEh
	GjSu90TDy9meTMekBLoEETSGJKVQBi0b/AW97xPPf57MxSW3J5rxw9NCeTPn1JaIT2HNHhtsr0KtF
	Gk6aloHiLLFM6fFHsFS4ztSXtFk6SMBsVQcVoLnPBfDWsT9nUbneatAR/jesh+fdBPtFhereWT17F
	qdQV4Ot2qVtE+C5bc1ZNbWD+iOrDN60fWpcUpYmFME4ONWJVjiKXJo075hI30XK4NFf8UnkTEi5HC
	Ynyu3URiYC8wievULGd5b3QG93hU/Nx8WE/RuhnlHOpTrXZTE3oQChFfbdRUDjFuc9H9BRYxMBdKT
	c8+/MvAjLZWq6NYA0URA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1ridsc-00EpVe-3q; Fri, 08 Mar 2024 19:19:36 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1ridsa-0007Bk-MV; Fri, 08 Mar 2024 19:19:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 08 Mar 2024 19:19:32 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Sergio
 Paracuellos <sergio.paracuellos@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/3] mips: dts: ralink: mt7621: associate uart1_pins
 with serial0
In-Reply-To: <eec5be72-e27f-4068-ac7a-566605f3256c@linaro.org>
References: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
 <20240308155616.11742-2-justin.swartz@risingedge.co.za>
 <70822db4-d642-4180-9db8-eb0aa5728ef1@arinc9.com>
 <bec06da5c4099898d9e531181d0797ca@risingedge.co.za>
 <eec5be72-e27f-4068-ac7a-566605f3256c@linaro.org>
Message-ID: <0ad4df2896fe0a3db06d3bcacbcf5931@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8Wv6VWwHFMFDV5KaGg4k2APUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJvXeR9sWP3X7B861DTGeXmiBZB5ABM5ibrJKBc41fzX2f
 c4dPBW7pWChw4uEjGhn8NxWJwjYpP3+Q3/7iG2wtXpUcDQ6SyB7RUHhtw6evVjjgo+5B/jmqOvZj
 iTeRCozF+pjfbFrzHCaFHgNTrYhVbBAqR8ZRvY88PgTw/yJlftBcHX6tS8NW54gm54VAvfk9VDzu
 2DWvs648c5Z9erCJvQs7NHJCRvPPwtX/YZRy1/6kBVM18TehOmSn2kZRt3z8CHTZnKdQqcB0QMMU
 IPF3mL0sZmYqDqSi6Ubx7BN0H0IaZOsZnP36dPZwQWhvr8FGGENbqE9x654AXkUfGHPAHnWD1MEm
 8zNnsSuSxjl6RVTXva2Jl4AHe5oTGEWuK7wQuHiJKcf5Sqd6P3zHxU4Ham35bIM7+pzQRR2+p5za
 8H1gUaDJZGpg6c2oigrh+YcF3SeOS5epce2vBFQn8BLQG4wdJz5OZPl/85ViK8Ea0fe5iniRDU9a
 IkFLX1Ne1hGTitUHsPftyxriH1hAvmSO1crrLwiF2BozUnkjKLcelPzx2oqVYjg7pBU6N7n2Xnf9
 ORWrllgKtBSNx6xUC0rhukb6/HI5FFTbPOoZF9qxZ4vf24IFf3S/QstrsvmHry2RQMdJZ93srF2r
 +35mEt2FC3cXutruHTpS87YkskBoFo6eZ5Uv5yUh4sH+KRvQOJ2675fcuW/3lDmDZZ7XgBhunFdj
 VYxKH3qWyoySMt2NXQeSeCQL64BFVPTx/kcAi/BxxCuBHKZE9WCF1zdBVVT8jZUewdfxHtr3FaH+
 eXAry2dy2DNwOgV373pfDhBQ21Od8BCsodKtWDQizmRHoSVjKnexcCkQ+p5zWKzxeWKxLCyS8776
 l4RSwc4z5cqDb97hdiFVwaP90eVaqnDphEW4xEWnj3iKGpP30awjRzKpQ4kPl+3D1YhNMZlGTB68
 YWMe6VM9RYQVmV8q7nN/oibcn491jt+pt12gBHaGoo19huz2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-08 19:13, Krzysztof Kozlowski wrote:
> On 08/03/2024 18:01, Justin Swartz wrote:
>> On 2024-03-08 18:14, Arınç ÜNAL wrote:
>>> On 08/03/2024 18:56, Justin Swartz wrote:
>>>> Add missing pinctrl-name and pinctrl-0 properties to declare
>>>> that the uart1_pins group is associated with serial0.
>>>> 
>>>> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>> 
>>> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> 
>>> Please add the trailers from previous patch versions from now on.
>> 
>> What do you mean by trailers?
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Thanks, Krzysztof.

I thought I had done this with this patchset on all three patches,
but if I've accidentally left anyone out - sorry about that.

Regards
Justin

