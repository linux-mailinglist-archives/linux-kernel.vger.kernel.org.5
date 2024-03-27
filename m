Return-Path: <linux-kernel+bounces-121672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E9188EC23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A471C2E0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317214D706;
	Wed, 27 Mar 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VTizb/8e"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC912FF99
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559336; cv=none; b=URFZmthx8eDp2d1kBidiGqNOku1jyPX0vWunhNZZ7QfIjvA7B3sQEeC41EOdVA4jNGL4oWib+Tbb8gGeuaBmN1pnP/oYFSPBJs3QkY0k0dlSuj6aqrTNOLBnvA5mgCYZSBPHItmLTE8hqRDkTSFMWuAyoCdT/bc+mel0SdldOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559336; c=relaxed/simple;
	bh=gMN/vy1OEAGkXDYuiqVo7/hP63UcoJ3uKwb/j9S4MrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8eLRke9Ot5ztJSGvG9J/p1QMT3CBItkYL752W5+wcRh9HE20gP75REAoso4sNC2/zxfBhpQabYfDtCONwe/kizrxBSxJUM4Q1cEzOEYueRq0sLrkAmEKzytksP0s7AF00QQRNRHRcSVmS7dQTxxV1OOSlzQzRg/GfBPTbhEqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VTizb/8e; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id p9lirZEWrHXmApWlcrvqdz; Wed, 27 Mar 2024 17:08:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pWlWrsRyfiKqRpWlWrTt0q; Wed, 27 Mar 2024 17:08:42 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=6604529a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=94brYO8VEXWNUbGmlHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lSCdqTkx1RljbiqDMVW8JxneDk+aNzMqtkDooNcx1vQ=; b=VTizb/8erBSeOHgRDK4TOCBTbK
	MNAbyEO8E8ekOM4tvOVc9aqjXSOPBiWwcfNJTHM3i5qI8apQrHoPJv8/ZvjKd/DQ5CvS+TLX7CuwU
	/VOXsNIWvAEI66e1BdhRuZoPh/dEVY5+S9VgOx8UJ6jvXf1fU9xdddpkbi5UndS9i921mPdD5XgDp
	XOQmvJ8ng1eNr9C7n8kXwmLbE/cnu832gPvDETyWYKgWV/2uk90nuYcB0AjMOqFZniGx4WB1x/eWF
	wDIYk3l03cUgta1YH/XWXc/Q+O2YPHQaoev7Vis4cp83P67f4lvN6dHEBpto3KjtukxfjtmlVMj+R
	eAlTG9Nw==;
Received: from [201.172.173.147] (port=54120 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpWlP-001nk2-05;
	Wed, 27 Mar 2024 12:08:35 -0500
Message-ID: <d5b0c70e-8369-4b99-9a42-9a4a93098251@embeddedor.com>
Date: Wed, 27 Mar 2024 11:08:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: L2CAP: Avoid
 -Wflex-array-member-not-at-end warnings
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZgRIF1bkXlZlaK22@neat>
 <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
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
X-Exim-ID: 1rpWlP-001nk2-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:54120
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAcutCFpTy7I6bSF3prWDH9SPu5ep83EZOGu0tbXNUb7276IHVigRsBISRe61bbsDg3nDCSvFFQ7CYBAmCe6n6xlBitrWrREj9HlVAZtVqCN7W8BPNkf
 lfmmasFuV0jIMh34Hi8t8tAQCa8hfisrJc8XtJHUei5Mq9XLHR+gxt0yOcnGgTQctBWEdrl3FZ0gCxGdoOPIltjPenTUhLAbQnrEkP0vDV+uTTIrMSEk53hf

Hi!

On 3/27/24 10:55, Luiz Augusto von Dentz wrote:
> Hi Gustavo,
> 
> On Wed, Mar 27, 2024 at 12:23 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
> 
> Which tree is this base on, I just rebased bluetooth-next on top of
> net-next but it looks like CI is still failing to build it, so either
> we don't have all the dependencies already in net-next or perhaps you
> had it submit while the tree had not been updated.

This is based off of linux-next.

I think net-next is missing this commit in v6.9-rc1:

d8e45f2929b9 "overflow: Change DEFINE_FLEX to take __counted_by member")

https://git.kernel.org/linus/d8e45f2929b9

Thanks
--
Gustavo

