Return-Path: <linux-kernel+bounces-132688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967AE89989F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C45EB21520
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C915FA8D;
	Fri,  5 Apr 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QtRX9Adn"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E7611E;
	Fri,  5 Apr 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307371; cv=none; b=NpdJ7X5z7MYUCivQCJK1hGOd4cxbOsYadYjdK6CgwyQVKSeLBp7pwatTLuLyU4lPz13CpEupkLYwdAqP/eoAoZqsxLc7KjFhR/NB0fDN/8Utn54Gn4raVaVh3lNduriyt6HKLRzBv8n0c9RO0lkUNiL4Dg86vQCGdRN7rkEp+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307371; c=relaxed/simple;
	bh=wGKl8M0KGVCfuWC968Hnzb25vs3AyVEmZN6DO2nu+to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLDzqaWsAm//N/yPqRHBOZyzul+4AYH5ZKRPU1PdS0pK3f45+qbIaC4HrbBN6uAVWJOAlpIy9P2nSNBflJKePniTVchUTjpCNNZ0m4gUZI0GjVRUJCQK4qp6vwJISSKBJDIyCAwcykKb62Q4HRuKvs1YqP9rGMEXZEx9+Vwhxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QtRX9Adn; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712307365;
	bh=wGKl8M0KGVCfuWC968Hnzb25vs3AyVEmZN6DO2nu+to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtRX9Adnok9ub5w71euVdVDrQCvCoofDVJ9fVJURGaQqt9lQO2G+sUobIZDzX6PVH
	 +HXeWPJ0WQYR/Gm7JzyrGot4JMKs+iL+LWNTvtLatKmqotgLOAE6hkXUXYW+Y8OtPv
	 3BvNtuunP7ssmc/6VBdYfJnXN8vKrr7UMVPVnKuWJMQXttTm/Qg26KxLM2xjErq/Yq
	 tMzGCHCA6PkFBrFlCY4jQ655/Wszqr+/md7YftPYvUhjtz/w9iIXz/b/GeyWTxz59J
	 ZW7rk/mNiKpHqCmSCe/F1cqauUe94dJHebTvPxGmr1gtr8HJQYHIVRBQqVblttU9lP
	 IuuRsMpJYz1Lw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45E823780EC6;
	Fri,  5 Apr 2024 08:56:05 +0000 (UTC)
Date: Fri, 5 Apr 2024 10:56:04 +0200
From: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jackson.lee" <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
Message-ID: <20240405085604.lzsekrtrtudvdh6c@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
 <SL2P216MB1246597E5880A5A590CE1DB2FB3F2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <20240404080235.kab6taeimsxpjtr3@basti-XPS-13-9310>
 <4f781313ddb2b7657fadc35dc04c0e3c3de3b27c.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f781313ddb2b7657fadc35dc04c0e3c3de3b27c.camel@ndufresne.ca>

Hey Nicolas,

On 04.04.2024 14:56, Nicolas Dufresne wrote:
>Hi,
>
>Le jeudi 04 avril 2024 à 10:02 +0200, sebastian.fricke@collabora.com a écrit :
>> > > > > > Wave5 can enable/disable the sec_axi_info option for each instance.
>> > > > > >
>> > > > > > How about handle sram-size through match_data ?
>> > > > > > I can find some drivers which use match_data to configure the sram
>> > > size.
>> >
>> > I proposed using match_data to allocate different sram size for each device.
>> > Do you think this is a reasonable approach ?
>>
>> As discussed here:
>> https://patchwork.linuxtv.org/project/linux-media/patch/20240201184238.2542695-1-b-brnich@ti.com/
>>
>> To quote Brandon Brnich from TI:
>>
>> If static SRAM allocation is the correct method to go, then this series
>> can be ignored and I will add section in device tree and remove check
>> for parameter in driver as that will now be a bug.
>>
>> I would like to adhere to that.
>
>I feel your statement is a bit ambiguous. Can you clarify what you adhere too ?
>That we should hardcode fixed sram size in the DT ?

Sorry wasn't aware that my statement is ambiguous, my intention was to
say that we do not add the sram size to the DT as it was discussed with
the DT maintainer in the thread above, my adherence was pointed towards
the statement from Brandon: "then this series can be ignored".

>
>When I read earlier today "How about handle sram-size through match_data ?",
>what I saw was a static C structure in the driver. Like what we do with HW
>variants usually.
>
>I was pretty convince that the right solution is to allocate sram when the
>driver is used (open() seems appropriate), and drop it when its not used. With
>the clear benefit that we can change our mind later if we find valid arguments.
>
>So with that in mind, dropping (cleaning up) that old code seems helpful to
>create a clean slate to re-introduce a better version.
>
>Nicolas

Greetings,
Sebastian

