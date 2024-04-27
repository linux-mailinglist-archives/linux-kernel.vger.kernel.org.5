Return-Path: <linux-kernel+bounces-161143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7C8B4793
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF10B2186E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ACE14386F;
	Sat, 27 Apr 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNwz/ZXV"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE628F4;
	Sat, 27 Apr 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246466; cv=none; b=rhwpfhrAs2JpLxGbpFHfd1iSbcOsLRZcK4LKL1MB6u7GQEmbyH/mH3y4j9zjI3fLcwcGql0l5OO8e+nqIePnVW6bgcFmzfYIa8NKvhmhb3CVyuy0SudCrY8AYzHjCs+GyeQeokpOVakmi3T41DI2inTf+psiTtXZWpeNn+3OlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246466; c=relaxed/simple;
	bh=q7rRxyGXdb9iLbeWC1LXBPTVWiaUAcj+jB9vx6mFOJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeqS3gZGG2NJ/yC3FKZ6hNDVgn0ASNBTH8OCMAN1ywYKFfEEcEvSsLOyyppreJsFgd3vKJDwBNbnlJVidvDtxW0wGH1y9UzpMRCuXrd4OmZC26SVi7Ps392V+LcSKtY201QWuBE0vdS53c6GOaCdAlkDi4kbOWenGjDQCg9gC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNwz/ZXV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57232e47a81so5371151a12.0;
        Sat, 27 Apr 2024 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714246463; x=1714851263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MID+B2Bh0mPzhxqGE2XrI56q0o17m4WOrXDwuiavZWE=;
        b=ZNwz/ZXV11OIsgsRnXTk3Dbcgz/BULBKTchEiUbi77dWHdEgOiEK5IG6uGNBwi1+mO
         3d1tjmdX4GNRwNSeHl4cu9G1T8WYs6G7tN78xe5VtVIdDJLEsO3kI9XqgMeJ6eQpKqtz
         Lcmhjn5tmWRLn+o5KNWLTZpnNRCmczYXvw7siAL4s9GdBXCMUh9ToQ3Hhtd8RZu033UY
         lCEzX4/rRnZ1sQ9th2aZG52imF8WgazyWbsCUxMfLM0UnxKVssw4qwbs7Zvh8J7E5LXJ
         VbcyRE/VJjEg+J6Pfh2oIdp3LlkvXKe8khsGZ1K/RbELhnM+4FDT3A3MuTLhRYkGYkq/
         0ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714246463; x=1714851263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MID+B2Bh0mPzhxqGE2XrI56q0o17m4WOrXDwuiavZWE=;
        b=swKru1WYoyocW8as84YOp4+fOtpnbAPQBGS27m5MHJRDQu67aWBZnsCfXZF+8GbE49
         4jpK0A9mwg/x5pqcMUhrIadq6DYIpchenIaSVHRi0K4gWs9xoXDU2G0zCxZwvBL94jFW
         WUyeBWXZ5m2HdNbVqQdP6TZUJG0ilR8XBuxBieAavd+eG/yUjCcAEoDYItLAKQBuwmuq
         yoOcnqLi4F3ugZEscUc+wXtrGgkYsG+qQSEB2ol2kjqTowG8l64nylbIw3YrmRc06nhP
         nq/OhfwBej9Xm0kmvfHtQCP0dI+B9RdEqgFAjI3Ax+Hc6JhazIa+aUG/FXlYZbf24e8C
         xiTg==
X-Forwarded-Encrypted: i=1; AJvYcCUPhCqMQzIKN0hp6HypdO9+gSHTJc1Eg5s+VWeTLvygXsTQkF1CVFLwpWNm02zrl9eo7evAB1qs9L31trqugUfdNpdS0JBOAQyEImqpjyuokFMtL/yimqqPaWkotFQ8UDkdgdO+
X-Gm-Message-State: AOJu0Ywi+iQ+RkVx20VtVFLcwg2NVc/FTkpl67xvWdTwLWpyExTvav0k
	QunGeV/sRsLqSYbZfr/PpXUpDXYY43d/1DcJNoKS2VAoyYGNwlWm
X-Google-Smtp-Source: AGHT+IG/+0HhEESs3V8kj/gUbOejKncVMqRiapoTCEkni1SKI4YWML67WBni9YKqx8XUV0QnprhVkQ==
X-Received: by 2002:a50:f614:0:b0:572:3f71:161f with SMTP id c20-20020a50f614000000b005723f71161fmr2906356edn.12.1714246462776;
        Sat, 27 Apr 2024 12:34:22 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c403:ad00:c9fe:f0c4:b80:4a0a? (dynamic-2a01-0c23-c403-ad00-c9fe-f0c4-0b80-4a0a.c23.pool.telefonica.de. [2a01:c23:c403:ad00:c9fe:f0c4:b80:4a0a])
        by smtp.googlemail.com with ESMTPSA id l11-20020a50cbcb000000b0057030326144sm11310255edi.47.2024.04.27.12.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 12:34:22 -0700 (PDT)
Message-ID: <d33888a9-3c26-47be-bead-5270b955307b@gmail.com>
Date: Sat, 27 Apr 2024 21:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL
 topologies
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com>
 <c37482d9-f97b-4f9a-8a2d-efde1a654514@gmail.com>
 <20240412152335.751a8dbb@device-28.home>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20240412152335.751a8dbb@device-28.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.04.2024 15:23, Maxime Chevallier wrote:
> Hello Heiner,
> 
> On Fri, 12 Apr 2024 15:07:46 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 12.04.2024 12:46, Maxime Chevallier wrote:
>>> In situations where phylib is a module, the topology can be NULL as it's
>>> not initialized at netdev creation.
>>>   
>>
>> What we see here is a bigger drawback of IS_REACHABLE(). For phylib it's
>> false from net core, but true from r8169 driver. So topo_create is a stub,
>> but topo_add is not. IS_REACHABLE() hides dependencies.
>>
>> topo_create et al don't really use something from phylib.
>> Therefore, could/should it be moved to net core?
> 
> That's a valid point, and a better solution indeed.
> 
>> At least for topo_create this would resolve the dependency.
>>
>> We could also add a config symbol and the PHY topology an optional
>> extension of net core.
> 
> That could be a thing indeed. It could be selected by phylib then, I
> don't see it being a user-controlled option, as this would make it very
> confusing for users to only be able to see when there are mutiple PHYs
> on the link when the relevant option is enabled (but I might be wrong).
> 
AFAIK the issue still exists on net-next. Are you going to submit
an updated version?

> Maxime
> 
>>
>>> Allow passing a NULL topology pointer to phy_link_topo helpers.
>>>
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
>>> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
>>> ---
>>>
>>> Hi,
>>>
>>> This patch fixes a commit that is in net-next, hence the net-next tag and the
>>> lack of "Fixes" tag.
>>>
>>> Nathan, Heiner, can you confirm this solves what you're seeing ?
>>>
>>> I think we can improve on this solution by moving the topology init at
>>> the first PHY insertion and clearing it at netdev destruction.
>>>
>>> Maxime
>>>
>>>  drivers/net/phy/phy_link_topology.c | 10 +++++++++-
>>>  include/linux/phy_link_topology.h   |  7 ++++++-
>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
>>> index 985941c5c558..0f3973f07fac 100644
>>> --- a/drivers/net/phy/phy_link_topology.c
>>> +++ b/drivers/net/phy/phy_link_topology.c
>>> @@ -42,6 +42,9 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
>>>  	struct phy_device_node *pdn;
>>>  	int ret;
>>>  
>>> +	if (!topo)
>>> +		return 0;
>>> +
>>>  	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
>>>  	if (!pdn)
>>>  		return -ENOMEM;
>>> @@ -93,7 +96,12 @@ EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
>>>  void phy_link_topo_del_phy(struct phy_link_topology *topo,
>>>  			   struct phy_device *phy)
>>>  {
>>> -	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
>>> +	struct phy_device_node *pdn;
>>> +
>>> +	if (!topo)
>>> +		return;
>>> +
>>> +	pdn = xa_erase(&topo->phys, phy->phyindex);
>>>  
>>>  	/* We delete the PHY from the topology, however we don't re-set the
>>>  	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
>>> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
>>> index 6b79feb607e7..21ca78127d0f 100644
>>> --- a/include/linux/phy_link_topology.h
>>> +++ b/include/linux/phy_link_topology.h
>>> @@ -40,7 +40,12 @@ struct phy_link_topology {
>>>  static inline struct phy_device *
>>>  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
>>>  {
>>> -	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
>>> +	struct phy_device_node *pdn;
>>> +
>>> +	if (!topo)
>>> +		return NULL;
>>> +
>>> +	pdn = xa_load(&topo->phys, phyindex);
>>>  
>>>  	if (pdn)
>>>  		return pdn->phy;  
>>
> 


