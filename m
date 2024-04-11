Return-Path: <linux-kernel+bounces-140682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA28A17B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92131C2011F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBF17BC9;
	Thu, 11 Apr 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InRaF0wP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A210A12;
	Thu, 11 Apr 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846603; cv=none; b=n/MgCPvqi+OIQz566ULeaYQmnoTxTv0qygiiHV12nVZtjTZ9pRZewSiMS5CdqEvgv7nn9v0cKLm87GtF6IRCWgym3kCPI6BJGJ5VCr5F9fFNbzWCXUdYq+RxpNvq7yeRwSTxWhxCTReNP1RiKnoqDDlBnlCkRyGJQcrSqqtq8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846603; c=relaxed/simple;
	bh=x/18Z9algBXQxM9quW+7AyCJRcmj23RiT3ilEq9hIAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZUxTx0J5seKsO1kbrwIf7SRYxeT3L1vWNuRFFfUNO7fDknKGuKaO0N0hnOIsuUHwYECzC/RnSowkVy/YjgLfyS7IImrhcoQb/keMMzhlTo3Z8oWmKCQ9aOZlPtw3vgMNKMAu4/0/GDT8JLsC+Iv7V83qYMu5oIAvEpU5hVrJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InRaF0wP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712846602; x=1744382602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x/18Z9algBXQxM9quW+7AyCJRcmj23RiT3ilEq9hIAk=;
  b=InRaF0wPVfqTY0u+IqB+pPm50dc8keL2IDUc8yCyxg8+hJUxldS4+84q
   uGjlUf0nQl24A7R7cQkTFrcVUW5hNOt2RPZuNjaOYZR1cnaUSNmTW+SSW
   kvtcoyfjcUvYhnuswW4uFhcpjHgJMzb3+IIdQZr90jIGGuF0uCid4ZJuz
   vi1TfxLZ5YRKHpgYRKIFa6Eg+fgUIILlW+MAaqyVKU8y7+3B12bL+OZGs
   YpeZgP+AxNEQ8vOLO7suEirGVY6rx6Jgmrecbvgsafk027zTT2dhnKRZc
   LQe9Ef8tB6sVnViED0eCcPuualxFLlZYkQ02ASpUegf7A9hnoB6FAtVs+
   g==;
X-CSE-ConnectionGUID: 9D6xSLu1Rh2kpEBl+4SD/w==
X-CSE-MsgGUID: 4EW9GTblQX2X/ggDoeTlJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8422089"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8422089"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:43:21 -0700
X-CSE-ConnectionGUID: il7oItqBTpS6AB0o+c+M2Q==
X-CSE-MsgGUID: FCVgRjC5T7mnEpCgcjHhyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20927053"
Received: from npirooza-mobl1.amr.corp.intel.com (HELO [10.212.34.202]) ([10.212.34.202])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:43:21 -0700
Message-ID: <3995e049-30db-4e31-a5fb-ca998b1822b6@linux.intel.com>
Date: Thu, 11 Apr 2024 09:24:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] soundwire: debugfs: add interface to read/write
 commands
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, bard.liao@intel.com
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>
 <Zg_ka02zLnXrADGj@matsya>
 <19f21879-885c-4120-9411-7022f526426f@linux.intel.com>
 <ZhetVE6RQXmGQrVg@matsya>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZhetVE6RQXmGQrVg@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/24 04:28, Vinod Koul wrote:
> On 05-04-24, 10:12, Pierre-Louis Bossart wrote:
>> On 4/5/24 06:45, Vinod Koul wrote:
>>> On 26-03-24, 09:01, Bard Liao wrote:
>>>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>>
>>>> We have an existing debugfs files to read standard registers
>>>> (DP0/SCP/DPn).
>>>>
>>>> This patch provides a more generic interface to ANY set of read/write
>>>> contiguous registers in a peripheral device. In follow-up patches,
>>>> this interface will be extended to use BRA transfers.
>>>>
>>>> The sequence is to use the following files added under the existing
>>>> debugsfs directory for each peripheral device:
>>>>
>>>> command (write 0, read 1)
>>>> num_bytes
>>>> start_address
>>>> firmware_file (only for writes)
>>>> read_buffer (only for reads)
>>>>
>>>> Example for a read command - this checks the 6 bytes used for
>>>> enumeration.
>>>>
>>>> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
>>>> echo 1 > command
>>>> echo 6 > num_bytes
>>>> echo 0x50 > start_address
>>>> echo 1 > go
>>>
>>> can we have a simpler interface? i am not a big fan of this kind of
>>> structure for debugging.
>>>
>>> How about two files read_bytes and write_bytes where you read/write
>>> bytes.
>>>
>>> echo 0x50 6 > read_bytes
>>> cat read_bytes
>>>
>>> in this format I would like to see addr and values (not need to print
>>> address /value words (regmap does that too)
>>>
>>> For write
>>>
>>> echo start_addr N byte0 byte 1 ... byte N > write_bytes
>>
>> I think you missed the required extension where we will add a new
>> 'command_type' to specify which of the regular or BTP/BRA accesses is used.
>>
>> Also the bytes can come from a firmware file, it would be very odd to
>> have a command line with 32k value, wouldn't it?
> 
> ofc no one should expect that... it should be written directly from the firmware file
> 
>> I share your concern about making the interface as simple as possible,
>> but I don't see how it can be made simpler really. We have to specify
>> - read/write
>> - access type (BRA or regular)
>> - start address
>> - number of bytes
>> - a firmware file for writes
>> - a means to see the read data.
>>
>> And I personally prefer one 1:1 mapping between setting and debugfs
>> file, rather than a M:1 mapping that require users to think about the
>> syntax and which value maps to what setting. At my age I have to define
>> things that I will remember on the next Monday.
> 
> Exactly, you won't remember all the files to write to, my idea was a
> simple format or addr, N and data.. a TLV kind of structure..

So your updated proposal for a write is

echo 1 0 0x50 6 test.bin > write_bytes

Mine was

echo 1 > command
echo 0 > access
echo 0x50 > start_addr
echo 6 > num_bytes
echo test.bin > firmware
echo 1 > go

I find the last version a lot more explicit and self-explanatory. There
is no need to look-up the documentation of the list and order of arguments.
You can argue that there are just three files needed (write command,
read command, read results), but there's more work to parse arguments
and remember the arguments order.

There's also the scripting part. In my tests, I relied on scripts where
I modified one line, it's just easier to visualize than modifying one
argument in the middle of a line.

The last point is extensibility. In the existing BPT/BRA tests, the data
is sent by chunks in each frame. We know that some peripherals cannot
tolerate back-to-back transfers in contiguous frames, that would require
additional arguments to control the flow. If we have to do this with a
list of arguments, it's not straightforward to do without a versioning
scheme.

The risk of getting things wrong is not really a concern, if the
destination or number of bytes is incorrect the command will fail. It
will not cause any issues. It's a debugfs interface to inject commands,
it's expected that people will actually try to make things fail...

Again, this is NOT how the BPT/BRA protocol would be used in a real
product. The integration would rely on the codec driver initiating those
transfers. What this debugfs interface helps with is only for initial
integration tests between a host and peripheral to simulate that the
codec driver will do in the final iteration.

> What would happen if you issue go, but missed writing one of the files.
> Also I would expect you to do error checking of inputs...

Please see the patch, the inputs are checked when possible to avoid
buffer overflows, etc, but as mentioned above it's important to allow
for bad commands to be issued to test the robustness of the driver.
There is e.g. no check on the start_addr, number of bytes, the interface
allows access to any part of the peripheral memory space. That's a
feature, not a bug.

