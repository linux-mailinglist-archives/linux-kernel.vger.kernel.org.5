Return-Path: <linux-kernel+bounces-82099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F778867F54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A9DB27692
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C312E1FB;
	Mon, 26 Feb 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HUmKJgWy"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F512CD89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969812; cv=none; b=Sia+mKwZVFCz9j2C+lQNJI4KLtnQum1W5FZJ76XLDJZlOgTIkqvb4r3TLsTWMbpv9M8DNAgimVtan8SiV1i+v/41yLlGrRmiS0z9w1gJlrCO22O9OHrSaekxOZ7VDWMRFvTo2wfIBzicLdxSLCqSXf9yj9wpOF4J9KOlr9lbzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969812; c=relaxed/simple;
	bh=Yr7g3zKNnMRw4lebe/AYlDELyuKSE781v4vikkRqf7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQOxjAVASQQ59B2hgKnvxpi5M63EXUxJ0SVvs565lnmk3s3mR/StJ0J9luQ/YvdfBMqWnWFUetj14eiIPe08ht1jTYi3Mw9Rk6oATU6V1mkvt3hFAeLsaE7xbPW1d4+VOQz9DunsiebASIvAp6nPot0ZARK9SJfY9+SKeK+Lvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HUmKJgWy; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69012259657so1855756d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708969809; x=1709574609; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49U9KfP28yyMJe+bXfUWM7UkIlQs2DgojUBtQREPrY8=;
        b=HUmKJgWy9/fHUnDpPPD9ljD2gYEzVNJkWmvDNqIdZykhcLh4T/w4pn2no2KE2UOORw
         55dMyjVmJVenuE0LOlem14CBgFnTfaABY7XxzabAtfbMLjEPD4D6qQZIqB6Gn2akRZ8P
         UYnlC/F77qu6WyPa7FNWsCRf00sauEtnjCGy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969809; x=1709574609;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=49U9KfP28yyMJe+bXfUWM7UkIlQs2DgojUBtQREPrY8=;
        b=uU3SktX36xU+smVYQ0WeDcwCdeGhg+gD9yHoOkD+N/bp47w/CA5z/3OHRQOppeHVn3
         tPD2feMvDU2CeLxnsN+MuAnv7TwcTfYaK+zO4COMgeyhmhts560m4ID7GlvCbz9uUE5H
         cZ9KXkAdCwqswd1BpuOE4gafo66LJDgWxKZUWZbqH4UDvDXKEtH2qAKne977a0g7zjyd
         7bJ+Bd3EfSU5yweVoqVYlacCX56ikjbR1l6ztcp9gK+PhBa0OpwU6Wjl4Mn7qWYnVWzd
         H39oRqavV+XzUW9jUFmwXnGIHsvzzsou6j7giRc4RIl4tka9qidzs8tgKLSvySsXmC2d
         5u5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtaJrkDryVOUrHKk+9/mb0C6o7owr4ve6RgZLEmMJdaxO/Z+NcSwV8B4zOWGBJlqYguWP0+pMN50GLg1JAa2j92Dw9n5Nxqb55UXRM
X-Gm-Message-State: AOJu0Yy3mJgb74leHSsmbQfqLBB2IdSgeM85I3RIk5G64ETnNFDRxPob
	D8ya6uHM4U78vWuK4n+ie7E4e0OV1bG7dG9G4CxVehsY04bucXiZ6G5lg4BG3Q==
X-Google-Smtp-Source: AGHT+IHFgKOC3VDYMOaZv+mEkekXLo/F7HDwWgVZwWgcYb5jHR718CyzbZknNqZNLo9Xr4uUtFkXVw==
X-Received: by 2002:a0c:e18b:0:b0:68e:e9d2:3e3 with SMTP id p11-20020a0ce18b000000b0068ee9d203e3mr7446318qvl.46.1708969808762;
        Mon, 26 Feb 2024 09:50:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ny6-20020a056214398600b0068ff0778895sm2868644qvb.81.2024.02.26.09.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:50:08 -0800 (PST)
Message-ID: <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
Date: Mon, 26 Feb 2024 09:50:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link if
 only tx_lpi_enabled changes
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
 <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000067bfde06124c8a4e"

--00000000000067bfde06124c8a4e
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 08:44, Andrew Lunn wrote:
> On Sat, Feb 24, 2024 at 06:57:12PM +0100, Oleksij Rempel wrote:
>> On Fri, Feb 23, 2024 at 09:53:06AM -0800, Florian Fainelli wrote:
>>> On 2/23/24 05:26, Russell King (Oracle) wrote:
>>>> On Fri, Feb 23, 2024 at 02:17:59PM +0100, Andrew Lunn wrote:
>>>>> On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
>>>>>> On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
>>>>>>> +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>>>>>>> +				      struct ethtool_keee *data)
>>>>>>> +{
>>>>>>> +	if (phydev->eee_cfg.tx_lpi_enabled !=
>>>>>>> +	    data->tx_lpi_enabled) {
>>>>>>> +		eee_to_eeecfg(data, &phydev->eee_cfg);
>>>>>>> +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
>>>>>>> +		if (phydev->link)
>>>>>>> +			phy_link_up(phydev);
>>>>>>
>>>>>> I'm not convinced this is a good idea. Hasn't phylib previously had
>>>>>> the guarantee that the link will go down between two link-up events?
>>>>>> So calling phy_link_up() may result in either the MAC driver ignoring
>>>>>> it, or modifying registers that are only supposed to be modified while
>>>>>> the MAC side is down.
>>>>>
>>>>> When auto-neg is used, we expect the link to go down and come back up
>>>>> again.
>>>>>
>>>>> Here we are dealing with the case that autoneg is not used. The MAC
>>>>> needs informing somehow. If we want to preserve the down/up, we could
>>>>> call phy_link_down() and then phy_link_up() back to back.
>>>>
>>>> Would it be better to have a separate callback for EEE state (as I
>>>> mentioned in another comment on this series?) That would be better
>>>> for future SmartEEE support.
>>>
>>> That sounds like a good approach to me. The additional callback also helps
>>> figure out which drivers use the API and it should be simpler to audit for
>>> changes in the future, too.
>>
>> At this point I need help to understand how to proceed.
>> What exactly do you have in mind? Some description like following would
>> be helpful:
>> Add callback with name phy_link_set_eee(), which should be executed in
>> function bla/blup..
> 
> When i first did this patchset, SmartEEE was out of scope. One
> question we should decide is, is it still out of scope, and we should
> first get 'dumb' EEE fixed everywhere, and than come back and look at
> SmartEEE? Or do we want to consider SmartEEE now?

I believe the considerations about SmartEEE (which BTW requires a less 
QCA-centric name to be found) are somewhat orthogonal to the concerns 
from Russell here.

The concern is that MAC drivers are not expecting to see the following 
sequence of calls:

->adjust_link(link == 0)
->adjust_link(link == 1)
->adjust_link(link == 1)

The latter is somewhat unusual and could lead to some spectacular and 
unknown bugs to be discovered. This is even more surprising for drivers 
in that the TX LPI timer is typically programmed as part of the 
set_eee() callback.

> 
> The idea of this patchset was to push as much as possible down into
> phylib. The MAC needs to say it supports EEE. I left handling of the
> tx_lpi_timer to the MAC driver, because the PHY has nothing it can do
> with that value. phylib then just needs to tell the MAC to enable or
> disable EEE when autoneg has completed. That i made part of the adjust
> link callback because that is the only callback we have, and most
> developers seem to understand it, and the locking around it. However,
> it does get messy when EEE can change without an auto-neg, as pointed
> out here.
> 
> If we are leaving SmartEEE out of scope for the moment, i would say
> just doing a down/up is sufficient, lets get this merged and all
> 'dumb' EEE fixed.
> 
> If we want feature creep and to think about SmartEEE then we need a
> few changes in the overall design.

I am fine with tackling Smart EEE later on, as a matter of fact, I don't 
believe many, if any changes at all should be required to your patch 
series here. We would need to find a less QCA-centric name since 
SmartEEE and AutoGrEEEn are both trade marks, though QCA definitively 
did a better job here at claiming a name people could understand.

> 
> We need to make eee_get and eee_set transparent to the MAC driver,
> since the PHY could be doing it all. So phylib needs to track
> tx_lpi_timer. If the MAC driver indicates it can do 'dumb' EEE we
> probably want to use that in preference to SmartEEE, since i guess the
> MAC can also save a little power in LPI mode. So the adjust link
> callback needs to say: Enable MAC EEE with this value of tx_lpi_timer,
> or turn off MAC EEE. When using SmartEEE it will never actually do
> either.

Agreed.

> 
> The current phylib model is that adjust_link is the only callback, and
> the MAC driver peeks into phydev to find what it needs. I would
> probably stick to that model, and not add MAC callbacks. phylink is
> slightly different, mac_link_up() passes everything the MAC needs to
> know as parameters, so one of my patches adds an extra parameter to
> indicate if EEE should be enabled or disabled. That would need
> extending with the tx_lpi_timer value.

This is the source of the concern, we don't know which MAC drivers we 
might end-up breaking by calling adjust_link(link == 1) twice in a row, 
hopefully none, because they should be well written to only update the 
parameters that need updating, but who knows?
-- 
Florian


--00000000000067bfde06124c8a4e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIfcEJI4V3v5wzM4
gcChQf1uwbkeCY+/OhoXgxZgk9F2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDIyNjE3NTAwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAD/rDvblmt2DoaWmZeYGR82d4vu8Sz4KSz
e4Iq3vcG+Mgx5ROPHgSds2/bYpFClAuoWsKLng+6Quq1ml0QDEUbvhsmg6/+N1SxQmN8lOuUEF8R
Fn6HZBO9SNXq3VWFMbnXSRGbGCy5ixoQSdV2GCnxSCAgCL3yP+rxPQDeDP8OIHL4LX1/ZDdr9XDm
YUtnWtwsEED69M8JDX2ACEUyfgzgPFzbDJnrkM986ZdiUyJsgovoD6ksHtbR5SlTPDIXGelwNlgq
zpFPVjtf5v+8Tbkoizfzzq8CIWke9uIAa4G34zzhfUtc7BGokrkneg/VkFPG3NJby+vYKdtQCblD
iF//
--00000000000067bfde06124c8a4e--

