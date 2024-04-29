Return-Path: <linux-kernel+bounces-161758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD88B50D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E59281314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2288F4EE;
	Mon, 29 Apr 2024 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeumaphG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD7DDB1;
	Mon, 29 Apr 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370086; cv=none; b=HGh6J94B7U+Jqhj6cqL5/kdkBEDeBtmWMl8eAVfF3qfywo4xYqhy9OY7pT4l44E8aCGir05uNWZUr20hHY+zsImK63yi1Ssnrr16LCPybcgigrAy2ia0tmC3SZr5eq++OKTFmRcNB6t/SfwiOhvijjkcOmPtZSrOYMLkTBqgIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370086; c=relaxed/simple;
	bh=KygCcw1hhniytw++trr1oIl8MgJAAzVCuTLV+BjlSfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOfotNDSBuCW0yVclyABt8nSVDYEpMihAtuxhgzCKzk3Ariibp6pLkC6nClgZuVXagvZ5blGJfHWJ9JrGrPJcpIGIwUCYa98PN34VahlO10aA/UZHP0r7fpb7T8A0LLtU3KBrh8TxjI1yKsx34m+nzbGZKUx1sCA9FgoMv3xoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeumaphG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714370085; x=1745906085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KygCcw1hhniytw++trr1oIl8MgJAAzVCuTLV+BjlSfo=;
  b=JeumaphGQTAb7+4YH46KXBuFgNB+t2ezhoAcoUrFaxO5sSYXK/aoXS31
   vdYvCk+P/GvP0o99sQIaGvAuN4Uy4zdEiYbi1upOkfk1HF1PmGPlzlsLL
   gYIGhxDYI1HXW8x72J+pucD5zpaT3OHdewUhUDh8kO0LZX63s3j0kPpnx
   S+wPq3Ckd/ubU5/X+fUXgJag+10E1WY4DLFlMwUmHspqxPXwMpD/9SEX8
   fXnmGFRbqyVU8UAt0BQmY5JlbdFJjzuDx0TfipPdRITQQXO61ekhWarrP
   OKWSJy4hjQ8v/KEcmZ/BaIyJJfVB840IYkN2WIUzZVrMNVqh08qfY2KqA
   g==;
X-CSE-ConnectionGUID: Xr5sjo2EQr6DvAfR0NzZAg==
X-CSE-MsgGUID: QySg7LLsR3Wfo0LkHstnWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10129318"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10129318"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 22:54:44 -0700
X-CSE-ConnectionGUID: 6o34SmsNQRaOBDnFFVaOlQ==
X-CSE-MsgGUID: LigLZAAERTqT919KFbD8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26410927"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 22:54:42 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EC81311F830;
	Mon, 29 Apr 2024 08:54:38 +0300 (EEST)
Date: Mon, 29 Apr 2024 05:54:38 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] device property: Fix a typo in the description of
 device_get_child_node_count()
Message-ID: <Zi82Ho69tYm8Hyu6@kekkonen.localdomain>
References: <369e7f6898c4a442d45aa15d7d969131d61e9cee.1714323747.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369e7f6898c4a442d45aa15d7d969131d61e9cee.1714323747.git.christophe.jaillet@wanadoo.fr>

On Sun, Apr 28, 2024 at 07:02:37PM +0200, Christophe JAILLET wrote:
> s/cound/count/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

