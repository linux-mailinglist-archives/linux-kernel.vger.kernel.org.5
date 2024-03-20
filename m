Return-Path: <linux-kernel+bounces-109214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF695881645
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEE528506B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AF69DE8;
	Wed, 20 Mar 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SapD/YO3"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821C69DF4;
	Wed, 20 Mar 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954842; cv=none; b=sHfpRaMEBe4xnw0+G4M+04uE6rCjwYlqvMk7vNpVUluu4gu3YITUhjVFSLZJG/dVjZjh5FnA0R6Ll00eIk/wfLmuG2pn5Gm5ZVnj94v9XMlXE+Gl9MEXLptO32rsXwc2UdYeII9ySW5JfUC/haH1h0gPb20N/3qK9OOXMlUrsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954842; c=relaxed/simple;
	bh=EbwDd+XVwF4iXBe+DrxSSVBH66+QYaIhOcGnrUJtJBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqT6azsE5AfvVbf0RnOUKehe4m6mB7zJZOd+kLsTKwklBCA3sLrHU16usoz+eazicC+OvHJDLlQe3X0sONhja8ZWvF4a6SFyr157XSO9jawpnCGvI11tFj1JAQEyVu7E7jM6285GdJ1TZ84edDUeeD2ATGzG5tReosAqhCXzcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SapD/YO3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2218a0f55e1so84472fac.1;
        Wed, 20 Mar 2024 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954839; x=1711559639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXFxjW4l3B5VQMh/kC2f380aAfgRFAUOCS83G200h3w=;
        b=SapD/YO3GeWEWPmcy45GZSw+9dX9XTe5XRnHAGkRoSiHrPsYwYltknkXoEHv5M7VyZ
         FYQROzOlqSpVDYQAQCHhfK4C1bndG6S/KEy4SZ6AqiIeUW1MRFCIOnc+xvmAbQBCR9fq
         TtTV6JhFShM/q9Dj49BoC+gK0AqTNra2XTJVruC5d4kmBsMQcBrIZXm+M2xChZVZ76dc
         5kYW0Q55FNZQ/dwXNvwYafoI3JAmJFreO8RbHMoFkkT5RJBq8y9hoUpjRSzYcvcc1T2Y
         ciKASRbAf25SUe33J5jhW4wKXmlA0IxTrFbRB4AlhVdxTh9MW1xMDqedIEfUZu30oIAM
         Z/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954839; x=1711559639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXFxjW4l3B5VQMh/kC2f380aAfgRFAUOCS83G200h3w=;
        b=nf8iBWXTNzs+EtT0aHAOyhr3oX0eFUjegpGoIsSVKK0aHP2NRnIlr3EHx6RlLBLDkm
         yaVLpwAkHSp93YGQeSUrXJT9W4ZdUn4G99ftvbZoygmWj8MchEzgzb+SlzhM85lNCqPF
         1fBJk9H2UQgFM2Gs4fNvbLJYNjgo0DLU49ZvQy/wwAkVIgBlLk6wyEBSQysF1eHzH0QL
         qlH8stOA8ArwNY9oyP/M5yYM/hHYvG8X5bPfhoNc5+egUfIUxBeQJwCAinm6UoTUSu2H
         tkF6lcmlaQcgUcQlQ9abnixGx18Y4LVPPY6TdNxBK9TgOkQV32jY1XDfLQAfb0ECrV0h
         vG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWiY7zJ/xjLS8sUs1dnNqSlt7fqOlKNmr0Y+xeUcaH3F7TUDzF3ePYK9zxjEtWR8WL27M4/Owo17dZi53ONMYpV4PvFgLc/4XfFsPckt0H1XkojC+Wc62l67/6SktX9Sp7RM8QE
X-Gm-Message-State: AOJu0Yxr/VX9Nx59HwVHiFrWIDQ0ssRNm5i7o+vxVzWbEL9DPsLiby7Q
	STMWB6EaZZ8XFF3mgUMKcbHKH0KEGJ/Fe6RbvvQOhntOnXll2E5x
X-Google-Smtp-Source: AGHT+IEgZCbZDh+1mo14R+9nGBzKs9ZqUZi23QwB2jCwICCDL9Q2/9JiASHdmSDSSgiedCTehzcJeg==
X-Received: by 2002:a05:6870:b62a:b0:221:38c0:3f0a with SMTP id cm42-20020a056870b62a00b0022138c03f0amr20548071oab.35.1710954839368;
        Wed, 20 Mar 2024 10:13:59 -0700 (PDT)
Received: from [192.168.99.37] ([216.14.52.203])
        by smtp.gmail.com with ESMTPSA id ey22-20020a05622a4c1600b00430b22f5735sm6337882qtb.78.2024.03.20.10.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 10:13:58 -0700 (PDT)
Message-ID: <7f0e5f8b-fb85-4f2b-8d77-4170366a1b55@gmail.com>
Date: Wed, 20 Mar 2024 10:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 John Ernberg <john.ernberg@actia.se>
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
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ZfsUvm9YC5O7il3h@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2024 9:54 AM, Russell King (Oracle) wrote:
> On Wed, Mar 20, 2024 at 03:25:54PM +0000, John Ernberg wrote:
>> Hi Russel,
> 
> Growl. Hi Peter.
> 
>> What we really want is the PHY to be suspended on suspend to RAM
>> regardless of us having had an initial link up or not.
> 
> So what you're asking is for the PHY to be suspended when the system
> is entering suspend, which is a long time after the system booted and
> thus phy_probe() was called, and could be some time before the system
> resumes.
> 
> I'm not sure what the relevance is of phy_probe() that was brought up
> previously then.
> 
>> This worked prior to 4c0d2e96ba05 ("net: phy: consider that suspend2ram
>> may cut
>> off PHY power") which was added in Linux 5.11, and 557d5dc83f68 ("net:
>> fec: use
>> mac-managed PHY PM") which was added in Linux 5.12.
> 
> Looking at the former commit, that looks to me like it is only
> affecting the resume paths, not the suspend paths, so wouldn't have
> any impact itself on what happens when suspend happens.
> 
> The latter commit states that it is a work around for an issue with a
> particular PHY. What happens if you revert just this commit, does your
> problem then go away?
> 
> Also, please clarify. It seems that you are reporting a regression -
> it used to work for you prior to 557d5dc83f68, but 557d5dc83f68 stops
> it working for you?
> 
>> Since FEC requires mac_managed_pm the generic PM suspend-resume paths
>> are not
>> taken. The resume sequencing with generic PM has been broken with the
>> FEC since
>> generic PM of the mdio bus was added, as the FEC will do phy_start()
>> (via FEC
>> resume) and then generic PM runs phy_init_hw() via mdio bus resume
>> (previously:
>> less damaging phy_resume()) due to how the FEC IP block works.
> 
> That suggests that even with 557d5dc83f68 reverted, it's broken.
> Digging into the history, what you're referring to dates from January
> 2016, so are you reporting a regression that occured 8 _years_ ago,
> at which point I'd question why it's taken 8 years.
> 
> Given the time that has passed, I don't think reverting commits is
> a sane approach. Quite what the right solution is though, I'm not
> sure.
> 
>  From the description and the commits pointed to, I just don't see
> that there is anything that could've changed with respect to the first
> boot - if that has changed, then I think more research into what caused
> it is needed.
> 
> If it's the subsequent state after a suspend-resume cycle, then yes,
> I would agree that its possible that these changes broke this for you.
> Would clearing ndev->phydev->mac_managed_pm just before
> phy_disconnect() in fec_enet_close() fix it for you, so the suspend/
> resume paths for the PHY get used when the network interface is down?
> 
> Maybe, however, that's something that should happen in any case inside
> phylib on phy_disconnect() as a matter of course, since the PHY will
> at that point be no longer under the control of the network driver for
> PM purposes. Could you give this idea a try please?
> 

On phy_disconnect() we will do a phy_detach() which calls phy_suspend(). 
Given that phy_disconnect() is called from fec_enet_close(), we still 
have a MDIO bus registered and we are not trying to suspend the MDIO 
bus, so we should have an effective phy_suspend() call here, what am I 
missing?
-- 
Florian

