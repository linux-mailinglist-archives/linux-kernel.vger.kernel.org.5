Return-Path: <linux-kernel+bounces-117189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89A88A875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173EF1C61F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A413CFB7;
	Mon, 25 Mar 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cJtsiE3T"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BB13CF99;
	Mon, 25 Mar 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375080; cv=none; b=dnPTGbfPj2xrjRcl5XvyxJJ8hHuhWfRqR6VR51swW5UwerF8M9dcVcmrtWNS/3I2thEHTse97oqq2nD/Es2N4SZh6ze/skGIs9vCZ5s6+DMCckA+8eZqklk6m3uEAyVjq0hZchS9sUJ6lYTcf6M2Z1m5tOc6pK4GzcEMuUiXwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375080; c=relaxed/simple;
	bh=SLkYKf7P/7HX8XrRjqY8I+HwX6HiSpxlmzsrBdk+4vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fveS+5Ay3vNWzaeW/KF+KVv8djuByRs1YV1vMfDQ3z5qt5VqF55/RL0KwWxb+QSgZPS7vpzUgreV285s7k+e1UJp9to8l6VMWM/L2sSoEKnOfEUS9LDdG5SHTwkWq6M2UN/SfsPb93rswfIy8xkqMpxCCuki3pPu+UH4SqeMjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cJtsiE3T; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=zXzI4MBpAZyeY9dZ4v2b6WShvnTo9KadIGopnBs+80c=;
	t=1711375078; x=1711807078; b=cJtsiE3TGuC5YtQ1tMLq3RnwS2MGlMhDQ4k7J3TWJRf4cE6
	A79jR8SDckNHuindHSKkmgZC1qt35FVHJ757Y3O/n00+2u38CnJk4juZ8EDPetaVXfXprg4swI9si
	5JiA7OgxowznlInN76ZJ7+7wZQ7qU5RebYMf48QmP/FkM6bIIxJkWEyaLUgLID3F+GIiKGXticj3+
	ZU6g+b3toeMz5Z/lERuD/oBpb0N8G8LP7RREaQXmisije3Bzc3l2/wWjEc715MdBsVSilgx8OsfWU
	w2InjtJWYfhp0LPXy4YhvjblUnzSsV5wKb3mks4nw6SR5cDDVNsaiMNighIG38gQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rokpn-0004yx-OJ; Mon, 25 Mar 2024 14:57:55 +0100
Message-ID: <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
Date: Mon, 25 Mar 2024 14:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Content-Language: en-US, de-DE
To: Johan Hovold <johan@kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZfMStHjwtCT1SW3z@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711375078;17de2c7d;
X-HE-SMSGID: 1rokpn-0004yx-OJ

Bluetooth Maintainers, what's...

On 14.03.24 16:07, Johan Hovold wrote:
> On Thu, Mar 14, 2024 at 10:30:36AM -0400, Luiz Augusto von Dentz wrote:
>> On Thu, Mar 14, 2024 at 4:44 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> 
>>> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
>>>
>>> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
>>> storage for the Bluetooth address and must therefore start as
>>> unconfigured to allow the user to set a valid address unless one has
>>> been provided by the boot firmware in the devicetree.
>>>
>>> A recent change snuck into v6.8-rc7 and incorrectly started marking the
>>> default (non-unique) address as valid. This specifically also breaks the
>>> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
>>>
>>> Note that this is the second time Qualcomm breaks the driver this way
>>> and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
>>> fix use-bdaddr-property quirk"), which also has some further details.
>>>
>>> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
>>> Cc: stable@vger.kernel.org      # 6.8
>>> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>
>> Well I guess I will need to start asking for evidence that this works
>> on regular Linux distros then, because it looks like that is not the
>> environment Janaki and others Qualcomm folks are testing with.
>>
>> What I probably would consider as evidence is bluetoothd logs showing
>> that the controller has been configured correctly or perhaps there is
>> a simpler way?
> 
> Well, in this case we actually want the controller to remain
> unconfigured (e.g. to avoid having every user of the X13s unknowingly
> use the same default address). 
> 
> I'm not sure why Qualcomm insists on breaking these quirks, but I guess
> they just haven't understood why they exist. It's of course convenient
> to be able to use the default address during development without first
> having to provide an address, but that's not a valid reason to break the
> driver.
> 
> From what I hear the Qualcomm developers only care about Android and I
> believe they have some out-of-tree hack for retrieving the device
> address directly from the rootfs.
> 
> For the X13s, and as I think I've mentioned before, we have been trying
> to get Qualcomm to tell us how to access the assigned addresses that are
> stored in some secure world storage so that we can set it directly from
> the driver. But until we figure that out, users will need to continue
> setting the address manually.

..the plan forward here? This to me sounds like a case where a quick
revert is the right (interim?) solution, but nevertheless nothing
happened for ~10 days now afaics. Or am I missing something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

