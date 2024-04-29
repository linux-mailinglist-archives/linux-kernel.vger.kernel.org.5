Return-Path: <linux-kernel+bounces-162248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178DE8B5888
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83C41F240B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AB41A85;
	Mon, 29 Apr 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6zg6tz3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0339FC1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393811; cv=none; b=pOrcnmm6llzzLaulshMLut9xNYr2EtPZF4UzaQHIJ6njG5gOMG6Vtq0A8B+fROkdXfMD8tIXPMgdU1TRm2ZhMEgxlxvcalMjlUdJ8pzgz0pl6OEc4zTmURrLoaoWb1AVYQJLZy1WJYka83Lo3M43O2FpV/HwG2hXFHmBvCnFgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393811; c=relaxed/simple;
	bh=jSZtNNbY89BBhDgG9LJQspn1hyqRqmbxw5Q4oVoqn5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ce83UuZ0NfLzfAy+Vy3jA90bTg52u7VRj3HiMi+8ivdRGINViyqsC5zkpexBvU87MSWMnLDfx21HovBu4AtTkg1vi2V1jf/28oT2dNoWTp87TvjAoYpy8/tLNDhkW2e2IVCDoUwKDaKdLmLXX0dL960CeYqGyDULruXRz3x//CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6zg6tz3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714393810; x=1745929810;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jSZtNNbY89BBhDgG9LJQspn1hyqRqmbxw5Q4oVoqn5A=;
  b=b6zg6tz3ecPHHdtlwoFzUntUDpe38Y4TyfGtfLmsury5N+mfJaaYEiOu
   1MScDmrXEt0NZGlwjz9oqf6iEJsVus09BEyHrOk0pRzRLdeaG2EGNKAAn
   GMxafTX7sfUx/rG+q6Fq5B6SGpQToakflRLLIUOONGHy3rvKvu5cGDrOC
   RcGmP7PmEjzuHsgr27tOIbYkeP/9tlml64ylb+8jLszvcs7eJ2C2Paq5i
   2OZASPcNq1ETSBqpBZ0CzVBh09kAWjdSGmkCUgei6pU+NvgJPxfqt+73I
   nxEkNVzKNfK+fWwvKKX3jVVhkutzzcg+Iir/xgNDnTMgFQDBbZK0YbwzL
   A==;
X-CSE-ConnectionGUID: MmgETgAGT2mJG24J1P+Cfw==
X-CSE-MsgGUID: evBtjPtyTnKtbmJBkY8bvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10160081"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10160081"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:30:09 -0700
X-CSE-ConnectionGUID: u7GDqQo6SpuY9Q0t8jI1Hg==
X-CSE-MsgGUID: mzZu2YE9SdyC+9E+jTxfZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="57287644"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa001.fm.intel.com with ESMTP; 29 Apr 2024 05:30:08 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
In-Reply-To: <871q6owe8f.fsf@ubik.fi.intel.com>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
 <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
 <875xwjxgsk.fsf@ubik.fi.intel.com>
 <rucgdqb5ejtttsd2ksvph3toeow652rdiqnohdsg6ndp6qgcwu@c3rz275bofqg>
 <871q6owe8f.fsf@ubik.fi.intel.com>
Date: Mon, 29 Apr 2024 15:30:07 +0300
Message-ID: <87y18wuzao.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>> I intend to change the prototype of platform_driver::remove() after the
>> merge window leading to v6.10-rc1 closes to cook in next for some time.
>> If this patch doesn't make it into the mainline before, I'll send it
>> together with the change adapting the remove callback. That will go in
>> via Greg's tree, too.
>
> I saw that you included this patch with your series earlier today, so I

Wait, did I hallucinate this? I can't find your new series now. Ugh.
If so, I'll put your patch back in and re-send my series right away.

Regards,
--
Alex

