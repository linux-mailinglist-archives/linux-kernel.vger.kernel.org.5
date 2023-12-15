Return-Path: <linux-kernel+bounces-872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193B81474F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A5BB228F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947F288DD;
	Fri, 15 Dec 2023 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4GIXifE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152C25561;
	Fri, 15 Dec 2023 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702641068; x=1734177068;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fWtDRVeoSimGVB8lb7ll2lE4znrOoEonyfKQ2IcOzjY=;
  b=T4GIXifE7+8ZraaMV6AjdhxvFnSUyaRVd0XnLQOVjfcpH1h2Bz7JFlxJ
   TvV/mmuWCQ7Pc8vAL++DaRnpOn6P7UsRpzo7E1Fd6M4xnYtpiEuJWMAXy
   I/Hoh9Z6Y4lUS6aXKA9NhDehlYbV4JbC4FuO/KYg7Rhf7DPzpszw3memw
   D9cM6st+Kw6rs0v0+NKZnCVRt4LPLJv4DlO0vXipfk2E6KTO5woYEcuqB
   f0nyduJiqTYxzjmNzvcGds+J8T78TwV0JCTpFiTVYOilMbysaz+x0HZ23
   hNNnlWEZfrQjIb9UKpSk3ISERVtcwFlczO+AnfYv3ay2RG9Ta4bgoixKp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2086234"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2086234"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808943836"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808943836"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.145.7])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:51:04 -0800
Date: Fri, 15 Dec 2023 12:50:59 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] md: Remove deprecated flavors
Message-ID: <20231215125059.00006270@linux.intel.com>
In-Reply-To: <20231214222107.2016042-1-song@kernel.org>
References: <20231214222107.2016042-1-song@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 14:21:04 -0800
Song Liu <song@kernel.org> wrote:

> Linear, multipath, and faulty have been marked as deprecated for 2.5 years.
> Let's remove them.
> 
> Thanks,
> Song

Hi Song,
Great idea!

Please note that there are mdadm tests for those levels. I can approve it only
when mdadm clean-up is merged. Our tests must pass continuously.

It is a nice code complexity improvement so let me know if you would
like to get my help with mdadm patches.

Thanks,
Mariusz

