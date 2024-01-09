Return-Path: <linux-kernel+bounces-21169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F456828B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1A21F24C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DE3B2A8;
	Tue,  9 Jan 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcNwnE+x"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12A3BB27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DFCD45C00CF;
	Tue,  9 Jan 2024 12:21:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Jan 2024 12:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704820910; x=1704907310; bh=Q2uwZ9O5GP4GyruMwC3whxZ+X7cK
	JkKtlqysnlOCtvI=; b=GcNwnE+x3ADlB+MhnzvrXTb25+gguksUQYMQyZxNDBhX
	WbihqFDwzSTdbr9K4llzitGsHXUIZb9ZUV+m2t/eb263Ayy7TOq9LX8cBqKqEvMv
	/NEF7/qp9T9qdd8pMDuedNiGLQ5i6sBFQCT6jo/Zv80C1UytqP3px9ZRQA3DX3Hb
	VQFfoQ4MEaN1D471AjYSKvGu7yJR2cypWr0S0sxXMcstfTPR4Vh/781Dlx1pqhJv
	tBC2GL9iWkSpOvYT9+4a89vLcInIJ4f8F1kVkqi0E7LWzAv83/DlZ7OHQvTV3O7k
	L604VBgmRq+Nv7N5UM6P3+zirnJoArSQNEG5sT2gug==
X-ME-Sender: <xms:roCdZVm0LtzPy4HqN5GesV236B_F_FoBgGxYEG-kPhiPlVNgp7Em2Q>
    <xme:roCdZQ3c7G0mYb6TawUQ-BZx1qN3TK9_JhIvpzZj8jxD1pYoIPdubvIl9W_DcoWWQ
    mUm3o9Cb_G9xU4>
X-ME-Received: <xmr:roCdZbq36bTuTeHWFeYzniEQxJbSIGG1ph0G7bUlKAuPexRUuvfpjRDWZFqB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:roCdZVnC7_JcN6TsYGh_J0qWp44JRr7a8OHj6wSftLFHbvNqFbuX1A>
    <xmx:roCdZT16AW2-CBYOCMcq3K85KIkz7losUO5tbCs28RJQwWjLXGwkGw>
    <xmx:roCdZUt2ltSUp8Z6hNsqZqq37GgmciVcFquNO4QxCo0ju4ryjbKc4Q>
    <xmx:roCdZdrhBQluRW7wCeO2Rh621WI2LKNPBMTBRAuvsQTX2-D-wNupOg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 12:21:49 -0500 (EST)
Date: Tue, 9 Jan 2024 19:21:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
	john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
	jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZ2AqZT4dD-s01q9@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>

Hi Robin,

Thanks for the reply.

On Mon, Jan 08, 2024 at 05:35:26PM +0000, Robin Murphy wrote:
> Hmm, we've got what looks to be a set of magazines forming a plausible depot
> list (or at least the tail end of one):
> 
> ffff8881411f9000 -> ffff8881261c1000
> 
> ffff8881261c1000 -> ffff88812be26400
> 
> ffff88812be26400 -> ffff8188392ec000
> 
> ffff8188392ec000 -> ffff8881a5301000
> 
> ffff8881a5301000 -> NULL
> 
> which I guess has somehow become detached from its rcache->depot without
> being freed properly? However I'm struggling to see any conceivable way that
> could happen which wouldn't already be more severely broken in other ways as
> well (i.e. either general memory corruption or someone somehow still trying
> to use the IOVA domain while it's being torn down).

The machine is running a debug kernel that among other things has KASAN
enabled, but there are no traces in the kernel log so there is no memory
corruption that I'm aware of.

> Out of curiosity, does reverting just patch #2 alone make a difference?

Will try and let you know.

> And is your workload doing anything "interesting" in relation to IOVA
> domain lifetimes, like creating and destroying SR-IOV virtual
> functions, changing IOMMU domain types via sysfs, or using that
> horrible vdpa thing, or are you seeing this purely from regular driver
> DMA API usage?

The machine is running networking related tests, but it is not using
SR-IOV, VMs or VDPA so there shouldn't be anything "interesting" as far
as IOMMU is concerned.

The two networking drivers on the machine are "igb" for the management
port and "mlxsw" for the data ports (the machine is a physical switch).
I believe the DMA API usage in the latter is quite basic and I don't
recall any DMA related problems with this driver since it was first
accepted upstream in 2015.

Thanks

