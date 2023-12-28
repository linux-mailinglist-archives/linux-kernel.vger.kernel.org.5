Return-Path: <linux-kernel+bounces-12462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FB81F51B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510B51F22664
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A35380;
	Thu, 28 Dec 2023 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YiU05am2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8302522B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231228064014epoutp04544f026e306ff263399df94b0554ce74~k65wFGwUq1183811838epoutp04E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231228064014epoutp04544f026e306ff263399df94b0554ce74~k65wFGwUq1183811838epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703745614;
	bh=A7fONOiB2KcoiR2yR271Shvujvl1NUDkB7NXQKc2mM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YiU05am2wjYqfzGsSkuj8FGPeEjfOBX0vRQGkL3durl6Z5G2e/L8DRgoF9O6gElKD
	 pbDyOEljuh2N+pn7kBPGirQtkE3O0NG3sTVMYoipdNYwX1Q8ywhvbVUuy/sIH3pRCr
	 iCR2s9SUTbhY03QqsHCq7AGTj0JmkESZfCc+ioYg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231228064013epcas2p2a3ab0255fd527dbd438d70b6c2dca362~k65vWdxBw0352903529epcas2p2B;
	Thu, 28 Dec 2023 06:40:13 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T0zQh6srgz4x9Q7; Thu, 28 Dec
	2023 06:40:12 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.63.08648.C481D856; Thu, 28 Dec 2023 15:40:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231228064012epcas2p327ba8a0aae748cbf1a3122475ae9a8c1~k65uK7WZP2736327363epcas2p30;
	Thu, 28 Dec 2023 06:40:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231228064012epsmtrp22dac7d9f6d1bee8419fbd151b1d05eaa~k65uJ0QHS3252532525epsmtrp2z;
	Thu, 28 Dec 2023 06:40:12 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-ea-658d184ca48f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.10.18939.C481D856; Thu, 28 Dec 2023 15:40:12 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231228064012epsmtip272cd714b4361500a1bf05d66beca29eb~k65t94Q_-0352703527epsmtip2e;
	Thu, 28 Dec 2023 06:40:12 +0000 (GMT)
Date: Thu, 28 Dec 2023 15:40:09 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com,
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, Youngmin Nam
	<youngmin.nam@samsung.com>, hs.gil@samsung.com
Subject: Re: [BUG] mutex deadlock of dpm_resume() in low memory situation
Message-ID: <ZY0YSc4YoUPTmEMr@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jupWr_89mttKMg-KGa6_dpu62JiUkUaueMfHVgeUXYWg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmua6PRG+qweWFxhbX9k5kt2hevJ7N
	Yuv8ecwWfzsvsFpsnlNsMWvKXiaLy7vmsFl87j3CaHH31FE2i7lfpjJbnDl9idVi8YFP7A48
	Hov3vGTy2LSqk81j/9w17B5brrazePRtWcXosWL1d3aPz5vkAtijsm0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5VUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn/P18l7VgIl/FxMaNbA2M
	i7i7GDk5JARMJBa9vsDYxcjFISSwg1Fi3+UTzBDOJ0aJWde/sMA5ffceM8O0fNk5HapqJ6PE
	xq+tbBDOQ0aJ/8cugVWxCKhK/D3xAcxmE9CV2HbiHyOILSKgLbFk0VWwbmaB3UwSE5pPM4Ek
	hAU8JZbM7Qdr4BVQllh16T8jhC0ocXLmExYQm1MgUOJy+0WwmyQE1nJInLtzD6iBA8hxkdi1
	NwziPGGJV8e3sEPYUhKf3+1lg7CLJRru32KG6G1hlDh1/QXUP8YSs561M4LMYRbIlHg/Pxli
	pLLEkVtga5kF+CQ6Dv9lhwjzSnS0CUE0qkn8mrKBEcKWkdi9eAXUQA+JvW8+MEHCpItJ4vrE
	DSwTGOVmIflmFsIyCFNTYv0u/Vlgy+QlmrfOZoYIS0ss/8eBpGIBI9sqRrHUguLc9NRkowJD
	eFwn5+duYgQnYS3nHYxX5v/TO8TIxMF4iFGCg1lJhPe4aE+qEG9KYmVValF+fFFpTmrxIUZT
	YCxNZJYSTc4H5oG8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY
	7mqvnpj1alOaU3zpX6f43WbdJ2q07ixNEZE5+LFsxhMWBoZ5zTqS3+f3b7irJm42VeTI2vmB
	jEYhiiuutK+LufYkNP3lOQkzP4bTv+69tedfcuTRrt398xIWbTe1uK9RccuA++V3kcjZU3hU
	biTa7ty28OH1DUuO1KX8bhJcacntwn6gbe3N8xM75cJtTu06dca3RX86b9wsmcKwmyxGJk1T
	TA/cW/V/+V2OC+xfuh5MabkttqijPnMF39SdQoX5LRpSh5x8Q1qX1oeWn/P2fV7hdeHghm+R
	ZQnfg/SUKxPv7l3Yq1abuVRw24z5sRqHcjhK3fmiF6Rb6vlVqPz8fkxE51PsLe6w9oSLSvlc
	SizFGYmGWsxFxYkAllGReksEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXtdHojfVYPkmPotreyeyWzQvXs9m
	sXX+PGaLv50XWC02zym2mDVlL5PF5V1z2Cw+9x5htLh76iibxdwvU5ktzpy+xGqx+MAndgce
	j8V7XjJ5bFrVyeaxf+4ado8tV9tZPPq2rGL0WLH6O7vH501yAexRXDYpqTmZZalF+nYJXBmz
	GyIKNnBXrJ92g7GB8S5HFyMnh4SAicSXndOZuxi5OIQEtjNKbHn1mBkiISNxe+VlVghbWOJ+
	yxFWiKL7jBJ7NqwFK2IRUJX4e+IDmM0moCux7cQ/RhBbREBbYsmiq2BTmQX2MkkcvnoLbJKw
	gKfEkrn9YA28AsoSqy79Z4SY2sMkcWfVOyaIhKDEyZlPWEBsZgF1iT/zLgE1cADZ0hLL/3FA
	hOUlmrfOBpvDKRAocbn9IssERsFZSLpnIemehdA9C0n3AkaWVYyiqQXFuem5yQWGesWJucWl
	eel6yfm5mxjBkaUVtINx2fq/eocYmTgYDzFKcDArifAeF+1JFeJNSaysSi3Kjy8qzUktPsQo
	zcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamDq7ytduKdl/YtJMaY3Fzxass4n437Eiu9T
	2NdHL+ly+bCn/goP50vlbWtXr4jVmRx2QG9Tw5zWZ1tnL1lV6NTirB1xY/U9Qb274ZOffIpu
	WeUyW4/zdvfrsMdrchwe2J2+unlOy+MS7stbV0zyvzhzu8+5bOWtW1Js+DlFhPN2HW1Yfk9i
	70+FH/L12/6av1m8+N/nS3Ma7gg3XnizyLFzOuvEf3NnGKlHuizQYksy++Yh+5A7t0CZvfKs
	RmzO24xbV00er3B7dnuZi5Nw26xNxjXzDdavXPVIZsbjOyccIg1fBVRopGVeiV5fM/XCnYVf
	jp6u+Ck7u9J6wpqQx98ucOz9ZcpgtleEZ52cTdeT2IVKLMUZiYZazEXFiQCdy6WaGwMAAA==
X-CMS-MailID: 20231228064012epcas2p327ba8a0aae748cbf1a3122475ae9a8c1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_151d76_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
	<2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher>
	<5755916.DvuYhMxLoT@kreacher>
	<CAJZ5v0jupWr_89mttKMg-KGa6_dpu62JiUkUaueMfHVgeUXYWg@mail.gmail.com>

------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_151d76_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Dec 27, 2023 at 09:50:01PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 27, 2023 at 7:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, December 27, 2023 7:39:20 PM CET Rafael J. Wysocki wrote:
> > > On Wednesday, December 27, 2023 5:08:40 PM CET Greg KH wrote:
> > > > On Wed, Dec 27, 2023 at 05:42:50PM +0900, Youngmin Nam wrote:
> > > > > Could you look into this issue ?
> > > >
> > > > Can you submit a patch that resolves the issue for you, as you have a
> > > > way to actually test this out?  That would be the quickest way to get it
> > > > resolved, and to help confirm that this is even an issue at all.
> > >
> > > Something like the appended patch should be sufficient to address this AFAICS.
> > >
> > > I haven't tested it yet (will do so shortly), so all of the usual disclaimers
> > > apply.
> > >
> > > I think that it can be split into 2 patches, but for easier testing here
> > > it goes in one piece.
> >
> > Well, please scratch this, it will not handle "async" devices properly.
> 
> This
> 
> https://lore.kernel.org/linux-pm/6019796.lOV4Wx5bFT@kreacher/
> 
> should address the issue properly (it has been lightly tested).
> 
> Please give it a go and let me know if it works for you (on top of 6.7-rc7).
> 
Thanks for your help.
Actually, this is very rare case on our side and it is the first time for us to see this issue.
Anyway, let me test and let you know.

------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_151d76_
Content-Type: text/plain; charset="utf-8"


------OVq5TT9zsDSQAN86dWjJc6zPY8CEKIwxCZDtRM.ioT5ZEg4T=_151d76_--

