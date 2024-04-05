Return-Path: <linux-kernel+bounces-133245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC889A122
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9211F2268A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D217165D;
	Fri,  5 Apr 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiBSLSW9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A616F91C;
	Fri,  5 Apr 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330963; cv=none; b=VxhX27hponqirZsv2aWZwU+ulGcaA7bvp247l37pMbyK9pN8i5aH7ypLEfdXDoz1xdj3Yefx12j/JwGzmmotbAWDweONtsbyYaRH87a9SBjTfbxEzJP0b3bC5GZdvjsvBJp016iUNYhxuqAPqlyYM5zYY02H1vVLwhmTXRJSM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330963; c=relaxed/simple;
	bh=OYqGBKrBY5SfTMrFR35DAFdlrk1wcg641xZ+cluwDl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9p2Gp9bqphALghi1Z0k/KSKTF1OL6XbaOLmj2b8RK+cTU+3cV5GKhxPsD+SZVe9T7qBSVJyL/fzhf4SxJUvYqsVDFwkOCsSH1fznprHmqwYqyoYgS3vWP0F+641hat/nqpXapVVybVSWBp0hOhg58uh4CE3X+EHSYMlSi8DeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiBSLSW9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330962; x=1743866962;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OYqGBKrBY5SfTMrFR35DAFdlrk1wcg641xZ+cluwDl4=;
  b=YiBSLSW9WG/ILNeB3z2ckUVg/N8NXUctDslOBCqfExg17jb2dt9QKNmI
   YYMjaxv8oHr2flBtb+9B3LTpTEbzaQ3UF8rIuq2ceUHhjL+OnXlkm23v3
   56wgaMPbpoWAVLkEVNXYsS60x+4VdAUuzuiThYsanXSYHucHY+wR6Yaf8
   X7S5sEBv5VQ6mgzIobV7WQezycRHbuCAK6D+PefBcF0g/hb809VGmKmEZ
   Ouec2QjwjKObUuZInrNP/yghLXzJPWSJDwDpSqMxxyfw0QVbHm3SgxxLN
   39MYXxyCSviqBWj4/lsMSGjCMdJUmja8HYn13J0LdiVVyVSOt+komNAit
   A==;
X-CSE-ConnectionGUID: f+Lq6uj0SkO3wNdJmmoZMA==
X-CSE-MsgGUID: bxxLuSy/RjWjtevxFr8TUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7505186"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7505186"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:29:21 -0700
X-CSE-ConnectionGUID: QudFO+hDT8K1ZFTSFgdMWw==
X-CSE-MsgGUID: 7CooQxbpT0WLEe0Pz0NCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23933087"
Received: from mdawoo-mobl.amr.corp.intel.com (HELO [10.212.152.63]) ([10.212.152.63])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:29:21 -0700
Message-ID: <36bb25c6-bb0b-4a95-936f-0f0333b2d1cf@linux.intel.com>
Date: Fri, 5 Apr 2024 08:29:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ACPI: x86: Move blacklist to x86 folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
 <20240404183448.3310449-4-andriy.shevchenko@linux.intel.com>
 <311c6f62-4232-417a-beb8-df9ca8a732ec@linux.intel.com>
 <ZhAWnOMaIcgXykft@smile.fi.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZhAWnOMaIcgXykft@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/5/24 8:19 AM, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 07:44:15AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 4/4/24 11:23 AM, Andy Shevchenko wrote:
>>> blacklist is built solely for x86, move it to the respective folder.
>> Don't you need #ifdef CONFIG_X86 for acpi_blacklisted() in
>> include/linux/acpi.h
> It's unrelated to this series.
> It was like that before and this series doesn't change this aspect.
>
> AFAICS the API is called from x86 only, that's why it's not a problem,
> but strictly speaking you are right. Feel free to submit a patch.
>
Agree.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


