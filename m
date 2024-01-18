Return-Path: <linux-kernel+bounces-29841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90283143F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F17283E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60241F615;
	Thu, 18 Jan 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4Cv8eUI"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13D1D69F;
	Thu, 18 Jan 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565307; cv=none; b=YRfUEFcThx4OnOS2e06xvo0GENCHprGwQ9g/ArPOJzkQDD2whjBuhSFWzL3fnCNfX1cTBmmsujQ5DFOVjgUyXtbo5Sy0K8UykCS1Ea3khWG6OpsXL/w0AR0unxEcj+L4FxNhd3+zFr+0J+32StOG9JUzqUxh6wQRJ1OZGv7Wd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565307; c=relaxed/simple;
	bh=zd1UV6eXmnQI/ncNg9lE1AehtvdK32jRC/nujt6eyzw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=NhWf8Ck5JTvmODpwt2AOfq5Knxf5ZKya276dxEF9vpT4hNZrVnGItPXenTr8qb5awSndXkBcQI0LEKWH0pISMqSvKEe8pi9IdcxD6CygqTFysilkINKksYHrASg1YCSToF4t3+MXuVoKnlp0wnTz7Azx7b9J7jyH+w4yxjCpFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4Cv8eUI; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705565305; x=1737101305;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zd1UV6eXmnQI/ncNg9lE1AehtvdK32jRC/nujt6eyzw=;
  b=c4Cv8eUIpUFlBteniyQVk81f9P+KffRR4bNQKZDywrjkhkLjP37gojpW
   TFke6ZMPAPsTOQ1pruMGHzK8c3YbgqNZZ+DAXRuhKQCfp/TbtWxd7NXD0
   /BjF8yrkbXcSHXN8fcZVz3PY80/Kq5Q4IIR3WQ7zafs8N9FLd/DRmHoel
   aVhMpcounvzUe08rg6rzCZAnlO67D0VsvMl+gd1FazNzGR94XQ//oLM3B
   YGJmCjBnQBGu/vEXFONT/9Pj7gw/fHG5vmM7hqleaDBwX91y+btibVCZ+
   H6ibgCQc8N5cTHfVpD3koxF20VQ7Ir9UdxoenbweSRfwqcY3X1QrO2vRL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="400045527"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="400045527"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 00:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031573618"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031573618"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.82.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 00:08:21 -0800
Date: Thu, 18 Jan 2024 09:08:14 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: linan666@huaweicloud.com
Cc: song@kernel.org, shli@fb.com, neilb@suse.com, zlliu@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
Subject: Re: [PATCH v2 2/3] md: factor out a helper mddev_sync_blockdev() to
 sync mddev
Message-ID: <20240118090814.00001d0d@linux.intel.com>
In-Reply-To: <20240117093707.2767209-3-linan666@huaweicloud.com>
References: <20240117093707.2767209-1-linan666@huaweicloud.com>
	<20240117093707.2767209-3-linan666@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 17:37:06 +0800
linan666@huaweicloud.com wrote:

> From: Li Nan <linan122@huawei.com>
> 
> There are no functional changes, prepare to sync mddev in
> array_state_store().
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4bf821b89415..2c793992a604 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -529,6 +529,23 @@ void mddev_resume(struct mddev *mddev)
>  }
>  EXPORT_SYMBOL_GPL(mddev_resume);
>  
> +/* sync bdev before setting device to readonly or stopping raid*/
> +static int mddev_sync_blockdev(struct mddev *mddev) {

Please add something about MD_CLOSING to the function name. Comment is good but
you need open function to get it. Something like:
mddev_set_closing_and_sync_blockdev() is more reader friendly.

Anyway, LGTM.
Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Thanks,
Mariusz

