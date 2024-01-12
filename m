Return-Path: <linux-kernel+bounces-24800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D265582C2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FF11F22A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3386EB5A;
	Fri, 12 Jan 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftbXLT06"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4B6EB50
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 3F5715C018D;
	Fri, 12 Jan 2024 10:31:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 12 Jan 2024 10:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705073475; x=1705159875; bh=ZhpXUyqtXqqOuV7cHzzwsDe+dNf2
	DevUdK02WPndxl4=; b=ftbXLT06+QrUk2I79xF+R9gJMtElPIs0d158WM7JuOq7
	EK7cWJYR0cItZn/yzg9sL74hkcLW7Zu+3Er+xQL38mxFrgNcGwj3MA8u5inkPMtw
	d6sxJEZ6SBeEY/MdTtwNIFfwYJl0Lal+JvhXJM5fU7Dc1JPTTpU+Al4XUHIpeZJQ
	OZ7LtfLi1TZlQp5lUeDT4RqlGbknjo5wGxqWTcpQT1HV+nV5Vse+OK9BAPG8ooR3
	RrbESSgigv5ENZgJ3JxCwvGoXU7dmMPavZ0avTJEKl56wZS+B6G2aHNMK6dZ0L4C
	6+Wflx9bHtygvFCXZWIyW2YJKBTb26QHnpb/o93lIA==
X-ME-Sender: <xms:QVuhZe6zX5wZHhSb4nHzYYQJynlQyRyOVKjUSjGafaKQphURZPhLHg>
    <xme:QVuhZX6MxRsnN4bTmbUZq4t6qJISziW2a489tML_ueVId8Gq-2gAnxjBF5UQvwLG0
    N1yKDIyR8-0MsI>
X-ME-Received: <xmr:QVuhZddd3g7OCaRHvqQT3Pohj4aku7NNLIsmUvpazwY4aVH5dpCzx1zcCuIi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:QluhZbKKFFba8by0Y6Iuxle2Jm81CLCST0p-zp9pvsMP4OGUkwyRKw>
    <xmx:QluhZSK-to_WtCrI332XG6oDxB0_6jFAoa1BPUf1uhr9KlJdDD_EKw>
    <xmx:QluhZcwc4KMUwjwCfkiAdmgp723j2YRUF_LSrBS8e4_qN7p0G1rpwQ>
    <xmx:Q1uhZToyw3O9WZFJRr5-AGMIqrJ6pbgxKi_QA9_9BSm5Uuu-4qZ1-Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 10:31:13 -0500 (EST)
Date: Fri, 12 Jan 2024 17:31:10 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZaFbPnDrYT5uGqJD@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
 <ZZ-ky9UCoHwbyqfn@shredder>
 <ZZ-_LWz_4KxOkRsA@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ-_LWz_4KxOkRsA@arm.com>

On Thu, Jan 11, 2024 at 10:13:01AM +0000, Catalin Marinas wrote:
> On Thu, Jan 11, 2024 at 10:20:27AM +0200, Ido Schimmel wrote:
> > On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> > > Transient false positives are possible, especially as the code doesn't
> > > use a double-linked list (for the latter, kmemleak does checksumming and
> > > detects the prev/next change, defers the reporting until the object
> > > becomes stable). That said, if a new scan is forced (echo scan >
> > > /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> > > If yes, they may not be transient.
> > 
> > We are doing "scan" and "clear" after each test. I will disable the
> > "clear" and see if the leaks persist.
> 
> If it is indeed a false positive

Looks like the leaks are transient. After removing the "clear" step the
leaks do not seem to persist.

> you can try the patch below (I haven't given it any run-time test,
> only compiled):

Will try and let you know next week.

Thanks

