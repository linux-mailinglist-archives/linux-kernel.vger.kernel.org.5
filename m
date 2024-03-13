Return-Path: <linux-kernel+bounces-101513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3A87A81D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97061C2195C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787E240860;
	Wed, 13 Mar 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="UpJTz4tI"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84683F9CC;
	Wed, 13 Mar 2024 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335600; cv=none; b=hYh0KTLMyUjFzqwZBpM2KUpXQZ1g7MfWAP1h5J/Elgm5pBQQnhQylsZJF2BgSpshrzkjvtzwr8sutvp4P60F1e9Gy4DKLSupiLVMlyrFXlDcBijz+yBk+aHb/kWS5X0BU0cy4Nf4WnF/HYUvDReuc0ackPgtCHVzaM2Ew8RmEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335600; c=relaxed/simple;
	bh=Svatgyy6s+expfjhx9aXTHe/V9ApXxNo/O+rbKmjHC0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=aaDAVFMJnp913r2xWCRJgzbnFTie2JeShTuM3zYCEMitz9TpbkTWIU4jfqAZplpVe542gdcXOEzv57xEkYWxafGQA7fmrLtUenTUkz/QC+P4yC6r1CzFY4UXi20nTQA1DbSevJbNevi9v1s7NJg6SqW2l7y3TSz+IMEqggMRogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=UpJTz4tI; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=rm25i0KtZLbroTKyEspxu/tszw9xx2JaRN6Tb/VjLTk=; b=UpJTz4tIlEks9c
	9gfFCBYnltVlPj8VxOOHe+St66HK611KEWZ4dFVgP3FVHN5kqPz6dqUEQP3MpA+neQSSJCB7jZjcR
	hcndA08uNj0cz/ZDGqsp+c7PVtAoJP/JHM+7VB2MwHkd9ukp1+qGhHw9+AihWzfk4sreSONHhdQYf
	tdoUiXi8o8dm2FHi3LQZdFN8QjVoCh/2G+yJWnaCk0ECrrXjbx0PJrBvh14BXUKM1Id8DheshpigF
	sccvOzkmfNIDaIPSNVG+NoSN//BEDfYfRgEUpuUaH6MM/FXJhmbjUlw0whrjseNcySzjBrZBBwzEU
	7BvQsAu2PwEaSecTNKlg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkOPs-009hPe-5o; Wed, 13 Mar 2024 15:13:10 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkOPm-0004Bl-Md; Wed, 13 Mar 2024 15:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 13 Mar 2024 15:13:02 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: increase reset hold time
In-Reply-To: <2640a495-97a0-4669-a53a-e367af956a78@arinc9.com>
References: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
 <20240312192117.7789-1-justin.swartz@risingedge.co.za>
 <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
 <e6525cac666a033a5866465abb3e63f1@risingedge.co.za>
 <2640a495-97a0-4669-a53a-e367af956a78@arinc9.com>
Message-ID: <c4590e9519d0cd788d157a1e1510cc45@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.28)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+MZhNT4K8vCZjbDVN6pgqEPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIv+fXqqb3FJ1Z7kkAIev0U9CKH/oA07tJunDPm536TODb5GPR
 oyaaXp1VNA9dXvxV+mFktoWo3CKg4C3LDJ75vu2U4GT70q7ZqN/P49BncZ5XB7lfx9K88uL/WnJE
 LAEP514Y/yfAEbrTclu3OeNcbACmFr3ts0d2E6vXySsvfMaT9Bjf4etJ827HW1/sdZ81dz6BqXHU
 oYg+nmOeSIjjxA24TPuOyBrko5yKpcR03QEJ9DjWmjcfK/FpTD0spWG+rMYoj8CdNq4vLYsMDbt4
 2oUP1Ae/eGZl2OLANHAHEjHENEhX9cq65nsXPA0MIFDIPOMDW/6+MC+5Mq5RH9OoW0W22an/ubzj
 InB/ImqScRfGyrhHVstPeAuxsRhUFJC4TtSvIahFt3uEpT0304dV2Yoz1SesQUA6bnjJZT6m9lal
 9vikoy50DqR3hu/rL5PGAoTDzn0QdoxFeruM0Uhu+WezSndkngXKk6QakCqMR7oihnVW8zB2Qi26
 vkVALycwzSdeC1kd8cXa71WqOc72jXbRpMw6Agze1f399OurHEyYS7nq+EBNvgiWKNNSkdVDZOrL
 5kxgO94lq2025NSImfKeGaSpuwkt9kMFaoxOFH2cp4YsTYwGNGW12ki18UnPMs4VIrisX+dtrxYn
 /0jYEvj5QBAPtzfeVlNHdCJmwgf0M7fnqgzRvCMiN68tcHQey84mBB4XoB473XOJmIRPynE3O7YZ
 oFBs6I7QuC1BjGNT52hVLEr/9PrrMm81h6IAYzikeIJfw26MB/V1E5BP9Gv0xI1YXOxC1lZqyFpL
 AwQr6muMti2YanICQnMITeB2fd0UyjU/MIq3Vtx6CgQGHtezYqxGMqsKjARq8PBC4qgGsfAERwCB
 JFs7XjZYbJPBsmpIto2O4JO2fx1gIuNHgi11AwJSTGCrOFs22K1ZnDqAw3gLmOBPHazhChxq9nGW
 aSi6bFHidB1VgzDzDZn/+QEiRQv+PVjjwa+Z5RFCOMTMctdsTl1csEqhToiNz8IDdfFYVDBYJee7
 gx/u82RtU03xDHIlkkSyUq+ExD5pZzw0mVfWLKEgol9rYV4JEcNP1rJoln/cD8h/RIvkzXRTCYvX
 WLQhlD92+1l+zHfJg1FMwntsduNBxKPaTpE5L8d4VqFy6yKUFQtzhTlGiGL9B5VjLKuX5+25ZPin
 lEh3KIhZW8SlfcXdA5N+Yq1uy1j9IIDSVMZhrIoAWTF5tIdhy/UIEBYDcZg+Q8UhuRLyBn1+pvlH
 hV6a5QjptwQBGybQyDQ2/GYwPjlMcE57ESN6G+kn87CtwPdB/10jfVNpDbYnXJdSRQj8460WHJib
 IxmU2pb4i4DTkMZeMiNI9JSIyUbtnrlbG4BI8o81FOo91axhCaqPShJzgHH7y4ZfQxML
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-13 14:06, Arınç ÜNAL wrote:
> On 13.03.2024 14:52, Justin Swartz wrote:
>> 
>> On 2024-03-13 10:59, Arınç ÜNAL wrote:
>>> This ship has sailed anyway. Now the changes the first patch did must 
>>> be
>>> reverted too. I will deal with this from now on, you can stop sending
>>> patches regarding this.
>> 
>> At least if the first patch isn't reverted, the approach used is
>> less likely to result in the problem occuring, IMHO.
> 
> I disagree that the previous approach is less likely to result in the
> problem occurring. If you don't like the delay amount we agreed on, 
> feel
> free to express a higher amount.

I created and tested a patch to entertain your input about what you
thought could be a suitable hold period to address the problem, and it
appeared to work. The criteria being that the crystal frequency 
selection
was correct over 20 tests.

So if only the reset hold period is going to change, I'm good with what
you had suggested: 5000 - 5100 usec.

Ultimately the selection of this period should be guided by the timing
information provided in a datasheet or design guide from the 
manufacturer.

If you, or anyone else, has such a document that provides this 
information
and is able to confirm or deny speculation about any/all timing periods
related to reset, please do so.


> I also disagree on introducing a solution that is in addition to 
> another
> solution, both of which fix the same problem.

I'm not sure I understand why you say that. These patches were intended
to be applied exclusively, or in other words: in isolation - not 
together.

Although if they were applied together, it wouldn't really matter.

For the record, I've only continued to keep this thread alive in the
hope that some solution to this problem will make it into mainline
eventually.

I don't care if it was my original patch, the subsequent patch, or a
later patch provided by you or someone else. :)


>> 
>> The delay between deliberately switching the LEDs off, instead of
>> only waiting on chip reset logic to handle that, and the reset
>> assertion could be considered a "reset setup" period to complement
>> the original reset hold period.
>> 
>> Increasing the hold period to what should be 5000 - 5100 usec,
>> definitely made the problem go away my testing, but the previous
>> approach is (if nothing else) more explicit in its intent.
> 
> I don't want any unnecessary complications on the code I'm maintaining. 
> I
> already gave a clear intent on the patch log that introduces a simpler 
> and
> more efficient approach, it doesn't need to be on the code.
> 
> Arınç


Kind Regards
Justin

