Return-Path: <linux-kernel+bounces-127948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053989532D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8118E1C2311D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45279B87;
	Tue,  2 Apr 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U80+1NCT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F912335A7;
	Tue,  2 Apr 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061389; cv=none; b=Uz6UFLcD4DYLB6ITcC9MpH+UuiPuvDnro5Dy1Xd6uLP7VyooHv1/2U97BuwnZYfbJI8Ayn5byRaXQX6oKuf88Ygav0dbO7gB8gdOWM32OMP95//o6Jjc7IY2g+u46hwaQ/y4rHhGmrYN+KtfA4lju2y5ZE0YqbGp6cwLmJxxrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061389; c=relaxed/simple;
	bh=LSeP6HN3z5K0OrmN8QMXYgQgBRdsW+fePyJf3hdOeBM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SclKaaRfzdLQO6+D6GqrvbHmebeEmCUKi53DdOS1eV2cTKw+sN0mgNWrpgvjzF0X54pY4Y86YGHL8MdhyQkPUXCW8tJpHNo3L7XM6AULzSsE7cIJIp9JZ+HkI8wh4/Q/MLA2UYIlaWse04cAYfzSjPXB2T/+ceZhxcv3E2dtslY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U80+1NCT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712061388; x=1743597388;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LSeP6HN3z5K0OrmN8QMXYgQgBRdsW+fePyJf3hdOeBM=;
  b=U80+1NCTpJVptOlpbA3DqcvAx+wofy2mw5B3N9faYVVPXlAQjtLIdOAn
   XFB9A5ILVhWkTYlT68wVOUsGGQoLeBnjTD5KdRMIcIc4ugeSAVztp4/Ok
   D35oNtaR9Ut0TXad2h4C/SF954O9PsQ0/OvZFwlFrgdgG0C+5xmDA1Kwu
   0fO3f009gwTTMxtY+WAJPXV4+0Scss/3dCYFjxdeJsqaBdq7QPcckTjQm
   aYGr+sSZRJS4J2ZE1Y+ixEuDZjesJ0t8wwiOy2PRo0C+awxdiat0duKn/
   qpat3cOgwBIYU+l61YjdBhT3MeDTJI/caIalLfQyacwlmTYlKS1/eZ1WN
   g==;
X-CSE-ConnectionGUID: o0qCbYu6R3ioGQ3VYgVAWA==
X-CSE-MsgGUID: MAd9wtCLSxuCRZ96H8jq/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7415864"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7415864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:36:27 -0700
X-CSE-ConnectionGUID: bpp0ap3QQ02FGnbHYhaZeg==
X-CSE-MsgGUID: OGqpTPEnRY6nrhf+1VUPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22507089"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:36:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 15:36:21 +0300 (EEST)
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Len Brown <len.brown@intel.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Harald Welte <laforge@gnumonks.org>, Matthew Garrett <mjg@redhat.com>, 
    Ivan Kapranov <i.kapranov@securitycode.ru>, lvc-project@linuxtesting.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
In-Reply-To: <9c4cfaf8-7738-4ba8-951e-5b91a3414f37@gmail.com>
Message-ID: <ab04ebea-235b-e3ec-5982-e1f7907bcc64@linux.intel.com>
References: <20240328103518.169604-1-korotkov.maxim.s@gmail.com> <da442a04-9db8-4951-98b4-3e149ea06415@gmx.de> <9c4cfaf8-7738-4ba8-951e-5b91a3414f37@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 Mar 2024, Maxim Korotkov wrote:
> On 29.03.2024 03:21, Armin Wolf wrote:
> > > Added a pointer check to ensure that it is valid
> > > before using it for pcc initialization.
> > 
> > is this check even needed? I think the ACPI driver core takes care
> > of passing a valid ACPI device pointer to acpi_pcc_hotkey_remove().
> 
> I proceeded from the assumption that the current check was not redundant.
> Kuppuswamy correctly noted in the message that the device would most likely be
> valid for the function of removal.
> 
> However, in my opinion, checking for NULL is a good coding practice, and has
> now been implemented incorrectly in this case.
> 
> Eliminating NULL checks could potentially cause bugs in this context.

Hi,

If you're going to be submitting patches based on some automated tool 
which finds "bugs" in kernel, you need to be ready to go through the hoops 
of the review process and not just assume the patches are good as is.

We do not do pointless NULL checks in the kernel, this is not a matter of 
opinion. If there are unnecessary NULL checks, they should to be 
eventually removed (and definitely not used as an excuse to add more).

If the NULL check is not required as was implied to you by the reviewers, 
the correct response is to go check that the what the reviewers pointed 
out is true and _adapt_ the patch based on that. Then send a v2 of the 
patch. It how the kernel development process works. You might sometimes 
find the reviewers are wrong too, if that happens you can come back and 
point out why the patch is correct.

Either removing that check adds a bug or it doesn't. Not "potentially" 
which is just an excuse for not wanting to figure it out from the code.
It takes time and significant effort, I know, but spending time is 
required if you want to participate in the kernel development.

-- 
 i.


