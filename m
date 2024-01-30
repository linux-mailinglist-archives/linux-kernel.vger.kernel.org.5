Return-Path: <linux-kernel+bounces-44013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48823841C34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BC1C2227A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571C4500D;
	Tue, 30 Jan 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="jDpkKn8y"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A4E537F3;
	Tue, 30 Jan 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597652; cv=none; b=HGx7yf0pdxfP9JJSq4s76wVfxpmcf1KljFnfmRWAlXTylv3qpM6+u0QD+UOOjs1T1P4wZ5uYajDd6NS8E2CLaFFN5PNIH3Wus/y9rOopJ3D9Jafk1BZGNpLxAqwEIqbg8Va4wSuTFKTyCSl21fm68+Tqs+hkfDfjsDqDc+HT6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597652; c=relaxed/simple;
	bh=P1RjsXtuqdoU53VPvfAsbIjZJnGmVvRKBIqNJ8TrKA8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IrPrm5dZafUIpqFPE9HkzbrKySkr88JEdinMyvCAAo9sPUsTTvAzomgOSALOErgTBhFMjjxHvPI/sBT/0QZ56SNbVXML5Yo7BYusXEGwDsAQEjeCoNDzaOF35mgmYW5BZCSgpRkugniQ9WtTsFaakRJJ/lhG9PCTNOmcE3rJPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=jDpkKn8y; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 819E8940010D;
	Tue, 30 Jan 2024 07:54:05 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 640x6qyzB95V; Tue, 30 Jan 2024 07:54:05 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 45AD79401685;
	Tue, 30 Jan 2024 07:54:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 45AD79401685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1706597645; bh=qEy0m5T6XKGINdPyFPj+69zy7dIFK43F6ujm1iJBtvk=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jDpkKn8ycg4Cj4nO8eqia9j02wv06dHyCX2A3uYHhlRAWLQt+H5iD2aho1H12fROp
	 XxsqejDAPFPEZXHjWjqzp8iH3wi4fQW0P3Qsc8mVzZGBkiJSdN0DpL9/ywNzeSxH1i
	 9R3jWw4djUs441IayyY6Z4wFRv5eb8Xdm3GXFhJkGrGAi47BuDrYXPdPbyQ59O1Dn7
	 7fHf/Pc1mbQGwxNpx8QKNE/oAxnGCt+xwMUmcKGiOL5JV/Tsv17pn9SNGvQPOhV7rF
	 cafZZtaquDEL2A3Cn8Uni7KNdsGSHasfYTSnghSOLEokJ66u3cAda7QM7VxKcr0TvW
	 f0SFyCdvLD2Tg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2gCRmhUlDDen; Tue, 30 Jan 2024 07:54:05 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 928A7940010D;
	Tue, 30 Jan 2024 07:54:04 +0100 (CET)
Date: Tue, 30 Jan 2024 07:54:04 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andre Werner <andre.werner@systec-electronic.com>, hkallweit1@gmail.com, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 1/2] net: phy: phy_device: Prevent nullptr exceptions
 on ISR
In-Reply-To: <b507e17b-da8b-4616-b0d0-af9995bf8fc7@lunn.ch>
Message-ID: <395188fe-e73d-36c2-d36a-bc043744895f@systec-electronic.com>
References: <20240129135734.18975-1-andre.werner@systec-electronic.com> <20240129135734.18975-2-andre.werner@systec-electronic.com> <b507e17b-da8b-4616-b0d0-af9995bf8fc7@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Thanks Andrew,

I will keep this in mind. Sorry!

Andre


On Mon, 29 Jan 2024, Andrew Lunn wrote:

> On Mon, Jan 29, 2024 at 02:55:04PM +0100, Andre Werner wrote:
>> If phydev->irq is set unconditionally, check
>> for valid interrupt handler or fall back to polling mode to prevent
>> nullptr exceptions in interrupt service routine.
>>
>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> Nitpick:
>
> Your Signed-off-by: should go last.
>
> Its not enough to need a respin, but please keep this in mind for
> future patches.
>
>       Andrew
>


