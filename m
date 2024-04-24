Return-Path: <linux-kernel+bounces-156778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797478B0805
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B211F22A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C715A484;
	Wed, 24 Apr 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZTnGkGzy"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C652159903;
	Wed, 24 Apr 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956833; cv=none; b=awKwMAOMTj0uIJzQ72zDw13NF35zDAFID201WmHfv7figmoAWDEKzSPP9QawQZGJZ5OROpbz7atoA7RmiamJ1ajqEUmsn7IdW7tYckXj4bwsLRMe49esEx9Rfn8flcimHLWojAcRUoiGVVPHycALYUch8EegeqWWPKBAvjhuT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956833; c=relaxed/simple;
	bh=HIuZMhY7gmL38f+1HRFPKHO8EAylymTaSV39MZkYuXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTLyzHzbU2DiqReVKx6QD9f/zKkJIJAV7fjzUe/Ve5EeIoATQw1GEFKGLewFhG8Q3NQrAGRpra8FmuvNLmKitznMVkMjJJYvZIIMTqqnYry9ojSL7rnk4dQ4oLs6vXRfM2hr0F5YV5qjjp13piU+NsZjQUfrLa31AeFBfE8teBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZTnGkGzy; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713956788; x=1714561588; i=markus.elfring@web.de;
	bh=HIuZMhY7gmL38f+1HRFPKHO8EAylymTaSV39MZkYuXw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZTnGkGzyZ0PmSZaEiDOLvObJG2eYu2o07Dfxyro+gYNe4IYOg42S41aWvW1SgEOX
	 d0v5CPMVvoidaHS/CbI6UwqujiWmn3lO/stFEr+GY3abiuiqfBVBCQsKZWGsChUEk
	 l3yUrG+sfX9VgOOEUYxJV1Yy1RKY/2qtnyf75cUf8tKCnI2iBQhZmm8HBWHKirwkr
	 aEtmK46przSiiCooJl68oC589FzPubfD8uTbJQjC3G5bpMBKTwOlVeBdFINdvjdrE
	 G0LH+0Mu7B6frOOULFiu2+NAzvhz+4U/jqHNIc4Ny4rWVOj9p2ixjsSER2Zx7JqwN
	 Jn+yvPqUNKvz7SZj1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1skfFo0Gui-016yeo; Wed, 24
 Apr 2024 13:06:28 +0200
Message-ID: <a89a7147-57b3-4881-86e0-410eab56a91d@web.de>
Date: Wed, 24 Apr 2024 13:06:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] sh: Call paging_init() earlier in the init sequence
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, linux-sh@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@quicinc.com,
 Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
 <f74fdb82-5d66-48f2-830e-3874570f022e@web.de>
 <7dd171cc41474871408f06326aea5cb87923e454.camel@physik.fu-berlin.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7dd171cc41474871408f06326aea5cb87923e454.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRNMe9qrU5aJRpoCAfC5rz7EUjw5g56wfPskauKuNvH3ZMG5EEZ
 P8nP8/oqVw4ue8jYew8HIpRoghFb6hsUIi51KaduMss+ekyviVrdfraIlD2lN5ffL0bL8rC
 YbdAMzq6yiBptALvY8hMKpXQ2is5lA35FX76LL3M8qt4R7UA8FI+FEoRaf4BlDkXAplQ9dl
 mUCM7hqO/XHtIjBtEjY7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QllExh7Fwoc=;bjfyI7DOEdkwOJ0LEZi2g3NyULL
 hKf7pVdwBQpHfkUeAIq+sGCyuhCZFB9oxhB+lEfwqiSCUPK5IwTDZ/4yBj5+PdCkhLe3/O0k0
 ACbMfd4XSDcsQWLFm9faOre3A+4H3+AaluNhfviqTy2Bx1pPdc1Pkj/cE1W5VMO3td94e2Uo5
 GiDogpomprcEyRT9DfqQJkblyrHAyVgI5KozmnfAd84y0553AwSlWAz5JnqRNyMNllCmib33I
 ZfMjEk378K/iFdzV1KnAY7sLkuilc7TWB/kqft4pQRZ3ufe5AiYyCmoJ7kKZEdZkjFQqPrlYE
 pIt2HmEHzWtWwh13yPNsJ1ZS3Mfl/gI9sJATaPlBKQjzVnmle/s1svJZT4s6UHULmeyWKsBkm
 wCNsqZ62PYQB25h11NYbWBNys/yeUBtmBVXOHlaYnTC32WkLniN6KEeVlzofTJoqBJ/Wr9G0A
 /l2MfMCj2HEZRfHXCpb3KJfwhSbYnRd6Dt93E6YF9Goc2Kf3oOg9ExdH++8SJKnBivguKI4sY
 aPhryC5XfXrpTDKwYfjdwpSPqnrFtsrtm1TKTlmukyLSVa1hS8g6DI0Z25ks0h5ZtuKfPyr6Q
 cvLAP0+eSvPJg45YtV+LarDmRgpPO6X9bIPYHFr82r+Pdn6h1obq8AgfXBAi0IMmNqrHcL7fh
 6eJKdR3/0+oLSZLW8fzKcQ7J6JRqTiEi5MUvjCJue2ItvBzaTUOXs9hcVNEduaBtUhCjPkR7I
 VeEW4y5co+kMd5pd7g3Y9kYChZFMS1309aEOwlML7hkZFzinm7s8f74Dmq+17EMbGswumnmKQ
 8w3ljYhjMjgZFygpClytMyLS7ncClPU0ocTBieZaGmOTk=

>> =E2=80=A6
>>> Hence, move the call to paging_init() to be earlier in the init
>>> sequence so that the reserved memory regions are set aside before any
>>> allocations are done using memblock.
>> =E2=80=A6
>>
>> Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?
>
> I'm not aware of any bugs that have been reported in this context.

Can the mentioned questionable function call ordering be interpreted
as a programming mistake?

Regards,
Markus

