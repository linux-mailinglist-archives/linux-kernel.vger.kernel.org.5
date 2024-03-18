Return-Path: <linux-kernel+bounces-106026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A148687E7D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6D2817AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CF2FE3E;
	Mon, 18 Mar 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="JVIJ7Mpm"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C8364AA;
	Mon, 18 Mar 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759464; cv=none; b=lsWVUR/AnWBXaRTwAE3v3P0ENCsXS0mTbIxZyPE60UTNUcAATj1jZq4JRuSle+YruIdTZqRnKma44+jbuDDZA8+fYiUJmJaMSVEZBQp674dZSM2S8i1QYHZDLg7U2Fx2dulS2iqlA5mI9bOngpgGU1jrB7IS61L4pEbbGV73GtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759464; c=relaxed/simple;
	bh=MWTf8fkNQ2QCgpFxTZvn5qcwx9xBfiKmXj3w2Usv5hg=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=eRfzW1BytnaWyUvykH5wuawsem41P28pD1+cYr/xxDgftLEqxJsLWHPh/LLff4IX6YPZnrDrvCrNs6wwp5hPMeAVvHTiKFLJATSw5x5ovGMgrMFkDoYfNIQIdEhaQXlrQrWPdIMEBVJh1Kl9iwK5QX5pa1JvFzsQnKPKj8fsq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=JVIJ7Mpm; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=OYVkuxYH48Jn2o5BWCgkp6UzoiSG4Lirr71ccRWrpI0=; b=JVIJ7MpmFJ7+9n
	ewbSIFtxi9OYXnp95IC8uD3sMn8NF4l144+umswJSQRi0qqnGlEg4DwbkBOGP6rkGa+rwy02CYdz2
	n/5qZks4Anz280ujPMfkJSSEJVF+zXB1JFmpltChHOywCB0JN54SHadzFUoy4CtJZLjP+ayJcho/1
	EwcqkawJhTgbp5ob7t3ORt0YotwUU4EafawgXggYc2maTuKx1omTlpJQbe5i5SPUzGK2SIOnwp9G1
	SYkk4gt/+DKRceWmY/9l+TyBg6PPcMX3QrKkpod0hQF173hmJyi1vH73lNL3jnPrV57sTeXXYYUmV
	f4SnItL++raFL96+FTdw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmAgG-00D3tt-SA; Mon, 18 Mar 2024 12:57:27 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmAgE-0003Z9-91; Mon, 18 Mar 2024 12:57:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 18 Mar 2024 12:57:22 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
In-Reply-To: <CAMhs-H_1bwfKO8yquz-3BHQ0UQYW1FFVJYHE66w8Q9m1+fCCHw@mail.gmail.com>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
 <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
 <CAMhs-H_1bwfKO8yquz-3BHQ0UQYW1FFVJYHE66w8Q9m1+fCCHw@mail.gmail.com>
Message-ID: <c2b8e6e52468fa9fa62da4c66689306f@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8CUKWN3S0rKpOTOocUYUj1PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNMwpa8J6LDEGB71xpBP9rMN3suOKfn8Hl
 koyhyj7ioi1H+3FR74FPtCVqefSOps3D+BsRiAfACpgn8kblwE1ZM57Ph7wksNU44DWpObor+fqr
 AP5R/Cae/ZemygD++WnmLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30+tdk6yIuh9K7v+Nq0Cm3JVhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 dBMSQgQtiTUcJp5roVy0aeoLdGEqJusV1340htLevvx4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV40p
 dJLitcoGgbEqkFmuUJ3wODI4njOoaB5WEUmF8qr+Ibtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-18 10:48, Sergio Paracuellos wrote:
> On Sun, Mar 17, 2024 at 4:43 PM Justin Swartz
> <justin.swartz@risingedge.co.za> wrote:
>> But for future reference: is it not enough for the Reviewed-by: 
>> trailer
>> to be sent in response to the cover letter of a patch set if a 
>> reviewer
>> has looked at the entire set?
> 
> It is enough, AFAICT. I found your patchset very easy to review so I
> am ok with the patchset as it is. However, at the end this will be
> through the mips tree, so let's do what Thomas prefers: add all
> patches as they are or squash all of them in one commit.
> 
> Thanks,
>     Sergio Paracuellos

Thank you for the review. I'm glad to squash them if need be.

