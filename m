Return-Path: <linux-kernel+bounces-35588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B78393B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E971C257EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15960BB4;
	Tue, 23 Jan 2024 15:45:21 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73760B8B;
	Tue, 23 Jan 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024721; cv=none; b=JdNY95eN5p6a/5s425Ebooa5A+uJQOZiUvOoa0/O5SwinwZ8i3EmE941GJgSB/VcT/pX4RlUgC/sQPg1Utx58U2ug07CGHwIYpwrFBfu73oiV+3iRFr5LZWAcI+iC6+qj2H5TrRBo+0yOc7zX5CSXl+UBQzV43Eyto36QzOdTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024721; c=relaxed/simple;
	bh=FEgIO/MXi0/Ry2LcyALUJDlsd8mzcNT3svcs7B5JZdk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n40JyPzeAN65fF2cOfc+5e9UdYzIy7naPrjLoyaTWj/kFfMFveZGWCZT3HWeN7ucrzNhXheXUzdZEVhXfPCQ6xzyeb8qXcRLFv5dE0WxyMHcRf9xTAkG4zG/0vSGhmQvvJ4OnVa2/zSDvS1/dl8wfs/3iBPIe6DeWRhH1pgYZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rSIxc-0008Go-EM; Tue, 23 Jan 2024 16:45:12 +0100
Message-ID: <7d16f013-7fdc-41f3-a966-973e8f5ccfdb@leemhuis.info>
Date: Tue, 23 Jan 2024 16:45:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <4c69cb61-1a43-4bfe-b01a-8118967ddbaf@leemhuis.info>
In-Reply-To: <4c69cb61-1a43-4bfe-b01a-8118967ddbaf@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706024719;12dfcb09;
X-HE-SMSGID: 1rSIxc-0008Go-EM



On 21.01.24 10:42, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 12.01.24 20:11, Guenter Roeck wrote:
>>
>> On Sat, Nov 25, 2023 at 02:51:30PM +0530, Amit Kumar Mahapatra wrote:
>>> AMD-Xilinx GQSPI controller has two advanced mode that allows the
>>> controller to consider two flashes as one single device.
>>>
>>> One of these two mode is the parallel mode in which each byte of data is
>>> stored in both devices, the even bits in the lower flash & the odd bits in
>>> the upper flash. The byte split is automatically handled by the QSPI
>>> controller.
>> [...]
>> With this patch in the mainline kernel, two of my qemu emulations
>> (quanta-q71l-bmc and almetto-bmc) fail to instantiate the first SPI
>> controller and thus fail to boot from SPI. The error message is
>>
>> [    3.006458] spi_master spi0: No. of CS is more than max. no. of supported CS
>> [    3.006775] spi_master spi0: Failed to create SPI device for /ahb/spi@1e620000/flash@0
>>
>> The problem is no longer seen after reverting this patch.
>> [...]
>> # first bad commit: [4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b] spi: Add multi-cs memories support in SPI core
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9
> #regzbot title spi: qemu emulations quanta-q71l-bmc and almetto-bmc fail
> to boot
> #regzbot ignore-activity

#regzbot fix: spi: Raise limit on number of chip selects
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

