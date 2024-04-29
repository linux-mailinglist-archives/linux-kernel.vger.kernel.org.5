Return-Path: <linux-kernel+bounces-161720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFD8B5024
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C82830C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB00946C;
	Mon, 29 Apr 2024 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gd3FvGYW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBE257B;
	Mon, 29 Apr 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363598; cv=none; b=OH0k/nU1mNTu9pQRiUIg40eK+uY+wZuMBtnfbvO4PmZMgwbZZ5g7DF7v6QBOuXuaYWzApBWPx3k6N0g+SzKfzL/fUMdwMVUkgIaxPGXGPrb7+NTVI0r+iAGUBm7KWVMws4aYuFbyFpidGk4rfgb3j99aDN2Hp9RKxU3NZwrhYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363598; c=relaxed/simple;
	bh=FD3ViZaLK0wtg7lH2KbwGb7HN39zndU5EWw+ZK7vnaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCU66FuSXL9hSXKcziDeSDh46Qc0rw2bHBf7iv3CepMsu+IZd8Ph7ZZs5th458x0LA73tRo4BZZQyS9Ja9Jg0aVxRMRJ7pET5750DmNWB8Up29cqEmKyVMjvs2cE/iPKHKF/5ldCkWiGPhsKhxjS5DZZsEY4j7UFUAcUXEVbYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gd3FvGYW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714363596; x=1745899596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FD3ViZaLK0wtg7lH2KbwGb7HN39zndU5EWw+ZK7vnaw=;
  b=Gd3FvGYW6tIn0YnJgvu17mzgIWGQ0xRDhGLPdC7kiM7DlqkDMALfuZJE
   kFQoPXXyCEFtKoZEhdrsiBJewBvgb65FtwNeVuzvsX6FlQc71wZZGugnp
   cH3VidNQZodNUbP7mODAuJ+9XWUETV6KxqBVyUvP71TI7CSwCeqif1NtX
   UlWVMjJoP3ZucsJIw/zg53r1/e0IkzaP5Q6q7iwMZsGPtWTEnnf6C0bv7
   PSLmfeswzFdjS4MYP9emZVxJKLEhYVU+RhSFLq+MZDFFTvKCTZNXfbM8Z
   vIEhHJJmGdUHO84ednkIgV4gmvO5WUc544fIhU9ovbjG4j5ki5EVjSS4R
   A==;
X-CSE-ConnectionGUID: Ks6MsBGKQOenRQES7iSdPA==
X-CSE-MsgGUID: giSd5P3bTCKNvtNUwaTA+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20565179"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="20565179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 21:06:36 -0700
X-CSE-ConnectionGUID: fVjHxYRMQvC1b0sDcXa9Ww==
X-CSE-MsgGUID: uFmKF7yfSqah2LD348K8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26001296"
Received: from kscheema-mobl.amr.corp.intel.com (HELO [10.251.17.13]) ([10.251.17.13])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 21:06:35 -0700
Message-ID: <228f5064-bf3d-4872-bcf7-b941f001d9dd@linux.intel.com>
Date: Sun, 28 Apr 2024 21:06:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86 is
 enabled
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0hqt6+1AvDWb0BYw0z9burVQfdkOF1qUGzRRuPmvq4qQg@mail.gmail.com>
 <ZiexZnmbLqPy11d1@smile.fi.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZiexZnmbLqPy11d1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/23/24 6:02 AM, Andy Shevchenko wrote:
> On Mon, Apr 22, 2024 at 06:37:59PM +0200, Rafael J. Wysocki wrote:
>> On Sun, Apr 7, 2024 at 8:33 AM Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> ...
>
>> Applied (as 6.10 material), but it looks to me like this declaration
>> could be moved away from this header file at all, as the function is
>> only used in one place in arch-x86 code.
> Yes, we probably may move it to asm/acpi.h for x86.
>
> I don't remember if I ever expressed that idea, but I definitely was thinking
> about this.
>

Makes sense. I have moved it to asm/acpi.h

https://lore.kernel.org/lkml/20240429040441.748479-1-sathyanarayanan.kuppuswamy@linux.intel.com/T/#u

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


