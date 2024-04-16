Return-Path: <linux-kernel+bounces-147017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6408A6E43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1041C22367
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F2112E1DE;
	Tue, 16 Apr 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqpP2Qs+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149C7BAF9;
	Tue, 16 Apr 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277805; cv=none; b=CX5kAwIY1OcjzVqsqdayv//Iudyavdb6wBClxV+JJfe/Gqi516EU0pW/kJe069fKhhMVD0BKLLb3+NDBIkM/H67trB7qbEF0Lh2jMkefbXheYvpvak3ymkAICryUwIGUIGWZjBjJ5DF6P66hmRC9hNVwAy/87hai5oaXAfXuSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277805; c=relaxed/simple;
	bh=PG7+KzUG9BmhGvzf7DGveQW4rN7ieE1W/rpfnZho9f8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXzDv8B6Iw8hVZFiS/SnldJ685XsXveTJSBm2i+6c7yLLZdGAIthu4nlqY0eX8o1IFkx3DNdI99FE3acLC/wbdKLmp8t2ktfOZCrJs7a0h51m9PkiNuFWDKCn2QmMjzeyLHmrELTK8/NyNs7mPZLA8HFh3FQxFfpA0KD1lN2GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqpP2Qs+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713277805; x=1744813805;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PG7+KzUG9BmhGvzf7DGveQW4rN7ieE1W/rpfnZho9f8=;
  b=CqpP2Qs+4uGyyjK4Qgan1lqTxRecAQroml+4JfM0HcGQXdboAA2gVZ9o
   bJteyjiAj6jdpwwdABZvrbkDg+NDbYpUU4staX0w/w+v0RDOHrn6jEE4s
   4/oqJ556xI717ZbUh9EcHl5xoil0g7StLpgFxtdwZXospIAR1Q1Gaakv+
   L+Yl5Kuye5ClABzZ5UqvZ4YCmQyCpuvROwo99TvVXEj/b7TyOlOnywz07
   rqilpeL54rGE60hxCjOIHTZ7Qr0k+HkPyMKPJcvoBW/zy4IiWzvAqbfj5
   Db5mC3X9dtNILwhzGUBHlEFcRgdDiwVjCd3A83M9k55/lljfVniXfOmoQ
   Q==;
X-CSE-ConnectionGUID: YH3YoUjOTLOq/pAZMT3ykQ==
X-CSE-MsgGUID: 5sexI8vET2WMfAKFKL3KMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12558487"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="12558487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:30:03 -0700
X-CSE-ConnectionGUID: vg0YtdBJTSO9xVUl7mpFxA==
X-CSE-MsgGUID: OFW2gb/lS3e2gWXlLLPbIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22348527"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.98.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:30:00 -0700
Date: Tue, 16 Apr 2024 16:29:55 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: song@kernel.org, yukuai3@huawei.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] md: Added journal count to md_u.h
Message-ID: <20240416162955.00002a4b@linux.intel.com>
In-Reply-To: <20240415160818.8276-1-jain.abhinav177@gmail.com>
References: <20240415160818.8276-1-jain.abhinav177@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 16:08:18 +0000
Abhinav Jain <jain.abhinav177@gmail.com> wrote:

> This patch addresses TODO in "./drivers/md/md.c:6752".
> Add journal struct member to mdu_array_info_t in "md_u.h".
> Add the journal field in get_array_info function in "md.c".
> Need feedback on if the update_array_info function needs to be updated.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---

Hello,
The field you added here is unused. I believe it works but I cannot determine
that as the filed you added in not exposed to user (probably --detail is right
place). Please do some tests and include the example test in commit description.
Please also explain why you see it useful.

For the question you asked, having it in update_array_info requires possibility
to modify/set from userspace, so user interface and/or corresponding metadata
property is needed.

Please explain why it would be useful to have possibility to set it from
userspace, what are the benefits.

Thanks,
Mariusz

