Return-Path: <linux-kernel+bounces-149191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2878A8D02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2901F2245E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A575482E9;
	Wed, 17 Apr 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf5519Ya"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7863D0C6;
	Wed, 17 Apr 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385981; cv=none; b=H0aBrObcnktb1cCvoylrLpahtF0Y/4G1vg0+XdvmHSq7sZCQPLnCE/e+azBxdgjoEnHe5bDHkUY92JQail7ZbZRWnCJkARZfbZ171kGmbCkT5SokXnNwmD/zFsEFLJ/6s5OnTyo1ouDcgscuavyHb0L/vGvwjO1Mbc2Pe3zZ2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385981; c=relaxed/simple;
	bh=lTR6y4fPduiya82NnYrhltb4YJaAycBG4JTcNmaYLjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR7ayma/1Ft3xU3bpK8cSLW7kUDLEA/UNHQZ1emPqPiaoDVI0dOztYS9FHn1g6C5kQBwQQgIL0GxMBOXRY0Pcyt3rStbXCFuHn3ztq3BtJpxPV7YLLVjdNtJYTA8RPdmcpm2bpfYGeEi6RbZSNi7W5Cc9y+2rb3UEbT4TSLlGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf5519Ya; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713385980; x=1744921980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lTR6y4fPduiya82NnYrhltb4YJaAycBG4JTcNmaYLjo=;
  b=lf5519Ya8+Gya8nbPhFkzhWZJqOzwoxOgy98QO8rVgb5dq5p9jqj35p9
   NUy+mbOK9R+FXC/WhmJMXFph+9EKeVRuoqF12HfNiR5lBp7ejzLEaeeu0
   V0eyTt8VyawbVu6frIzqSDUnrHtVfogStuc136A1xCIIBzI1/k61yE5L3
   40bxz67WCks2mXyr1SD7NkslWJ7lWxa5/G8XOlM/X9lvhXp1hF111w3FZ
   mHcQuZu7lPAT3KITXCgUBhGvlLAYIRydirdhXbrpE7Y8iSB++RmECeVU+
   DQ5la8sE39SMGpl4JBWsYkOo85Iu5avLTMDwCgO3eixB0QHpxUiH7cSDD
   A==;
X-CSE-ConnectionGUID: SvdCXsi5RY27hT2rn1fl7w==
X-CSE-MsgGUID: A+rARE3fR8ye2Gw7OlRgZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19508325"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="19508325"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 13:24:10 -0700
X-CSE-ConnectionGUID: WDGjrP4iTUqIEAcA7VY5Rw==
X-CSE-MsgGUID: U0buHxQITXuBTBv1UXRkRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="27541475"
Received: from mfzarate-mobl.amr.corp.intel.com (HELO [10.92.4.37]) ([10.92.4.37])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 13:24:08 -0700
Message-ID: <a44a9ac5-5afa-4226-8a59-fab3e44af352@linux.intel.com>
Date: Wed, 17 Apr 2024 15:23:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: "Xing, Cedric" <cedric.xing@intel.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
 <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
 <3d5ffd62-beff-4394-91e7-715b348b7bae@intel.com>
Content-Language: en-US
From: Dan Middleton <dan.middleton@linux.intel.com>
In-Reply-To: <3d5ffd62-beff-4394-91e7-715b348b7bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 7:19 PM, Xing, Cedric wrote:
> Hi James,
>
> In the past couple of weeks I've been thinking about what should be a 
> good log format that can be conformant to existing standards and 
> accommodate future applications at the same time. After discussing 
> with folks from Alibaba and Intel internally, I created this issue - 
> https://github.com/confidential-containers/guest-components/issues/495 
> to document what I've found. Although it was written for CoCo, the 
> design I believe is CEL (Canonical Event Log) conformant and generic 
> enough to be adopted by the kernel. Hence, I revive this thread to 
> solicit your opinion. Your valuable time and feedback will be highly 
> appreciated!
>
> Thanks!
>
> -Cedric
>

Hi,

Closing the loop on testing format options with CNCF CoCo as an adopter
community...
There was a robust discussion in the issue [1] posted ~1.5 months back 
on the
previous note on this thread.
It seems the conversation has tailed off with agreement that the NELR format
would work for that containers community.
I think that's a good signal for this approach to move forward.

[1] https://github.com/confidential-containers/guest-components/issues/495

Regards,
Dan


