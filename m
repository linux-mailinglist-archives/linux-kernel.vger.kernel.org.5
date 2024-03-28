Return-Path: <linux-kernel+bounces-122440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FB88F776
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560391F248F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250E4CDEB;
	Thu, 28 Mar 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Oc5M9ecH"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48E48CC6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605118; cv=none; b=mTuX7P5n/BbyUtdIKM5pad0C+81OOZEZRpkIO+tvQQBoqYHc69SUDAmRA5o7WNagDMzLi30YBzznnWa7ezbNjMn2nFhrZLng82sk8CVUW388QhnzJ5m1T3Kw9NUx4VbIATclpuhfg2dQHPbbkTI4lz13NHieWdEXypVPLr3kgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605118; c=relaxed/simple;
	bh=XzUh4e+GUGrMcXpbZTUiag+z5Q0W3vzGlRM1MWSPvVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjqagZVwJWam4SQxNHDQgp0jlx1YmoKgz8ikTW++25tpq2kUE3XS9CPmFEq6kkFuHpBMBTcVJuUQa0ThXbpo483y0dYDXKZnu8XF8VScn+2n23PCkGjD8O+ThYAQQTG4YCbBfWJsa3RzZ4hiljkubbiosLCBy0KjcLSv1vcCOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Oc5M9ecH; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id pWKkrLIE6tf2Qpig8r8pds; Thu, 28 Mar 2024 05:51:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pig7rTVumd4oepig7rUYoo; Thu, 28 Mar 2024 05:51:56 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=6605057c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=_Wotqz80AAAA:8
 a=VwQbUJbxAAAA:8 a=ig1jn5DGqgWrHlYdm24A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OcyKQZGGVgXeDvPpM0FzUWGtl7ItivqUfJysf/GnhwY=; b=Oc5M9ecHzFYA7FQzOy/2hKZgz/
	v7+B98xURL/wvmkDwRhiolfQGFH2gbMZr9FVDZV1Z2UzeubH2VbS0VAHDZolh/TjEqt74o0tSnUNa
	uoMaH+biF4r1ZK9hFJV5BZdpYn9A2LiXNBdimeeWMa5yeAcEu3imYTd30bbeWscSZQdgYVU9OLbx9
	0LwpRJXh5G4Yl2qOb86kA0MOeLn+kcgzCr8uOWzeaDu5E1qeZDHGp8PAn+bUOutiexX11tLcbLlaW
	q06PUqQVIWmJDIgUISU9c9FSDuG0BV4aulTOvlaGvMnk4/zVd6MYFRHXff+685NrPm2LbvSFGKtk+
	3yC2tTNA==;
Received: from [201.172.173.147] (port=46938 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpig5-0000I1-2n;
	Thu, 28 Mar 2024 00:51:53 -0500
Message-ID: <ceb2091f-d36f-419e-8ed6-2165b6842d96@embeddedor.com>
Date: Wed, 27 Mar 2024 23:51:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgRIF1bkXlZlaK22@neat>
 <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
 <d5b0c70e-8369-4b99-9a42-9a4a93098251@embeddedor.com>
 <E3E65D27-9A43-4D99-8AF7-C857A169D8E2@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <E3E65D27-9A43-4D99-8AF7-C857A169D8E2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpig5-0000I1-2n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.147]:46938
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI3A+KRLJo9Wy+ZdpaV+T8u0e718EP8O7jSFAR3HbhKKc1NSKYDVI44Q+xb2LCIJtfezirazSBBkvvWAeNt4LBTHCTBtO9baaPdbOhZ663KMKnUe8l+J
 qQxnfEXkP6qe9viFyqKKG/WFQxGPmUZngq2dlpJjPs2FLLQT663Esj1MMgjNCsU2sPUH3T9wq32VevM6cZC02hXPNwmn6rR8CYDb3gonFAwChHIh3dkdPihM



On 27/03/24 23:28, Kees Cook wrote:
> 
> 
> On March 27, 2024 11:08:33 AM MDT, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> Hi!
>>
>> On 3/27/24 10:55, Luiz Augusto von Dentz wrote:
>>> Hi Gustavo,
>>>
>>> On Wed, Mar 27, 2024 at 12:23 PM Gustavo A. R. Silva
>>> <gustavoars@kernel.org> wrote:
>>>>
>>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>>> ready to enable it globally.
>>>
>>> Which tree is this base on, I just rebased bluetooth-next on top of
>>> net-next but it looks like CI is still failing to build it, so either
>>> we don't have all the dependencies already in net-next or perhaps you
>>> had it submit while the tree had not been updated.
>>
>> This is based off of linux-next.
>>
>> I think net-next is missing this commit in v6.9-rc1:
>>
>> d8e45f2929b9 "overflow: Change DEFINE_FLEX to take __counted_by member")
>>
>> https://git.kernel.org/linus/d8e45f2929b9
> 
> Just FYI, that is in rc1. (I sent it late to avoid a netdev collision.)
> 

Yep.

They haven't pulled all the changes from mainline up to -rc1, yet:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/

--
Gustavo

