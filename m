Return-Path: <linux-kernel+bounces-23211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685D82A8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0500F1F2180E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D0F9F3;
	Thu, 11 Jan 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3d7BLwju"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1114F65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 30BEC5C018F;
	Thu, 11 Jan 2024 03:20:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 03:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704961232; x=1705047632; bh=uzELjG1LAz/gx8olsV0S39RBHTMk
	nfMVVQPTdHT2PyA=; b=3d7BLwjuWwx8RWHHm0NNrYXXisP0H6nvCtJecmA+xKZq
	PGDGLbVYmhFCBkKVuQEgRq+aFkRm2b0Rc7llH0bmILHfowGSa1pQVVSiDY8qNyXv
	z7O5TXsAoifhUPE7d8iv0C3GPH3euJIFIF1kTk3Y33ccT8ltx0cCHreelVJWU4Ui
	EFFy7XAGHET/2UoDC04be2GMPU/HS+g8Afl0g2Q7kOPmt8E8ZBPe55JOczn2RzXx
	aC2sRAqmBeKJgOuI3uICo7Zko/h7AxAo7JI7TFBhsu2WFTqN8XIaB/4kOxlq4FzK
	M0MflluZSiLyufOF0okx2hBvLiW6mGJp5exNIeFoKg==
X-ME-Sender: <xms:z6SfZQ5reCCFLsaY6GB3Nj9lYe8HjuwtLxhS58XVACkzSBc8x97fmQ>
    <xme:z6SfZR5FUiAn7p7r5S86kS09HF_Umbr2G0h6QiWcLQ0z_IaQGXHGA7vZPUsPxabL-
    HhX0ff-6POa1dA>
X-ME-Received: <xmr:z6SfZfe5KGDaiG_pLGG0UB4nr6PAyJaC4_k2g5jsRrQPP3qTYuPmFeOrSQnZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:z6SfZVKEAm8E6DrAxigUnURK1TpdAqGiIWZLHVv0TVZV735uJlqMRw>
    <xmx:z6SfZULHz9pZmZIIxzzmhZWwyHYJ7bemv_WvCzkYDpVievmLvpdtXg>
    <xmx:z6SfZWy_O0UTkteT6a07xb5nKa5iVhL6xEZVOxZ6GgLenKC6FjVdog>
    <xmx:0KSfZdpSb126QTsyffII9jLQTGgA_eD29xV4XKs_LRVfGS1TbzvsQA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 03:20:30 -0500 (EST)
Date: Thu, 11 Jan 2024 10:20:27 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZ-ky9UCoHwbyqfn@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ7atzgT6_kOvWnJ@arm.com>

On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> Transient false positives are possible, especially as the code doesn't
> use a double-linked list (for the latter, kmemleak does checksumming and
> detects the prev/next change, defers the reporting until the object
> becomes stable). That said, if a new scan is forced (echo scan >
> /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> If yes, they may not be transient.

We are doing "scan" and "clear" after each test. I will disable the
"clear" and see if the leaks persist.

