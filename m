Return-Path: <linux-kernel+bounces-15154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D88227DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193F31C22E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF9154AD;
	Wed,  3 Jan 2024 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MJB9Ud66"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3368171B4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240103043921epoutp0188dcd42df64886862423bb06c0749b52~mvH68hmnJ2553325533epoutp012
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 04:39:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240103043921epoutp0188dcd42df64886862423bb06c0749b52~mvH68hmnJ2553325533epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704256761;
	bh=+z+RwFYXciET0SiS/y+SreGeC/xbNenokiOyj2egkPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJB9Ud66/2xJxSXxJGIZm6lUcHCxPjJ9qC8IseKZX6vr2EN+S1jjSjhYqqHb10ak8
	 Aa3+OxyWTtJ3As7Oxrsu0nf09BdebGoQVVu7OGU/1eXjusgZcC1Uiq2D9Eobj3+PYX
	 ch7XPBjaLHjMBDNo55h+Pa6w0d78oJZ5L+4RWJQA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240103043920epcas2p1d0a5bce4ee9d59f04a85ab496f5fb66b~mvH6QlcGg3186931869epcas2p1E;
	Wed,  3 Jan 2024 04:39:20 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T4cSS1rTKz4x9Pr; Wed,  3 Jan
	2024 04:39:20 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.06.10006.8F4E4956; Wed,  3 Jan 2024 13:39:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240103043919epcas2p4932e1a901dda96a736ea6892ee626ae0~mvH5Wr_mj1796717967epcas2p4g;
	Wed,  3 Jan 2024 04:39:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240103043919epsmtrp11d1f22ca2e33346b78d86f60fa9404e8~mvH5V6LCA0271402714epsmtrp1l;
	Wed,  3 Jan 2024 04:39:19 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-c2-6594e4f81272
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.59.08817.7F4E4956; Wed,  3 Jan 2024 13:39:19 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240103043919epsmtip2edd1902343f8e3ecbc95c637ef26de16~mvH5Iv5tQ0657406574epsmtip2M;
	Wed,  3 Jan 2024 04:39:19 +0000 (GMT)
Date: Wed, 3 Jan 2024 13:39:17 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Youngmin
	Nam <youngmin.nam@samsung.com>, rafael@kernel.org,
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com,
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, hs.gil@samsung.com,
	yulgon.kim@samsung.com, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 0/3] PM: sleep: Fix possible device suspend-resume
 deadlocks
Message-ID: <ZZTk9dRlueSuZuAy@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j6vspzj00ZH66eHtcDP8_fUcaR+KNoaTA8qG1r0hkrVQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmqe6PJ1NSDR71c1lc2zuR3aJ58Xo2
	i63z5zFb/O28wGqxeU6xxeVdc9gsPvceYbSY+2Uqs8WZ05dYLSb8vsBmcXxtuMXiA5/YLTrO
	HmR34PXYtKqTzePOtT1sHvvnrmH32HK1ncVj9t0fjB59W1YxenzeJBfAHpVtk5GamJJapJCa
	l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
	zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO6Nr0wH2gofcFS+v
	7mVuYLzG2cXIySEhYCLxZFknUxcjF4eQwA5GiYY9T1kgnE+MEt83zWSGcL4xSkycdJQNpqVj
	12s2iMReRon5TzezQzgPGSWuHJvCDlLFIqAi8a19LQuIzSagK7HtxD9GEFtEIExiX88xsAZm
	gVdMEo+6bzKDJIQFQiU6G7rAGngFlCUO313OBGELSpyc+QQszikQKPFj8SJWkGYJgR0cEu/e
	Poe6yUWiYXYPK4QtLPHq+BZ2CFtK4mV/G5RdLNFw/xYzRHMLo8Sp6y+YIRLGErOetYOdxyyQ
	KbHr6h+gQRxAcWWJI7dYIMJ8Eh2H/7JDhHklOtqEIDrVJH5N2cAIYctI7F68Amqih8TeNx+g
	odrFJDHnzj72CYxys5D8MwvJtllAY5kFNCXW79KHCMtLNG+dzQwRlpZY/o8DScUCRrZVjGKp
	BcW56anFRgWG8OhOzs/dxAhOyVquOxgnv/2gd4iRiYPxEKMEB7OSCO/6dZNThXhTEiurUovy
	44tKc1KLDzGaAiNqIrOUaHI+MCvklcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQ
	WgTTx8TBKdXAtMWcb5WwzzRvy+v3ZrhcvfD9tl/Qc3Wz1FZL9g0X/EOc9odpb17JdN768NTg
	4vXaj3cd83XhbLhUW+NZbGOZ/WdT+8uvksaNPv92X7TW5f04m6EuqimmZmnKfN3+h1dK7hnu
	FjYxM1E/dNT9rGakz9anJ6ZFhjyapJCs2J7j2c+RbRiv7vH5X8ru4NKamdF5v830pGfkrFn0
	9t+TUH1+Xb+9qc9kd72dneyRrnGZ7VhqckDF+ShJG0eFP6f+Cn66lrhHcOnZnsZL39Pkme13
	R1ZM+jrROlaoYtEdPqvLfxKj+b34ZI80z1JTKX5/qWnfGoa4/WwSK0sz6l5cVp0Y28b6zt9x
	oUm7zLunZ5mUWIozEg21mIuKEwH56wNeUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO73J1NSDZp3aFtc2zuR3aJ58Xo2
	i63z5zFb/O28wGqxeU6xxeVdc9gsPvceYbSY+2Uqs8WZ05dYLSb8vsBmcXxtuMXiA5/YLTrO
	HmR34PXYtKqTzePOtT1sHvvnrmH32HK1ncVj9t0fjB59W1YxenzeJBfAHsVlk5Kak1mWWqRv
	l8CVMePZGtaCBs6KHcfPsjYwTmTvYuTkkBAwkejY9Zqti5GLQ0hgN6PEkd5nrBAJGYnbKy9D
	2cIS91uOsEIU3WeU2L94ORNIgkVAReJb+1oWEJtNQFdi24l/jCC2iECYxMRjb8BqmAXeMEks
	+qoMYgsLhEp0NnSB1fMKKEscvgsyB2RoD5PEiwtHoRKCEidnPmGBaFaX+DPvEnMXIweQLS2x
	/B8HRFheonnrbGYQm1MgUOLH4kWsExgFZyHpnoWkexZC9ywk3QsYWVYxSqYWFOem5xYbFhjl
	pZbrFSfmFpfmpesl5+duYgRHmpbWDsY9qz7oHWJk4mA8xCjBwawkwrt+3eRUId6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGphO+HPUmd8yex6U8XaZ85LF
	XyvKr+3i+3dM67JbVcpm0ZOLYh+s3b9raolXcOuhJydZs4rXJWmumVpfJ3DA7NblGQXhV9bU
	lM2dpN2w6ll7cVVwXEpwduTSKv5z1im+WWFf/O5mzD6c0qM/t6WJNWLPhQfRgZ4uzvm6pXMX
	FqXavjM7csXkaPatKOeyReqrJpZdu7Tm+yP98uOeXDpMXAIHv34Kjaq3NX1kr55Q3n9jweVa
	DavjyYvPLTl7ULCCU1vsSofBx1cFs55nfw3dKHK48fzi3uT+8gT/nuyZWX2vn64JmvN+78ML
	SjpPY/o5eW/MnuZktj5izd9JLexmL8SOaPKvnsnv0hi9vW53wm4lluKMREMt5qLiRADb95Rt
	IwMAAA==
X-CMS-MailID: 20240103043919epcas2p4932e1a901dda96a736ea6892ee626ae0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_182864_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
	<2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher>
	<6019796.lOV4Wx5bFT@kreacher>
	<CAJZ5v0j6vspzj00ZH66eHtcDP8_fUcaR+KNoaTA8qG1r0hkrVQ@mail.gmail.com>

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_182864_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Jan 02, 2024 at 02:18:43PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 27, 2023 at 9:41 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi Everyone,
> >
> > As reported here
> >
> > https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> >
> > the device suspend-resume code running during system-wide PM transitions
> > deadlock on low memory, because it attempts to acquire a mutex that's
> > already held by it in those cases.
> >
> > This series addresses the issue by changing the resume code behavior
> > to directly run the device PM functions synchronously if they cannot
> > be scheduled for asynchronous executions (patch [3/3]).
> >
> > For this purpose, the async code is rearranged (patch [1/3]) and a
> > new variant of async_schedule_dev() is introduced (patch [2/3]).
> 
> Given the lack of negative feedback, I've queued up this series for 6.8-rc1.
> 
> Please let me know if there are any issues with that.
> 
> Thanks!
> 
Hi Rafael

We haven't seen any regression issue under our stress test.

So, feel free to add

Tested-by: Youngmin Nam <youngmin.nam@samsung.com>

Thanks.

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_182864_
Content-Type: text/plain; charset="utf-8"


------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_182864_--

