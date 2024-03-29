Return-Path: <linux-kernel+bounces-123883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECD890F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E33B21F49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B4182DA;
	Fri, 29 Mar 2024 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DbrgHuvL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE314A8F;
	Fri, 29 Mar 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671817; cv=none; b=kYkn7xe2a0hI6tHPMM9eo1VXfGqFjdrR1RqZ9UGqsDIWp17SwxufsyKaaQp1npdir7bWG6+2yOsyGFQXw3v4nZIYjsUSLTTOS+Or+t7to1ha1QQFNgRDwCa8oLQXW2CDuuKZ8ZEDtTooP/ak5K2COWcLluPej9yqJOL7tGB0F4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671817; c=relaxed/simple;
	bh=QQgR7iomNGX0bSVus4hS65bFO/2THSxfma/6Hee+5pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJFLCa9MxVcyFBvwjzY/cLjIZf/HfNig5Lsturv8UiZgyynODRhxGqlV6OBUAvsr+NofKuzhvHvA0OuviyTI4ft9GIG1elfTO3j2UEXXRQeeA6cv/9YpJjZ2BcBycp+nnvEiUf58mwH4aehhLDXyZisXA4BFL28vdOUn6kvBMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DbrgHuvL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711671806; x=1712276606; i=w_armin@gmx.de;
	bh=QQgR7iomNGX0bSVus4hS65bFO/2THSxfma/6Hee+5pU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DbrgHuvLmWW+XyrqZepb2XdYXUS83w2Rd8n2MCKFBPnX8TzYsJRjJluIvK5M7DKx
	 LSOg31HKxmvdJibDfYHRPkZnj+V+cJm6Ipn/lu9UmBNbKGb6EGcLhxP4K0pLW5ag8
	 gIUS2wo9Q6ThGUDy5RPihViuto2Gb7aUqYLujNQWZVnVmPIh02+Q5VnbNWDRnNltu
	 oPaIArhjN++d7jV9ri9WxDUm6/tWItYO0f/LimlCAaMGLyyi9PCoE/mbUMSpg/RyI
	 OUCX4dgBrGhP/J+kk1J3+CI+r1ymSocTqd0QzVbVeLq7cTpf9F7Zh24AFwK8oWCaQ
	 1xPovd810RKMfqpqBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1sA8F50NGD-00KB4M; Fri, 29
 Mar 2024 01:23:26 +0100
Message-ID: <1ff02eec-084b-4d4b-9629-cd1a104e6213@gmx.de>
Date: Fri, 29 Mar 2024 01:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] platform/x86: quickstart: Miscellaneous
 improvements
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240327215208.649020-1-andy.shevchenko@gmail.com>
 <a2362908-feab-416c-b5ae-13d560089ee6@gmx.de>
 <CAHp75VcnsxanOpP+v+EFqpO1TLXyuz1_55Qvttrib9=T1Y1Y+Q@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAHp75VcnsxanOpP+v+EFqpO1TLXyuz1_55Qvttrib9=T1Y1Y+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jd4EBrWa2IIopu7TkDyxFlqmdKXGWD9lPPOrq6ApwJxk+tNNgBb
 PS8O9Zor3WEfcX8mqbkILpiWwbCJSYK+asU+Sj2KZlmA0E9+QY4ALpMOZukLZg0R4qMkgS5
 J3D8gTrXEvJCNIdc2N3jc/BVaK5djy4srQVMBucYFM2g1aTorONgXeYvvw4nGI09tTw3N2L
 P335wn33blBk3QQ47XPlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ibJfbMIAWoY=;PDU4vzZfhYJV7LNPhnolBzuQu7C
 hiKW2WA1esExR8JP9HIssMg4rkYlXxP5arqIVPZ9ivJTPvw9GQkcjydNXK3WhxwxWRN8a2HgE
 W971gsDX26vf/+/7DsoivUCoJcUppZ3AK7YG4+tMZsgb0M1FivHWplq79s8li/2sAvn5CmE8M
 +8gMHSb27rNmtziuZKqsQiGq29c2SWE0XNFIspVfBMN1v/aONgijbvhJfbdNYopp8KWH/t5U+
 1vgftmMP2iJCyljY/SNc5SK6P5VpBnXiYmbSeHDRRPxr0vX3t7TUp0Ibvogw9V0jKDmE0k9Sw
 3ip47nheQWmVjFIkoeEKyuqelQAiashKmUz8BY3+E0/4dkC2g34vi3APw0tVtXxyAJ2MH/vx/
 WTuF1tZZ8yLYiKSfscUYlLnuBFDL2KXmHVsO5kg8CbFrYyiS1UkoLydbSH9+FLBu9zCtISbeL
 kMfIp0DNj+TiwWE21fgahUe086xxq1255CnDUtFTYjnsXz3o6T8P5PAnzO2vgmeUrj4isLO4l
 yp+1NmZtIs5Uk6nXwjlcomqX+lzKb2ZDkZ/m2+Z7ZWA6ZI65x9xgINIn1yG0y8J4+GYFVo+Xw
 D+AmUB+8d9xScYoKTDIJkuAcW2bZig8jaFM3ELUDNF05KdT8iQXjj+2TYIyvyncxke5s2UG58
 whQuq8pbsDZNgc2eN+pVSe4dzpwTFQ9wxhCq1GatroGkRgRBtl4REIKoZR+VJpyCSaYsjBM/X
 tG8KI+9jiN3/bFlpa5L88QI7I/1QcFmk9Uf+4QcnsDThUWjZvYeabnNDRBPcQO9ppajLWAT0S
 UGepnCgkIlMfP9ahV5Vu1UBnPgtKiex5PKLbPkA4PLNxc=

Am 28.03.24 um 09:50 schrieb Andy Shevchenko:

> On Thu, Mar 28, 2024 at 1:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 27.03.24 um 22:52 schrieb Andy Shevchenko:
> ...
>
>>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> that is the reason for removing this?
> Yes, it's a dead code. Likely the cargo cult line was copied from
> another driver.
>
In that case: Reviewed-by: Armin Wolf <W_Armin@gmx.de>


