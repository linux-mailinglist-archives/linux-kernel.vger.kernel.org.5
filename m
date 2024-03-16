Return-Path: <linux-kernel+bounces-105193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6487DA5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19C61F2180A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B57A18EB0;
	Sat, 16 Mar 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="Eb1yFjOR"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20CEAEB;
	Sat, 16 Mar 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597800; cv=none; b=WRCs3lQLUXkT530uYWyq0HU6igcxmaCEvdSrf5QBfc+D7AL8x92ndkPdlpwcONAm2DvTaCSlB/gnqpIRLOzyTnEg+CQsI4JmsBpXOPhbnfnqZ1xC4F7y7903b46Msmq4Ecw8xqpAJJYtUEZ1ldOVr1cGAIN0CJzeS1Tuo+RpZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597800; c=relaxed/simple;
	bh=BS1PK3qoqrGZE+ZA9VsKpv7aoKhXMXaTQxyTFJtX1BE=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=X9reCVYtAGbQR/bfu2TdLhuSOSjgQ/bBsZK4OaHKPg/IcAN9/PINS8dkqsaeUXx09scEU4Ugk5yDA0G5EQXpgdfMFbk8vt2/NgDWLd9rVRDEy1ZOClSvEIkxjizi9LBrjBMy4uwQVO5NR6RqkoyTtqHouYFqnP9roP9To8xREWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=Eb1yFjOR; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=gmrczaOhlAucHh9+mNoIwUjFZ3eZSylCEeQeqB6Qn/4=; b=Eb1yFjOROSkwGC
	lAyQ3yEs0n+Argh8f6bIBP19P4LQUksFRM1Nb1Eoo+dhXVoY2vKXhnWygt9EFwXZY45q7pLmg433d
	LQbng8aMKrGbbiMpFiWzbSdpvn2IuiVzrhKxVOTB+dXe1fGl6o1RsgbWPxCkL5ujRb8i0TXxY0YTs
	BY70wP+cY5G2oPDdeley6F3OGVhQ2hJPIrLUVKl+aaxGFi/FBiebuYYDpos08wX12tshqr+1I1YU9
	PTRogQrm5TWW89/ldvXbtEZ3ljRJDlflg7p2wJebsJJP2U7ywdlAyxqTFqyPzV0MKCnAPuzOpwFGC
	fUXp7px69M9DTbWuvTTA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlUco-001TB0-6N; Sat, 16 Mar 2024 16:03:05 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlUcm-0001sp-OC; Sat, 16 Mar 2024 16:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Sat, 16 Mar 2024 16:03:00 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
In-Reply-To: <31b3d00f-6cf4-4bf8-ad78-a8354d57c518@arinc9.com>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <31b3d00f-6cf4-4bf8-ad78-a8354d57c518@arinc9.com>
Message-ID: <c7eb79ee77542db3a539d8bb7719dba9@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9i+OtSoA78SfwGCJVi3LtnPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3FOty77OmI9XlaAJpX2qfax0
 xYCHwzEoZpUBagq+YQPMLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30/jNv+A51L2swh0gYW0eVWShle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 AHYPcQ0eIL+UT9voGXmPy4gA6hyxsNfrkhMdzrtm39J4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV9tc
 xZF8I+FDjZqH3AmOvbgLx2C4ory8kLqkdy3XI1++Ibtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-16 11:24, Arınç ÜNAL wrote:
> On 16.03.2024 07:54, Justin Swartz wrote:
>> This set of patches was created with the intention of cleaning up
>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>> 
>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>> 
>> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>> 
>> Justin Swartz (14):
>>    mips: dts: ralink: mt7621: reorder cpu node attributes
>>    mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>    mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>    mips: dts: ralink: mt7621: reorder sysc node attributes
>>    mips: dts: ralink: mt7621: reorder gpio node attributes
>>    mips: dts: ralink: mt7621: reorder i2c node attributes
>>    mips: dts: ralink: mt7621: reorder spi0 node attributes
>>    mips: dts: ralink: mt7621: move pinctrl and sort its children
>>    mips: dts: ralink: mt7621: reorder mmc node attributes
>>    mips: dts: ralink: mt7621: reorder gic node attributes
>>    mips: dts: ralink: mt7621: reorder ethernet node attributes and 
>> kids
>>    mips: dts: ralink: mt7621: reorder pcie node attributes and 
>> children
>>    mips: dts: ralink: mt7621: reorder pci?_phy attributes
>>    mips: dts: ralink: mt7621: reorder the attributes of the root node
>> 
>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 430 
>> ++++++++++++++------------
>>   1 file changed, 239 insertions(+), 191 deletions(-)
> 
> A well done patch series. Thank you very much for doing this!
> 
> Arınç

++ for reviewing them all.

As you have at least one board that features an MT7621 SoC,
please may you (and anyone else willing) take a look at a
patch [1] that I've submitted for spi-mt7621.c which allows
GPIO chip select lines to be used as well as the native chip
selects.

There's already been some back and forth with Mark Brown about
the initial version of the patch (the linked patch is v2) and,
of course I messed up how I send v2, as you'll read in the thread.

It seems you weren't included because I rely on [2] to determine
which people to address as maintainers when sending patches.

Is there a better approach for populating git send's --to argument?

Regards
Justin


[1] 
https://lore.kernel.org/linux-mediatek/20240316010302.20776-1-justin.swartz@risingedge.co.za/

[2] scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats 
--nol

