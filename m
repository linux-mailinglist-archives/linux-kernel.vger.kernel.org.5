Return-Path: <linux-kernel+bounces-147990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 247FD8A7C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609F3B21DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAC57898;
	Wed, 17 Apr 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmElhFwZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57E537E5;
	Wed, 17 Apr 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335336; cv=none; b=IfBSpCPnzMoy+YFAxp2ixc6fVtcNuy43wxMJfwvOtrl754OsO5weeTwpmYkStVdAJ29Y/Zoj68txJLAgqXGZtu+2MGVTtICrpeRs9UZEPxPBrb+ihtF2qhADtl/CPjjxged2cSOrTw9aeJOA0Q3Mk/8ZGCJPRAk9vmHINm+6EyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335336; c=relaxed/simple;
	bh=smjDec/8rpAG7SGBZVdym3JuATOncC3nq4kDgqqp4T4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=szVJ85XzvBGXh8G4ru+zFVhNecgxu7q/5320gsMScg5fdCUnujDUu2Q9ic0rexyjV42yWFzYQ8paFlbTSREpZdSbxQd0oQ5EntwnGC6THdP+gv1g82UyuGESkl86D07AvxXOFZiklLfwQlbZmy8YEmMgip3BN4gUkPLHzviT7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmElhFwZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713335330; x=1744871330;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=smjDec/8rpAG7SGBZVdym3JuATOncC3nq4kDgqqp4T4=;
  b=FmElhFwZ5+4nZs2Rp62bc4+DJi/4d+9oBIRKs6pp5GKMZVRdebR3R3z7
   YM4UcepTykRw1WBgQGfLYkJmnMi7x//ueNFh43vWDlNMlLCUHSxtM8gy+
   IXzNgpLxjgBadVnmlfb7dVU3zzDGFQ9C3EchJQL7JflPxozgKmproFto4
   zllyz9xOnOj6TzNwE1zYTJr5h4uW20Kr1YkL1CR6mDn6isX8m6wpiCuGj
   G6HjeEM8y1mZD3aPf+QqvpV0hF1fGu/vDkb/mySNkktEEfKjQwsa9/5KP
   tMRVSN+ra3pNZigc6q3pWskR0fjz7OvoD8xsyQzp1ocj35iQ57iX1nAei
   Q==;
X-CSE-ConnectionGUID: ABqC9J+DTtiDs7uV+cmsPQ==
X-CSE-MsgGUID: xMC1x+RGQw+In89kSntntA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9030484"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="9030484"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:28:49 -0700
X-CSE-ConnectionGUID: 0GDMQVMmTrmsmFjCQAMLgQ==
X-CSE-MsgGUID: 8ylpVV5nRniLqcZYoLqfmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22576325"
Received: from unknown (HELO localhost) ([10.245.247.35])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:28:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 09:28:44 +0300 (EEST)
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
cc: "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
    corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for vivobook fan
 profiles
In-Reply-To: <Zh6oooU-DL2IXLg9@laptop>
Message-ID: <e61ddc4f-5e55-248c-72fa-3c15d6316961@linux.intel.com>
References: <20240413202112.37729-1-luke@ljones.dev> <dccc5701-f533-e80e-09f8-199f232f447f@linux.intel.com> <Zh6oooU-DL2IXLg9@laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1066009640-1713335324=:1007"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1066009640-1713335324=:1007
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Apr 2024, Mohamed Ghanmi wrote:

> On Tue, Apr 16, 2024 at 03:51:03PM +0300, Ilpo J=E4rvinen wrote:
> > On Sun, 14 Apr 2024, Luke D. Jones wrote:
> >=20
> > > From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > >=20
> > > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > > to adjust power limits.
> > >=20
> > > These fan profiles have a different device id than the ROG series.


> > > and different order.
> >=20
> > Fix grammar.
>=20
> my grammar is not the greatest so i'm finding it hard to know what is
> the error you're referring to but I think that 'add'
> should become 'adds' ?

That's not what I was referring to, you've a dangling/broken "sentence"
right in front of my reply:=20

"and different order."

Please fix that. Perhaps you just want to remove the stop (".") from=20
the previous sentence to join the sentences together?

--=20
 i.

--8323328-1066009640-1713335324=:1007--

