Return-Path: <linux-kernel+bounces-81922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE4867C38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7CA296D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDF12C522;
	Mon, 26 Feb 2024 16:40:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD242433C4;
	Mon, 26 Feb 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965654; cv=none; b=hPZwRctzKVUnYYFix0VR4bmcHGAqm0t7+t3Wroqacy3tpzGTzxDyj9B1YIRK/3TtkFjAjmTJ/bGTXsI+jTimWZOdMWsBjj0rBDnQ/uGySYW3j4EUcQFCnXQ49ODSlisAGYU58LOF5dXvQR6hYyHEawOZ2OURLht4SYVdTm4xHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965654; c=relaxed/simple;
	bh=tbrC+G2poxmPDlALZboFVqjxLPIIMR/BR+gc8VJamMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn9q/Pzf2yaRza7/gf5lWAPSB8H/6PBrVNNM/4ECnI6dpZ+l3XO1HeCRvdMx+8NHAn7yeFgOJCVbSbB3F3F3BjkXHN1/AyEvP1NKisLExzgBM/uBfW1Biv4Ys+vi55HFSdxI/WvbDXvxusYycoj+AajBDzeL/rrffYO111b3Zbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13903010"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="13903010"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913881452"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="913881452"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:40:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1ree21-00000007jed-1KuH;
	Mon, 26 Feb 2024 18:40:45 +0200
Date: Mon, 26 Feb 2024 18:40:45 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: ojeda@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, geert@linux-m68k.org, pavel@ucw.cz,
	lee@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Message-ID: <Zdy_DRAJaHXY7xov@smile.fi.intel.com>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 26, 2024 at 04:23:15AM +0200, Andy Shevchenko wrote:
> On Sun, Feb 25, 2024 at 11:34 PM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> >
> > This series adds a driver for a 7 segment LED display.
> >
> > I'd like to get some feedback on how this could be extended to support >1
> > character. The driver as presented is sufficient for my hardware which only has
> > a single character display but I can see that for this to be generically useful
> > supporting more characters would be desireable.
> >
> > Earlier I posted an idea that the characters could be represended by
> > sub-nodes[1] but there doesn't seem to be a way of having that and keeping the
> > convenience of using devm_gpiod_get_array() (unless I've missed something).
> 
> It seems you didn't know that the tree for auxdisplay has been changed.
> Can you rebase your stuff on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git/log/?h=for-next?
> It will reduce your code base by ~50%.

I have just updated the branch so it adds one patch that changes the prototype
of linedisp_register().

> WRT subnodes, you can go with device_for_each_child_node() and
> retrieve gpio array per digit. It means you will have an array of
> arrays of GPIOs.

Btw, as Geert proposed for another 7-segment driver, we might gain from the
display-width-chars property. But I think this property has to be parsed on
top of line display library, no need to have it in each affected driver.

> > [1] - https://lore.kernel.org/lkml/2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz/

-- 
With Best Regards,
Andy Shevchenko



