Return-Path: <linux-kernel+bounces-135617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E889C892
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF94286829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B5141981;
	Mon,  8 Apr 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceAG0F83"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6562561F;
	Mon,  8 Apr 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590925; cv=none; b=Ip3zlLyIOLraoHUnSZDVHdKDUr/TWzKWlCMSv/arLBSYqqD6x5OF1n32w/pEgUI7L1gwc5gVziPvU41KLpNlE7vSTlGB1TYI3shNv1carRUm6zeZ7SnxM1kQmz9PVn7s7PUlQYCw5Apv7NN3iqGi/GiswkVl52HvnLdciheGJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590925; c=relaxed/simple;
	bh=bArQz5icl278xwWhfGv9Pk2wQyLMoJSvwtaPZLGeo9I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CIaH4pRT0NeuSOlxTCg0Xudn0J4KnsnwCaIqFZyXy8cGLhLd6W/3S5qR5t4yd1kf8peMzf1CCp+ocxcq4os9GP/Y8aoUXHe/MoXNYvp5Cd488KNwP1ab+EyeG4nL/J+Dnxe11sluxh2kMcepYA9vw3Z2wvccFbddKQWzdUSX7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceAG0F83; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712590924; x=1744126924;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=bArQz5icl278xwWhfGv9Pk2wQyLMoJSvwtaPZLGeo9I=;
  b=ceAG0F83fc9bGIC/QgIuC7gELSI+517mpq75PZ/4qQWlstRf2OKdCGz0
   3kdx/V8L3/n/dhHvQQV0VQg6mONjjvQZ6+Wtr0a4bDcZKXZzA7czf6Fwx
   GrIj8B0H+HKZ2ak2FQpUIpkK9eEq9P5q7Oma7bZR+zOKxkoNroK1skL9t
   d8Oet0q+FMltj4v5A8aLefogFfT9fQjpA/awPFVJMJig7n0j5fawYiTO7
   uW6YFV//D7/wVovSENnJKbA233XYh851aIDdSK64zT7lY8G3BaDgRbEzY
   BJ+Dit73jt0e4/dxRk76NBBZFCU/QppBuJ0jQwVRnm/h0x29kCfACBZd2
   A==;
X-CSE-ConnectionGUID: C+SjQHdtQL+NWrE3y/9YQA==
X-CSE-MsgGUID: jQHkWfbFQVSyFa8dnDX+3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18446925"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18446925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:03 -0700
X-CSE-ConnectionGUID: oxeXO5YgTMmQtMzjOBZpKg==
X-CSE-MsgGUID: 7VsVyfMBSYGJiXCcVtQHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="43094929"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:42:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, jlee@suse.com, hdegoede@redhat.com, 
 onenowy@gmail.com, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240329152800.29393-1-bero@baylibre.com>
References: <20240329152800.29393-1-bero@baylibre.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Add support for Acer PH18-71
Message-Id: <171259091380.17776.12885756128842752367.b4-ty@linux.intel.com>
Date: Mon, 08 Apr 2024 18:41:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 29 Mar 2024 16:28:00 +0100, Bernhard Rosenkränzer wrote:

> Add Acer Predator PH18-71 to acer_quirks with predator_v4
> to support mode button and fan speed sensor.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: acer-wmi: Add support for Acer PH18-71
      commit: b45d0d01da542be280d935d87b71465028cdcb1f

--
 i.


