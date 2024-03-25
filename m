Return-Path: <linux-kernel+bounces-116980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E930388A5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B5E296FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0DD13E04D;
	Mon, 25 Mar 2024 12:18:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBA13E04A;
	Mon, 25 Mar 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368826; cv=none; b=QMkAtcOidKpEx9d9pzio2rEqyO0v7xcOzEkdNMPT/Y70t2FGYvTQgu8C5DFy+38DCQG5bBLDWiMpUU8/ybug53be1FJ9HVGDvvn6DIs7mHL3AosPtUu8oKilAsytQ6Cz/7a+VIW1OYyBPIc5ldjDhULOXRz0mIdn8ci0m+uzRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368826; c=relaxed/simple;
	bh=F1i0nJhQlomLCRn3IkSGbdjRcJxAk5L3Z/oZb5ZtN5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck0td84FcgNsAbuBWH3VH8uoleuf55XRmLtVBhXgy/dpmE43G3ShXLwrOarS8Ecr/7XwZkm+egV2rJw3YIHOXMgpXAVAWPDOCoKiBCfaCEkeEuoLGcVGVmFodm2cgdgI80tjfiNJTKS8cIPUNCqoR4jmwqJkVH5hbyhXNuv211o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17757795"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17757795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070315"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070315"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:13:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09B5C228; Mon, 25 Mar 2024 14:13:39 +0200 (EET)
Date: Mon, 25 Mar 2024 14:13:39 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, corbet@lwn.net, dober@lenovo.com,
	mpearson@lenovo.com
Subject: Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo ThinkStation
 motherboards
Message-ID: <ZgFqc5Lz3P8BfPw7@black.fi.intel.com>
References: <20240315115810.15816-1-dober6023@gmail.com>
 <f748574c-93cf-48ec-8e88-44d5b35fb107@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f748574c-93cf-48ec-8e88-44d5b35fb107@roeck-us.net>

On Wed, Mar 20, 2024 at 10:59:34AM -0700, Guenter Roeck wrote:
> On Fri, Mar 15, 2024 at 07:58:10AM -0400, David Ober wrote:
> > This addition adds in the ability for the system to scan
> > the EC chip in the Lenovo ThinkStation systems to get the
> > current fan RPM speeds the Maximum speed value for each
> > fan also provides the CPU, DIMM other thermal statuses
> > 
> > Signed-off-by: David Ober <dober@lenovo.com>
> > Signed-off-by: David Ober <dober6023@gmail.com>
> 
> Applied to hwmon-next.
> 
> Please note that I'll push the branch after the commit window closed.

Hmm... Was it even compiled?

lenovo-ec-sensors.c:154:31: error: expected '}'
static int p8_fan_map[] = {0. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14};
                              ^
lenovo-ec-sensors.c:154:27: note: to match this '{'
static int p8_fan_map[] = {0. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14};
                          ^

-- 
With Best Regards,
Andy Shevchenko



