Return-Path: <linux-kernel+bounces-101448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509F87A747
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335F01C22B96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648B3FB01;
	Wed, 13 Mar 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="LcdqIFtr"
Received: from outgoing4.flk.host-h.net (outgoing4.flk.host-h.net [188.40.0.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6743F9C7;
	Wed, 13 Mar 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330740; cv=none; b=o3s8xz4IcUlCSwrZ7Z1bJS0hOTG0uJt6IZben4XFe8KDnXAGUhsaFdqo61iH7bGB2si211epKBEePRz7ujsI+V6r61lxh26wAd4ttEUUNQoK3fzZ+E0eyJqdwhH+0ncyAcDL6l/T6MfMgsOB2C87zeVlWfqHvAWcRjcJ3HjSSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330740; c=relaxed/simple;
	bh=oR32zcbSbD07sD8xPlKozpRT+Tm2pr/c1t+ufn09Jzk=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=pKVgLBstG71NzqwypO6bJXuj6Xu0jVoFra11bbHMN8C7nfjyhJV6uO889vOFhAJ49sW6vjeh4+LbCRFhnohaJcN/pvwEkVarHPRd+llC2Mhv7QFnjn5jCCLhyRWichlUim7y/S120nktFJZgYYI25m2a+0OmmWW6bFfHQKpWKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=LcdqIFtr; arc=none smtp.client-ip=188.40.0.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=kP/x0UCxIGXaYUmSQNq85lpjgX5/E0wqn7vxqxEhUfo=; b=LcdqIFtrdhQeB8
	8k5zjPNEpsUiPgKbFrlAtdamD6V9691rlFLiaAselfqb0TqcgkNS/+D9msF9f4XIdnvYeGlVgE9Mp
	FT+rY7fkOL5AZUeYd+NWioD0fAm+bTZENqfKARGPw7E4f4LtdXoL5/sDXsKoTzPJAwMt4mjvw7J+S
	8nUmbTk2nDxi5Py4PSkg4Qaa9XoaUFn2BzOoC5vXvZoXi1ysqe7w+qUqFk5eoSLQoUOlBpQmD9cUg
	C2xAAb3Fw1hCiSd6UTHvAFT6e1Y+HsTt8OOdvGTEiRaq6gAZ8GyGThhTRX/EgBaIyrgSY5Nd2xHBj
	T8Z5yApQIDh/URhFGvxg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkN9R-00DrWD-Km; Wed, 13 Mar 2024 13:52:08 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rkN9O-0005Os-9C; Wed, 13 Mar 2024 13:52:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 13 Mar 2024 13:52:02 +0200
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
In-Reply-To: <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
References: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
 <20240312192117.7789-1-justin.swartz@risingedge.co.za>
 <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
Message-ID: <e6525cac666a033a5866465abb3e63f1@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/f5ASvLhoONzvM3Neet7I0PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIv+fXqqb3FJ1Z7kkAIev0U9CKH/oA07tJunDPm536TODb5GPR
 oyaaXp1VNA9dXvxV+mFktoWo3CKg4C3LDJ75vu2U4GT70q7ZqN/P49BncZ5XB7lfx9K88uL/WnJE
 LAEP514Y/yfAEbrTclu3OeNcbACmFr3ts0d2E6vXySsvfMaT9Bjf4etJ827HW1/sdZ81dz6BqXHU
 oYg+nmOeSIjjxA24TPuOyBrko5yKpcR03QEJ9DjWmjcfK/FpTD0spWG+rMYoj8CdNq4vLYsMDbt4
 2oUP1Ae/eGZl2OLANHAHEjHENEhX9cq65nsXPA0MIFDIPOMDW/6+MC+5Mq5RH9OoW0W22an/ubzj
 InB/ImqScRfGyrhHVstPeAuxsRhUFJC4TtSvIahFt3uEpT0304dV2Yoz1SesQUA6bnjJZT6m9lal
 9vikoy50DqR3hu/rL5PGAoTDzn0QdoxFeruM0Uhu+VmAdrqarzedA2bamK+XGdcihnVW8zB2Qi26
 vkVALycwzSdeC1kd8cXa71WqOc72jXbRpMw6Agze1f399OurHEyYS7nq+EBNvgiWKNNSkdVDZOrL
 5kxgO94lq2025NSImfKeGaSpuwkt9kMFaoxOFH1hIqsDqiY5NFuEmlCmGLsHMs4VIrisX+dtrxYn
 /0jYEvj5QBAPtzfeVlNHdCJmwgf0M7fnqgzRvCMiN68tcHQey84mBB4XoB473XOJmIRPynE3O7YZ
 oFBs6I7QuC1BjGNT52hVLEr/9PrrMm81h6IAYzikeIJfw26MB/V1E5BP9Gv0xI1YXOxC1lZqyFpL
 AwQr6muMti2YanICQnMITeB2fd0UyjU/MIq3Vtx6CgQGHtezYqxGMqsKjARq8PBC4qgGsfAERwCB
 JFs7XjZYbJPBsmpIto2O4JO2fx1gIuNHgi11AwJSTGCrOFs22K1ZnDqAw3gLmOBPHazhChxq9nGW
 aSi6bFHidB1VgzDzDZn/+QEiRQv+PVjjwa+Z5RFCOMQwU3LvoOQWIGmR34v72byEdfFYVDBYJee7
 gx/u82RtU6CfboKKYz8yU9NdQv+cV8A0mVfWLKEgol9rYV4JEcNP1rJoln/cD8h/RIvkzXRTCYvX
 WLQhlD92+1l+zHfJg1FMwntsduNBxKPaTpE5L8d4VqFy6yKUFQtzhTlGiGL9B0AyxPUbQ/f3iVyf
 P9wHzfAz6SNqPP2zalJxIwFTIvo1IIDSVMZhrIoAWTF5tIdhy/UIEBYDcZg+Q8UhuRLyBn1+pvlH
 hV6a5QjptwQBGybQyDQ2/GYwPjlMcE57ESN6G+kn87CtwPdB/10jfVNpDbYnXJdSRQj8460WHJib
 IxmU2pb4i4DTkMZeMiNI9JSIyUbtnrlbG4BI8o81FOo91axhCaqPShJzgHH7y4ZfQxML
X-Report-Abuse-To: spam@antispamquarantine.host-h.net


On 2024-03-13 10:59, Arınç ÜNAL wrote:
> On 12.03.2024 22:21, Justin Swartz wrote:
>> Increase the MT7530 reset hold period from 1000-1100 usec
>> to 5000-5100 usec.
>> 
>> This should reduce the likelihood of an incorrect external
>> crystal frequency selection which may occur when reset is
>> deasserted too early under certain link conditions.
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>   drivers/net/dsa/mt7530.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
>> index 3c1f65759..5e9e1381a 100644
>> --- a/drivers/net/dsa/mt7530.c
>> +++ b/drivers/net/dsa/mt7530.c
>> @@ -2243,11 +2243,11 @@ mt7530_setup(struct dsa_switch *ds)
>>   	 */
>>   	if (priv->mcm) {
>>   		reset_control_assert(priv->rstc);
>> -		usleep_range(1000, 1100);
>> +		usleep_range(5000, 5100);
>>   		reset_control_deassert(priv->rstc);
>>   	} else {
>>   		gpiod_set_value_cansleep(priv->reset, 0);
>> -		usleep_range(1000, 1100);
>> +		usleep_range(5000, 5100);
>>   		gpiod_set_value_cansleep(priv->reset, 1);
>>   	}
>> 
> 
> Again, the patch subject is missing the indication of a tree. Read the
> networking subsystem (netdev) development page [1].

Thanks for that pointer.


> This ship has sailed anyway. Now the changes the first patch did must 
> be
> reverted too. I will deal with this from now on, you can stop sending
> patches regarding this.

At least if the first patch isn't reverted, the approach used is
less likely to result in the problem occuring, IMHO.

The delay between deliberately switching the LEDs off, instead of
only waiting on chip reset logic to handle that, and the reset
assertion could be considered a "reset setup" period to complement
the original reset hold period.

Increasing the hold period to what should be 5000 - 5100 usec,
definitely made the problem go away my testing, but the previous
approach is (if nothing else) more explicit in its intent.


> [1] 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> Arınç

