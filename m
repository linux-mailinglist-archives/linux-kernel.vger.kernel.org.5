Return-Path: <linux-kernel+bounces-68479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F28857ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E2B22442
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57315644E;
	Fri, 16 Feb 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Xyzro7Pg"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9915491;
	Fri, 16 Feb 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081277; cv=none; b=AZjkhq5I265VEuCjm7XyeBY+vLKJoYPSBtTCumk3RptqAsFGNU4sM3XPtlXGQu0FcDb9qed7vi177Ni5jxxDWsMNGF5sh6Qgokr0uHr2WZuLJD9etzTk9Rmf+IJtufuPHPMW0Jc5dJM4S2W+u1tEFCQp20guYV/W8mkIFzXgM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081277; c=relaxed/simple;
	bh=ttlPDFfnXnAZ+jVduK6do/F9ZlFOzYi5qo7d9pC8V/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGppvXq1uE2c29/1LXvdy5/+90/lf7cMrY6gK0B8Gb0pk725axKhUy/vs85apcbsz1MyPpZ8Vi3SgmyUmWo+sLW0evT6BADm6Qx6oOhUh/t2jhhyhKeFV8GKPFRdi8aR2SXHy0nQOo4I1UB054R+Rim1c1lC4T/DQg0Qxet53pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Xyzro7Pg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7D111BF208;
	Fri, 16 Feb 2024 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1708081272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd4WAsqllMr+HE/wOBUfBJwcZ1dEQURjDou2URdczPM=;
	b=Xyzro7Pg+vbO6KWBl3OOC29SiOE3vdsmgRyOpgay+YJbbT9IqA8OJ5VmXlDge8eOuIMPnS
	4N2Sk16ZOq1qoeoQPK5iFIstw8CurHvbqI8vlJ6+LzMLNkHhp4PefCCk+yqfK67LUHBP2h
	2s08xwocjTuiXmNxiqkkkOAvWghkGIOKAv7rN2v/DJ2K7czx16OkCNHx4xAQCmBHKSTCSl
	5Fdip0U1r06gozSnWpFNWA8P2PxJ1d68Hn58YviwWtvk+fyYaZ5j+nzdbuNShW5RxjQTbu
	meh7Cdu8f8x+M3FeUYP5V5AApSqaVIEFnyINyCdmdEEWi7nDvVE6evkj+rKfcQ==
Message-ID: <c90958ef-f581-4c1b-86c2-ea71e89fbb65@arinc9.com>
Date: Fri, 16 Feb 2024 14:01:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH netnext 0/8] MT7530 DSA Subdriver Improvements Act III
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
 <20240216013439.dq7s5hp74mjahy4d@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240216013439.dq7s5hp74mjahy4d@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16.02.2024 04:34, Vladimir Oltean wrote:
> On Thu, Feb 08, 2024 at 08:51:28AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> Hello!
>>
>> This is the third patch series with the goal of simplifying the MT7530 DSA
>> subdriver and improving support for MT7530, MT7531, and the switch on the
>> MT7988 SoC.
> 
> There was an automation failure, you used the name "netnext" in the
> subject prefix and patchwork reacted with "Patch does not apply to net"...
> 
> Please resend to get some build testing. I gave a quick look over the
> patches and I didn't see anything obviously objectionable.

Ok then.

Arınç

