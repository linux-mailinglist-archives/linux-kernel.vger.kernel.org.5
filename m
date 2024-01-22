Return-Path: <linux-kernel+bounces-34143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130E83744E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641471C289A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9B47F4C;
	Mon, 22 Jan 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Odv6hbDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fa7i8sq5"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545E48CD7;
	Mon, 22 Jan 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956276; cv=none; b=QhbbuU7kuTmQvEjxjo8e7lh9HgiAYhIfGygqhXdIMR9oe43vL9X9C6AFlOJx9wRlFbpuACNbEdW58AJQeGy49n+2CyV3g4e13qWWpCOCXKlBMzJhFBSPRlulZ/8opRWcLHIoIrAx5wMQRqVyzVpSC0Y3mRp7OTV4Y0Tu1cPPvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956276; c=relaxed/simple;
	bh=HTfVJjeKPMLdJ2VK7VUKQP9eFDr8nmzwZ1hMuarqhpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK7RrB7LO/mf9EBofDaU2rAeKUuXnBVtD3kA6iebvg84Idvmei4kwkW3hQP530YtSz2YMTJQKUoV5HeEemOpgGkGUR3R7P6zv9CUvHk+OAVvVa1kkGp6oKjGNBQ7EOAQo0Xr/g6ez02EAmAMZ5J8PaHgGdAdciuur38ZwuZCwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Odv6hbDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fa7i8sq5; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 98BFE5C01C4;
	Mon, 22 Jan 2024 15:44:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 15:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705956272; x=1706042672; bh=NknfBqxyeA
	rB5sr9Kwtp3IMv27vftUekDkOawLRCvOs=; b=Odv6hbDjNwnNeBzNZA1T1Q6POa
	P0Qju2BklHfroy3YCvN/BsKzfC8slpmP1wUDxnhD43LN7TO7ss3jHqqqIJBDR7bh
	LFrZsBxnaUnI4D8nzT+76au3MDVaonZnkdK9sclw+cEBW9sCbq+3ICKnhd+2upd0
	NBH6J/01cX/5IDXem2sM8KUSb5YShpWwXcjHzynGDBRogwCaM5+GU2gQcQqVqbSi
	eHhvt8DHNHV5AYQrSJvqRGTlRaXK/IdDM/CwXecnJjV2E+LO8xOMIdWDQ4l8Xsnf
	ERPZ1jPlToEQQK0BMBg02F3FJtz3bDqh11BLH0SQY+ru5bMqDJ9FN3+tvJyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705956272; x=1706042672; bh=NknfBqxyeArB5sr9Kwtp3IMv27vf
	tUekDkOawLRCvOs=; b=fa7i8sq52tXBq5GIfOXxG2FGFNnFyTWaysLu48akDagj
	C/9sSpaTu2KcmPuDBAcfoGtXOX3y12svVkhsvKBSTwWNjMBcnqhPWa6+qJ3218n6
	a3q0QI/Chn69g8QUB/+z+BtIyhPTXg8JAlBIoHQPSo/SqoFaWFcp7pzM78y7sDp1
	1/PaiWunj3Ydnsr4Ql0pCIFGCUowG6PUfzXS+KDQU6qe76KrjPZ0FnuhzmGVJIBo
	eK/k0Bo7A4SwepSDXt9tA5I1Pls/AhvqFsDHeSgxmONeI3UfD0v3jKUem62WV8hs
	ze/UATIkrzdiyR+bDtO4s3S07N9+Kss/mbmz6uvepQ==
X-ME-Sender: <xms:sNOuZSS1cRASSKtlBipwLlR809YlCkjabFzRnQvL-IL89zBbJSDGLA>
    <xme:sNOuZXyUTqYq5doEUzyWI7KN4CtTcsXoQK8EBadV-JOO3vKnXO_Zk-_6Gl_lhMUuV
    GMMOBG7CKmTZQ>
X-ME-Received: <xmr:sNOuZf34jMpD1J0hqBF9vJdGewB8AKGBr2wBptqjU9uE0AgFuhSZbdK26322>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:sNOuZeC92Bm5JEhCVGbybAffmfkaHnuMWaE8tjYyP5mNBD7TfHx15g>
    <xmx:sNOuZbjco0Jod66T7yP5hAikXE8xT3ejD_tG-MgR-rRT8utWhWSFBQ>
    <xmx:sNOuZarmmCI6InqB6TmNPy5KLHOik8Pqf1EKybemgmrXTBXnOWrIOg>
    <xmx:sNOuZWQxvNHkE2MgBWtwKeXASFQc7CgWqKf30lQeREy6-IRXfXM7LQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 15:44:31 -0500 (EST)
Date: Mon, 22 Jan 2024 12:44:28 -0800
From: Greg KH <greg@kroah.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Tom Murphy <murphyt7@tcd.ie>,
	Saravana Kannan <saravanak@google.com>,
	Joerg Roedel <jroedel@suse.de>, kernel-team@android.com,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] iommu/dma: Trace bounce buffer usage when mapping
 buffers
Message-ID: <2024012219-mushiness-implement-4fb5@gregkh>
References: <2024012226-unmanned-marshy-5819@gregkh>
 <20240122203758.1435127-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122203758.1435127-1-isaacmanjarres@google.com>

On Mon, Jan 22, 2024 at 12:37:54PM -0800, Isaac J. Manjarres wrote:
> When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
> use bounce buffers") was introduced, it did not add the logic
> for tracing the bounce buffer usage from iommu_dma_map_page().
> 
> All of the users of swiotlb_tbl_map_single() trace their bounce
> buffer usage, except iommu_dma_map_page(). This makes it difficult
> to track SWIOTLB usage from that function. Thus, trace bounce buffer
> usage from iommu_dma_map_page().
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Cc: stable@vger.kernel.org # v5.15+
> Cc: Tom Murphy <murphyt7@tcd.ie>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> (cherry picked from commit a63c357b9fd56ad5fe64616f5b22835252c6a76a)
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Now queued up, thanks.

greg k-h

