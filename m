Return-Path: <linux-kernel+bounces-164755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4E8B8213
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F4B213C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F51BED7A;
	Tue, 30 Apr 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQq31YhL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882011A0AF9;
	Tue, 30 Apr 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513580; cv=none; b=ao2mZ8GfwrGj3ccQoEHD6Yx+q3OQNjHrUlviqVuc21BRtahESQgRkpNBDJ4bd6C3jvdhzwpYYfMFTI/F3Q3igvygrD5jMZjPanh8f4tgSLtMxhOOD/U9GjGqHFFnynU+xeJ7zxcLMJ+pAFCtCU8fmmFsK+EZcgjayGcQmLjjV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513580; c=relaxed/simple;
	bh=78qG5kqlkVDltvHppEYJ+XTjcIg/mL/fOmO9DvbnYJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzatIDIhz3M3xnqWiKHMCnCoTtfmw/VP9GJly69lSLLQuJRxO4bAhJvciZ/Hjumuava8IHiMSFcRiJOXOQlNI9S2FOsHgIjGfGBBg4cdGdQdJ10OISlqyiX3UFs9gWWj3OJahlmAyAt35k7Kpud2FBTiWStOp5+aA4zJIF4xZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQq31YhL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714513579; x=1746049579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=78qG5kqlkVDltvHppEYJ+XTjcIg/mL/fOmO9DvbnYJc=;
  b=AQq31YhLCAzTXJebnPveQbJjc8OOH2dyKLPa2o6GE6PcOyKlrbW9j/hi
   70uZCBxQVEPZrIiwfk64IHEM4Tx/rZeUkGloFkfFwzV+1NxLKQ908tv5B
   GaxZ9VPfNoZoofwWMiAoi1173KAPljcP4sN1FdufjAKr+W8NtJSJpoSkF
   bP55vKsy6TPyVhA5ZdWOCpakzZOcvv9rakpm6/v7nGNaNeSI+h6ehVDIZ
   678IJ5D7VICOKWtsbiWrTfPpOEeJUQ4NK0R7g4F3zJzGOklIiyX+0EUQm
   YbzSuwcCBi3GsBQxZH7kYfRPbpoW8Jseg1eKzt8fgPf5QcffUSaQ1fNsN
   A==;
X-CSE-ConnectionGUID: D18PihHDTFGMcTVUPusHeg==
X-CSE-MsgGUID: Inh9/keLSB2SJpAxRRYB1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10173417"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10173417"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:46:18 -0700
X-CSE-ConnectionGUID: 9X0W5HnRT12ypdpykBlBdw==
X-CSE-MsgGUID: Vgw6QLO2QsmyY7OWS+21xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31209312"
Received: from kyeoh3-mobl.amr.corp.intel.com (HELO [10.212.18.64]) ([10.212.18.64])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:46:17 -0700
Message-ID: <83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
Date: Tue, 30 Apr 2024 16:46:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk
 detection
To: Allen Ballway <ballway@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Brady Norander <bradynorander@gmail.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/24 16:28, Allen Ballway wrote:
> This device has an audio card which is quirked for force SOF use but the
> device does not support SOF so the card is not usable and audio can't
> play through the HDMI output.
> 
> Add another quirk detection that matches the Azulle Access 4 in the DMI
> info.

Please try the patch "ALSA: hda: intel-dsp-config: harden I2C/I2S codec
detection" shared last week.

https://lore.kernel.org/linux-sound/20240426152818.38443-1-pierre-louis.bossart@linux.intel.com/

I really don't want to maintain a long list of ES8336 false detections
due to broken ACPI tables.

Thanks!




