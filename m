Return-Path: <linux-kernel+bounces-136057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163189CF8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C584C1F23302
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727C4C69;
	Tue,  9 Apr 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EvzpiiBl"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2023A6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623827; cv=none; b=rNIXf3RCKK3HCp0+dBRHC10hkod2AEyGiqh3WbIqXULAuwhWf/Pmlz2o3tqqP/mbCyayHC5YZqMHXOfDpWmzmVCPeuIIef76OHTTBSerLKC7cetkavUd7YOYCEZTz+rQ27nJKDYYBBa/qFr1Sq0DSppEeiPk7nh7skYbtLGRfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623827; c=relaxed/simple;
	bh=SEXZ9Stfh9HAvmZ60x9saSWwRpiVkRcLWjYj9VwNC/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=C9Q9o6YOKaAphFkXaGVLlaYsTWzTw2Q4L8VdtIjwI81NHlAclbXv4/2vAaRG3wc4rvjFuAth8z8I0eV5Z9xpKCfMa/6hK7WJn9lxT1FtznvZDcyR3VvtlTBt03cQJIh8+NZgiBiGCotLdUs5SWeUrr/rQC0JS9+N3Rr8zWLCkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EvzpiiBl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240409005022epoutp02539058ff903f57e5e5f5839207c29a88~EdkrZNKo-0959609596epoutp02P
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240409005022epoutp02539058ff903f57e5e5f5839207c29a88~EdkrZNKo-0959609596epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712623822;
	bh=Pbenu89o6CnLd19DNEGwB4jMCmGD32Lc8k1TKR3l0eE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvzpiiBlpzemC+qCTlU/9bE2NcMmXEtiofLG7BDkpxH1hn6c1Q2ZzijjXq9RHR6gd
	 H58kaETvrJDshBRFYEpYaF3KJlE8UZ9AwyNdDfytOyPF1ZYVcdhdO0AL5fbGCz/+yi
	 n+ER5R9PvSAPYVltjv2/5PDJCtel1hnw8tgpCgxs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240409005021epcas2p31e56238087a90bdc0a6b97c85efb73d4~Edkq51ZdG3006730067epcas2p3I;
	Tue,  9 Apr 2024 00:50:21 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VD6nT0mcRz4x9Q7; Tue,  9 Apr
	2024 00:50:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.B5.09665.CC094166; Tue,  9 Apr 2024 09:50:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20240409005020epcas2p16359a40ccdf5656c63e9f498343e4428~EdkqFnz8a0350503505epcas2p1O;
	Tue,  9 Apr 2024 00:50:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240409005020epsmtrp2bcac632a11fc7cc9387875d7a8d5d1ec~EdkqE7sVE0277202772epsmtrp2L;
	Tue,  9 Apr 2024 00:50:20 +0000 (GMT)
X-AuditID: b6c32a47-93fff700000025c1-87-661490cc72e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.8A.19234.CC094166; Tue,  9 Apr 2024 09:50:20 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240409005020epsmtip24be4f974b33eb32f1abe1055723c7c37~Edkp3IVDS0844408444epsmtip23;
	Tue,  9 Apr 2024 00:50:20 +0000 (GMT)
Date: Tue, 9 Apr 2024 09:50:20 +0900
From: Bongkyu Kim <bongkyu7.kim@samsung.com>
To: xieliujie <xieliujie@oppo.com>
Cc: Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, bongkyu7.kim@samsung.com
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
Message-ID: <20240409005020.GA9827@KORCO045595.samsungds.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bf2b7ee4-16a5-43ba-bfe0-d24ad7ad87a4@oppo.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmme7ZCSJpBtv+MVq8bnzJZLFmSyOT
	RfPi9WwWf05sZLO4vGsOm8XpYydYLC4dWMBkcbz3AJNFyx1TiyOXcxy4PHbOusvusWBTqcfm
	FVoem1Z1snnsn7uG3ePdLCWP9/uusnn0bVnF6PF5k1wAZ1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QkUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
	/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Ixp6w+wF3wKqDh38RlzA+Myuy5G
	Tg4JAROJlpOrmLoYuTiEBHYwSvy90wvlfGKUaJyziQXOOXNrFWsXIwdYy5c3mRDxnYwS877s
	hSr6xihx+/MCZpC5LAIqEncmbgWz2QR0JP6vnsEEYosIKElMmb2fGaSBWeA9o8THLftZQBLC
	Ai4Sbd/XM4Js4BWwlThxTw4kzCsgKHFy5hOwEk4BG4l5sy6wgvRKCKzkkNjz5TsrxBMuEtdn
	vWaEsIUlXh3fwg5hS0l8freXDcIulpj4ciozRHMDo0TT6+0sEAljiVnP2sGamQUyJI4v28MC
	8aayxJFbLBBhPomOw3/ZIcK8Eh1tQhCdahK7n7dCnSAjcfDsWiYI20Pi2sHJ0GC8zCLRf2U3
	6wRGuVlI/pmFZNssoLHMApoS63fpQ4TlJZq3zmaGCEtLLP/HgaRiASPbKkax1ILi3PTUYqMC
	Y3hkJ+fnbmIEp18t9x2MM95+0DvEyMTBeIhRgoNZSYQ32FQwTYg3JbGyKrUoP76oNCe1+BCj
	KTCeJjJLiSbnAzNAXkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFIN
	TIILGtrVYo/aTerqa1Fj/Lf13T+Tk4XK/NxnC1p+iKs7THjswMq+dFafjM0fF4V5hz4/kf1Z
	n6T3MjvA83sCS86tTQXxjMaVNi0fdy0MrNLre6znpvpG9JJ7hWyYBqP1/5VRf5/f7TjAfOr5
	HdEl/7bPlMq+vOe2xOGFofdrnsqfX/Vp4jx/+9a58Wpd5w6oNm9Imz09odjEeVn5rPPvg9b7
	z5f+k3zQ4dOZub3NtUln5s9R8LjfIcR5nOfvhR39h5eqO82XOPM5/GsBv8w/rR33pl2cfvXf
	+6vCfTpCJ77X6fL5Je+YaLtZc9vf9FBNbbF1EQdX7I8VlF1257SY/P9J+3cxfHZWnOq4OIhR
	56YSS3FGoqEWc1FxIgBGQd2bSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXvfMBJE0g6tHVS1eN75kslizpZHJ
	onnxejaLPyc2sllc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pxZHLOQ5cHjtn3WX3WLCp1GPz
	Ci2PTas62Tz2z13D7vFulpLH+31X2Tz6tqxi9Pi8SS6AM4rLJiU1J7MstUjfLoEr49y2JsaC
	KX4V2/8vYW1gfGLdxcjBISFgIvHlTWYXIxeHkMB2Rol3vycydTFyAsVlJA79WwtlC0vcbznC
	CmILCXxhlNjULwhiswioSNyZuJUZxGYT0JH4v3oGWL2IgJLElNn7mUGGMgu8Z5T4uGU/C0hC
	WMBFou37ekaQxbwCthIn7slBLL7MItH0bh5YDa+AoMTJmU/AbGYBdYk/8y4xg9QzC0hLLP/H
	ARGWl2jeOhtsL6eAjcS8WRdYJzAKzkLSPQtJ9yyE7llIuhcwsqxiFE0tKM5Nz00uMNQrTswt
	Ls1L10vOz93ECI4mraAdjMvW/9U7xMjEwXiIUYKDWUmEN9hUME2INyWxsiq1KD++qDQntfgQ
	ozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qBScBpvc/uib/4fDiq/W92mPhkLrgYtGDB
	R26x4zPnzvS7Pjme/bwj06yPB/uLZ4SfPLTdaPp16/8/RcR+6Ezf8FlqCp+bT6lUsPPtFfNr
	eDJTXm998GSm+4mHkhJ3evofsU9a9vTV/shMoWUB0QYxLZL87MJ2B9VXcH594muyb7cJ45PG
	iumtP/dJfNB3nvzKe8fnlpLJXz402/LcEd3pf2bq0UqtK8UKssB4Vzb1q5Tca/9gxq1g4Y6U
	MoFeAcNP9ZFZtr9TJUWzN/CV1C4pMUkwCdnzb/WlZT/fnWzwU6t/da9z+t5DDpu+ntA/WTi9
	8XOksvengwH9q8XvyFy7WnGi6P1tE63yjQ+m6a/XUmIpzkg01GIuKk4EAFZiB2QVAwAA
X-CMS-MailID: 20240409005020epcas2p16359a40ccdf5656c63e9f498343e4428
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_f08df_"
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
	<20240405065133.GA5329@KORCO045595.samsungds.net>
	<bf2b7ee4-16a5-43ba-bfe0-d24ad7ad87a4@oppo.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_f08df_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Mon, Apr 08, 2024 at 04:15:04PM +0800, xieliujie wrote:
> 
> On 2024/4/5 14:51, Bongkyu Kim wrote:
> > On Thu, Apr 04, 2024 at 11:06:12PM -0400, Waiman Long wrote:
> > > On 4/4/24 13:44, Waiman Long wrote:
> > > > On 4/2/24 21:42, Bongkyu Kim wrote:
> > > > > On Tue, Apr 02, 2024 at 06:27:40PM -0700, John Stultz wrote:
> > > > > > On Tue, Apr 2, 2024 at 6:21 PM Bongkyu Kim
> > > > > > <bongkyu7.kim@samsung.com> wrote:
> > > > > > > On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
> > > > > > > > On Thu, Aug 31, 2023 at 6:07 PM Bongkyu Kim
> > > > > > > > <bongkyu7.kim@samsung.com> wrote:
> > > > > > > > > This is rework of the following discussed patch.
> > > > > > > > > https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Changes from the previous patch
> > > > > > > > > - Split to revert and modify patches
> > > > > > > > > - Change according to Waiman Long's review
> > > > > > > > >       More wording to documentation part
> > > > > > > > >       Change module_param to early_param
> > > > > > > > >       Code change by Waiman Long's suggestion
> > > > > > > > > 
> > > > > > > > > In mobile environment, reader optimistic spinning is still useful
> > > > > > > > > because there're not many readers. In my test result
> > > > > > > > > at android device,
> > > > > > > > > it improves application startup time about 3.8%
> > > > > > > > > App startup time is most important factor for
> > > > > > > > > android user expriences.
> > > > > > > > > So, re-enable reader optimistic spinning by this commit. And,
> > > > > > > > > make it optional feature by cmdline.
> > > > > > > > > 
> > > > > > > > > Test result:
> > > > > > > > > This is 15 application startup performance in our exynos soc.
> > > > > > > > > - Cortex A78*2 + Cortex A55*6
> > > > > > > > > - unit: ms (lower is better)
> > > > > > > > > 
> > > > > > > > > Application             base  opt_rspin  Diff  Diff(%)
> > > > > > > > > --------------------  ------  ---------  ----  -------
> > > > > > > > > * Total(geomean)         343        330   -13    +3.8%
> > > > > > > > > --------------------  ------  ---------  ----  -------
> > > > > > > > > helloworld               110        108    -2    +1.8%
> > > > > > > > > Amazon_Seller            397        388    -9    +2.3%
> > > > > > > > > Whatsapp                 311        304    -7    +2.3%
> > > > > > > > > Simple_PDF_Reader        500        463   -37    +7.4%
> > > > > > > > > FaceApp                  330        317   -13    +3.9%
> > > > > > > > > Timestamp_Camera_Free    451        443    -8    +1.8%
> > > > > > > > > Kindle                   629        597   -32    +5.1%
> > > > > > > > > Coinbase                 243        233   -10    +4.1%
> > > > > > > > > Firefox                  425        399   -26    +6.1%
> > > > > > > > > Candy_Crush_Soda         552        538   -14    +2.5%
> > > > > > > > > Hill_Climb_Racing        245        230   -15    +6.1%
> > > > > > > > > Call_Recorder            437        426   -11    +2.5%
> > > > > > > > > Color_Fill_3D            190        180   -10    +5.3%
> > > > > > > > > eToro                    512        505    -7    +1.4%
> > > > > > > > > GroupMe                  281        266   -15    +5.3%
> > > > > > > > > 
> > > > > > > > Hey Bongkyu,
> > > > > > > >     I wanted to reach out to see what the current status of this patch
> > > > > > > > set? I'm seeing other parties trying to work around the loss of the
> > > > > > > > optimistic spinning functionality since commit 617f3ef95177
> > > > > > > > ("locking/rwsem: Remove reader optimistic spinning") as well, with
> > > > > > > > their own custom variants (providing some substantial gains), and
> > > > > > > > would really like to have a common solution.
> > > > > > > > 
> > > > > > > I didn't get an reply, so I've been waiting.
> > > > > > > Could you let me know about their patch?
> > > > > > I don't have insight/access to any other implementations, but I have
> > > > > > nudged folks to test your patch and chime in here.
> > > > > > 
> > > > > > Mostly I just wanted to share that others are also seeing performance
> > > > > > trouble from the loss of optimistic spinning, so it would be good to
> > > > > > get some sort of shared solution upstream.
> > > > > > 
> > > > > > thanks
> > > > > > -john
> > > > > > 
> > > > When this patch series was originally posted last year, we gave some
> > > > comments and suggestion on how to improve it as well as request for more
> > > > information on certain area. We were expecting a v2 with the suggested
> > > > changes, but we never got one and so it just fell off the cliff.
> > > > 
> > > > Please send a v2 with the requested change and we can continue our
> > > > discussion.
> > > The major reason that reader optimistic spinning was taken out is because of
> > > reader fragmentation especially now that we essentially wake up all the
> > > readers all at once when it is reader's turn to take the read lock. I do
> > > admit I am a bit biased toward systems with large number of CPU cores. On
> > > smaller systems with just a few CPU cores, reader optimistic spinning may
> > > help performance. So one idea that I have is that one of the command line
> > > option values is an auto mode (beside on and off) that reader optimistic
> > > spinning is enabled for, say, <= 8 CPUs, but disabled with more CPUs.
> > > 
> > > Anyway, this is just one of my ideas.
> > > 
> > > Cheers,
> > > Longman
> > > 
> > Hi Longman,
> > 
> > Including your idea, I will reconsider and resend patch.
> > 
> > Thanks,
> > Bongkyu
> Hi Bongkyu,
> 
> I have met the same problem as you. After rwsem reader optimistic spin
> disabled, DouYin(or TikTok as you know, is one of the top applicaitons),
> it's uninterruptible sleep (non-io) time increased during cold launch.
> With the patch set you provide, the blocked time can be reduce from
> 122.6ms to 59.3ms(we test it in our mobile device with SM8650 core). Now
> I'm trying to use vendor hook in GKI to restore the reader spin, and
> john said I can share my test result to you here.
> 
> Thanks,
> Liujie

Hi Liujie,

Thanks for your sharing. I'm trying to send v3 patch like below.
https://lore.kernel.org/all/20240406081126.8030-1-bongkyu7.kim@samsung.com/

Bongkyu

> > 
> > 
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人（包含个人及群组）使用。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，切勿传播、分发、复制、印刷或使用本邮件之任何部分或其所载之任何内容，并请立即以电子邮件通知发件人并删除本邮件及其附件。
> 网络通讯固有缺陷可能导致邮件被截留、修改、丢失、破坏或包含计算机病毒等不安全情况，OPPO对此类错误或遗漏而引致之任何损失概不承担责任并保留与本邮件相关之一切权利。
> 除非明确说明，本邮件及其附件无意作为在任何国家或地区之要约、招揽或承诺，亦无意作为任何交易或合同之正式确认。 发件人、其所属机构或所属机构之关联机构或任何上述机构之股东、董事、高级管理人员、员工或其他任何人（以下称“发件人”或“OPPO”）不因本邮件之误送而放弃其所享之任何权利，亦不对因故意或过失使用该等信息而引发或可能引发的损失承担任何责任。
> 文化差异披露：因全球文化差异影响，单纯以YES\OK或其他简单词汇的回复并不构成发件人对任何交易或合同之正式确认或接受，请与发件人再次确认以获得明确书面意见。发件人不对任何受文化差异影响而导致故意或错误使用该等信息所造成的任何直接或间接损害承担责任。
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you are not the intended recipient, please do not read, copy, distribute, or use this information. If you have received this transmission in error, please notify the sender immediately by reply e-mail and then delete this message.
> Electronic communications may contain computer viruses or other defects inherently, may not be accurately and/or timely transmitted to other systems, or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall not be liable for any damages that arise or may arise from such matter and reserves all rights in connection with the email.
> Unless expressly stated, this e-mail and its attachments are provided without any warranty, acceptance or promise of any kind in any country or region, nor constitute a formal confirmation or acceptance of any transaction or contract. The sender, together with its affiliates or any shareholder, director, officer, employee or any other person of any such institution (hereinafter referred to as "sender" or "OPPO") does not waive any rights and shall not be liable for any damages that arise or may arise from the intentional or negligent use of such information.
> Cultural Differences Disclosure: Due to global cultural differences, any reply with only YES\OK or other simple words does not constitute any confirmation or acceptance of any transaction or contract, please confirm with the sender again to ensure clear opinion in written form. The sender shall not be responsible for any direct or indirect damages resulting from the intentional or misuse of such information.
> 

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_f08df_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_f08df_--

