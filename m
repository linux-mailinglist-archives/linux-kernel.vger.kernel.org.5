Return-Path: <linux-kernel+bounces-12823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B381FA80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3849A1F241CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36974FC11;
	Thu, 28 Dec 2023 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LhdziUWd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F6F9D7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 18:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929E5C433C7;
	Thu, 28 Dec 2023 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703787740;
	bh=tBExf5HuOVYqV/xViimQaqtRAwARNj/EtfuaeJz5sHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhdziUWdR5ijjRLcubLVV2XfqZsn0HgCDENEHcgR33G+Xxf8aSb5Ry7qzumGuGRDG
	 k4zb/lhlVnEMUjAYrSFDn7kt7Tzn5d6EekXqR+dN70s7M9WyPJ6BhNvmggXFKuzcLX
	 6GIonfB6Q5LgJcPCE1WztBJuFGI7hXjdTvF88Zlo=
Date: Thu, 28 Dec 2023 10:22:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "rafael@kernel.org"
 <rafael@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ying.huang@intel.com" <ying.huang@intel.com>, "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/vmstat: Move pgdemote_* to per-node stats
Message-Id: <20231228102219.30f165c01ed837cbe95655dd@linux-foundation.org>
In-Reply-To: <7cab217a-8543-4ede-aa67-4cc6900f5fb2@fujitsu.com>
References: <20231103031450.1456523-1-lizhijian@fujitsu.com>
	<7cab217a-8543-4ede-aa67-4cc6900f5fb2@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 03:52:25 +0000 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> > This patch also make pgdemote_* behind CONFIG_NUMA_BALANCING, since
> > demotion is not available for !CONFIG_NUMA_BALANCING
> 
> I just realized that moving pgdemote_* behind CONFIG_NUMA_BALANCING was wrong.
> Demotion works well without CONFIG_NUMA_BALANCING.
> 
> Since this patch was already in the mm-stable branch, is it possible to
> replace this patch from mm-stable or post a fixup for this

A fixup would be preferred, please.  With the appropriate Fixes:

