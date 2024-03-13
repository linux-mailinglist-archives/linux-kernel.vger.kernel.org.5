Return-Path: <linux-kernel+bounces-101661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CE87AA01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E4C285E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E066A45028;
	Wed, 13 Mar 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="bpQnl2O5"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE947A6B;
	Wed, 13 Mar 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342311; cv=none; b=mE4tsPyIuNOU7NEgmHXJkxLFOg3zzOJqV+5lD6L5MEoUnpEENGEziqy0TDSdogpF/fGdoPWGu98ZIFLWmcyRhMAB8WhP3Qhp+H6B0uUheuA3XDCB3mI+BbHhHdgw6jiXvFnSTsYff/BWJV73XNkK+SIgCD1okIxVxtqJtX4A2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342311; c=relaxed/simple;
	bh=CDXkMbNP6Dr819keB8cc99FBEz+pFiQXjJqIoMwQ8oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/K+/HL0m5oGY8xzT1R5h3VcLPePcs2G24JQcDN+DAuS+McE8ToPLYV1eVYd264ly4JJne4q+0ytjT1BSlXdv0A+yetUxXrR/tHZAT6JG6f5aWE0ezW8oeHVFGKpVQdF33job3ezR6C/fwtxMSt71tTy9ryXE+NXfybzyNo7Qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=bpQnl2O5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42A22C0012;
	Wed, 13 Mar 2024 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710342301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08xa12eFgF24Q/HExgdKesRSK158jc76k5/A1mMD/dI=;
	b=bpQnl2O53b8VNslubfwlRrs7ImLhnBZRI9miQ9brL4i/HTzsv/LTAj56RocdLqLJLKoGny
	DldxBahLEeGZIYaq6nGvwweoK0RZxxCAGLpB3lUtGBxr0vzg+NePAaMp5QVbvGeTNOhXqY
	0Bd51c+TdsuD0Xjs5lcutZp/YDpwzN3sia8HmJD1NJugiryFPoXi2WHCYtKZMEdjrK+6fD
	VZPX8G0BRxGd4xbw+VUiAMm15m4hi8RtDQ469an0lQU4Vpbaar4bHRzELsSYqWlM8guE4I
	DzGIwsu9iTOhSFm8iVlcemcECjbo8FTzHz/PTrGBZW08zaCt2UjiroNmPTWaMQ==
Message-ID: <997db446-030b-4e6a-beea-0ae7d990e7e2@arinc9.com>
Date: Wed, 13 Mar 2024 18:04:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mt7530: increase reset hold time
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <f594a72a91d12f1d027a06962caa9750@risingedge.co.za>
 <20240312192117.7789-1-justin.swartz@risingedge.co.za>
 <bf0ed70f-e106-4a7f-a98c-de34658feb4d@arinc9.com>
 <e6525cac666a033a5866465abb3e63f1@risingedge.co.za>
 <2640a495-97a0-4669-a53a-e367af956a78@arinc9.com>
 <c4590e9519d0cd788d157a1e1510cc45@risingedge.co.za>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <c4590e9519d0cd788d157a1e1510cc45@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 13.03.2024 16:13, Justin Swartz wrote:
> On 2024-03-13 14:06, Arınç ÜNAL wrote:
>> On 13.03.2024 14:52, Justin Swartz wrote:
>>>
>>> On 2024-03-13 10:59, Arınç ÜNAL wrote:
>>>> This ship has sailed anyway. Now the changes the first patch did must be
>>>> reverted too. I will deal with this from now on, you can stop sending
>>>> patches regarding this.
>>>
>>> At least if the first patch isn't reverted, the approach used is
>>> less likely to result in the problem occuring, IMHO.
>>
>> I disagree that the previous approach is less likely to result in the
>> problem occurring. If you don't like the delay amount we agreed on, feel
>> free to express a higher amount.
> 
> I created and tested a patch to entertain your input about what you
> thought could be a suitable hold period to address the problem, and it
> appeared to work. The criteria being that the crystal frequency selection
> was correct over 20 tests.
> 
> So if only the reset hold period is going to change, I'm good with what
> you had suggested: 5000 - 5100 usec.
> 
> Ultimately the selection of this period should be guided by the timing
> information provided in a datasheet or design guide from the manufacturer.

That's a good point, I agree.

> 
> If you, or anyone else, has such a document that provides this information
> and is able to confirm or deny speculation about any/all timing periods
> related to reset, please do so.

These are the documents I use to program this switch family. I did not
stumble upon a page going over this.

MT7621 Giga Switch Programming Guide v0.3:

https://github.com/vschagen/documents/blob/main/MT7621_ProgrammingGuide_GSW_v0_3.pdf

MT7531 switch chip datasheet:

https://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents

> 
> 
>> I also disagree on introducing a solution that is in addition to another
>> solution, both of which fix the same problem.
> 
> I'm not sure I understand why you say that. These patches were intended
> to be applied exclusively, or in other words: in isolation - not together.
> 
> Although if they were applied together, it wouldn't really matter.
> 
> For the record, I've only continued to keep this thread alive in the
> hope that some solution to this problem will make it into mainline
> eventually.
> 
> I don't care if it was my original patch, the subsequent patch, or a
> later patch provided by you or someone else. :)

I think you've missed that your patch is already applied. And it won't be
reverted for reasons explained by Paolo in this mail thread.

https://git.kernel.org/netdev/net-next/c/2920dd92b980

So if your patch here were to be applied too, the final mt7530.c would have
the LEDs disabled AND before reset deassertion delay increased.

Arınç

