Return-Path: <linux-kernel+bounces-63650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6808532C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463D928428A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D645786A;
	Tue, 13 Feb 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="ge547K3M"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA856476;
	Tue, 13 Feb 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833680; cv=none; b=u1XGd+gGUA2lFuwKr3XNGywXfIgZQpmhKSPVWgTXNP+aqQ7M5U3UBiSVESSbdyynYO6UvD5fgOdSkbyCtaVOtUDgm1Hr2yDBq0N7leXY4JfYIj+31r9LeiTAJlxZaqDK/thlQ0qp6ZQISxpZdfEwmdz0/KI+VsicvE+tDDovJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833680; c=relaxed/simple;
	bh=dN+V2m6PMzxOOJ+eizEB3r3qhqBSFvqLxJESCTceKKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLTZHw0iNZUaLklrYL7mZC6WaDOSHICtv6igErBrwdTBawReedXzK0yRw6N/MFSKKYkveLNTQPqdT+JNEZWwcr//OCfxCcEvXEj2bFuK2LqSWz4+M7G05cscZMJYMGM/UnIxx702kN/1cDdI8nagvAbQIiDRdjOwb/RS3JZgBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=ge547K3M; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1707833676;
	bh=fZ0nzxrMD3UebTkjOZJU+F8PQH7/KEhE5YGFJr9E2uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ge547K3MJ+bSAVnWd+AHahqVdOUnCd9H9oxO0u7DxnHGxtMMyO2RrzAUfqeCtY4X8
	 uTS1cferz/R1aRiOlCc33b7HmwqufPOR2Rhcua3Ay9ezp7E2PkL6pZ+l3+vaA/Nmny
	 BYXifV8JvzHE7NF8oKTBe1LNc4FB00Wgz4c2hK04=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 74626A0522;
	Tue, 13 Feb 2024 15:14:36 +0100 (CET)
Message-ID: <f3b75b82-2ff4-491c-8abf-1ba86171260d@ysoft.com>
Date: Tue, 13 Feb 2024 15:14:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl-yapp4: Fix the QCA switch register
 address
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonathan McDowell <noodles@earth.li>
References: <1707751422-31517-1-git-send-email-michal.vokac@ysoft.com>
 <c5dad8e7-c486-4dd9-bfb5-bdfa2ddc18b3@lunn.ch>
 <db282aa5-2db3-49b9-a7dd-86e94226aa7b@ysoft.com>
 <e00ed8cb-f73d-48a6-9999-f5acd5a202a0@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <e00ed8cb-f73d-48a6-9999-f5acd5a202a0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13. 02. 24 14:10, Andrew Lunn wrote:
> On Tue, Feb 13, 2024 at 01:20:44PM +0100, Michal Vokáč wrote:
>> On 12. 02. 24 17:08, Andrew Lunn wrote:
>>> On Mon, Feb 12, 2024 at 04:23:41PM +0100, Michal Vokáč wrote:
>> The fact is that the switch actually works regardless of the reg value.
>> It worked prior to the 15b43e497ffd commit with address 0, it worked
>> later on with the reg value 10 and it works now with reg value 0x10.
> 
> Ah, so that is the missing piece of information from the commit
> message. That the reg value does not actually matter. Hence it is safe
> to change it.
> 
> Please reword the commit message.

OK, I will do so.

>> I admit that my understanding of the MDIO bus and addressing of
>> the connected external/internal devices is pretty limited. I have no
>> answer to why it works like that but as you brought up your questions
>> I would actually like to know as well.
> 
> My guess is, the switch assumes it has full access to all the
> addresses on the bus. It probably uses a subset, but that subset is
> hard coded. But the MDIO DT binding requires a valid reg value, so
> something has to be used.

That makes sense. The problem is that the MDIO access and addressing
of the QCA8K switch is not well documented in the datasheet.

> There are some devices which use a single address on the bus. The
> mv88e6xxx can be strapped into such a mode, so you can have multiple
> switches on the bus. The reg value is then used. But you can also
> strap it so it takes over the whole bus, and uses #num_ports + 3
> addresses on the bus, and those addresses are hard coded in the
> silicon, so the reg value is ignored.

Ah, yes I am actually aware of that feature on the mv88e6xxx. We use
it on newer board revisions. AFAIK the switch is by default strapped
to the single chip addressing mode by internal pull-ups.

Thank you very much for shedding some light to that topic!

Michal

