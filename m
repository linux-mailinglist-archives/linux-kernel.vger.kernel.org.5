Return-Path: <linux-kernel+bounces-14111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F068217F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5584B21590
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B61FD6;
	Tue,  2 Jan 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jQuDPbIO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9020F5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 918FE5C020C;
	Tue,  2 Jan 2024 02:24:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Jan 2024 02:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704180281; x=1704266681; bh=2sRidRuJgpmzA3ok6Z8thcz4Si/E
	71P3fem+BTaKpTg=; b=jQuDPbIOhXqcnl/2XjMpDaMcfl8xMb0wUs6rifmWfVnZ
	CZyxvBfDg4CzNtJNfrNs4+dOmDN2ncCytkOjYcO8sCmEpGwsUPm4+YJUUPOAVj/c
	1Pdv20ipeOaPJCDVwd4xl9BDleAvi9pF1dXCTJSP+GwGS5s4cUStlTvsXWwjArjd
	8B4ajb/zsO5pS9vjG3tsbDSazawMBGIULVq9LMj5KUE6UgknAoo+2ovfgp5Q4duv
	QS/cLYDgUJRzvms0uPwhCqfN2ncTrCDdaQoKBKUk3rslelsN/RifvBtrmxWFSx3E
	EWX3JjrflNsJvDR7mFxphBRhPWWPrIoJzjdtMqmSPA==
X-ME-Sender: <xms:OLqTZUqAZ-YFvGovg8iqU2bumziCYdVmWR2Wgkh7eiyeTWBGXlpGyQ>
    <xme:OLqTZao3gs-XZFS3Z5E8oQ3eaw3wZp2s2Spjst4Rusgj7u9xEptqfuIHO2HuTgxpE
    FDE5ucQOq_ZTtM>
X-ME-Received: <xmr:OLqTZZPHjAyI0mpsJHA9ckF9qNuRpoLEV47SExMujYxI63b-fA3ZaUR0GhKf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeguddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedt
    hfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:OLqTZb53po1fN4Io2LSO_N0eEztCj_q1ImWDYwbbOY3ew-lL4Ht0Yw>
    <xmx:OLqTZT504UKHqOCdIbj0j54Sixv7Z2KLuWhmT2IriPWpbR0Qk0B5mA>
    <xmx:OLqTZbjOfHbkBgFDvLHHCaItpI0NaYi7uu3XRdZAt63uU3Yo3_EsiQ>
    <xmx:ObqTZQuMPdwdPnnJtxkLqNynTDndagm2DAp9_OwGLHIchSsg8qiTmA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jan 2024 02:24:40 -0500 (EST)
Date: Tue, 2 Jan 2024 09:24:37 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
	john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
	jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZO6NV-Kq-ktnyo5@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY1osaGLyT-sdKE8@shredder>

On Thu, Dec 28, 2023 at 02:23:20PM +0200, Ido Schimmel wrote:
> On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
> > v2: https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
> > 
> > Hi all,
> > 
> > I hope this is good to go now, just fixed the locking (and threw
> > lockdep at it to confirm, which of course I should have done to begin
> > with...) and picked up tags.
> 
> Hi,
> 
> After pulling the v6.7 changes we started seeing the following memory
> leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
> which is why I didn't perform bisection. However, looking at the
> mentioned code paths, they seem to have been changed in v6.7 as part of
> this patchset. I reverted both patches and didn't see any memory leaks
> when running a full regression (~10 hours), but I will repeat it to be
> sure.

FYI, we didn't see the leaks since reverting these two patches whereas
before we saw them almost everyday, so I'm quite sure they introduced
the leaks.

Thanks

