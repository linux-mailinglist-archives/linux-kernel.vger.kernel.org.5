Return-Path: <linux-kernel+bounces-74873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2885DE30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288791F243D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04B7F7EB;
	Wed, 21 Feb 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aZtIpTgr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BR7FjtBS"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F57F7D6;
	Wed, 21 Feb 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524858; cv=pass; b=jPses5QL8bGMWcx7J9gkpGeDMn4DqeDkomRnchbjS5M+zaTPOGNPKKzjhA1nrdNwRjyoaiTzy9hcJUkoOjtDr1djmhsWGhYW4rt6rUt2M+7YLfBqOLyk320uAf0Rh5APkkhCDV5faW0+qiMDF2siWPp3hhncdsAWS3MhJxV8nxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524858; c=relaxed/simple;
	bh=pi0QTeoqLUA5dmYDVYf3K6m8CWRUvmdoAUIzsn1wTAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTgNOtPpMbWd9nTr0P4qjog0xaG4jZLKspnywW0LlnFCRHLl7U4vGiE232q8GSUUwB+x0z4mqnw7S38GoxZAtK58QIad1ql3TUxSFX8/KFp3sjCbYCE/9P76JW9X6KnGezbnkcj8VSbfXi4ziqIqHmyFt5ZAFubk+hIGGwuJRV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aZtIpTgr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BR7FjtBS; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708524847; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eF7zpziyzn7qfFatPGrSLuoZKqHgAbED3q2DQWAh0F16lqhFhPmy7h1TO0yucGd4Ht
    ch2KYFruI/2dhAF6qAIZSzG8ewmC6RK9u1kuHVZYqvFT7c8B+8yBts2GVgGP5rr60ul0
    0lHFhjc7uj8nW1ykR1f9mvpjEWUpF+BQkLTDLcsjsmKr3zNGfNJNo4Yym8G0QSGD/x52
    6DQkWPNnp3X4XDEWpCobcqrSOWLRKk3p7F52Pqa+HXb1nAwxOXNltyIqu38FGF/gZ+KC
    RzGMSCZzrBTEuvw7cEeOmQMXuZ7gpbxANe3CAxCZ6kvVvoF62C7Td6MRVgewwEo+POHn
    2fkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708524847;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pNmfUJlxupC7lu/MxHbYI/dHRvIwzgDi+MUm9/NBeeQ=;
    b=XFG5G6PDSsXfZRQzW7IMDP/1N2t+tWxmi6b0FSEFn0Xd2HRPgy/Dx5jbI1HDCEOgNh
    E5bHIwYX7Wrr5xSuhIDA86dxiKD8l20kY4aWEYBabDYZ7aCMCJ2MsUhfn/xZCGCnH6it
    9H3p0YfDRCkj/tajRjfQt+Y6CQTVNawoZjipGHk34niVLdWxI4a9EjkGajKRErcvJX39
    NUJv6Tw9lSMn2uQhMEKea0dUcxQ5Gnbp65jzZtadWSOgB30ha1T3cIegdLwA+RVQ7OYf
    1VE44hxyz2vM6FX3Gzt/wtLE/tlZub0JIXQnqJkkdFND2N3SzZX7COB2cJsxKTc5fgMx
    q8Tw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708524847;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pNmfUJlxupC7lu/MxHbYI/dHRvIwzgDi+MUm9/NBeeQ=;
    b=aZtIpTgrrBR/wxkhlAsr0m3oKEFRuqe3XxDAv5nUabSD74row8W+B9fvaxDY/zbDfH
    jiDF5zD1GAG7WAYzc2dC54arK9dBAKprsYg+4DfXp6UlDKjJGerJpBRy2bBiMflDyno4
    D2ckHRe+gfkQeqxr0ehBuLM1CZojsrPMfaQekc9xQ7OI8hbXFOuw0FQ3CV7PwNKRZHJV
    lnq5EdPdV1k1DK11+CjHd6IZRRdpjTlKAUV4EYG/YM6KoRaWNFvPkFOqENAYsrxDJXS/
    8Xgl+PUs2hzfx7i5reNLPj1cj9KqlMd0YRkir5aD18Zjw8h0m1kiURTzbcYRhtCDqMRT
    HFlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708524847;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pNmfUJlxupC7lu/MxHbYI/dHRvIwzgDi+MUm9/NBeeQ=;
    b=BR7FjtBSb695Dxo4QhwEk0KAqx83hUHhhtwes2uCKy3WZcxi0c1krj3P2fbQA2VGV0
    /U2Tbu0uh5ZQopL8WFBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01LEE7EFu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Feb 2024 15:14:07 +0100 (CET)
Message-ID: <54afa5e8-fb5e-4d90-8897-8f3c5a684418@hartkopp.net>
Date: Wed, 21 Feb 2024 15:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: netlink: Fix TDCO calculation using the old data
 bittiming
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
 <CAMZ6Rq+10m=yQ9Cc9gZQegwD=6iCU=s1r78+ogJ4PV0f5_s+tQ@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+10m=yQ9Cc9gZQegwD=6iCU=s1r78+ogJ4PV0f5_s+tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I have an old PCAN USB adapter (Classical CAN) which uses the pcan_usb 
driver and wanted to set a 50kbit/s bitrate:

ip link set can0 up txqueuelen 500 type can bitrate 50000 sjw 4

First it complained about the SJW having a higher value than some 
phase-seg value which was 2.

Error: sjw: 4 greater than phase-seg2: 2.

I always thought the driver automatically adapts the SJW value to the 
highest possible and SJW=4 could always be set. Did this change at a 
certain point?

Anyway, then I reduced the given SJW value and the ip command did not 
give any error message.

But finally there was not CAN traffic possible with my "always working 
setup".

I'm running 6.8.0-rc4-00433-g92a355464776 from Linus' tree.

Reverting this patch fixed my issue.

Best regards,
Oliver


On 07.11.23 03:26, Vincent MAILHOL wrote:
> On Tue. 7 Nov. 2023 at 03:02, Maxime Jayat
> <maxime.jayat@mobile-devices.fr> wrote:
>> The TDCO calculation was done using the currently applied data bittiming,
>> instead of the newly computed data bittiming, which means that the TDCO
>> had an invalid value unless setting the same data bittiming twice.
> 
> Nice catch!
> 
> Moving the can_calc_tdco() before the memcpy(&priv->data_bittiming,
> &dbt, sizeof(dbt)) was one of the last changes I made. And the last
> batch of tests did not catch that. Thanks for the patch!
> 
>> Fixes: d99755f71a80 ("can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)")
>> Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
>> ---
>>   drivers/net/can/dev/netlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 036d85ef07f5..dfdc039d92a6 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -346,7 +346,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>                          /* Neither of TDC parameters nor TDC flags are
>>                           * provided: do calculation
>>                           */
>> -                       can_calc_tdco(&priv->tdc, priv->tdc_const, &priv->data_bittiming,
>> +                       can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
>>                                        &priv->ctrlmode, priv->ctrlmode_supported);
>>                  } /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
>>                     * turned off. TDC is disabled: do nothing
>> --
>> 2.34.1
>>
> 

