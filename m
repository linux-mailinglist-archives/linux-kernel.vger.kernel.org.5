Return-Path: <linux-kernel+bounces-150179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481158A9B65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE641C22D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5511161307;
	Thu, 18 Apr 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK6G+jI2"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1369DF5;
	Thu, 18 Apr 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447357; cv=none; b=bzOlEAOBiCGOCxee8oKiAAd+X+tc6FPT1f189dQfVRI5qq8gt6XrsmX0WeTW5GBK5N9JvO7RAKE3+nuCQAQuxOGuVAVjxxBjJ1aE8noHQirluNgTzx3pIRaG8HD7wLUJ90KHPBanVCiBrcivQgD1usu1Cp29gzUjE4IUhLWJac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447357; c=relaxed/simple;
	bh=ugSV+/MOGhq9n75FEgYpVvgdy8aFV/GnMHdXlvDcXZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oPkzXRYaODBbY2jVdHOg1YTlQL9RQLd173AuzKM93qkTThIkTeBl+Kovn3GbqRpfrZI85KrS9/hBad68BEiYkZwOMAEG51C0yTGjhW9m4d9emE2tMhxwshebc8Kc40dMVwBen5RZ8gBZ2Hhl243PfIn0Hu4wAfRyOEyN6xBGOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK6G+jI2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da888330b1so13805521fa.1;
        Thu, 18 Apr 2024 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447354; x=1714052154; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5fHXSPxLQIiGSd9D1sItraRBNGWAeaK2D+DAOeVHio=;
        b=GK6G+jI262VQeBRLbEaL1SYqEEXX4M3DomHgmG4EaVcZbDRUZ3gHobf7bcIOS19lmO
         5ayOlra2d0JSqSNOzO1vYzCWalJFweik+Cf4XNRXrYS4aUb62jd1EausY7wusUKBcunx
         seJSWYRJb3GT40z8I0K6M7r0guNrUcsGAsg8KWBIuLAkA35qbkDAIlcwTJ2xwJy0QZ7F
         OjpKdJ4L13O0Pylnn6QSYYmAI66WzxsewWhy2GJ48nblwu6wBRGk7vd2FL1ro7VOAchW
         qj8PLwic2n9t94jVblEkBDa2ldkKRcyKYCLU+4ljc2iNlDJ2wET5xVWJX8tK0cixxZYL
         DUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447354; x=1714052154;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5fHXSPxLQIiGSd9D1sItraRBNGWAeaK2D+DAOeVHio=;
        b=nCNuJIMsv+8P2fqDRA8mlpOT/DbU0QQNxtHp7R3WcsTtkA8qZhZU5ldpRiKXzLiGuC
         B1hclH4gTKqhX0snH71231hj9YaGGEnOLYH2Ts/tD17nW8+iVRWdRUEdh5no3fikdiNm
         oTgTPBtwgD1qrrWuKbZEV+uKxVwcmvhqRuF0TQw8BbcA31BBrTPQIC9fWlgGRmIEAOKz
         X5cmbAB7mgBBvN0MeT1Hmq8ZjuecJD4qhNvou0uZuuAgklQ28OuWtraoo+TMohyGH+Gp
         nQK8qwW9xiAqwsT7q8hXZFHOgV0jp023CbCDvnh7hL3FuYI/3Ri7YUO9tWRX487Wcdr7
         x7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW95JS/ycF/TzaG/nN5rXvUohSPr/71rEwaiZsoIx+dy+JXsShl6cO7BV1K5ENFvVUGXHCHmfcJh8pbCMhTnPMc6ZcrpSW36bLJGdP
X-Gm-Message-State: AOJu0YyQF12FS6Dy42UQl3qFxvMlfmBH8qT5qAtwr3WnNCbMB8Tpdsgg
	LsHwNcblASYVx3VI6lb8q8vKobems8FFRdK+GIoxtNgii9i+aCrc
X-Google-Smtp-Source: AGHT+IFfGTkTqdS07TBOApk8qgPuzYCONLVGs9iFNW/fJbN8O1QdvcYTRQs4s7EBNkVCSq4vAsiQxw==
X-Received: by 2002:a2e:9104:0:b0:2db:218:b050 with SMTP id m4-20020a2e9104000000b002db0218b050mr1722446ljg.34.1713447353460;
        Thu, 18 Apr 2024 06:35:53 -0700 (PDT)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id h25-20020a2e3a19000000b002da968f03f9sm198269lja.89.2024.04.18.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:35:52 -0700 (PDT)
From: Casper Andersson <casper.casan@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support (HSR-SAN)
In-Reply-To: <20240416150359.7362c762@wsk>
References: <20240415124928.1263240-1-lukma@denx.de>
 <20240415124928.1263240-2-lukma@denx.de> <86mspt7glf.fsf@gmail.com>
 <20240416150359.7362c762@wsk>
Date: Thu, 18 Apr 2024 15:35:52 +0200
Message-ID: <86bk66hjyf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

Sorry for the late reply, I was awaiting confirmation on what I can say
about the hardware I have access to. They won't let me say the name :(
but I can give some details.

On 2024-04-16 15:03 +0200, Lukasz Majewski wrote:
>> On 2024-04-02 10:58 +0200, Lukasz Majewski wrote:
>> > Changes for v3:
>> >
>> > - Modify frame passed Port C (Interlink) to have RedBox's source
>> > address (SA) This fixes issue with connecting L2 switch to
>> > Interlink Port as switches drop frames with SA other than one
>> > registered in their (internal) routing tables.  
>> 
>> > +	/* When HSR node is used as RedBox - the frame received
>> > from HSR ring
>> > +	 * requires source MAC address (SA) replacement to one
>> > which can be
>> > +	 * recognized by SAN devices (otherwise, frames are
>> > dropped by switch)
>> > +	 */
>> > +	if (port->type == HSR_PT_INTERLINK)
>> > +		ether_addr_copy(eth_hdr(skb)->h_source,
>> > +				port->hsr->macaddress_redbox);  
>> 
>> I'm not really understanding the reason for this change. Can you
>> explain it in more detail?
>
> According to the HSR standard [1] the RedBox device shall work as a
> "proxy" [*] between HSR network and SAN (i.e. "normal" ethernet)
> devices.
>
> This particular snippet handles the situation when frame from HSR node
> is supposed to be sent to SAN network. In that case the SA of HSR
> (SA_A) is replaced with SA of RedBox (SA_RB) as the MAC address of
> RedBox is known and used by SAN devices.
>
>
> Node A  hsr1  |======| hsr1 Node Redbox |   |
> (SA_A) [**]   |	     |           eth3   |---| ethX SAN
> 	      |      |        	 (SA_RB)|   |  (e.g switch)
>
>
> (the ====== represents duplicate link - like lan1,lan2)
>
> If the SA_A would be passed to SAN (e.g. switch) the switch could get
> confused as also RedBox MAC address would be used. Hence, all the
> frames going out from "Node Redbox" have SA set to SA_RB.
>
> According to [1] - RedBox shall have the MAC address.
> This is similar to problem from [2].

Thanks for the explanation, but I still don't quite follow in what way
the SAN gets confused. "also RedBox MAC address would be used", when
does this happen? Do you mean that some frames from Node A end up using
the RedBox MAC address so it's best if they all do?

I see there is already some address replacement going on in the HSR
interface, as you pointed out in [2]. And I get your idea of being a
proxy. If no one else is opposed to this then I'm fine with it too.

>> The standard does not say to modify the
>> SA. However, it also does not say to *not* modify it in HSR-SAN mode
>> like it does in other places. In HSR-HSR and HSR-PRP mode modifying
>> SA breaks the duplicate discard.
>
> IMHO, the HSR-SAN shall be regarded as a "proxy" [*] between two types
> (and not fully compatible) networks.
>
>> So keeping the same behavior for all
>> modes would be ideal.
>> 
>> I imagine any HW offloaded solutions will not modify the SA, so if
>> possible the SW should also behave as such.
>
> The HW offloading in most cases works with HSR-HSR setup (i.e. it
> duplicates frames automatically or discards them when recived - like
> ksz9477 [3]).
>
> I think that RedBox HW offloading would be difficult to achieve to
> comply with standard. One "rough" idea would be to configure
> aforementioned ksz9477 to pass all frames in its HW between SAN and HSR
> network (but then it wouldn't filter them).

I don't know anything about ksz9477. The hardware I have access to is
supposed to be compliant with 2016 version in an offloaded situation for
all modes (HSR-SAN, PRP-SAN, HSR-PRP, HSR-HSR). Though, I haven't
verified if the operation is fully according to standard. It does not
modify any addresses in HW.

Does the interlink port also reach the drivers? Does it call
port_hsr_join and try to join as an HSR port? Do we maybe need a
separate path or setting for configuring the interlink in the different
modes (SAN, HSR, PRP interlink)?

> Notes:
>
> [*] - However there is no specific "guidelines" on how the "proxy"
> shall be implemented.
>
> [**] - With current approach - the SAN MAC addresses are added to
> "node table" of Node A. For Node RedBox those are stored in a separate
> ProxyNodeTable. I'm not sure if this is the best possible approach
> [***], as ideally only MAC addresses of HSR "network" nodes shall be
> visible.
>
> [***] - I think that this "improvement" could be addressed when HSR
> support is added to Linux as it is the pre-requisite to add support for
> it to iproute2. Afterwards, the code can be further refined (as it
> would be added to net-next anyway).
>
> [****] - As I'm now "on the topic" - I can share full setup for busybox
> to run tests included to v5 of this patch set.
>
>
> Links:
>
> [1] - IEC 62439-3:2021
>
> [2] -
> https://elixir.bootlin.com/linux/latest/source/net/hsr/hsr_framereg.c#L397
>
> [3] -
> https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/microchip/ksz9477.c#L1341

BR,
Casper

