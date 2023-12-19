Return-Path: <linux-kernel+bounces-4804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE981823D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8431F24D59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A334EC13E;
	Tue, 19 Dec 2023 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl+8ivjV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3E14A8F;
	Tue, 19 Dec 2023 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702970817; x=1734506817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z+XpiPGaWflbcQBYZ16yoZ6jlTwt5CFV9FhRZHc9Sgg=;
  b=Tl+8ivjV/YfIPNGDD3H81nAjQZYEfFXWi9RcJGVLXdnxzppO62eomwPk
   dyUP22BC+BMdmsbEaWfSHoeli2c2Tz05AuLtFzPyu3iGRucNpViVz68Pq
   TlIj66YuS/sOki7CI5zEkRClFD+m+UCnSgHtvp6hUTafTtk7kOenGqdxX
   m2m/0t1qOQ7nfu7rp1bNZHU7KXcY5M0Eb54h06sapyhrhgjiMsz45x9QK
   ya8JW5+u3da24Ve5tJ6Z0qUJsMh5AW7iQZATWTZ93RWGLywLixBd03Tyl
   GjzZrTNz8YxBS7Rd/EVHYrMSNzHG9ERiie+SL4Y0hj67CxTKnhVRNfZsn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2442688"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2442688"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="725638283"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="725638283"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:26:54 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EF7AB11F7E4;
	Tue, 19 Dec 2023 09:26:51 +0200 (EET)
Date: Tue, 19 Dec 2023 07:26:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: media: ipu3: Remove some excess struct
 member documentation
Message-ID: <ZYFFu6ieLKk5QLKe@kekkonen.localdomain>
References: <87h6kfjay7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6kfjay7.fsf@meer.lwn.net>

Hi Jon,

On Mon, Dec 18, 2023 at 05:24:48PM -0700, Jonathan Corbet wrote:
> Remove kerneldoc entries for struct members that do not exist, fixing these
> warnings:
> 
>   ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved1' description in 'ipu3_uapi_acc_param'
>   ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved2' description in 'ipu3_uapi_acc_param'
>   ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2778: warning: Excess struct member '__acc_osys' description in 'ipu3_uapi_flags'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks for the patch.

I'll take this to my tree. I assume the other two patches are destined
elsewhere.

-- 
Kind regards,

Sakari Ailus

