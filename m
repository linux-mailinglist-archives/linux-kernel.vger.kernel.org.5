Return-Path: <linux-kernel+bounces-151481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF28AAF66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE6C1C21F58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932D128826;
	Fri, 19 Apr 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUwXN0ya"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFA622;
	Fri, 19 Apr 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533578; cv=none; b=R8vE6tQd3/bB48mTJUIQx58G8woI6AtJmNHj/Yi7lc1xt7ANnDiVTtUO5TDSvpJjy/dXwgFDeByLrFlpwna7Y/EfxO6m2BOTzsuRHqOuhHGQ6JRZO5DXC3DQgYGZSunax0fBRWMdMx7BsZuTPYsylr2xxZuuw6/LoLhmTN5XQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533578; c=relaxed/simple;
	bh=LhbTggTO/Za71U9Nzsfy3zlYZSd8CAnva/3Vl4sNSBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3boF+g+34kYweaLiQICjfshWtAyk1u9tZCW/MaMD9VsZ4SdqhmaMpWQcL2AaGvUjIH3DnyoKh1SFCxw03debbNcWax7rsdi6N4GZ2inFyJQzGXcqpgRdhOw+Or4nEpf2F4mrYkVRYyqKtiQ1YyLY2KNXLD0tij2iY8aAFeCHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUwXN0ya; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533578; x=1745069578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LhbTggTO/Za71U9Nzsfy3zlYZSd8CAnva/3Vl4sNSBI=;
  b=lUwXN0yaElnuR6AZgic2Ecb2nvu3Li7ika7JEB1M795AzqpxKVVxXY27
   dMbhP+eLtGnJkfhPGJb2kQvvqhLfwxppZx8Ff+gdhEWA665cxXUar+L8a
   0VkrOwfMGXFucs1UxnoWz9QD8nQaUNkFYyGleJDnIilmDrIKRV2JyXuV9
   O0mpyzMd6mFq4oRx60DG6yb+5xEtWtn3nda/R3fkx2NviJ8TB3ynIceJ+
   Dk3QrAoiuKneNuwa96rPzpW6i0UkxQRdMIuUJITADkJoPEKJZmaPaNtiy
   ai8xkZFZ3somfIqhxahbfPxhGYRiCSh/EPQK8x6id/HduvzO1eCcwsCUa
   w==;
X-CSE-ConnectionGUID: vEkJS/1CQWK+XsxaGq4OVQ==
X-CSE-MsgGUID: kE/xNi3TQ0O4dLtyaxv7rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20525319"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20525319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:32:57 -0700
X-CSE-ConnectionGUID: DESZkyngQsKLazwvX7oqWw==
X-CSE-MsgGUID: QDBZqaw2Ssm/DKzTzAemnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23836439"
Received: from mpkangas-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:32:54 -0700
Date: Fri, 19 Apr 2024 16:32:45 +0300
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Message-ID: <io2megd6ymifff3ae6bqvdig5de3loczdmbnhoao3e32vuiqvh@pkqmxl4p7yy2>
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
 <CAHp75Ve=TUqba0Ga23QCiP7uM==VzY6kL=3A-5k5WNJAz4gGuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve=TUqba0Ga23QCiP7uM==VzY6kL=3A-5k5WNJAz4gGuA@mail.gmail.com>

On Fri, Apr 19, 2024 at 04:12:55PM GMT, Andy Shevchenko wrote:
> On Fri, Apr 19, 2024 at 11:07 AM Aapo Vienamo
> <aapo.vienamo@linux.intel.com> wrote:
> >
> > This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> > virtual GPIOs. On SoCs with limited physical pins on the package, the
> > physical pins controlled by this driver would be exposed on an external
> > device such as a BMC or CPLD.
> >
> > Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hmm... How did this happen?

This happened because the commits got mixed up between the internal tree
and my own branch. Apologies for that.

Sincerely,
Aapo

