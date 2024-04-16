Return-Path: <linux-kernel+bounces-146758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66D8A6A76
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB4F1C20CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FE85644;
	Tue, 16 Apr 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DzzFlkEU"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427112A163;
	Tue, 16 Apr 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269684; cv=none; b=bnvr7kTsmzhFPYHDyJaTicyxcXliQLtzVBUmCNT9ysZKSAY2W5YW+/hIgFO+GMI2HQFWGFytq9vhl8LbQU+6pIcZcEQ8bEJdLgHVJaDMDOb3mVPHr3cXIG99hArPTGdfSlNLcjGuWAZ+T1O//XIxjD1CybFM6y8PhVtC54/MeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269684; c=relaxed/simple;
	bh=F3vyWR29X0lXAaTUtv3IWAlN8f9D6N5W3tJOFc7fnmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp5ileCkouCkVYdBy6WSf92Ptz0VXbf0IQ+lhYVx/OuXusu7KYA+ms0OUrN2cG8C7wJLCuGjx+LrSwpyAkO5cqLHtTNLiZ13d4sJ/uIPCSNCiXJt/0+8Zop2f+y9rN6wJ4pkjTYypuLxM27D3qNEjvwMaNgYvEswdXSdALvOXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DzzFlkEU; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713269670; x=1713874470; i=markus.elfring@web.de;
	bh=Lv4Wq6qu9p1ZBlPnYwsPtJ9DrW7B8a2DGJ+zDiVy+Vo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DzzFlkEUke+DhEGxPHdIS8e4/ngQIMUtZ8HEZd1HZgFq6/3lNsQorRZX1khJ9Xwt
	 0SGBJYOr+f/Dd3q8G4gJWCI+OR+6jFNWWoWBY1ra4Nv/dN6urer/7z/Tl7epWgF2B
	 uydQzFiYsdAg+egdNjjkO8pYx6Dp55rvzfdB7q91aevhS8/NZnjWfzqjTeBb/I3ba
	 hYVB6vNVLFlruAKhELns3sYA/a4DeEH/JolGvjt4w70i5L2ZvvrA+lqOmxcr/ib3v
	 ii4b9cFFFqJs7GTx1jJ/4eevBEsJUqyL5AVkAxXOaDgakG1uSPihBBHFZSEhQSZYC
	 zC62WaDdQp7G0L76IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1rullX0mPx-002YIA; Tue, 16
 Apr 2024 14:14:30 +0200
Message-ID: <33a38d7e-26da-46e0-90d4-7137f9ec0c90@web.de>
Date: Tue, 16 Apr 2024 14:14:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
 <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsxChQyFzhPEKKvYCyvy7NgsHW1pjrvs8WruIhj+JKDV7dHWRe0
 I4b/QJ8s8AXfyqEPsqrF3pGy3hn/sZ+YDLWr95BvPAPEz1iabte7Xs9qjteD3zPuY3bU47F
 XW9ujYjwb5Ccas8EWQ2MHwVzl/UnDEYgne3L/Wx1VhSNyLAeOQUpOI803P39hx1YTXPc2OO
 IuN9VbCGqj8aIop4FE3tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cgnuqKGvJbs=;A9nNALScgBDWwff956u51qJ3ddr
 IwHS8JlxBuV4T5W7RhoUOEBY/k5hzh1H36Nvz681MqMc/Bt7X4y7ROd7hwnkWwz1GlenSxin8
 rETv+oYf/jAVXATFkGSiM92DXMC5jKaPJDdnc0QAL2QhOyJ4YyiWehUfXE5guZ/cgkGjgX62U
 k2ythW+58+lwecDDVYYL5+PxUsPJiLU8Zs5Zh2aJQB+jzsF8gFdbRgVrCh1hWfuEtEbQTTTXe
 JdDTK7oPYgUHPa6WhdQRG8Mjdqft1ZSR+gQRdIU7wBLI7uSaS/R1fXVPh27xpU5B6PwusfQlL
 GPjqUv0xkIuEfnYb3RJJTOqrc8WMxp4DuEAICG+MWlz5U5EwjDl2B050SoMaa0BOZkPybV62K
 VUW1aGirQj9Bh7Tak4lhDw4vZwwG6swjpetwTsa29/9P0vBZTjJ7EWQPtS8GYg06RjMX6SJIi
 3H1arPp0IZvpSMBLt47D6xzFpq6/aJoa3ZZ2vk2BYTkrdnaFJOvU5tN7WUhAJiBbEh0RF7lou
 V4ABevcKcEDkD60OQyW2eLpJL/TuyJ9SFhi4vI7Ftw0gFCjuEmysuw2F/Mfol0zQFpxj4MhOV
 Sbo17qHtgKSZLewLIVsCDPO6VoWmmiLmtQBBKYNZ9/D0RnhX1FKcow29VoZYkecg592P92F3K
 Z6JJ6m/oZ7MGneIspDw8jSKSET8DNH2aJ1fwn/wHTewvizMNI/t3QfTLaIzZgJkds+wyBERZp
 0AuiMSAbgoWWuxOhLSIzt0mvHFE5rX4rCBoBA/rrFgZH6pk+/OJBcSySbwGc3zk4nSkmL1IbS
 vEVhAV0RbpMZDjzbF3ZDBuM5HgpXM1v0IzO0IG189sfSc=

> This is explicit in Kernel documentation:
>
> /**
>   * kfree - free previously allocated memory
>   * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>   *
>   * If @object is NULL, no operation is performed.
>   */
>
> That's exactly the same behaviour as free() in libc.
>
> So Coccinelle should be fixed if it reports an error for that.

Redundant function calls can occasionally be avoided accordingly,
can't they?

Regards,
Markus

