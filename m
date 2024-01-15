Return-Path: <linux-kernel+bounces-25674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2F82D479
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84466B20EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405D3D62;
	Mon, 15 Jan 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="To/Qh4W4"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB64401
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BC8EB3200A44;
	Mon, 15 Jan 2024 02:17:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Jan 2024 02:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705303027; x=1705389427; bh=phMzmdFjOAKkAe7G8nrfpKSwAy4D
	gHYOvk+P0sJcsSc=; b=To/Qh4W4hmr8MB7sDIHKrDXKYa/e1KA9x/mTaRwx72wo
	D+D3wqUPDeVShEL2JNk4pKm8wILHPcPWsyoXIZh1SIWAqupZrZKYt8speoW0ZuPG
	pmc/w87ox30gtBgi2es4wCEoe2dzrpBFyy5rbOtDu1D10mrieLghfs8n8ZBSusUj
	td6qR4IstkHuj7PV++56rHcC/VdLWfC16C48KQeRDY0xPpZuKcKAhbbVC49SHvjx
	f4xqWHhzy9bkINzZNRI3A/Zv8uhlH32oX67Mgez8+qjj7faApFNEByqo569g/CHx
	KIkcXpy8FMIifxVGq2R5bZ7JC7f00IRGqEaVr1BvgA==
X-ME-Sender: <xms:8tukZUHUmdgS2ZwngSGyS-tf0z2-6ZsgyfeSWlnLuKhyMDcGFCn3EA>
    <xme:8tukZdXhE8CpIyuPIeNIPbZKxl01l276HQ1-w1r9t3kYp6NcQmbr_9gqArvTXIH7d
    LgRM00Cvgcqo50>
X-ME-Received: <xmr:8tukZeLdGIP1_-fZez5Ibgx7gKf7jqJkXzR8JY7SCBgt2V2Lu7ktmE2FQe5X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejtddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:8tukZWHxKvaxzij1gtuOCewbz8zckEr3xmZ3gPSfajKGloth2ZvCSQ>
    <xmx:8tukZaWw1UR1WF63e1X3Fg-488xiwn-bpPoQ80n3Z7nVzKrT-FrvWw>
    <xmx:8tukZZMQs7qAJvlbEefruf-seoOlQWC0MeRrkAHPKTNelaqr4D2VTA>
    <xmx:89ukZVGLvRNIIS_KLLOrlfZndo_wws6kjoZOkI15UuP7IFk5Rl5-3A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 02:17:06 -0500 (EST)
Date: Mon, 15 Jan 2024 09:17:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZaTb8KorPFPgRqD6@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
 <ZZ-ky9UCoHwbyqfn@shredder>
 <ZZ-_LWz_4KxOkRsA@arm.com>
 <ZaFbPnDrYT5uGqJD@shredder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFbPnDrYT5uGqJD@shredder>

On Fri, Jan 12, 2024 at 05:31:15PM +0200, Ido Schimmel wrote:
> On Thu, Jan 11, 2024 at 10:13:01AM +0000, Catalin Marinas wrote:
> > On Thu, Jan 11, 2024 at 10:20:27AM +0200, Ido Schimmel wrote:
> > > On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> > > > Transient false positives are possible, especially as the code doesn't
> > > > use a double-linked list (for the latter, kmemleak does checksumming and
> > > > detects the prev/next change, defers the reporting until the object
> > > > becomes stable). That said, if a new scan is forced (echo scan >
> > > > /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> > > > If yes, they may not be transient.
> > > 
> > > We are doing "scan" and "clear" after each test. I will disable the
> > > "clear" and see if the leaks persist.
> > 
> > If it is indeed a false positive
> 
> Looks like the leaks are transient. After removing the "clear" step the
> leaks do not seem to persist.
> 
> > you can try the patch below (I haven't given it any run-time test,
> > only compiled):
> 
> Will try and let you know next week.

Looks good. Feel free to add:

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

