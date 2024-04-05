Return-Path: <linux-kernel+bounces-133221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F181589A0BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC422862E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1116F84A;
	Fri,  5 Apr 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfGaSh3Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A816D331;
	Fri,  5 Apr 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329971; cv=none; b=KXbGSN0X6zgzRxI3H1NAJW+NNIePre2rqucNH5BhvDt6D14VzJU30oGu4eoTgZVSkyhPp5dhttokIMVFAG/AHQTu/TLFzOp/49w7SuwPsQsaaayApM2wo2EKzO6jE9jHvoKhK7+iuIK+STTeQTBA9Jotmei0eP/mffGRVdaquiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329971; c=relaxed/simple;
	bh=JIVzB8EAS0X1yVhPxr3X0yBglPfuin2m7XG+z2ewpMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkT4JAKyGLHQQXupQUZoOTdnOzvlYfHic3tE9jwLEnpg1fgZRHUVCXgaEkcRQX/1NkAhIzpeIk9Ugc6mIl3AbzDcQJbbzu3OOCYL+0H4Nqzu35+NwT1ORk0nf3py/J2/SEBeQGcn01RCMQNLy7o+/XR2h+30YnX6moM5F7KQJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfGaSh3Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712329970; x=1743865970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JIVzB8EAS0X1yVhPxr3X0yBglPfuin2m7XG+z2ewpMI=;
  b=YfGaSh3ZzQm0vrnVbF2HDG54o6T7MpGIxutAMYqSikYD39C6T9of8ZK1
   EyhBYLLdjLX2ByIFteh0hjH3jS1yEuTY2WHXdMPp/pr8TbrKkJuTZPsRW
   LZiE5k0EpIYWuQmGMdAOoXhk8mTZ7OIQ2ySs8G6P1d87QdVtagYxTz986
   ee8cNTySYOOJpsFYqxsIqHcpQ7qITey82XKOGwEMcX2/SB9LK5JOtdElM
   +kt0+c0Bmp3+q2ETiapn1yPh+yzRi4xDSMy8+xmWPv/0MhZXhTvhUhPsU
   KU2jL9XdGAyoVvk12Jwkc/tLqqNciwlKkZA5Gt/UZi7kXVuVvY9cJJp9u
   w==;
X-CSE-ConnectionGUID: L+rRlzjMQpevZJW/y6aZiw==
X-CSE-MsgGUID: olQf0ZgyRZ2Fl5bMV+fuHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19096788"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19096788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:12:50 -0700
X-CSE-ConnectionGUID: Fqt99sqcSSq+64XiV2ONnQ==
X-CSE-MsgGUID: rhmB8fVWQw2CBkZNszo/rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19120656"
Received: from kmoorman-mobl.amr.corp.intel.com (HELO [10.212.57.192]) ([10.212.57.192])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:12:49 -0700
Message-ID: <19f21879-885c-4120-9411-7022f526426f@linux.intel.com>
Date: Fri, 5 Apr 2024 10:12:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] soundwire: debugfs: add interface to read/write
 commands
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 bard.liao@intel.com
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>
 <Zg_ka02zLnXrADGj@matsya>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Zg_ka02zLnXrADGj@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 06:45, Vinod Koul wrote:
> On 26-03-24, 09:01, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> We have an existing debugfs files to read standard registers
>> (DP0/SCP/DPn).
>>
>> This patch provides a more generic interface to ANY set of read/write
>> contiguous registers in a peripheral device. In follow-up patches,
>> this interface will be extended to use BRA transfers.
>>
>> The sequence is to use the following files added under the existing
>> debugsfs directory for each peripheral device:
>>
>> command (write 0, read 1)
>> num_bytes
>> start_address
>> firmware_file (only for writes)
>> read_buffer (only for reads)
>>
>> Example for a read command - this checks the 6 bytes used for
>> enumeration.
>>
>> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
>> echo 1 > command
>> echo 6 > num_bytes
>> echo 0x50 > start_address
>> echo 1 > go
> 
> can we have a simpler interface? i am not a big fan of this kind of
> structure for debugging.
> 
> How about two files read_bytes and write_bytes where you read/write
> bytes.
> 
> echo 0x50 6 > read_bytes
> cat read_bytes
> 
> in this format I would like to see addr and values (not need to print
> address /value words (regmap does that too)
> 
> For write
> 
> echo start_addr N byte0 byte 1 ... byte N > write_bytes

I think you missed the required extension where we will add a new
'command_type' to specify which of the regular or BTP/BRA accesses is used.

Also the bytes can come from a firmware file, it would be very odd to
have a command line with 32k value, wouldn't it?

I share your concern about making the interface as simple as possible,
but I don't see how it can be made simpler really. We have to specify
- read/write
- access type (BRA or regular)
- start address
- number of bytes
- a firmware file for writes
- a means to see the read data.

And I personally prefer one 1:1 mapping between setting and debugfs
file, rather than a M:1 mapping that require users to think about the
syntax and which value maps to what setting. At my age I have to define
things that I will remember on the next Monday.


