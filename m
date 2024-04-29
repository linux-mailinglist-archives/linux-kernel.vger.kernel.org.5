Return-Path: <linux-kernel+bounces-162607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599F8B5DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EA3282BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5D82883;
	Mon, 29 Apr 2024 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJSKaAHR"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154645F861
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405566; cv=none; b=VvknZhN3ByEPbFspb1tTcTKvAWy/QKDJ8ooLTdgnbqXcI9XbEZzXJBZofWawCPP6eiy0uJPyyrFeyHKMXs7sI2mg2GHCJsdlxIqjtqrAwQjLf/w0RDjEqT4dNaxIallDmRDS/lNEacqJDf1O4l+s7487HCMXGcVnWiryJnegCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405566; c=relaxed/simple;
	bh=P0h08ySQW/pzGkMT46fRR86P2Rx2EeEH89//p3wP4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg5p6ukMQIhaysJ3TUQqlO1tqy3Co2/fBeVv1YxSiWvHAds6CFzYkFB2ov95KLKJ5I+IG1xgJSvzU3gNTBMjY5AxgA4VkVd/zVpaVXCDNLFWACv3Dkl9S+6QGqf+F7b0I+PhKKh564fCXbBdp4PCflWBkfrFHYBEoH7FXZfFE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJSKaAHR; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 08:45:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714405563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bH1KRroG12nkropE2iEhNxUKhZ1TUIZx58axkBs7XDg=;
	b=LJSKaAHRqD6cV8/+ofcEmnU8toT9CxLa93fd3yhqtQTQYWK0hz83Zy03x5rg1qsGwmganW
	nXJ/gFY1YXGCRbZ6nH6UdFHZjNUoG4umRh8kqMm6osnG/yNgCoAGsQix4ayS+9pUkyFXQO
	Avog2hIKItss60wffjdQ64j4nBemfdA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] memcg: cleanup __mod_memcg_lruvec_state
Message-ID: <Zi_AtYd4q7K4SiSW@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-5-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:30PM -0700, Shakeel Butt wrote:
> There are no memcg specific stats for NR_SHMEM_PMDMAPPED and
> NR_FILE_PMDMAPPED. Let's remove them.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

