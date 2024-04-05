Return-Path: <linux-kernel+bounces-132496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D18995E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD29F1C21F43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC34224CC;
	Fri,  5 Apr 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UelaUZFt"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77423759
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299901; cv=none; b=UkT5B2fpODs5e9cuBi0nm7A5nvUcWSrLJc671ZocZ+m01nnX2CVxZvGMJ4XwlCmbMb0RRz2pvZa9VE8fX0xavtIlVLgW53jXq0ZbTTgAbCDDh6mYxIAaevoLwBc4Oh/I9JF+wJKLfBWzsAXlZjJw5NZ8ElUwCFZApuCaElWI7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299901; c=relaxed/simple;
	bh=iS1di4OXHWfUUWsLTEF0P7J2I7Appt/Dke0GxuOsJtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=aZlf1vvX4hfJYeH54z8KKxGiTKChq32bIMk+kLErPqxaepCplA3vo/hWdGJyL2ha0oBm8Mr/3DRpvFaT7HpdHfIGIFfver90bgZxi9TfaMg0yJatAwoUztmBq++NCA0PYNrH0xdVtQPsFn3M3cAGWQs47bQGIp4Hka/KR8DXXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UelaUZFt; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240405065135epoutp0494590a2593f9ae1a7018c0b1155e77de~DT67CKS_52272422724epoutp04h
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:51:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240405065135epoutp0494590a2593f9ae1a7018c0b1155e77de~DT67CKS_52272422724epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712299895;
	bh=wpi+x25p2JOWjJWAY9WVNpsWDrjrXSMxL/ddqQjzXCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UelaUZFt7uc7QmToK9HDXDQAkbCUd9WtSrkeHnD8Pm6hilhASf8Xekj6hsPMW7OoT
	 NakF76ekWjxs7W12UBCdF6BoXqyqWHY8XJHxSrT3Aapg1Mci8EDk9RpkIW2NEZGUSg
	 EAp1okb0aS3isUt0a77wbZU3YxHwoQoJRUyDkUp0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240405065134epcas2p4fdbf40376dbcb992c27a667b87f86e68~DT66Y9svT3232832328epcas2p4W;
	Fri,  5 Apr 2024 06:51:34 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V9q060w23z4x9QH; Fri,  5 Apr
	2024 06:51:34 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.FA.19141.57F9F066; Fri,  5 Apr 2024 15:51:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240405065133epcas2p34a7dc2ee8db45ea45e46a38fb1045b52~DT65h_Nwr3036030360epcas2p3w;
	Fri,  5 Apr 2024 06:51:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240405065133epsmtrp2c5454fdccc4be74383d96f64cbcf7a56~DT65gstK20321003210epsmtrp2M;
	Fri,  5 Apr 2024 06:51:33 +0000 (GMT)
X-AuditID: b6c32a4d-b17ff70000004ac5-eb-660f9f75b022
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.2A.19234.57F9F066; Fri,  5 Apr 2024 15:51:33 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240405065133epsmtip16d17ebd6929becf0a5ae2ebc5c7b2ff8~DT65TJhHP2131821318epsmtip1K;
	Fri,  5 Apr 2024 06:51:33 +0000 (GMT)
Date: Fri, 5 Apr 2024 15:51:33 +0900
From: Bongkyu Kim <bongkyu7.kim@samsung.com>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	bongkyu7.kim@samsung.com
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
Message-ID: <20240405065133.GA5329@KORCO045595.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <45ddde77-a5dd-41e8-933f-36ed0f8cf178@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmmW7ZfP40g0dnmSxeN75kslizpZHJ
	onnxejaLPyc2sllc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pA6fHzll32T0WbCr12LxCy2PT
	qk42j/1z17B7vN93lc2jb8sqRo/Pm+QCOKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
	dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
	FJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGecu/CQqWCWfsWV4wfZGhj3q3YxcnJICJhInLm0
	krmLkYtDSGAPo8SK8ztZIJxPjBIT9reywTk7H69h7GLkAGs51+UDEd/JKHHn2G1WCOcbo8SM
	+V/YQeayCKhIvFs1mw3EZhPQkfi/egYTiC0CFO94+wMszixwllHi9EptEFtYwEWi7ft6sAW8
	ArYS/z7ogYR5BQQlTs58wgJicwrYSdw/DLFLQmAmh8TmpxPZIH5wkXh16hYLhC0s8er4FnYI
	W0ri87u9UDXFEhNfTmWGaG5glGh6vR2qwVhi1rN2RoiDMiSufb/DBvGlssQRiJnMAnwSHYf/
	skOEeSU62oQgOtUkdj9vZYWwZSQOnl3LBGF7SFw7OBnMFhJ4yyyx7FjtBEa5WUjemYVk2Syg
	qcwCmhLrd+lDhOUlmrfOZoYIS0ss/8eBpGIBI9sqRqnUguLc9NRkowJD3bzUcnh0J+fnbmIE
	p1wt3x2Mr9f/1TvEyMTBeIhRgoNZSYS324E3TYg3JbGyKrUoP76oNCe1+BCjKTCmJjJLiSbn
	A5N+Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTHYGm286JZyp
	2P8yYHFs+gXLA+V+gT2Fc8/lTG2Xkl2k7uZikJk4XUTRokJC+EFz6Mz0mdPfGt7rL/iZ/3jj
	2blHGcMNG9xeHyp9oTPfoFQwPsVhfaTn3cKCW+bGB9wWnzoTv1v6s3b9/e1TdZ5tPT05xniX
	mUzDrWliexU/KG67xnGwpIt/74vdsjs33VPpPbk8bduDoCu1E5TN7Ht61ggU2sx9bZJ+vC7w
	5bKVl7zdJdJ6uxnZ718LCHB6klTUnG839bfYtvtatTw/uJZtmxllVPZ+FqfGvbRPtzw/Mib/
	Scp8PN05+0vxZ+vK8rmS3+xq70ib/362qmimfkHt9ilsfazJXHa9c3b4zFkrosRSnJFoqMVc
	VJwIALy3GIdCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnG7pfP40g2mPlCxeN75kslizpZHJ
	onnxejaLPyc2sllc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pA6fHzll32T0WbCr12LxCy2PT
	qk42j/1z17B7vN93lc2jb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Ms5d38JWsEen4nTXXpYG
	xr9KXYwcHBICJhLnuny6GLk4hAS2M0rs7mpm62LkBIrLSBz6t5YJwhaWuN9yhBWi6AujxO/1
	88CKWARUJN6tmg1mswnoSPxfPQOsQQQo3vH2B1icWeAso8TpldogtrCAi0Tb9/WMIIt5BWwl
	/n3Qg5j5llmio/snI0gNr4CgxMmZT1ggetUl/sy7xAxSzywgLbH8HwdEWF6ieetsZhCbU8BO
	4v7h26wTGAVnIemehaR7FkL3LCTdCxhZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIER49W
	0A7GZev/6h1iZOJgPMQowcGsJMLb7cCbJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUgg
	PbEkNTs1tSC1CCbLxMEp1cAkuvve9FPFH5ofV3EJH3N6MtNgz7KIk3enn8x+0Hgw7P3JGTtq
	mGo/R6y8ylmWWnaA+fMTZmln379RH1VEl+5mfyEtm30o6vscF8lLvydZrbeOOlfXo8O5ufKd
	XpN5bNzfU7NXSn5sm+3fUKE9YVX8qXmztVI5zI5JTPhxSmnn49I//b0LwjvrNnv4qXzYwix6
	LexXXhh/4QOh9Pv6Sw3UrIO4fu5mWbR/nsXc2LzIxtqHM0xXvDzTveXYm5iYrIQ+d6PlHZfr
	nWrM706pTZzyT0k01b3unZbL3S+us1J5WLy85P3e7np0url1x9zN4cb8s6YJf71/2Yr7678C
	Dd3UtVeSzd+bZX+f8Jlt/4r5SizFGYmGWsxFxYkApfZvAQ0DAAA=
X-CMS-MailID: 20240405065133epcas2p34a7dc2ee8db45ea45e46a38fb1045b52
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----TOZlIVLwwMrWyiQcmaMv.RfJj4xujRO9DKwkEeR9_h2yBUMZ=_d27b6_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p4aadced02d68d3db407fda23de34601d2
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
	<20230901010704.18493-1-bongkyu7.kim@samsung.com>
	<CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
	<20240403012132.GA460@KORCO045595.samsungds.net>
	<CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>
	<20240403014207.GA499@KORCO045595.samsungds.net>
	<23fd78bb-76a7-46e8-9523-5d2cab4186f5@redhat.com>
	<45ddde77-a5dd-41e8-933f-36ed0f8cf178@redhat.com>

------TOZlIVLwwMrWyiQcmaMv.RfJj4xujRO9DKwkEeR9_h2yBUMZ=_d27b6_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Thu, Apr 04, 2024 at 11:06:12PM -0400, Waiman Long wrote:
> On 4/4/24 13:44, Waiman Long wrote:
> > 
> > On 4/2/24 21:42, Bongkyu Kim wrote:
> > > On Tue, Apr 02, 2024 at 06:27:40PM -0700, John Stultz wrote:
> > > > On Tue, Apr 2, 2024 at 6:21 PM Bongkyu Kim
> > > > <bongkyu7.kim@samsung.com> wrote:
> > > > > On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
> > > > > > On Thu, Aug 31, 2023 at 6:07 PM Bongkyu Kim
> > > > > > <bongkyu7.kim@samsung.com> wrote:
> > > > > > > This is rework of the following discussed patch.
> > > > > > > https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/
> > > > > > > 
> > > > > > > 
> > > > > > > Changes from the previous patch
> > > > > > > - Split to revert and modify patches
> > > > > > > - Change according to Waiman Long's review
> > > > > > >      More wording to documentation part
> > > > > > >      Change module_param to early_param
> > > > > > >      Code change by Waiman Long's suggestion
> > > > > > > 
> > > > > > > In mobile environment, reader optimistic spinning is still useful
> > > > > > > because there're not many readers. In my test result
> > > > > > > at android device,
> > > > > > > it improves application startup time about 3.8%
> > > > > > > App startup time is most important factor for
> > > > > > > android user expriences.
> > > > > > > So, re-enable reader optimistic spinning by this commit. And,
> > > > > > > make it optional feature by cmdline.
> > > > > > > 
> > > > > > > Test result:
> > > > > > > This is 15 application startup performance in our exynos soc.
> > > > > > > - Cortex A78*2 + Cortex A55*6
> > > > > > > - unit: ms (lower is better)
> > > > > > > 
> > > > > > > Application             base  opt_rspin  Diff  Diff(%)
> > > > > > > --------------------  ------  ---------  ----  -------
> > > > > > > * Total(geomean)         343        330   -13    +3.8%
> > > > > > > --------------------  ------  ---------  ----  -------
> > > > > > > helloworld               110        108    -2    +1.8%
> > > > > > > Amazon_Seller            397        388    -9    +2.3%
> > > > > > > Whatsapp                 311        304    -7    +2.3%
> > > > > > > Simple_PDF_Reader        500        463   -37    +7.4%
> > > > > > > FaceApp                  330        317   -13    +3.9%
> > > > > > > Timestamp_Camera_Free    451        443    -8    +1.8%
> > > > > > > Kindle                   629        597   -32    +5.1%
> > > > > > > Coinbase                 243        233   -10    +4.1%
> > > > > > > Firefox                  425        399   -26    +6.1%
> > > > > > > Candy_Crush_Soda         552        538   -14    +2.5%
> > > > > > > Hill_Climb_Racing        245        230   -15    +6.1%
> > > > > > > Call_Recorder            437        426   -11    +2.5%
> > > > > > > Color_Fill_3D            190        180   -10    +5.3%
> > > > > > > eToro                    512        505    -7    +1.4%
> > > > > > > GroupMe                  281        266   -15    +5.3%
> > > > > > > 
> > > > > > Hey Bongkyu,
> > > > > >    I wanted to reach out to see what the current status of this patch
> > > > > > set? I'm seeing other parties trying to work around the loss of the
> > > > > > optimistic spinning functionality since commit 617f3ef95177
> > > > > > ("locking/rwsem: Remove reader optimistic spinning") as well, with
> > > > > > their own custom variants (providing some substantial gains), and
> > > > > > would really like to have a common solution.
> > > > > > 
> > > > > I didn't get an reply, so I've been waiting.
> > > > > Could you let me know about their patch?
> > > > I don't have insight/access to any other implementations, but I have
> > > > nudged folks to test your patch and chime in here.
> > > > 
> > > > Mostly I just wanted to share that others are also seeing performance
> > > > trouble from the loss of optimistic spinning, so it would be good to
> > > > get some sort of shared solution upstream.
> > > > 
> > > > thanks
> > > > -john
> > > > 
> > When this patch series was originally posted last year, we gave some
> > comments and suggestion on how to improve it as well as request for more
> > information on certain area. We were expecting a v2 with the suggested
> > changes, but we never got one and so it just fell off the cliff.
> > 
> > Please send a v2 with the requested change and we can continue our
> > discussion.
> 
> The major reason that reader optimistic spinning was taken out is because of
> reader fragmentation especially now that we essentially wake up all the
> readers all at once when it is reader's turn to take the read lock. I do
> admit I am a bit biased toward systems with large number of CPU cores. On
> smaller systems with just a few CPU cores, reader optimistic spinning may
> help performance. So one idea that I have is that one of the command line
> option values is an auto mode (beside on and off) that reader optimistic
> spinning is enabled for, say, <= 8 CPUs, but disabled with more CPUs.
> 
> Anyway, this is just one of my ideas.
> 
> Cheers,
> Longman
> 
Hi Longman,

Including your idea, I will reconsider and resend patch.

Thanks,
Bongkyu


------TOZlIVLwwMrWyiQcmaMv.RfJj4xujRO9DKwkEeR9_h2yBUMZ=_d27b6_
Content-Type: text/plain; charset="utf-8"


------TOZlIVLwwMrWyiQcmaMv.RfJj4xujRO9DKwkEeR9_h2yBUMZ=_d27b6_--

