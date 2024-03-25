Return-Path: <linux-kernel+bounces-118037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32B88B2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B879630926D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360C6E5FD;
	Mon, 25 Mar 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os2uLtdZ"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60C481A3;
	Mon, 25 Mar 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402031; cv=none; b=EEtHYnW5RQ43r/nTP5TQS2xnqhwJ9ObKIHlIGMdkYOIOuS0+8yvaw3iBypWhMH0ZQD+5K6IcMTO86LHqy2k9BTmqOGRkG2GrPeeghvJrCC5lcQ1bi4dvqO3tfpw4jxmf/+FGx+6d89xqxZg+OvuwWT33TlKCvfEinyfhbV1xUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402031; c=relaxed/simple;
	bh=Kd3xmesa4LEqQaLnoE03Qd2vDqHAxmlJBp5wo9yPs2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dwqt2QtYMxhZbqMdXZgqLhPZsi2HWEqUwBRZy/Es55Qbtgp8AK7OagIkiuZmBjfp9e4KuRWDm1inuqMvMnHDt162wS6iIcggu5xH+rSUAPvO8db2Q2AEKUgPhm3f2WbfcG05UelsJSF4VcxYmYZVx+d8mPurS/CttGcvVQ82Ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os2uLtdZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789d0c90cadso326141785a.3;
        Mon, 25 Mar 2024 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711402028; x=1712006828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcXGrDwZYrN1zzru3Wgu6jq53rbOZgHObeSUTM5zESU=;
        b=Os2uLtdZqH4lS8a79+gqV231ea3YGDkMw4Cu1M7vLJJcYjm+UD1Xp+JmdxC2IVJAXp
         uUFuBtYu8Av3CkoQFXyDTesMHOiMfOeNxVp0y413I2BbvvrdM4TPLw3d7lYX6zfjyOnG
         SWHr4ym+qXqIX0wv43mdJo4+5v9kKU0tLhTI3ny2Y7by7JhB2NfLjlUXfOjUVybRTZ9M
         M1viemY/ETD4u8UvtgXAst/FZEh6ggXOgqBVwAHNTErg2X9h2lG3Syou9rztlLBEpsIw
         tmqYRAOGGXRLD1yEB8DZgQi0LrhrOEgT/lF9/6Rju7gSzxBDNfjitBAbT6CZxT1TBZXc
         g2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402028; x=1712006828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcXGrDwZYrN1zzru3Wgu6jq53rbOZgHObeSUTM5zESU=;
        b=YZeD/MtfsAZz5n/SkNMCExQHlh67WshfVNmV2ZdAZKwYF5iC5ON+tu9m9j1omp0D8e
         kvEBXv/sEul9glKi1CNPqyZQ74u4mFRcUPzu11i1sNGxvvzQzUnQ8tQ+6g0gKG/Med0T
         jFWIrVPwreH/aumfWODXN0wptW9oNWH6w4je90xJK2Iogc9oX7sPvkhcafwPEpcWfyYY
         B296kkx/08frQDX96OaZPy7zaTBr647GYMN1A4LEEMfSrIk98ElANuBYXB0er1TxW2iA
         hmolOJsB6HLP7v3OG1sQ+GCy4kCfnjFgHTId3v1XwJk19WaYaImxGOJ3uogvSsZ0b312
         nJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoIyZRLypWSdzc9SEy3h+MXVUbozUzAZfjibQ6AQnDwqvSakZGY89cx4/b4YPnJwqZ31RfdvHawoeiPtlYpYU8ri/HL/WonKhcNw0GhYL6dfcAEkYYfMfFfXEAA3Jj+zDxasTs
X-Gm-Message-State: AOJu0Yw3YHNxiI6bb0IkESR+OaCatbnWELlEmJd5HFCwLhu0NB5dpr9+
	1e2B6uwAvEN8PAuXBfNzze4Hq56AFLMWSICexP4mrHEZBp++/wHf
X-Google-Smtp-Source: AGHT+IEli7TvZHtKaTgDAw8FiZsX/v6sEKF1C9dbpcgJ9fz2dinBG2o+Fvo2t6S/L4KYj7VvPdlpNw==
X-Received: by 2002:a05:620a:3781:b0:78a:e5f:1595 with SMTP id pi1-20020a05620a378100b0078a0e5f1595mr8105239qkn.45.1711402028153;
        Mon, 25 Mar 2024 14:27:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i10-20020ae9ee0a000000b00787fd080d28sm2437251qkg.74.2024.03.25.14.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:27:07 -0700 (PDT)
Message-ID: <0976fbf5-efb4-4fe6-a68d-28a79309cd05@gmail.com>
Date: Mon, 25 Mar 2024 14:27:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Content-Language: en-US
To: John Ernberg <john.ernberg@actia.se>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
 <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
 <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
 <ZfsUvm9YC5O7il3h@shell.armlinux.org.uk>
 <7f0e5f8b-fb85-4f2b-8d77-4170366a1b55@gmail.com>
 <Zfs8hWo/aVbvuAgm@shell.armlinux.org.uk>
 <efffa6e6-f519-4424-8d58-0951e7c68f27@actia.se>
 <27453913-d4a3-4535-8cf5-2f5f3eb6c7b7@gmail.com>
 <ed6da286-eba7-4fae-882b-bb960a613dac@actia.se>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ed6da286-eba7-4fae-882b-bb960a613dac@actia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/24 05:20, John Ernberg wrote:
> Hi Florian,
> 
> On 3/21/24 17:13, Florian Fainelli wrote:
>> On 3/21/24 09:02, John Ernberg wrote:
>>> Hi Russell,
>>>
>>> On 3/20/24 20:44, Russell King (Oracle) wrote:
>>>> On Wed, Mar 20, 2024 at 10:13:55AM -0700, Florian Fainelli wrote:
>>>>>
>>>>>
>>>>> On 3/20/2024 9:54 AM, Russell King (Oracle) wrote:
>>>>>> On Wed, Mar 20, 2024 at 03:25:54PM +0000, John Ernberg wrote:
>>>>>>> Hi Russel,
>>>>>>
>>>>>> Growl. Hi Peter.
>>>>>>
>>>>>>> What we really want is the PHY to be suspended on suspend to RAM
>>>>>>> regardless of us having had an initial link up or not.
>>>>>>
>>>>>> So what you're asking is for the PHY to be suspended when the system
>>>>>> is entering suspend, which is a long time after the system booted and
>>>>>> thus phy_probe() was called, and could be some time before the system
>>>>>> resumes.
>>>>>>
>>>>>> I'm not sure what the relevance is of phy_probe() that was brought up
>>>>>> previously then.
>>>>>>
>>>>>>> This worked prior to 4c0d2e96ba05 ("net: phy: consider that
>>>>>>> suspend2ram
>>>>>>> may cut
>>>>>>> off PHY power") which was added in Linux 5.11, and 557d5dc83f68
>>>>>>> ("net:
>>>>>>> fec: use
>>>>>>> mac-managed PHY PM") which was added in Linux 5.12.
>>>>>>
>>>>>> Looking at the former commit, that looks to me like it is only
>>>>>> affecting the resume paths, not the suspend paths, so wouldn't have
>>>>>> any impact itself on what happens when suspend happens.
>>>>>>
>>>>>> The latter commit states that it is a work around for an issue with a
>>>>>> particular PHY. What happens if you revert just this commit, does your
>>>>>> problem then go away?
>>>
>>> Our PHY does not begin working again without reverting both.
>>> phy_init_hw()
>>> will remain an issue if it occurs after phy_start().
>>>
>>> The commit message in 557d5dc83f68 is not explaining nearly enough, I
>>> spent a
>>> few days on it before I proved that commit to be nearly correct (See
>>> whole
>>> thread at [1]), it happened to just explode with that PHY. The issue is a
>>> sequencing issue that was made more prominent by 4c0d2e96ba05, but it
>>> existed
>>> since around 2008. Because FEC is both MDIO controller and MAC,
>>> meaning the
>>> resume of the link in a link up case runs phy_start() in the FEC resume
>>> function, which will trigger a mdio bus resume when it completes, in turn
>>> calling phy_init_hw() (before 4c0d2e96ba05 it was phy_resume() which
>>> wasn't a
>>> problem but still wrong sequence wise).
>>>
>>>>>>
>>>>>> Also, please clarify. It seems that you are reporting a regression -
>>>>>> it used to work for you prior to 557d5dc83f68, but 557d5dc83f68 stops
>>>>>> it working for you?
>>>>>>
>>>>>>> Since FEC requires mac_managed_pm the generic PM suspend-resume paths
>>>>>>> are not
>>>>>>> taken. The resume sequencing with generic PM has been broken with the
>>>>>>> FEC since
>>>>>>> generic PM of the mdio bus was added, as the FEC will do phy_start()
>>>>>>> (via FEC
>>>>>>> resume) and then generic PM runs phy_init_hw() via mdio bus resume
>>>>>>> (previously:
>>>>>>> less damaging phy_resume()) due to how the FEC IP block works.
>>>>>>
>>>>>> That suggests that even with 557d5dc83f68 reverted, it's broken.
>>>>>> Digging into the history, what you're referring to dates from January
>>>>>> 2016, so are you reporting a regression that occured 8 _years_ ago,
>>>>>> at which point I'd question why it's taken 8 years.
>>>
>>> A revert of those is absolutely wrong. Those commits are fixing bigger
>>> issues.
>>>
>>>>>>
>>>>>> Given the time that has passed, I don't think reverting commits is
>>>>>> a sane approach. Quite what the right solution is though, I'm not
>>>>>> sure.
>>>>>>
>>>>>>     From the description and the commits pointed to, I just don't see
>>>>>> that there is anything that could've changed with respect to the first
>>>>>> boot - if that has changed, then I think more research into what
>>>>>> caused
>>>>>> it is needed.
>>>>>>
>>>>>> If it's the subsequent state after a suspend-resume cycle, then yes,
>>>>>> I would agree that its possible that these changes broke this for you.
>>>>>> Would clearing ndev->phydev->mac_managed_pm just before
>>>>>> phy_disconnect() in fec_enet_close() fix it for you, so the suspend/
>>>>>> resume paths for the PHY get used when the network interface is down?
>>>>>>
>>>>>> Maybe, however, that's something that should happen in any case inside
>>>>>> phylib on phy_disconnect() as a matter of course, since the PHY will
>>>>>> at that point be no longer under the control of the network driver for
>>>>>> PM purposes. Could you give this idea a try please?
>>>>>>
>>>>>
>>>>> On phy_disconnect() we will do a phy_detach() which calls
>>>>> phy_suspend().
>>>>> Given that phy_disconnect() is called from fec_enet_close(), we
>>>>> still have a
>>>>> MDIO bus registered and we are not trying to suspend the MDIO bus,
>>>>> so we
>>>>> should have an effective phy_suspend() call here, what am I missing?
>>>>
>>>> I didn't look there, but if that is the case, then what is John's
>>>> problem - I can't figure it out, something isn't adding up here.
>>>>
>>>
>>> I could instead add extra phy_suspend() in the suspend path if the
>>> link is
>>> down and the FEC is up and running. I rejected it originally thinking
>>> it was
>>> a much dirtier fix, but maybe that is the more correct thing to do?
>>
>> This does not seem like the proper solution, the only time where an
>> explicit phy_suspend() should be done in the Ethernet MAC's ->suspend()
>> routine is if the network device was brought up at the time
>> (netif_runninng() returns true) *and* you set mac_managed_pm = true
>> because you must precisely control the order in which the MAC and the
>> PHY get suspended with respect to each other (typically because the PHY
>> supplies a RX clock back to the MAC, and some of the MAC logic depends
>> upon it to operate properly, e.g.: perform a proper FIFO flush etc.).
> 
> I'm having some trouble understanding your message in context of my most
> recent reply to Russell, so please bear with me here as I will
> potentially ask a really dumb question:
> 
> Do I understand this correctly as what used to work in 5.10 was never
> meant to work and the behavior now is the correct one in the FEC case?

I am not sure about that, because I do not believe this had been 
explicitly accounted for, and that is what I am also trying to figure out.

> Meaning that if the link has never been up the PHY must never be handled
> from a power management perspective?

Let's stray away from saying "link is UP" but instead say interface 
administratively brought up (ip link set dev <foo> up) so we are on the 
same page.

> 
> The only PHY examples I have come across (though not many in total) the
> PHY has done some initial configuration of itself after POR or release
> of the reset line.
> 
>>
>>   From there, I see two distinct cases:
>>
>> - the network device driver probed, but the network device was never
>> brought up in the first place in that case, I do not see a path whereby
>> the PHY would have been suspended, unless the boot firmware already took
>> care of that (which arguably it should if you are trying to be as power
>> efficient as possible), although arguably there could be a path within
>> the kernel where this is also done. It could get really complicated however
> 
> Generic PM via mdio_bus_phy_suspend() will suspend the PHY if it has a
> .suspend callback and mac_managed_pm isn't set.

Correct.

> 
> mdio_bus_phy_may_suspend() will see that netdev is NULL, which means it
> returns the inverse of phy->suspended (which is false), meaning the
> function returns true. Thus phy_suspend() is called.

OK, so right there is where you were were basically depending upon 
mdio_bus_phy_may_suspend() being called to suspend your PHY device! I 
don't think this had ever been envisioned to be working that way, if it 
did that was a byproduct rather than a contract. Introducing 
mac_managed_pm certainly did break that contract because now we no 
longer have that "double" suspend and resume that used to happen.

> 
>>
>> - the network device driver probed, and the network device was brought
>> up at least once (regardless of whether a link state was detected or
>> not), such that the PHY has gone through a phy_start()/phy_stop() cycle,
>> and upon phy_stop() a phy_suspend() has been called
>>
>> It is safe to assume you fall in the first case only, or do you also see
>> a problem in the second case as well?
> 
> There is only a problem in the first case. The second case is working as
> expected.

Thanks for the clarification.
-- 
Florian


