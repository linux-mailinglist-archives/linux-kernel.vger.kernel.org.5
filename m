Return-Path: <linux-kernel+bounces-154955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB478AE381
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC121C2214F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39C82865;
	Tue, 23 Apr 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERnBvNby"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDF80028;
	Tue, 23 Apr 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870646; cv=none; b=McIFTCSSLlautCAxL3r8ISgCDKGc0PtRggL2S+KbrCwPhsDhWwLCBbosgekjZIIvy53Cts8GbLC0eRZ+g9W2cW3iUqoKCov7id1Eg8rx9UPnBMbwoZFMycvmfpWT55qBwsv5EvBIyxSuGjvxvM5te/7GlzVSyAJiffqZgNU4+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870646; c=relaxed/simple;
	bh=FhMYwpD0Jy+0t5UX4wrDuIaENfV+qwJP/+xWhZFZCdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHkX7VD6nLSh6upVA9fIJm9w2KmOdWzm9TWX+uBPXXpxGUDUmefcuoqmVEyjgqCW2K94IDiuVvYT+wyKl7LXiF3vssX8M54uUlDsi7aLOrxTg8hhBpXwQ+zhnUyR4tskoNOC50PDjo4jJs1A5YICrpNEAV9CY/jUZVYBhBidrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERnBvNby; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713870645; x=1745406645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FhMYwpD0Jy+0t5UX4wrDuIaENfV+qwJP/+xWhZFZCdQ=;
  b=ERnBvNbyFK6VwTLE/1IyNhrnjvj0TxFuN2XL4Gq4yAOJ7yN7lSkTHEOX
   CDlc2aCKPJPboY8CRQ9p25ZrTi0xPKZuDho4/fJGNiDcoXAExx5WCcUT7
   k1Ot3Y0us4F2uybfjrr42Qo85nTF/Jmcg9zLevTfktr3qGwmdSW6fDX4u
   oTSHr0zY+q3Of+/1/hBTnL1uVqM88Npsrax+/yF5sxl/b18eE4LkXFwEC
   8rX2uGqbODoQIr+zy0zp+Xw2b4xHI78iHrjfyCgGijDyqdO1VYQBh/OOC
   Igdk54FoXmzzQn2j3gpp4kz7UQAw2sFDxEGa/Tc3pVTe6HmSSwbPnLjKU
   A==;
X-CSE-ConnectionGUID: yTIwQevkT9CXDZpZ5SC9lQ==
X-CSE-MsgGUID: 8EmlvmEuT8+Ut7spIoLwrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26905757"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26905757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:10:45 -0700
X-CSE-ConnectionGUID: GHANmPF1QaSu/tzRusNdUw==
X-CSE-MsgGUID: zm+oKK03QECvY3VX9hfdGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24342606"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.35.198]) ([10.246.35.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:10:37 -0700
Message-ID: <eb54c7bb-db63-4361-b42f-dc02e2c37fbf@linux.intel.com>
Date: Tue, 23 Apr 2024 13:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 0/5] Ensure the copied buf is NULL
 terminated
To: Bui Quang Minh <minhquangbui99@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Krishna Gudipati <kgudipat@brocade.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>,
 Manish Rangankar <manish.rangankar@cavium.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Saurav Kashyap <saurav.kashyap@cavium.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.04.2024 18:41, Bui Quang Minh wrote:
> Hi everyone,
> 
> I found that some drivers contains an out-of-bound read pattern like this
> 
> 	kern_buf = memdup_user(user_buf, count);
> 	...
> 	sscanf(kern_buf, ...);
> 
> The sscanf can be replaced by some other string-related functions. This
> pattern can lead to out-of-bound read of kern_buf in string-related
> functions.
> 
> This series fix the above issue by replacing memdup_user with
> memdup_user_nul or allocating count + 1 buffer then writing the NULL
> terminator to end of buffer after userspace copying.
> 
> Thanks,
> Quang Minh.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Bui Quang Minh (5):
>       drivers/net/ethernet/intel-ice: ensure the copied buf is NULL terminated
>       drivers/net/brocade-bnad: ensure the copied buf is NULL terminated
>       drivers/scsi/bfa/bfad: ensure the copied buf is NULL terminated
>       drivers/scsi/qedf: ensure the copied buf is NULL terminated
>       drivers/s390/cio: ensure the copied buf is NULL terminated

Typically you don't include path to module in title, instead:
ice: ensure the copied buf is NULL terminated
bna: ensure the copied buf is NULL terminated
etc.

> 
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_debugfs.c    | 8 ++++----
>  drivers/s390/cio/cio_inject.c                   | 3 ++-
>  drivers/scsi/bfa/bfad_debugfs.c                 | 4 ++--
>  drivers/scsi/qedf/qedf_debugfs.c                | 2 +-
>  5 files changed, 11 insertions(+), 10 deletions(-)
> ---
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> change-id: 20240422-fix-oob-read-19ae7f8f3711
> 
> Best regards,

Thanks,
Marcin

