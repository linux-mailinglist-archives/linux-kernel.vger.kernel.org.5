Return-Path: <linux-kernel+bounces-17964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2A82561A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5281F27C44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C52E40A;
	Fri,  5 Jan 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTuBahhA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400C2DF66;
	Fri,  5 Jan 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704466101; x=1736002101;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RxEU85iqOfByUyrJYPVfCpaU9ks1B0mopNfPQI1Vdnk=;
  b=YTuBahhAoSxEy8MdvLSuFQT7MIokQELSURlE3Dlnb6Y0nY7lhx2Wk1gi
   lUJyzOEgRfy8UpFVLfBEO7fHU3og5H6Z+HgPEIgUIazD9VcFUrcosTaJO
   H/I2qXGFjIV5tENXmhF01MxUbGGRfIc3lq2TuAuF1OGkIeNJ+EPd63zAE
   cTs6KZBAfrSUzZXtJi40FERz6akdWDDiTQtJ4r6f9h57XmirGE8hCYZn0
   LJs+nYxurgQZShDQrKJrAsD2c4CEgBUtfcTVvqpZengjNiUUmiPuI2We+
   uKskhAcIAY/hNJQgEnjbXjfmPPOreITiFqOquyhu+/46mzCkfICj6of2R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461819331"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="461819331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="15259927"
Received: from gchung-mobl.gar.corp.intel.com (HELO hschroed-mobl1.ger.corp.intel.com) ([10.252.52.104])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:48:19 -0800
Date: Fri, 5 Jan 2024 16:48:17 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: lizhe <sensor1010@163.com>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH v6] serial: linflexuart: Remove redundant uart type
 assignment
In-Reply-To: <7a49d3a4.1e16.18cd8564671.Coremail.sensor1010@163.com>
Message-ID: <ee52b724-799f-1be5-b455-8e82aba55ee2@linux.intel.com>
References: <20230105170437.4437-1-sensor1010@163.com> <67a7681a-ca4a-0ac7-97b6-2c7db8f2bb3c@kernel.org> <7a49d3a4.1e16.18cd8564671.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1854983850-1704466100=:1746"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1854983850-1704466100=:1746
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 5 Jan 2024, lizhe wrote:

> HI，all
> 
>        How should I wirte these comments ? please help me, 
>        i am not sure how to properly write these comments, 
>        i want to merge this patch into the mainline
> 
> 
> 
> 
> 
> 
> At 2023-01-06 15:16:56, "Jiri Slaby" <jirislaby@kernel.org> wrote:
> >On 05. 01. 23, 18:04, 李哲 wrote:
> >> in linflex_config_port() the member variable type will be
> >> assigned again. see linflex_connfig_port()
> >
> >I wrote to v5:
> >Please use capitals when you start a sentence. And periods at the ends 
> >of them.
> >> Signed-off-by: 李哲 <sensor1010@163.com>
> >
> >
> >> V4 -> V5: Link: https://lore.kernel.org/all/ddcf396b-7b91-00f3-8c16-7de5d
> c891aef@kernel.org/
> >> V3 -> V4: Link: https://lore.kernel.org/all/2f726128-29c-b7dd-ad8-f8b536f
> be5f@linux.intel.com/
> >> V2 -> V3: Link: https://lore.kernel.org/all/8f433e5-fb46-d3b8-431b-4bddcc
> 938f6b@linux.intel.com/
> >> V1 -> V2: Link: https://lore.kernel.org/all/1c33a2af-cd0d-cdde-5bc7-49b41
> 8665784@kernel.org/
> >
> >This is not the proper way. PLease see:
> >https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-
> canonical-patch-format

For this you need to spell out the changes you made between versions.

E.g.,

v6:
- Used Chinese letters for From and Signed-off-by


-- 
 i.

--8323329-1854983850-1704466100=:1746--

