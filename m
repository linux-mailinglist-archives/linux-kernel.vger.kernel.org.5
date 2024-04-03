Return-Path: <linux-kernel+bounces-128926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B028961EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CABB1F26F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48046134B1;
	Wed,  3 Apr 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="infsyJV6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559717BCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107299; cv=none; b=KMtfg0E6fjzuSxpfiiYpagBf75ENsGpS2z88sAMhDAIHhewNOT9/fni2K1QffF4IP5r5794yJ3RorjFSgSXXSb5rmRiMnQ0YSAAqa3aR5k3UnL3abGYYe8VVTj8K6nctdCj8VXHjqCqSXiAw5zg0snpBMIshPmHGmYgB10hfQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107299; c=relaxed/simple;
	bh=AwR9GA1SKDtJCvAtWSPh9faOBya3UFFgdo2pD6G7UII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=s6Dp1Y5MGxylzhxCWFVHHjZT/fXPZdqwm7V8L/KnlSAJtK7BSfS8sOPlDlPbaATZOBheALKA8w+o1L5w1TkZVBecsZMNwHOXyuwLPkFVtuYeKnatoFhnwon/NDTwgE40ATe7VPboaH9iua6DYV0yf1BZA8CPW04QG/TtszPoVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=infsyJV6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240403012134epoutp03e4b9f18b17eedc351192e2ce1418731e~CoINpeTnK1500315003epoutp03b
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:21:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240403012134epoutp03e4b9f18b17eedc351192e2ce1418731e~CoINpeTnK1500315003epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712107294;
	bh=15ScYprIi2wlKlqs2N9bGdV42mZntBJrNiCaHjA1tDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=infsyJV6IwiImwKS9YVn7Wl+eEBFfzTCbfs7hugAfmRdkrrN6Qmu2jUDWDJInGwF8
	 IfzU0/gq86m/or+NpdJwUcfQ2maNeV81/zi25PLImlJ0pFkMM2mfbvZHGSmLcjksQK
	 Cx5Fu1rSP9Ie5vXibatDR3yTPpCYU9I2ijbYtT4c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240403012133epcas2p2de9683ce20f971637236519c19bfaa41~CoIMr1pOa1006910069epcas2p2x;
	Wed,  3 Apr 2024 01:21:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V8RmD74PVz4x9Q6; Wed,  3 Apr
	2024 01:21:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.3D.09673.C1FAC066; Wed,  3 Apr 2024 10:21:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240403012132epcas2p430da5d3644461ed8148b9f92d19b7e74~CoILqGNNv2618926189epcas2p4q;
	Wed,  3 Apr 2024 01:21:32 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240403012132epsmtrp2dd96cc4849a94a0286741ca74c4892bc~CoILkuDst2055020550epsmtrp2-;
	Wed,  3 Apr 2024 01:21:32 +0000 (GMT)
X-AuditID: b6c32a45-a89fa700000025c9-8c-660caf1c92b6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.31.07541.C1FAC066; Wed,  3 Apr 2024 10:21:32 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240403012132epsmtip15baaf75583f628b6bfac67b012ce5492~CoILWV8Do3199731997epsmtip1L;
	Wed,  3 Apr 2024 01:21:32 +0000 (GMT)
Date: Wed, 3 Apr 2024 10:21:32 +0900
From: Bongkyu Kim <bongkyu7.kim@samsung.com>
To: John Stultz <jstultz@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, bongkyu7.kim@samsung.com
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
Message-ID: <20240403012132.GA460@KORCO045595.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmma7Mep40g/77xhavG18yWazZ0shk
	0bx4PZvFnxMb2Swu75rDZnH62AkWi0sHFjBZHO89wGTRcsfUgdNj56y77B4LNpV6bF6h5bFp
	VSebx/65a9g93u+7yubRt2UVo8fnTXIBHFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
	uoaWFuZKCnmJuam2Si4+AbpumTlAxykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
	CswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMWvrzGVLBVsqKl9y1zA+NbwS5GTg4JAROJ34f6
	mLsYuTiEBHYwSryaeZ8dwvnEKNH9ogcq841Rov/6NBaYlgV9L6Cq9jJKHFryBKHq5o8DTCBV
	LAIqEsuuXGQEsdkEdCT+r54BFhcBij+c+5MNpIEZpPvCh0vMIAlhAReJtu/rwRp4BWwkfj3e
	xAZhC0qcnPkEbDWnQKDE54W/oM6YyyHx7Jh5FyMHkO0isfp2OURYWOLV8S3sELaUxOd3e9kg
	7GKJiS+ngh0qIdDAKNH0ejvUHGOJWc/awfYyC2RI9LyaywwxU1niyC0WiDCfRMfhv+wQYV6J
	jjYhiE41id3PW1khbBmJg2fXMkHYHhLXDk5mgoTJDUaJ6QdWsExglJuF5JtZSLbNAhrLLKAp
	sX6XPkRYXqJ562yosLTE8n8cSCoWMLKtYhRLLSjOTU8tNiowhEd2cn7uJkZwutVy3cE4+e0H
	vUOMTByMhxglOJiVRHh/enOmCfGmJFZWpRblxxeV5qQWH2I0BUbTRGYp0eR8YMLPK4k3NLE0
	MDEzMzQ3MjUwVxLnvdc6N0VIID2xJDU7NbUgtQimj4mDU6qBqXnWdIc/D3f82mg8587lA7HJ
	s0unXNVR05zAe07+vOpxcQXBSPOgPQdOndN8mNlz9UJQwP8jySYpshF2oSqdFQsO5qVuLqjY
	/atsivKxV91LVla37rX+9cbi2uu2tW65S59NUtPdcfvmy/K9CVK7fVTqsoLu/rr8tYvriued
	M3kOpqcMLKbZ8uy+ofss8OulUw+VAg9s3tZ7nVOj7FnmV3mnr2cLHrVHL/E0EDhXJHXeLnW2
	RW2Tzw71ft8H541KQ2P9an4ujq6+U8Nw5xnTqavn+OxPOyT/jfF3fF97a3dlG+eXmoUeBpwn
	p5io5GV9Wfu3aUf8Va0p+6O2KLcwvIg9wSLb380+jSdss+7Rl0osxRmJhlrMRcWJAGVv9ldA
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJTldmPU+awflDAhavG18yWazZ0shk
	0bx4PZvFnxMb2Swu75rDZnH62AkWi0sHFjBZHO89wGTRcsfUgdNj56y77B4LNpV6bF6h5bFp
	VSebx/65a9g93u+7yubRt2UVo8fnTXIBHFFcNimpOZllqUX6dglcGW8OLmQsuC5W0dw9h6WB
	cTV/FyMnh4SAicSCvhfsXYxcHEICuxkl5l2bzgiRkJE49G8tE4QtLHG/5QgrRNEXRon2OYeY
	QRIsAioSy65cBGtgE9CR+L96BliDCFD84dyfbCANzAL7GSW6r6wAaxAWcJFo+74erIFXwEbi
	1+NNbBBTbzBKzP+0ix0iIShxcuYTFhCbWUBd4s+8S0DNHEC2tMTyfxwQYXmJ5q2zwWZyCgRK
	fF74i2UCo+AsJN2zkHTPQuiehaR7ASPLKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M
	4FjS0tjBeG/+P71DjEwcjIcYJTiYlUR4f3pzpgnxpiRWVqUW5ccXleakFh9ilOZgURLnNZwx
	O0VIID2xJDU7NbUgtQgmy8TBKdXANFO10iB6S2KwtANrzdZln94t3ZtWpenmvnHK09u1D7//
	+b/BO7VumyX3F62iPHPvX9XuHEvKs38viV5SaiL055zbpwMVB4TeVq2yEIvOadvguf6T27Pk
	o9Y9lWvK9i6WiwqvMpV0f9/weMa1s/Okt/CtfbK8z/aVyYKVKr29Rmyv59dslGjQefGV+0kt
	32Yernk+URqM5X03lN6VxbXcEFfvUajw2xDwSNkr/MeniWWFrx+HiN6TNy2+oVB1/YAd62Iu
	nssi7AJuutffBCw4aN5T3hWbYh2/8+zjrvyC212nDQPmr6wRM0k3mpsxPbx6rcb5Y/XnZkpt
	y/juK8k+fYejwX/hEzzu8k+PWLoosRRnJBpqMRcVJwIAOEb86hQDAAA=
X-CMS-MailID: 20240403012132epcas2p430da5d3644461ed8148b9f92d19b7e74
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b700b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p4aadced02d68d3db407fda23de34601d2
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
	<20230901010704.18493-1-bongkyu7.kim@samsung.com>
	<CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b700b_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
> On Thu, Aug 31, 2023 at 6:07 PM Bongkyu Kim <bongkyu7.kim@samsung.com> wrote:
> >
> > This is rework of the following discussed patch.
> > https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/
> >
> > Changes from the previous patch
> > - Split to revert and modify patches
> > - Change according to Waiman Long's review
> >     More wording to documentation part
> >     Change module_param to early_param
> >     Code change by Waiman Long's suggestion
> >
> > In mobile environment, reader optimistic spinning is still useful
> > because there're not many readers. In my test result at android device,
> > it improves application startup time about 3.8%
> > App startup time is most important factor for android user expriences.
> > So, re-enable reader optimistic spinning by this commit. And,
> > make it optional feature by cmdline.
> >
> > Test result:
> > This is 15 application startup performance in our exynos soc.
> > - Cortex A78*2 + Cortex A55*6
> > - unit: ms (lower is better)
> >
> > Application             base  opt_rspin  Diff  Diff(%)
> > --------------------  ------  ---------  ----  -------
> > * Total(geomean)         343        330   -13    +3.8%
> > --------------------  ------  ---------  ----  -------
> > helloworld               110        108    -2    +1.8%
> > Amazon_Seller            397        388    -9    +2.3%
> > Whatsapp                 311        304    -7    +2.3%
> > Simple_PDF_Reader        500        463   -37    +7.4%
> > FaceApp                  330        317   -13    +3.9%
> > Timestamp_Camera_Free    451        443    -8    +1.8%
> > Kindle                   629        597   -32    +5.1%
> > Coinbase                 243        233   -10    +4.1%
> > Firefox                  425        399   -26    +6.1%
> > Candy_Crush_Soda         552        538   -14    +2.5%
> > Hill_Climb_Racing        245        230   -15    +6.1%
> > Call_Recorder            437        426   -11    +2.5%
> > Color_Fill_3D            190        180   -10    +5.3%
> > eToro                    512        505    -7    +1.4%
> > GroupMe                  281        266   -15    +5.3%
> >
> 
> Hey Bongkyu,
>   I wanted to reach out to see what the current status of this patch
> set? I'm seeing other parties trying to work around the loss of the
> optimistic spinning functionality since commit 617f3ef95177
> ("locking/rwsem: Remove reader optimistic spinning") as well, with
> their own custom variants (providing some substantial gains), and
> would really like to have a common solution.
> 
> thanks
> -john
> 

Hi John,

I didn't get an reply, so I've been waiting.
Could you let me know about their patch?
I will try to comparing the app startup performance with reader optimistic spinning.

Thanks,
Bongkyu

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b700b_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_b700b_--

