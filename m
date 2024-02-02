Return-Path: <linux-kernel+bounces-49015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6018464D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EE61C2382E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E7185A;
	Fri,  2 Feb 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPf2IaaP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E210EF;
	Fri,  2 Feb 2024 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832335; cv=none; b=rbezv6p2c6NtRCTYrwI0AtaE4x2rGAKJ0DJ4Y7eKeXTiHfRU+u7j6t3Efr3vata5EN0FlMq1oo5U9AfGE9JBnT4MphMbyeuuV0R57/rF2YbJJoYwUMp1zGxA2ZGfpZYrrVVTUsOJ6/j21QxmdbXHJigAKiW8DKOq5Yex+O7sN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832335; c=relaxed/simple;
	bh=+De4TUxIX9GGQpXLWuAEcB7P/wKiFnoQrmglfp/o8ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud7ZfndJSNqOQitJgPJYGNy3QjI00elf8Dn1NV15wIngemyTdeEd2c46lsSiLoayYNIg5B5/7awGVuztJAPYTbUbqQLkXipuqjx+tPH/h8jgWEoy2TWgtEjFb/LN23NM10DUKQeou6xTliDmh2BOcDTiQ6sTByJwMcBUE6PtFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPf2IaaP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370315191dso11824066b.2;
        Thu, 01 Feb 2024 16:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706832331; x=1707437131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kw5yCa7B5h6E5tqNELeCv4fqCVbEaQWT1fjUMOqoUrY=;
        b=JPf2IaaPh9AU644zkZ+yh9sft/wJNiJF1gajdC+XRDd/9HR73XeMpd/AtsJdP5G7Kd
         AVcnjLOGT8R6HBDOYxnmmNPVJK+Rdbi7ed61UxRVMyU+9TXSuVexIXv9RRNoQ1nSQf95
         /+jCunekEmUS0Ao52PVUzeggldpCvjgGO9hpegjGN2g8PvyNuUG/oEqhOglepSBJ90yG
         6OgPH7izCS1fqCLxzvNzHLpE5fYoUlTf0LtTAoxKwMK4WOlTctW4e3DQa/OeLL8Ah0od
         ihJPb9lPXfZXhB9dIEg7d45qxg7OLqM9Saf3CK9WZdPQeNyzpz5BGN+wg3fQB7SOTeAL
         t9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832331; x=1707437131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw5yCa7B5h6E5tqNELeCv4fqCVbEaQWT1fjUMOqoUrY=;
        b=UfpcyTfFzNLyCllYe24xmEJ3pX2vdjp2rgB1QmKlp8imjmxH9ZcTc2mMrWP4KpJkTG
         5XumSZmfYcIXIV/+pUxcF3BPHRr08hHI1NI2MDVhIb9wgxHbbqUFZYnxhTCHkf66HryM
         aIij0BqRU325NESsH49i4yCB+e0kG9/5tjSMqHPxqWThZVfnlDRXcPD2NRi3wOV3mI4u
         wZ5iIQmVIvCj7xOT01ubynQwS+VCD6wpVTUDcsKxQ6B4SiSwJMEVvNcVBTZsmIFZuIXp
         fhw2f6cNtoyBFiUg0QvkohnBFCtg/R912RJ0/Az0BwFf//wJhUI8Pdyakcb4Mhprbhyy
         sX2A==
X-Gm-Message-State: AOJu0Yw6v0PqT8aOk6x5rxInOm4XUB9Zog0/iSBZbwGkB4SwvTBoQXTD
	ONzg17uRBionvHy8nML2VI1Tu01z4er1m/nYDZhszv5S4rwKUk+t
X-Google-Smtp-Source: AGHT+IG3Oc+QVcDW1imSv28f6Wfd18UPkfs0THsoQFFMSm7GDFwNpyXEsoyc6JUAhBc82NDm4akIqQ==
X-Received: by 2002:a17:906:6c8b:b0:a31:7aca:a429 with SMTP id s11-20020a1709066c8b00b00a317acaa429mr2525716ejr.4.1706832331143;
        Thu, 01 Feb 2024 16:05:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqP+Ej+Py+JOKNXrBkFKszG2TQ5BitJp54lFM/ULnJrFAc1ThEwV37zImCs1V0f0eDefU0plz4nmA8YW3GvEpfgesqzJ8LlKKoG/cQTSLKgFdp4GlDVA7fbbENVVpIiX5Rglz9ADw69SHHTh8o8pghR4qkBmabwOP09SIfqUNUa8ziP3ewAGr/dVYf+2fuGLm0L3c0CWqnc4aV1+buL5BfYCzCDgyjKrqV783V7L21RduwjXpzinMDUJ+LzzD6P91YNrz88t0BrW2Homhh7ViZCsm+/NMsiFKs02EaAmqcDK99b02kw/c706SVeTz7P5E4LkNfp6eH0jUnieHOs9pHpLY8Mz3X3chY/UdnntiLMpAf/YRQMyMh1827YqyvR8fnU4n91AaOyZbXbV9QJWn02buVYKPHSno5klsYAemlYzsY8T87xFkGhfpNWQqgORiRY2+nBDIGQsGMzWqg7Rq1/X2g4A8WVFsaMmxp6mIE7O0z7+jKh3aSBpAjiYR3vbRqNBRr8Nta93M/1hAB9bog5PYudd/t6ezBNGXqJT3sCH12ovbVkKaAxftXTgekJMH97R6TbP+NFraj7y/peJ1wuakTP3fOXpvCtb4+ohGLj3+K38Jw/JNL7D0ns6yNLuV+l3K5DvAV3Wqho8pA7oSJ47CuZzI2
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b00a3161adb239sm279824ejd.158.2024.02.01.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 16:05:30 -0800 (PST)
Date: Fri, 2 Feb 2024 02:05:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: correct port
 capabilities of MT7988
Message-ID: <20240202000528.efgly2bpfhqxu332@skbuf>
References: <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-6-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-6-ba06f5dd9eb0@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130-for-netnext-mt7530-improvements-2-v2-6-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-6-ba06f5dd9eb0@arinc9.com>

On Tue, Jan 30, 2024 at 06:20:52PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> On the switch on the MT7988 SoC, as shown in Block Diagram 8.1.1.3 on page
> 125 of "MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open
> Version) v0.1", there are only 4 PHYs. That's port 0 to 3. Set the case for
> ports which connect to switch PHYs to '0 ... 3'.
> 
> Port 4 and 5 are not used at all in this design.
> 
> Link: https://wiki.banana-pi.org/Banana_Pi_BPI-R4#Documents [1]
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

